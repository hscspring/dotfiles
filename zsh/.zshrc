# =========================
# ZSH bootstrap (unified: macOS + Linux)
# =========================

export TERM=${TERM:-xterm-256color}
[[ "$TERM" == (dumb|emacs|) ]] && export TERM=xterm-256color

export ZSH="$HOME/.oh-my-zsh"

# starship handles the prompt; fall back to refined if starship isn't installed
if command -v starship >/dev/null 2>&1; then
  ZSH_THEME=""
else
  ZSH_THEME="refined"
fi

plugins=(
  git
  kubectl
  docker
  jsontools
  vi-mode
)
[[ "$(uname -s)" == "Darwin" ]] && plugins+=(brew)

# fpath must be set before oh-my-zsh is sourced
fpath=("$HOME/.oh-my-zsh/custom/completions" $fpath)
fpath+=(~/.zfunc ~/.zsh.d)

source $ZSH/oh-my-zsh.sh

# fzf
if [[ "$(uname -s)" == "Darwin" ]]; then
  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
else
  [ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && source /usr/share/doc/fzf/examples/key-bindings.zsh
  [ -f /usr/share/doc/fzf/examples/completion.zsh ]    && source /usr/share/doc/fzf/examples/completion.zsh
fi

# fzf defaults: use fd if available, preview with bat
if command -v fdfind >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fdfind --type d --hidden --follow --exclude .git'
elif command -v fd >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
  export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
fi
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --info=inline'

# =========================
# Modular config (~/.zsh/)
# =========================

for file in env path alias proxy python git dev local; do
  [ -f "$HOME/.zsh/${file}.zsh" ] && source "$HOME/.zsh/${file}.zsh"
done

# Deduplicate PATH
typeset -U PATH
