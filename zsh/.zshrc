# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/Yam/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="refined"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git kubectl docker git brew z fd ripgrep jsontools vi-mode )

source $ZSH/oh-my-zsh.sh

# User configuration

# zsh
. ~/z.sh


# gdal2
export PATH="/Users/Yam/.local/bin:$PATH"
export PATH="/usr/local/opt/gdal2/bin:$PATH"

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# alias
alias vim='nvim'
alias sc='echo "eas oss | mus tssh"'
alias eas='eascmdmac64'
alias oss='ossutilmac64'
alias mus='optimus'
# tssh

alias d='docker'
alias k='kubectl'
alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'
alias pc="proxychains4"
alias aria="aria2c --conf-path="/Users/Yam/.aria2/aria2.conf" -D" 
alias julia='/Applications/Julia-1.0.app/Contents/Resources/julia/bin/julia'
# alias ffmpeg="/usr/local/Cellar/ffmpeg/bin/ffmpeg"
export PATH=$PATH:/usr/local/cling/bin
export PATH="/usr/local/Cellar/ffmpeg/bin:$PATH"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

plugins+=(zsh-nvm)
export PATH="/usr/local/opt/sqlite/bin:$PATH"
export PATH="/usr/local/opt/opencv@2/bin:$PATH"
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
export PATH="/usr/local/opt/openssl/bin:$PATH"
export PATH="/usr/local/bin/psql/bin:$PATH"

alias mysql="/usr/local/mysql/bin/mysql"
alias mysqladmin="/usr/local/mysql/bin/mysqladmin"

alias pg_start="launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist"
alias pg_stop="launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist"
export PATH=$PATH:/usr/local/sbin
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/ghz:$PATH"
export PATH="$HOME/istio-1.5.0/bin:$PATH"
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export JNI_HOME=`/usr/libexec/java_home -v 1.8`
export PATH=$JAVA_HOME/bin:$PATH
export PATH=$JNI_HOME/include:$PATH


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/Yam/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/Yam/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/Yam/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/Yam/google-cloud-sdk/completion.zsh.inc'; fi

fpath+=~/.zfunc

tmux_work()
{
    if [ -z "$(tmux list-sessions -F '#{session_name}' | grep work)" ]; then
        tmux new-session -s "work" -d -n "base"    # 开启一个会话
        tmux split-window -h
        # tmux split-window -v "top"          # 开启一个横屏,并执行top命令
        tmux new-window -n "work1"          # 开启一个窗口
        tmux split-window -h                # 开启一个竖屏
        tmux new-window -n "work2"
        tmux split-window -h
        tmux new-window -n "docker"
        tmux split-window -h
        tmux new-window -n "full"
        # tmux -2 attach-session -d           # tmux -2强制启用256color，连接已开启的tmux
        tmux a -t work
    else
        tmux a -t work
    fi
}

tmux_night() {
    if [ -z "$(tmux list-sessions -F '#{session_name}' | grep night)" ]; then
        tmux new-session -s "night" -d -n "base"
        tmux new-window -n "coding"
        tmux split-window -h
        tmux new-window -n "opensource"
        tmux split-window -h
        # tmux -2 attach-session -d
        tmux a -t night
    else
        tmux a -t night
    fi
}
#
#  # # 判断是否已有开启的tmux会话，没有则开启
# if which tmux 2>&1 >/dev/null; then
#     test -z "$TMUX" && (tmux a -t work || tmux_work);
# export LANG="zh_CN.utf8"
# export LC_ALL="zh_CN.utf8"
# fi

export LC_ALL=en_US.UTF-8
export LANG=zh_CN.UTF-8
export LIBTORCH=/usr/local/libtorch
export LD_LIBRARY_PATH=${LIBTORCH}/lib:$LD_LIBRARY_PATH
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"


export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/3.0.0/bin:$PATH"
fpath=(~/.zsh.d/ $fpath)

# tere
tere() {
    local result=$(/Users/Yam/.cargo/bin/tere "$@")
    [ -n "$result" ] && cd -- "$result"
}

# history
# starship
eval "$(starship init zsh)"

# pnpm
export PNPM_HOME="/Users/Yam/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# Wasmer
export PATH="${HOME}/.bin:${PATH}"
export WASMER_DIR="/Users/Yam/.wasmer"
[ -s "$WASMER_DIR/wasmer.sh" ] && source "$WASMER_DIR/wasmer.sh"

# torch
export LIBTORCH=/usr/local/libtorch
export LD_LIBRARY_PATH=${LIBTORCH}/lib:$LD_LIBRARY_PATH

source /opt/homebrew/opt/autoenv/activate.sh
export MODULAR_HOME="/Users/Yam/.modular"
export PATH="/Users/Yam/.modular/pkg/packages.modular.com_mojo/bin:$PATH"
