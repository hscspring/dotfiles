# Neovim Config

Leader: `,`

## 基础

| 键 | 功能 |
|-----|------|
| `;` | 进入命令模式（代替 `:`) |
| `,s` | 重载配置 |
| `,y` | 复制到系统剪贴板（visual） |
| `,p` | 从系统剪贴板粘贴 |
| `Ctrl+b` | 清除搜索高亮 |

## 文件 / 搜索（Telescope）

| 键 | 功能 |
|-----|------|
| `,l` | 查找文件 |
| `,rg` | 全局搜索（ripgrep） |
| `,lb` | 切换 buffer |
| `,lm` | 最近文件 |
| `,ll` | 当前文件内搜索 |
| `,lf` | 文件内符号跳转 |
| `,ld` | 诊断信息 |

Telescope 内：`Ctrl+j/k` 上下移动，`Esc` 关闭。

## 代码（LSP）

| 键 | 功能 |
|-----|------|
| `gd` | 跳转定义 |
| `gr` | 查看引用 |
| `K` | 悬浮文档 |
| `,rn` | 重命名 |
| `,ca` | 代码操作 |
| `[d` / `]d` | 上/下一个诊断 |
| `,f` | 格式化 |

LSP 服务器通过 Mason 管理，已配置：pyright、rust_analyzer、gopls、ts_ls、lua_ls。

## 导航

| 键 | 功能 |
|-----|------|
| `,t` | 文件树开关（nvim-tree） |
| `,m` | Flash 跳转（类似 easymotion） |
| `,M` | Flash treesitter 选择 |
| `Ctrl+h/j/k/l` | 窗口间移动 |
| `vv` | 垂直分屏 |
| `ss` | 水平分屏 |
| `Ctrl+方向键` | 调整窗口大小 |

## Git

| 键 | 功能 |
|-----|------|
| `,g` | Git status（fugitive） |
| `,G` | Git diff |
| `]c` / `[c` | 下/上一个 hunk |
| `,hs` | stage hunk |
| `,hr` | reset hunk |
| `,hp` | preview hunk |
| `,hb` | blame 当前行 |

## 编辑

| 键 | 功能 |
|-----|------|
| `gcc` | 注释/取消当前行 |
| `gc` | 注释/取消选中（visual） |
| `ys{motion}{char}` | 添加 surround（如 `ysiw"` 给单词加引号） |
| `ds{char}` | 删除 surround |
| `cs{old}{new}` | 替换 surround |
| `Tab` / `S-Tab` | 补全菜单上下选 |
| `CR` | 确认补全 |
| `Ctrl+Space` | 手动触发补全 |
| `Ctrl+e` | 关闭补全菜单 |

## 插件管理

| 键 | 功能 |
|-----|------|
| `,i` | 安装插件 |
| `,u` | 更新插件 |

## 其他

| 键 | 功能 |
|-----|------|
| `,sh` | 执行 shell 命令 |
| `,py` | 运行当前 Python 文件 |
| 按住 `,` 等一秒 | which-key 弹出所有快捷键提示 |

## 插件列表

| 插件 | 用途 |
|------|------|
| catppuccin | 主题（mocha） |
| lualine | 状态栏 |
| nvim-tree | 文件树 |
| telescope | 模糊搜索 |
| nvim-treesitter | 语法高亮 |
| nvim-lspconfig + mason | LSP 代码智能 |
| nvim-cmp | 自动补全 |
| conform.nvim | 代码格式化 |
| nvim-autopairs | 自动括号 |
| nvim-surround | surround 操作 |
| Comment.nvim | 注释 |
| flash.nvim | 快速跳转 |
| gitsigns | git 行标记 |
| vim-fugitive | git 命令 |
| which-key | 快捷键提示 |
| vim-markdown | markdown 支持 |
