# ==============================
# Platform detect
# ==============================

ARCH=$(uname -m)

# Apple Silicon brew
BREW_ARM="/opt/homebrew"

# Intel brew
BREW_INTEL="/usr/local"

# ==============================
# Common user paths
# ==============================

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.moon/bin:$PATH"
export PATH="$HOME/.bin:$PATH"                    # wasmer bin dir
export PATH="$HOME/ghz:$PATH"
export PATH="$PNPM_HOME:$PATH"                    # set in env.zsh

# ==============================
# Brew paths
# ==============================

if [[ "$ARCH" == "arm64" ]]; then
  # Apple Silicon priority
  export PATH="$BREW_ARM/bin:$PATH"
  export PATH="$BREW_ARM/sbin:$PATH"
  export PATH="$BREW_ARM/opt/mysql-client/bin:$PATH"
  export PATH="$BREW_ARM/opt/lld@19/bin:$PATH"

  # Intel fallback (Rosetta tools)
  export PATH="$BREW_INTEL/bin:$PATH"
  export PATH="$BREW_INTEL/sbin:$PATH"
else
  # Intel machine
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
# Java (depends on JAVA_HOME set in env.zsh)
# ==============================

[ -n "$JAVA_HOME" ] && export PATH="$JAVA_HOME/bin:$PATH"

# ==============================
# Extra dev tools
# ==============================

export PATH="/Applications/Docker.app/Contents/Resources/bin:$PATH"
export PATH="$HOME/.modular/pkg/packages.modular.com_mojo/bin:$PATH"
export PATH="$HOME/.opencode/bin:$PATH"
export PATH="$HOME/.antigravity/antigravity/bin:$PATH"
export PATH="$HOME/.local/share/ponyup/bin:$PATH"
