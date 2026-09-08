#!/usr/bin/env python3
"""生成 sessions_index.md：列出本机所有 codex threads + claude 对话，
每条给 id / 时间 / cwd + 「用户自己的最后两条消息」(会话>2条时另给首条当主题)，便于自己 resume。
只放 user 消息，不含助手回复。只读，不改任何会话文件。标准库即可。跨机可移植(路径走 $HOME，输出落脚本旁)。
用法: python3 build_sessions_index.py
"""
import json, sqlite3, os, glob, datetime

HOME       = os.path.expanduser("~")
CODEX_DB   = os.path.join(HOME, ".codex", "state_5.sqlite")
CLAUDE_DIR = os.path.join(HOME, ".claude", "projects")
OUT        = os.path.join(os.path.dirname(os.path.abspath(__file__)), "sessions_index.md")

META_MARKERS = ("<system-reminder", "Caveat:", "<command-", "local-command",
                "This session is being continued", "Continue from where you left off",
                "<environment_context", "<user_instructions", "<multi_agent_mode",
                "</environment_context", "</apps_instructions", "</user_instructions",
                "The previous turn was interrupted", "<turn_aborted", "</turn_aborted",
                "# AGENTS.md", "<INSTRUCTIONS", "</INSTRUCTIONS", "AGENTS.md instructions",
                "<task-notification", "[Request interrupted", "<user-prompt-submit", "<local-command")

def clip(s, n=220):
    s = " ".join((s or "").split())
    return s[:n] + ("…" if len(s) > n else "")

def is_meta(t):
    t = (t or "").lstrip()
    return any(t.startswith(m) or m in t[:80] for m in META_MARKERS)

# ---------- 各来源只抽 user 文本 ----------
def codex_users(path):
    out = []
    try:
        with open(path, encoding="utf-8", errors="replace") as f:
            for line in f:
                try:
                    o = json.loads(line)
                except Exception:
                    continue
                p = o.get("payload") or {}
                if p.get("type") != "message" or p.get("role") != "user":
                    continue
                txt = " ".join(c.get("text", "") for c in (p.get("content") or [])
                               if isinstance(c, dict) and c.get("text")).strip()
                if txt and not is_meta(txt):
                    out.append(txt)
    except FileNotFoundError:
        pass
    return out

def claude_users(path):
    out = []
    try:
        with open(path, encoding="utf-8", errors="replace") as f:
            for line in f:
                try:
                    o = json.loads(line)
                except Exception:
                    continue
                if o.get("type") != "user":
                    continue
                content = (o.get("message") or {}).get("content")
                if isinstance(content, list):
                    txt = " ".join(b.get("text", "") for b in content
                                   if isinstance(b, dict) and b.get("type") == "text" and b.get("text"))
                elif isinstance(content, str):
                    txt = content
                else:
                    txt = ""
                txt = txt.strip()
                if txt and not is_meta(txt):
                    out.append(txt)
    except FileNotFoundError:
        pass
    return out

def render(users):
    lines = []
    if len(users) > 2:
        lines.append(f"- **主题** {clip(users[0], 90)}")
    if users:
        lines.append("- **我最后两条**")
        for t in users[-2:]:
            lines.append(f"    - 👤 {clip(t)}")
    else:
        lines.append("- (无用户消息 / 空会话)")
    return lines

# ---------- codex ----------
def codex_section():
    if not os.path.exists(CODEX_DB):
        return f"## CODEX — (本机无 {CODEX_DB}，跳过)\n"
    con = sqlite3.connect(f"file:{CODEX_DB}?mode=ro", uri=True)
    try:
        rows = con.execute(
            "SELECT id, datetime(updated_at,'unixepoch','localtime'), cwd, rollout_path "
            "FROM threads WHERE archived=0 ORDER BY updated_at DESC").fetchall()
    finally:
        con.close()
    out = [f"## CODEX — {len(rows)} 条", "", "`cd <cwd> && codex resume <id>`", ""]
    for tid, ts, cwd, rp in rows:
        out.append(f"### `{tid}`")
        out.append(f"- **时间** {ts}  **cwd** `{cwd}`")
        out += render(codex_users(rp))
        out.append("")
    return "\n".join(out)

# ---------- claude ----------
def proj_cwd(proj_dirname):
    return "/" + proj_dirname.strip("-").replace("-", "/")

def claude_section(proj_dirname):
    d = os.path.join(CLAUDE_DIR, proj_dirname)
    files = sorted(glob.glob(os.path.join(d, "*.jsonl")),
                   key=os.path.getmtime, reverse=True)
    cwd = proj_cwd(proj_dirname)
    out = [f"## CLAUDE — cwd={cwd} ({len(files)} 条)", "",
           f"`cd {cwd} && claude --resume <id>`", ""]
    for f in files:
        sid = os.path.basename(f)[:-6]
        ts = datetime.datetime.fromtimestamp(os.path.getmtime(f)).strftime("%Y-%m-%d %H:%M:%S")
        out.append(f"### `{sid}`")
        out.append(f"- **时间** {ts}")
        out += render(claude_users(f))
        out.append("")
    return "\n".join(out)

def all_claude_sections():
    if not os.path.isdir(CLAUDE_DIR):
        return [f"## CLAUDE — (本机无 {CLAUDE_DIR}，跳过)\n"]
    def dir_mtime(name):
        fs = glob.glob(os.path.join(CLAUDE_DIR, name, "*.jsonl"))
        return max((os.path.getmtime(x) for x in fs), default=0.0)
    dirs = [name for name in os.listdir(CLAUDE_DIR)
            if os.path.isdir(os.path.join(CLAUDE_DIR, name))]
    dirs.sort(key=dir_mtime, reverse=True)
    return [claude_section(name) for name in dirs]

def main():
    parts = ["# Sessions Index (codex + claude)", "",
             "> build_sessions_index.py 生成，只读扫描 ~/.codex 与 ~/.claude；只列用户自己的消息。重跑即刷新。", ""]
    parts.append(codex_section())
    parts.extend(all_claude_sections())
    with open(OUT, "w", encoding="utf-8") as fo:
        fo.write("\n".join(parts))
    print(f"✅ 写出 {OUT}  (codex+claude)")

if __name__ == "__main__":
    main()
