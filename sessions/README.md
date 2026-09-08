# sessions — 本机 tmux + AI 会话备份/索引

只读扫描本机的 codex / claude 会话，生成人类可读的索引，方便随时 `resume`。
纯标准库 / bash，跨机可移植(路径走 `$HOME`，输出落本目录)。**只读，绝不改任何会话文件。**

## 两个脚本

- **`build_sessions_index.py`** — 扫 `~/.codex/state_5.sqlite` + `~/.claude/projects/*`，
  每条会话列 id / 时间 / cwd + 「我自己的最后两条消息」，写出 `sessions_index.md`。
  某工具在本机不存在(如没装 codex)会自动跳过。
- **`tmux_bindings.sh`** — 读活着的 pane 里 `claude --resume <id>` / `codex resume <id>`
  进程的实时命令行，得出「tmux 会话名 → 会话 id」权威绑定，写出 `sessions_record.md`
  (`--tsv` 再写 `bindings.tsv`)。Linux 读 `/proc`，macOS 回落 `ps`。

## 用法

```bash
python3 build_sessions_index.py
bash tmux_bindings.sh --tsv
```

生成的 `sessions_index.md` / `sessions_record.md` / `bindings.tsv` 含会话内容，已 gitignore，不入库。

## 定时(每天刷新一次)

服务器上用 crontab；示例(每天 04:17 本地时间)：

```cron
17 4 * * * cd $HOME/dotfiles/sessions && /usr/bin/python3 build_sessions_index.py >> cron.log 2>&1; bash tmux_bindings.sh --tsv >> cron.log 2>&1
```

Mac 上手动跑或用 launchd/cron 皆可。tmux_bindings 需能连到默认 socket 的 tmux server
(cron 以本人身份跑即可)。
