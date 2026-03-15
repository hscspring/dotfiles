# ==============================
# git helpers
# ==============================

alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push'
alias gl='git pull'
alias gd='git diff'
alias gco='git checkout'
alias gb='git branch'

gclone() {
  git clone "$1" && cd "$(basename "$1" .git)"
}
