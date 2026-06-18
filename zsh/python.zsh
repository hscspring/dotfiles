# ==============================
# conda initialize
# ==============================

if [[ "$(uname -s)" == "Darwin" ]]; then
  CONDA_ROOT="$HOME/miniconda3"
else
  CONDA_ROOT="${CONDA_ROOT:-/mnt/local/envs/miniconda3}"
fi

if [ -x "$CONDA_ROOT/bin/conda" ]; then
  __conda_setup="$("$CONDA_ROOT/bin/conda" 'shell.zsh' 'hook' 2>/dev/null)"
  if [ $? -eq 0 ]; then
    eval "$__conda_setup"
  else
    if [ -f "$CONDA_ROOT/etc/profile.d/conda.sh" ]; then
      . "$CONDA_ROOT/etc/profile.d/conda.sh"
    else
      export PATH="$CONDA_ROOT/bin:$PATH"
    fi
  fi
  unset __conda_setup
  export PATH="$CONDA_ROOT/bin:$PATH"
  alias ca='conda activate'
  alias cc='conda create'
fi
unset CONDA_ROOT

export PIP_DISABLE_PIP_VERSION_CHECK=1

alias jn='jupyter notebook'
alias jl='jupyter lab'
