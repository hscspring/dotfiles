# ==============================
# conda lazy load — only init when first used (~0.9s saved per shell)
# ==============================

if [[ "$(uname -s)" == "Darwin" ]]; then
  _CONDA_ROOT="$HOME/miniconda3"
else
  _CONDA_ROOT="${CONDA_ROOT:-/mnt/local/envs/miniconda3}"
fi

# Put conda on PATH immediately (so `python` resolves), but defer the heavy hook
if [ -x "$_CONDA_ROOT/bin/conda" ]; then
  export PATH="$_CONDA_ROOT/bin:$PATH"
fi

_conda_init() {
  if [ -z "$_CONDA_INITIALIZED" ] && [ -x "$_CONDA_ROOT/bin/conda" ]; then
    eval "$("$_CONDA_ROOT/bin/conda" 'shell.zsh' 'hook' 2>/dev/null)"
    _CONDA_INITIALIZED=1
  fi
}

conda()  { _conda_init; command conda "$@"; }
ca()     { _conda_init; conda activate "$@"; }
cc()     { _conda_init; conda create "$@"; }

export PIP_DISABLE_PIP_VERSION_CHECK=1

alias jn='jupyter notebook'
alias jl='jupyter lab'
