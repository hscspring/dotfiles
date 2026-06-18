#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# Dotfiles Setup — symlink configs to $HOME
# Usage: bash ~/dotfiles/setup.sh
# ============================================================

DOTFILES="$(cd "$(dirname "$0")" && pwd)"

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

link() {
    local src=$1 dst=$2
    if [ -L "$dst" ]; then
        rm "$dst"
    elif [ -e "$dst" ]; then
        mv "$dst" "${dst}.bak"
        echo -e "${YELLOW}[BAK]${NC}  $dst -> ${dst}.bak"
    fi
    ln -sf "$src" "$dst"
    echo -e "${GREEN}[LINK]${NC} $dst -> $src"
}

echo ""
echo "Dotfiles: $DOTFILES"
echo "================================="
echo ""

# --- ZSH ---
link "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
mkdir -p "$HOME/.zsh"
for f in alias dev env git path proxy python; do
    link "$DOTFILES/zsh/${f}.zsh" "$HOME/.zsh/${f}.zsh"
done
# local.zsh: create from platform-specific example if missing (never overwrite)
if [ ! -f "$HOME/.zsh/local.zsh" ]; then
    if [[ "$(uname -s)" == "Darwin" ]]; then
        cp "$DOTFILES/zsh/local.zsh.example.mac" "$HOME/.zsh/local.zsh"
        echo -e "${GREEN}[NEW]${NC}  ~/.zsh/local.zsh (from mac example)"
    else
        cp "$DOTFILES/zsh/local.zsh.example.linux" "$HOME/.zsh/local.zsh"
        echo -e "${GREEN}[NEW]${NC}  ~/.zsh/local.zsh (from linux example)"
    fi
fi

# --- Vim ---
link "$DOTFILES/vim/.vimrc" "$HOME/.vimrc"
link "$DOTFILES/vim/.vimrc.bundle" "$HOME/.vimrc.bundle"
mkdir -p "$HOME/.vim/autoload"
link "$DOTFILES/vim/autoload/plug.vim" "$HOME/.vim/autoload/plug.vim"

# --- tmux ---
link "$DOTFILES/tmux/.tmux.conf" "$HOME/.tmux.conf"

# --- Git ---
link "$DOTFILES/git/.gitconfig" "$HOME/.gitconfig"
# Machine-specific git settings go in .gitconfig.local
if [ ! -f "$HOME/.gitconfig.local" ]; then
    cat > "$HOME/.gitconfig.local" <<'GITLOCAL'
# Machine-local git config (not tracked by dotfiles)
# [user]
#     name = your-name
#     email = your@email.com
# [credential]
#     helper = store
GITLOCAL
    echo -e "${GREEN}[NEW]${NC}  ~/.gitconfig.local (edit with your credentials)"
fi

# --- Starship ---
mkdir -p "$HOME/.config"
link "$DOTFILES/starship/starship.toml" "$HOME/.config/starship.toml"

# --- macOS-only ---
if [[ "$(uname -s)" == "Darwin" ]]; then
    # Hammerspoon
    if [ -d "$DOTFILES/hammerspoon" ]; then
        link "$DOTFILES/hammerspoon" "$HOME/.hammerspoon"
    fi
    # Kitty
    if [ -d "$DOTFILES/kitty" ]; then
        mkdir -p "$HOME/.config"
        link "$DOTFILES/kitty" "$HOME/.config/kitty"
    fi
    # Karabiner
    if [ -d "$DOTFILES/karabiner" ]; then
        mkdir -p "$HOME/.config"
        link "$DOTFILES/karabiner" "$HOME/.config/karabiner"
    fi
fi

echo ""
echo "================================="
echo -e "${GREEN}Done!${NC} Run: exec zsh"
echo ""
echo "Don't forget to edit ~/.gitconfig.local with your credentials."
echo "Machine-specific zsh overrides go in ~/.zsh/local.zsh"
echo "================================="
