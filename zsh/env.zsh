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

if [[ "$(uname -s)" == "Darwin" ]]; then
  export JAVA_HOME=$(/usr/libexec/java_home -v 1.8 2>/dev/null)
  export JNI_HOME="$JAVA_HOME"
  export CPPFLAGS="-I/usr/local/opt/openjdk/include"
else
  # Linux: pick a sensible OpenJDK if present
  if [ -z "$JAVA_HOME" ]; then
    for j in /usr/lib/jvm/default-java /usr/lib/jvm/java-17-openjdk-amd64 /usr/lib/jvm/java-11-openjdk-amd64 /usr/lib/jvm/java-8-openjdk-amd64; do
      if [ -d "$j" ]; then
        export JAVA_HOME="$j"
        break
      fi
    done
  fi
  export JNI_HOME="$JAVA_HOME"
  [ -n "$JAVA_HOME" ] && export CPPFLAGS="-I${JAVA_HOME}/include"
fi

# ==============================
# Torch / LibTorch (optional local install)
# ==============================

export LIBTORCH=/usr/local/libtorch
export LD_LIBRARY_PATH="${LIBTORCH}/lib${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}"

# ==============================
# Shared caches (/mnt/gv0/cache) — data/model downloads, machine-independent
# ==============================

export HF_HOME="${HF_HOME:-/mnt/gv0/cache/huggingface}"
export HF_HUB_CACHE="${HF_HUB_CACHE:-$HF_HOME/hub}"
export HF_DATASETS_CACHE="${HF_DATASETS_CACHE:-$HF_HOME/datasets}"
export TRANSFORMERS_CACHE="${TRANSFORMERS_CACHE:-$HF_HOME/transformers}"
export HUGGINGFACE_ASSETS_CACHE="${HUGGINGFACE_ASSETS_CACHE:-$HF_HOME/assets}"
export HF_XET_CACHE="${HF_XET_CACHE:-$HF_HOME/xet}"
export TORCH_HOME="${TORCH_HOME:-/mnt/gv0/cache/torch}"
export PIP_CACHE_DIR="${PIP_CACHE_DIR:-/mnt/gv0/cache/pip}"
export NLTK_DATA="${NLTK_DATA:-/mnt/gv0/cache/nltk}"
export GENSIM_DATA_DIR="${GENSIM_DATA_DIR:-/mnt/gv0/cache/gensim}"

# ==============================
# Local-only caches (/mnt/local/cache) — compiled/machine-specific
# ==============================

export XDG_CACHE_HOME="${XDG_CACHE_HOME:-/mnt/local/cache/xdg}"
export TORCHINDUCTOR_CACHE_DIR="${TORCHINDUCTOR_CACHE_DIR:-/mnt/local/cache/torch/inductor}"
export TRITON_CACHE_DIR="${TRITON_CACHE_DIR:-/mnt/local/cache/triton}"
export CUDA_CACHE_PATH="${CUDA_CACHE_PATH:-/mnt/local/cache/cuda}"
export NUMBA_CACHE_DIR="${NUMBA_CACHE_DIR:-/mnt/local/cache/numba}"
export MPLCONFIGDIR="${MPLCONFIGDIR:-/mnt/local/cache/matplotlib}"
export TFHUB_CACHE_DIR="${TFHUB_CACHE_DIR:-/mnt/local/cache/tfhub}"
export JAX_CACHE_DIR="${JAX_CACHE_DIR:-/mnt/local/cache/jax}"

# ==============================
# Node / NVM
# ==============================

export NVM_DIR="$HOME/.nvm"

# ==============================
# pnpm (Linux default store layout)
# ==============================

export PNPM_HOME="${PNPM_HOME:-$HOME/.local/share/pnpm}"

# ==============================
# Wasmer
# ==============================

export WASMER_DIR="$HOME/.wasmer"

# ==============================
# Mojo / Modular
# ==============================

export MODULAR_HOME="$HOME/.modular"

# ==============================
# Homebrew (macOS / Linuxbrew only)
# ==============================

if command -v brew >/dev/null 2>&1; then
  export HOMEBREW_NO_AUTO_UPDATE=1
fi
