# ==============================
# Locale
# ==============================

export LC_ALL=en_US.UTF-8
export LANG=zh_CN.UTF-8

# ==============================
# Go
# ==============================

export GOPATH="$HOME/go"

# ==============================
# Java
# ==============================

export JAVA_HOME=$(/usr/libexec/java_home -v 1.8 2>/dev/null)
export JNI_HOME="$JAVA_HOME"
export CPPFLAGS="-I/usr/local/opt/openjdk/include"

# ==============================
# Torch / LibTorch
# ==============================

export LIBTORCH=/usr/local/libtorch
export LD_LIBRARY_PATH="${LIBTORCH}/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

# ==============================
# Node / NVM
# ==============================

export NVM_DIR="$HOME/.nvm"

# ==============================
# pnpm
# ==============================

export PNPM_HOME="$HOME/Library/pnpm"

# ==============================
# Wasmer
# ==============================

export WASMER_DIR="$HOME/.wasmer"

# ==============================
# Mojo / Modular
# ==============================

export MODULAR_HOME="$HOME/.modular"

# ==============================
# Homebrew
# ==============================

export HOMEBREW_NO_AUTO_UPDATE=1
