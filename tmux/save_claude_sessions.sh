#!/usr/bin/env zsh
# 保存 tmux session → claude session ID 映射
# 累计(不删旧) + 去重(按 session 名) + 最近覆盖(当前观测即最新)
# 记录格式: <session名> <claude-id> <cwd> <ISO时间戳>
OUT="${1:-$HOME/.tmux/claude_sessions.txt}"
NOW="$(date +%Y-%m-%dT%H:%M:%S)"

typeset -A rec

# 读旧记录作为累计基础（session 名为 key，天然去重）
if [[ -f "$OUT" ]]; then
  while read -r session rest; do
    [[ -n "$session" ]] && rec[$session]="$rest"
  done < "$OUT"
fi

# 扫当前跑着的 claude，覆盖同名记录（当前观测即最新时间）
while read -r session pid cwd; do
  for child in $(pgrep -P "$pid" 2>/dev/null); do
    cmd="$(ps -p "$child" -o command= 2>/dev/null)"
    if [[ "$cmd" == *"claude --resume"* ]]; then
      id="$(print -r -- "$cmd" | grep -oE '[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}' | head -1)"
      [[ -n "$id" ]] && rec[$session]="$id $cwd $NOW"
    fi
  done
done < <(tmux list-panes -a -F "#{session_name} #{pane_pid} #{pane_current_path}" 2>/dev/null)

# 写回：按 session 名排序
for session in ${(k)rec}; do
  print -r -- "$session ${rec[$session]}"
done | sort > "$OUT.tmp" && mv "$OUT.tmp" "$OUT"

print -r -- "Saved to $OUT:"
cat "$OUT"
