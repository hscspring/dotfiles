 
-- clear hights and matches Ctrl+b
-- noh means nohlsearch
vim.cmd("noremap <C-b> :noh<cr>:call clearmatches()<cr>")
vim.cmd("noremap ; :")


function map(mode, shortcut, cmd)
	vim.api.nvim_set_keymap(mode, shortcut, cmd, {noremap = true, silent = true	})
end


function nmap(shortcut, cmd)
	map("n", shortcut, cmd)
end


function imap(shortcut, cmd)
	map("i", shortcut, cmd)
end


function vmap(shortcut, cmd)
	map("v", shortcut, cmd)
end


function cmap(shortcut, cmd)
	map("c", shortcut, cmd)
end



-- sane regexes
-- after / actually /\\v, will use "very magic" mode
nmap("/", "/\\v")
vmap("/", "/\\v")


-- Easy window split
nmap("vv", "<C-w>v")
nmap("ss", "<C-w>s")
vim.o.splitbelow = true -- when splitting horizontally, move coursor to lower pane
vim.o.splitright = true -- when splitting vertically, mnove coursor to right pane


-- Easy buffer navigation
nmap("<C-h>", "<C-w>h")
nmap("<C-j>", "<C-w>j")
nmap("<C-k>", "<C-w>k")
nmap("<C-l>", "<C-w>l")


-- Programing
nmap("<leader>sh", ":!")
nmap("<leader>py", ":!python")
nmap("<leader>pt", ":!python -m pytest")
