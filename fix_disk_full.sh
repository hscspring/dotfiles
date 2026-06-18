#!/usr/bin/env bash
set -e

BASE="/mnt/local/data"
CACHE="$BASE/cache"
ENVS="$BASE/envs"
MODELS="$BASE/models"
CKPT="$BASE/checkpoints"

echo "========== Step 0: 初始化目录 =========="
mkdir -p $CACHE $ENVS $MODELS $CKPT

echo "========== Step 1: 清理垃圾 =========="

rm -rf ~/.cache/pip || true
rm -rf /tmp/* || true

if command -v conda &> /dev/null; then
    echo "[conda] 清理缓存"
    conda clean -a -y || true
fi

sudo apt clean || true
sudo apt autoremove -y || true
sudo journalctl --vacuum-time=3d || true

echo "========== Step 2: 修复 ~/.cache =========="

if [ -L ~/.cache ]; then
    REAL=$(readlink -f ~/.cache)
    echo "已有软链 -> $REAL"

    if [ -d "$REAL/cache" ]; then
        echo "修复 cache/cache 嵌套"
        mv $REAL/cache/* $REAL/ 2>/dev/null || true
        mv $REAL/cache/.* $REAL/ 2>/dev/null || true
        rm -rf $REAL/cache
    fi
else
    echo "迁移 ~/.cache"
    mv ~/.cache $CACHE 2>/dev/null || true
    ln -sfn $CACHE ~/.cache
fi

echo "========== Step 3: 配置环境变量 =========="

BASHRC=~/.bashrc

add_line () {
    grep -qxF "$1" $BASHRC || echo "$1" >> $BASHRC
}

add_line "export HF_HOME=$CACHE/hf"
add_line "export TRANSFORMERS_CACHE=$CACHE/hf"
add_line "export HF_DATASETS_CACHE=$CACHE/hf"
add_line "export TORCH_HOME=$CACHE/torch"
add_line "export PIP_CACHE_DIR=$CACHE/pip"

add_line "export MODEL_DIR=$MODELS"
add_line "export CHECKPOINT_DIR=$CKPT"

mkdir -p $CACHE/hf $CACHE/torch $CACHE/pip

echo "========== Step 4: 迁移 conda 环境 =========="

if command -v conda &> /dev/null; then
    echo "设置 conda envs_dirs"

    CONDA_CONFIG=~/.condarc

    if [ ! -f "$CONDA_CONFIG" ]; then
        touch $CONDA_CONFIG
    fi

    if ! grep -q "envs_dirs" $CONDA_CONFIG; then
        echo "envs_dirs:" >> $CONDA_CONFIG
        echo "  - $ENVS" >> $CONDA_CONFIG
    fi

    mkdir -p $ENVS

    echo "👉 新环境将安装到: $ENVS"
    echo "⚠️ 旧环境不会自动迁移（可手动处理）"
fi

echo "========== Step 5: 提示模型/训练目录 =========="

echo "建议以后这样用："
echo "模型目录: $MODELS"
echo "checkpoint目录: $CKPT"

echo "例如："
echo "  --output_dir \$CHECKPOINT_DIR/exp1"
echo "  --model_name_or_path \$MODEL_DIR/xxx"

echo "========== Step 6: 最终检查 =========="

echo "[~/.cache]"
ls -ld ~/.cache

echo "[cache内容]"
ls $CACHE | head

echo "========== 完成 ✅ =========="
echo "执行: source ~/.bashrc"