
-- ##### Global #####

vim.g.mapleader = ","
vim.g.maplocalleader = "\\"

vim.g.logging_level = "info"

-- Disable
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0

-- setting python location
vim.g.python3_host_prog = "/opt/homebrew/bin/python3"

-- ##### Setting #####

-- Basic
vim.opt.encoding = "utf-8"
vim.opt.history = 1000


-- Waiting time
vim.opt.timeout = false
vim.opt.ttimeout = true
vim.opt.ttimeoutlen = 100


-- Display


-- Sidebar
vim.opt.number = true


-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true


-- White
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.tabstop = 2 -- 1tab = 2spaces
vim.opt.shiftwidth = 2 -- indent rule


-- ##### Plugin #####