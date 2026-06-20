# ==============================
# Platform detect
# ==============================

_OS=$(uname -s)

# ==============================
# Modern replacements
# ==============================

# ls -> eza
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --group-directories-first'
  alias ll='eza -alh --git --group-directories-first'
  alias la='eza -a --group-directories-first'
  alias l='eza -F --group-directories-first'
  alias lt='eza --tree --level=2 --group-directories-first'
  alias llt='eza -alh --tree --level=2 --git --group-directories-first'
else
  alias ll='ls -alh'
  alias la='ls -A'
  alias l='ls -CF'
fi

# cat -> bat
if command -v batcat >/dev/null 2>&1; then
  alias bat='batcat'
  alias cat='batcat --paging=never --plain'
elif command -v bat >/dev/null 2>&1; then
  alias cat='bat --paging=never --plain'
fi

# find -> fd
if command -v fdfind >/dev/null 2>&1 && ! command -v fd >/dev/null 2>&1; then
  alias fd='fdfind'
fi

# du -> dust
command -v dust >/dev/null 2>&1 && alias du='dust'

# top -> btm
command -v btm >/dev/null 2>&1 && alias top='btm --basic'

# ==============================
# Containers & Kubernetes
# ==============================

alias d='docker'
alias k='kubectl'

# ==============================
# Git TUI
# ==============================

command -v lazygit >/dev/null 2>&1 && alias lg='lazygit'

# ==============================
# Editors (macOS Sublime — guarded)
# ==============================

if [[ "$_OS" == "Darwin" ]] && [ -x "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" ]; then
  alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
fi

# ==============================
# Homebrew (macOS Rosetta)
# ==============================

if [[ "$_OS" == "Darwin" ]] && [ -x /usr/local/bin/ibrew ]; then
  alias ibrew='arch -x86_64 /usr/local/bin/ibrew'
fi

# ==============================
# Database (macOS Homebrew MySQL / launchctl Postgres)
# ==============================

if [[ "$_OS" == "Darwin" ]]; then
  [ -x /usr/local/mysql/bin/mysql ] && alias mysql='/usr/local/mysql/bin/mysql'
  [ -x /usr/local/mysql/bin/mysqladmin ] && alias mysqladmin='/usr/local/mysql/bin/mysqladmin'
  alias pg_start='launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist'
  alias pg_stop='launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist'
fi

# ==============================
# Downloads
# ==============================

[ -f "$HOME/.aria2/aria2.conf" ] && alias aria="aria2c --conf-path=\"$HOME/.aria2/aria2.conf\" -D"

# ==============================
# Cloud / DevOps tools (macOS-named binaries)
# ==============================

command -v eascmdmac64 >/dev/null 2>&1 && alias eas='eascmdmac64'
command -v ossutilmac64 >/dev/null 2>&1 && alias oss='ossutilmac64'
command -v optimus >/dev/null 2>&1 && alias mus='optimus'
alias sc='echo "eas oss | mus tssh"'

# ==============================
# GPU / Training
# ==============================

alias gpu='nvitop'
alias smi='nvidia-smi'
alias gpumem='nvidia-smi --query-gpu=index,name,memory.used,memory.total,utilization.gpu --format=csv,noheader,nounits'
alias gkill='nvidia-smi --query-compute-apps=pid --format=csv,noheader | xargs -r kill -9'

# ==============================
# Markdown preview
# ==============================

command -v glow >/dev/null 2>&1 && alias md='glow'

# ==============================
# Tmux
# ==============================

alias ta='tmux a -t'
alias tl='tmux ls'
alias tn='tmux new -s'

# ==============================
# Misc (macOS-only)
# ==============================

if [[ "$_OS" == "Darwin" ]] && [ -x "/Applications/Julia-1.0.app/Contents/Resources/julia/bin/julia" ]; then
  alias julia='/Applications/Julia-1.0.app/Contents/Resources/julia/bin/julia'
fi

unset _OS
