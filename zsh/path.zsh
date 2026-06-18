# ==============================
# Platform detect
# ==============================

ARCH=$(uname -m)
OS=$(uname -s)

# ==============================
# Common user paths
# ==============================

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.moon/bin:$PATH"
export PATH="$HOME/.bin:$PATH"
export PATH="$HOME/ghz:$PATH"
export PATH="$PNPM_HOME:$PATH"

# ==============================
# macOS Homebrew
# ==============================

if [[ "$OS" == "Darwin" ]]; then
  BREW_ARM="/opt/homebrew"
  BREW_INTEL="/usr/local"

  if [[ "$ARCH" == "arm64" ]]; then
    export PATH="$BREW_ARM/bin:$PATH"
    export PATH="$BREW_ARM/sbin:$PATH"
    export PATH="$BREW_ARM/opt/mysql-client/bin:$PATH"
    export PATH="$BREW_ARM/opt/lld@19/bin:$PATH"
    export PATH="$BREW_INTEL/bin:$PATH"
    export PATH="$BREW_INTEL/sbin:$PATH"
  else
    export PATH="$BREW_INTEL/bin:$PATH"
    export PATH="$BREW_INTEL/sbin:$PATH"
    export PATH="$BREW_INTEL/opt/openssl/bin:$PATH"
    export PATH="$BREW_INTEL/opt/gnu-sed/libexec/gnubin:$PATH"
    export PATH="$BREW_INTEL/opt/ruby/bin:$PATH"
    export PATH="/usr/local/lib/ruby/gems/3.0.0/bin:$PATH"
    export PATH="$BREW_INTEL/opt/openjdk/bin:$PATH"
    export PATH="$BREW_INTEL/opt/sqlite/bin:$PATH"
    export PATH="$BREW_INTEL/opt/gdal2/bin:$PATH"
  fi

# ==============================
# Linux (Ubuntu/Debian-style + optional Linuxbrew)
# ==============================

elif [[ "$OS" == "Linux" ]]; then
  [ -d /snap/bin ] && export PATH="/snap/bin:$PATH"

  # Homebrew on Linux (https://docs.brew.sh/Homebrew-on-Linux)
  if [ -d /home/linuxbrew/.linuxbrew/bin ]; then
    export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:$PATH"
  elif [ -d "$HOME/.linuxbrew/bin" ]; then
    export PATH="$HOME/.linuxbrew/bin:$HOME/.linuxbrew/sbin:$PATH"
  fi
fi

# ==============================
# Java (depends on JAVA_HOME set in env.zsh)
# ==============================

[ -n "$JAVA_HOME" ] && export PATH="$JAVA_HOME/bin:$PATH"

# ==============================
# Extra dev tools
# ==============================

if [[ "$OS" == "Darwin" ]] && [ -d "/Applications/Docker.app/Contents/Resources/bin" ]; then
  export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"
fi

export PATH="$HOME/.modular/pkg/packages.modular.com_mojo/bin:$PATH"
export PATH="$HOME/.opencode/bin:$PATH"
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
export PATH="$HOME/.local/share/ponyup/bin:$PATH"
