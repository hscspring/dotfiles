# ==============================
# Rust (Aliyun mirrors)
# ==============================

export RUSTUP_UPDATE_ROOT=https://mirrors.aliyun.com/rustup/rustup
export RUSTUP_DIST_SERVER=https://mirrors.aliyun.com/rustup

# ==============================
# git-repo (Tsinghua mirror)
# ==============================

export REPO_URL='https://mirrors.tuna.tsinghua.edu.cn/git/git-repo'

command -v proxychains4 >/dev/null 2>&1 && alias pc='proxychains4'

proxy_status() {
  if nc -z 127.0.0.1 7890 2>/dev/null; then
    echo "proxy: ON"
  else
    echo "proxy: OFF"
  fi
}

proxychains-prefix() {
  LBUFFER="pc $LBUFFER"
}

if [[ -o interactive ]] && [[ -o zle ]]; then
  zle -N proxychains-prefix
  bindkey "^[p" proxychains-prefix
fi
