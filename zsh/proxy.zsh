# ==============================
# Rust (Aliyun mirrors)
# ==============================

export RUSTUP_UPDATE_ROOT=https://mirrors.aliyun.com/rustup/rustup
export RUSTUP_DIST_SERVER=https://mirrors.aliyun.com/rustup

# ==============================
# git-repo (Tsinghua mirror)
# ==============================

export REPO_URL='https://mirrors.tuna.tsinghua.edu.cn/git/git-repo'

alias pc='proxychains4'

proxy_status() {
  if lsof -i:7890 >/dev/null 2>&1; then
    echo "proxy: ON"
  else
    echo "proxy: OFF"
  fi
}

proxychains-prefix() {
  LBUFFER="pc $LBUFFER"
}

zle -N proxychains-prefix
bindkey "^[p" proxychains-prefix
