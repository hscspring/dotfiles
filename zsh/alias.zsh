# ==============================
# Basic
# ==============================

alias ll='ls -alh'
alias la='ls -A'
alias l='ls -CF'

# ==============================
# Containers & Kubernetes
# ==============================

alias d='docker'
alias k='kubectl'

# ==============================
# Editors
# ==============================

alias subl='/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl'

# ==============================
# Homebrew
# ==============================

alias ibrew='arch -x86_64 /usr/local/bin/ibrew'

# ==============================
# Database
# ==============================

alias mysql='/usr/local/mysql/bin/mysql'
alias mysqladmin='/usr/local/mysql/bin/mysqladmin'
alias pg_start='launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist'
alias pg_stop='launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist'

# ==============================
# Downloads
# ==============================

alias aria="aria2c --conf-path=\"$HOME/.aria2/aria2.conf\" -D"

# ==============================
# Cloud / DevOps tools
# ==============================

alias eas='eascmdmac64'
alias oss='ossutilmac64'
alias mus='optimus'
alias sc='echo "eas oss | mus tssh"'

# ==============================
# Misc
# ==============================

alias julia='/Applications/Julia-1.0.app/Contents/Resources/julia/bin/julia'
