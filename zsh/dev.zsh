# ==============================
# NVM (NVM_DIR set in env.zsh)
# ==============================

[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"

# ==============================
# Wasmer (WASMER_DIR set in env.zsh)
# ==============================

[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"

# ==============================
# acme.sh
# ==============================

[ -f "$HOME/.acme.sh/acme.sh.env" ] && . "$HOME/.acme.sh/acme.sh.env"

# ==============================
# Google Cloud SDK
# ==============================

if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then
  . "$HOME/google-cloud-sdk/path.zsh.inc"
fi

if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then
  . "$HOME/google-cloud-sdk/completion.zsh.inc"
fi

# ==============================
# autoenv
# ==============================

[ -f /opt/homebrew/opt/autoenv/activate.sh ] && source /opt/homebrew/opt/autoenv/activate.sh

# ==============================
# Prompt (starship)
# ==============================

eval "$(starship init zsh)"

# ==============================
# tere  (cd + ls)
# ==============================

tere() {
    local result=$("$HOME/.cargo/bin/tere" "$@")
    [ -n "$result" ] && cd -- "$result"
}

# ==============================
# tmux sessions
# ==============================

tmux_work() {
    if [ -z "$(tmux list-sessions -F '#{session_name}' 2>/dev/null | grep work)" ]; then
        tmux new-session -s "work" -d -n "base"
        tmux split-window -h
        tmux new-window -n "work1"
        tmux split-window -h
        tmux new-window -n "work2"
        tmux split-window -h
        tmux new-window -n "docker"
        tmux split-window -h
        tmux new-window -n "full"
        tmux a -t work
    else
        tmux a -t work
    fi
}

tmux_night() {
    if [ -z "$(tmux list-sessions -F '#{session_name}' 2>/dev/null | grep night)" ]; then
        tmux new-session -s "night" -d -n "base"
        tmux new-window -n "coding"
        tmux split-window -h
        tmux new-window -n "opensource"
        tmux split-window -h
        tmux a -t night
    else
        tmux a -t night
    fi
}
