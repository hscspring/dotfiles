# ==============================
# conda initialize
# ==============================

__conda_setup="$("$HOME/miniconda3/bin/conda" 'shell.zsh' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup

# Ensure conda python/pip take priority over homebrew
export PATH="$HOME/miniconda3/bin:$PATH"

alias ca='conda activate'
alias cc='conda create'

export PIP_DISABLE_PIP_VERSION_CHECK=1
export PIP_NO_CACHE_DIR=1

alias jn='jupyter notebook'
alias jl='jupyter lab'