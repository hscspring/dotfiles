#!/bin/bash
# 保存当前 tmux session → claude session ID 的映射
OUT="${1:-$HOME/.tmux/claude_sessions.txt}"
> "$OUT"

tmux list-panes -a -F "#{session_name} #{pane_pid}" | while read session pid; do
    for child in $(pgrep -P "$pid" 2>/dev/null); do
        cmd=$(ps -p "$child" -o command= 2>/dev/null)
        if echo "$cmd" | grep -q "claude --resume"; then
            id=$(echo "$cmd" | grep -oE '[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}')
            cwd=$(tmux display-message -p -t "$session" "#{pane_current_path}" 2>/dev/null)
            echo "$session $id $cwd" >> "$OUT"
        fi
    done
done

echo "Saved to $OUT:"
cat "$OUT"
