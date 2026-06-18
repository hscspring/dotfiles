-- ===== Global =====

vim.g.mapleader = ","
vim.g.maplocalleader = ","

vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

-- python: platform-aware
if vim.fn.has("mac") == 1 then
  vim.g.python3_host_prog = "/opt/homebrew/bin/python3"
else
  local conda = os.getenv("CONDA_PREFIX")
  if conda then
    vim.g.python3_host_prog = conda .. "/bin/python3"
  end
end

-- ===== Options =====

vim.opt.encoding = "utf-8"
vim.opt.fileencodings = { "utf-8", "ucs-bom", "gbk", "cp936", "gb2312", "gb18030" }
vim.opt.history = 1000
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"

-- Display
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.showmode = false
vim.opt.laststatus = 3

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.inccommand = "nosplit"

-- Indent
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Files
vim.opt.backup = false
vim.opt.swapfile = false
vim.opt.autoread = true
vim.opt.autowrite = true
vim.opt.confirm = true
vim.opt.undofile = true

-- Folding
vim.opt.foldmethod = "indent"
vim.opt.foldlevelstart = 99

-- Timeout
vim.opt.timeout = true
vim.opt.timeoutlen = 500
vim.opt.ttimeoutlen = 10
vim.opt.updatetime = 250
