# =========================
# ZSH bootstrap
# =========================

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="refined"

plugins=(
  git
  kubectl
  docker
  brew
  z
  jsontools
  vi-mode
)

# fpath must be set before oh-my-zsh is sourced
fpath=("$HOME/.oh-my-zsh/custom/completions" $fpath)
fpath+=(~/.zfunc ~/.zsh.d)

source $ZSH/oh-my-zsh.sh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# =========================
# Modular config (~/.zsh/)
# =========================

ZSH_CONFIG_DIR="$HOME/.zsh"

for file in env path alias proxy python git dev local; do
  [ -f "$ZSH_CONFIG_DIR/$file.zsh" ] && source "$ZSH_CONFIG_DIR/$file.zsh"
done
