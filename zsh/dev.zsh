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
# autoenv (Homebrew macOS / apt Debian paths)
# ==============================

if [ -f /opt/homebrew/opt/autoenv/activate.sh ]; then
  source /opt/homebrew/opt/autoenv/activate.sh
elif [ -f /usr/share/autoenv/activate.sh ]; then
  source /usr/share/autoenv/activate.sh
fi

# ==============================
# Prompt — starship
# ==============================

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# ==============================
# zoxide (smarter cd, replaces z plugin)
# ==============================

if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# ==============================
# yazi — cd to last visited dir on exit
# ==============================

if command -v yazi >/dev/null 2>&1; then
  y() {
    local tmp
    tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
      builtin cd -- "$cwd"
    fi
    rm -f -- "$tmp"
  }
fi

# ==============================
# tere (cd + ls) — legacy, kept for compatibility
# ==============================

if command -v tere >/dev/null 2>&1; then
  tere() {
    local result
    result=$(command tere "$@")
    [ -n "$result" ] && cd -- "$result"
  }
fi

# ==============================
# AWS MFA — get temp session token
# ==============================

awsmfa() {
    local script
    for d in "$HOME/dotfiles" "$HOME/.local/dotfiles" /mnt/local/sean/dotfiles; do
        [ -x "$d/bin/aws-mfa" ] && script="$d/bin/aws-mfa" && break
    done
    if [ -z "${script:-}" ]; then
        echo "aws-mfa script not found"; return 1
    fi
    "$script" "$@" && source "$HOME/.aws/mfa-session.env"
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
