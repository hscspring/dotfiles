#!/usr/bin/env bash
set -euo pipefail

# ============================================================
# CLI Tools Installer
# Works on: macOS (Homebrew) / Ubuntu/Debian (apt + GitHub releases)
# Usage: bash ~/dotfiles/install.sh
# ============================================================

OS=$(uname -s)
ARCH=$(uname -m)

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

info()  { echo -e "${BLUE}[INFO]${NC} $*"; }
ok()    { echo -e "${GREEN}[OK]${NC}   $*"; }
warn()  { echo -e "${YELLOW}[SKIP]${NC} $*"; }
fail()  { echo -e "${RED}[FAIL]${NC} $*"; }

has() { command -v "$1" >/dev/null 2>&1; }

# ============================================================
# GitHub release helper — download latest .deb or binary
# ============================================================
gh_latest_tag() {
    local repo=$1
    curl -fsSL "https://api.github.com/repos/${repo}/releases/latest" \
        | grep '"tag_name"' | head -1 | sed -E 's/.*"([^"]+)".*/\1/'
}

install_gh_deb() {
    local repo=$1 pattern=$2 name=$3
    if has "$name"; then
        warn "$name already installed ($(command -v "$name"))"
        return
    fi
    info "Installing $name from $repo ..."
    local tag
    tag=$(gh_latest_tag "$repo")
    local url
    url=$(curl -fsSL "https://api.github.com/repos/${repo}/releases/latest" \
        | grep '"browser_download_url"' | grep "$pattern" | head -1 \
        | sed -E 's/.*"(https[^"]+)".*/\1/')
    if [ -z "$url" ]; then
        fail "Could not find .deb for $name"
        return 1
    fi
    local tmp
    tmp=$(mktemp /tmp/${name}-XXXXXX.deb)
    curl -fsSL -o "$tmp" "$url"
    sudo dpkg -i "$tmp" || sudo apt-get install -f -y
    rm -f "$tmp"
    ok "$name installed ($tag)"
}

install_gh_binary() {
    local repo=$1 pattern=$2 name=$3 dest=${4:-/usr/local/bin}
    if has "$name"; then
        warn "$name already installed ($(command -v "$name"))"
        return
    fi
    info "Installing $name from $repo ..."
    local tag
    tag=$(gh_latest_tag "$repo")
    local url
    url=$(curl -fsSL "https://api.github.com/repos/${repo}/releases/latest" \
        | grep '"browser_download_url"' | grep "$pattern" | head -1 \
        | sed -E 's/.*"(https[^"]+)".*/\1/')
    if [ -z "$url" ]; then
        fail "Could not find binary for $name"
        return 1
    fi
    local tmp
    tmp=$(mktemp -d /tmp/${name}-XXXXXX)
    if [[ "$url" == *.tar.gz ]] || [[ "$url" == *.tgz ]]; then
        curl -fsSL "$url" | tar -xz -C "$tmp"
        local bin
        bin=$(find "$tmp" -type f -name "$name" | head -1)
        if [ -z "$bin" ]; then
            bin=$(find "$tmp" -type f -executable | head -1)
        fi
        sudo install -m 755 "$bin" "${dest}/${name}"
    elif [[ "$url" == *.zip ]]; then
        curl -fsSL -o "$tmp/archive.zip" "$url"
        unzip -q -o "$tmp/archive.zip" -d "$tmp"
        local bin
        bin=$(find "$tmp" -type f -name "$name" | head -1)
        if [ -z "$bin" ]; then
            bin=$(find "$tmp" -type f -executable | head -1)
        fi
        sudo install -m 755 "$bin" "${dest}/${name}"
    else
        curl -fsSL -o "$tmp/$name" "$url"
        sudo install -m 755 "$tmp/$name" "${dest}/${name}"
    fi
    rm -rf "$tmp"
    ok "$name installed ($tag)"
}

# ============================================================
# macOS (Homebrew)
# ============================================================
install_macos() {
    if ! has brew; then
        info "Installing Homebrew ..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    # Keep the list light — only packages with small bottle footprints.
    # Heavy-dep packages (llvm/rust/ghc build chains) are excluded.
    local pkgs=(
        fzf ripgrep fd
        eza bat zoxide
        tmux htop
    )

    info "brew install: ${pkgs[*]}"
    brew install "${pkgs[@]}"

    # starship: use official installer (no brew deps)
    if ! has starship; then
        info "Installing starship ..."
        curl -sS https://starship.rs/install.sh | sh -s -- -y
        ok "starship installed"
    else
        warn "starship already installed"
    fi

    ok "All macOS packages installed"
}

# ============================================================
# Linux (Ubuntu/Debian)
# ============================================================
install_linux() {
    info "Updating apt index ..."
    sudo apt-get update -qq

    # --- apt packages ---
    local apt_pkgs=(fd-find eza zoxide btm tealdeer)
    local to_install=()
    for pkg in "${apt_pkgs[@]}"; do
        if dpkg -s "$pkg" &>/dev/null; then
            warn "$pkg already installed (apt)"
        else
            to_install+=("$pkg")
        fi
    done
    if [ ${#to_install[@]} -gt 0 ]; then
        info "apt install: ${to_install[*]}"
        sudo apt-get install -y "${to_install[@]}"
        ok "apt packages installed"
    fi

    # --- bat (already installed as batcat on this system) ---
    if has batcat && ! has bat; then
        warn "bat available as batcat; alias will be set in zsh config"
    elif ! has batcat && ! has bat; then
        info "Installing bat ..."
        sudo apt-get install -y bat
    fi

    # --- starship (official installer) ---
    if has starship; then
        warn "starship already installed"
    else
        info "Installing starship ..."
        curl -sS https://starship.rs/install.sh | sh -s -- -y
        ok "starship installed"
    fi

    # --- dust (GitHub .deb) ---
    install_gh_deb "bootandy/dust" "x86_64-unknown-linux-musl.deb" "dust"

    # --- yazi (GitHub binary) ---
    install_gh_binary "sxyazi/yazi" "x86_64-unknown-linux-musl.zip" "yazi"

    # --- lazygit (GitHub binary) ---
    install_gh_binary "jesseduffield/lazygit" "Linux_x86_64.tar.gz" "lazygit"

    # --- tealdeer cache ---
    if has tldr; then
        info "Updating tldr cache ..."
        tldr --update 2>/dev/null || true
    fi
}

# ============================================================
# Oh My Zsh (cross-platform)
# ============================================================
install_omz() {
    if [ -d "$HOME/.oh-my-zsh" ]; then
        warn "Oh My Zsh already installed"
    else
        info "Installing Oh My Zsh ..."
        sh -c "$(curl -fsSL https://install.ohmyz.sh/)" "" --unattended
        ok "Oh My Zsh installed"
    fi
}

# ============================================================
# vim-plug (cross-platform)
# ============================================================
install_vimplug() {
    local plug="$HOME/.vim/autoload/plug.vim"
    if [ -f "$plug" ]; then
        warn "vim-plug already installed"
    else
        info "Installing vim-plug ..."
        curl -fLo "$plug" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        ok "vim-plug installed"
    fi
}

# ============================================================
# Main
# ============================================================
echo ""
echo "========================================="
echo "  CLI Tools Installer"
echo "  OS: $OS | Arch: $ARCH"
echo "========================================="
echo ""

install_omz
install_vimplug

case "$OS" in
    Darwin) install_macos ;;
    Linux)  install_linux ;;
    *)      fail "Unsupported OS: $OS"; exit 1 ;;
esac

echo ""
echo "========================================="
ok "Done! Restart your shell or run: exec zsh"
echo "========================================="
