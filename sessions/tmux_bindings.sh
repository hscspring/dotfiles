#!/usr/bin/env bash
# tmux 会话名 <-> claude/codex 会话 id 绑定。
# 原理：每个活着的 pane 里正跑着 `claude --resume <id>` / `codex resume <id>`，
# 读该进程的实时命令行就是权威绑定(不靠历史/猜测；窗口退出/新增后重跑即最新)。
# 跨平台：Linux 读 /proc，macOS 回落到 ps。
# 用法:  bash tmux_bindings.sh          # 打印 + 写 sessions_record.md (name -> id)
#        bash tmux_bindings.sh --tsv    # 额外写 bindings.tsv (name<TAB>tool<TAB>id<TAB>cwd)
set -u
UUID='[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}'
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REC="$DIR/sessions_record.md"
TSV="$DIR/bindings.tsv"
WRITE_TSV=0; [ "${1:-}" = "--tsv" ] && WRITE_TSV=1 && : > "$TSV"

command -v tmux >/dev/null 2>&1 || { echo "无 tmux，跳过" >&2; exit 0; }
tmux list-panes -a >/dev/null 2>&1 || { echo "tmux server 未运行，跳过" >&2; exit 0; }

pcomm() {  # 进程名(取 basename)
    if [ -r "/proc/$1/comm" ]; then
        cat "/proc/$1/comm" 2>/dev/null
    else
        ps -p "$1" -o comm= 2>/dev/null | awk -F/ '{print $NF}' | awk '{print $1}'
    fi
}
pcmdline() {  # 完整命令行(空格分隔)
    if [ -r "/proc/$1/cmdline" ]; then
        tr '\0' ' ' < "/proc/$1/cmdline" 2>/dev/null
    else
        ps -p "$1" -o command= 2>/dev/null
    fi
}
descendants() { echo "$1"; for c in $(pgrep -P "$1" 2>/dev/null); do descendants "$c"; done; }

printf '# tmux -> 会话 id\n\n重生成: bash tmux_bindings.sh   (读实时 cmdline; 窗口退出/新增后重跑即最新)\n\n' > "$REC"

tmux list-panes -a -F '#{session_name}|#{pane_pid}|#{pane_current_path}' | sort -u | while IFS='|' read -r s ppid cwd; do
    tool=""; id=""
    for pid in $(descendants "$ppid"); do
        comm=$(pcomm "$pid")
        case "$comm" in
            claude|codex|node)
                cl=$(pcmdline "$pid")
                case "$cl" in
                    *resume*)
                        u=$(echo "$cl" | grep -oE "$UUID" | head -1)
                        if [ -n "$u" ]; then tool="$comm"; id="$u"; fi
                    ;;
                    *codex*|*claude*) [ -z "$id" ] && tool="$comm" && id="(新会话,未带resume-id)";;
                esac
            ;;
        esac
    done
    if [ -n "$id" ]; then
        printf "%-20s %-7s %s\n" "$s" "$tool" "$id"
        printf "%-20s %s\n" "$s" "$id" >> "$REC"
        [ "$WRITE_TSV" = 1 ] && printf "%s\t%s\t%s\t%s\n" "$s" "$tool" "$id" "$cwd" >> "$TSV"
    else
        printf "%-20s %s\n" "$s" "—(空shell)"
    fi
done
echo ">> 写出 $REC"
[ "$WRITE_TSV" = 1 ] && echo ">> 写出 $TSV"
exit 0
