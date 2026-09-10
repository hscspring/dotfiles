#!/bin/bash
# 重启后在对应 tmux session 里恢复 claude
IN="${1:-$HOME/.tmux/claude_sessions.txt}"

[ -f "$IN" ] || { echo "No session map at $IN"; exit 1; }

while read session id cwd; do
    [ -z "$session" ] && continue
    tmux has-session -t "$session" 2>/dev/null || { echo "Session $session not found, skipping"; continue; }
    echo "Restoring claude --resume $id in $session ($cwd)"
    tmux send-keys -t "$session" "cd $cwd && claude --resume $id" Enter
done < "$IN"
