local map = vim.keymap.set

-- ===== General =====
map("n", ";", ":")
map("n", "<leader>s", "<cmd>source $MYVIMRC<cr>", { desc = "Reload config" })
map("n", "<C-b>", "<cmd>noh<cr>", { desc = "Clear highlights" })

-- Clipboard
map("v", "<leader>y", '"+y', { desc = "Copy to system clipboard" })
map("n", "<leader>p", '"+p', { desc = "Paste from system clipboard" })

-- ===== Window navigation =====
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

-- Split
map("n", "vv", "<C-w>v", { desc = "Vertical split" })
map("n", "ss", "<C-w>s", { desc = "Horizontal split" })

-- Resize
map("n", "<C-Up>", "<cmd>resize +2<cr>")
map("n", "<C-Down>", "<cmd>resize -2<cr>")
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>")
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>")

-- ===== Telescope =====
map("n", "<leader>l", "<cmd>Telescope find_files<cr>", { desc = "Find files" })
map("n", "<leader>rg", "<cmd>Telescope live_grep<cr>", { desc = "Live grep" })
map("n", "<leader>lb", "<cmd>Telescope buffers<cr>", { desc = "Buffers" })
map("n", "<leader>lm", "<cmd>Telescope oldfiles<cr>", { desc = "Recent files" })
map("n", "<leader>ll", "<cmd>Telescope current_buffer_fuzzy_find<cr>", { desc = "Buffer lines" })
map("n", "<leader>lf", "<cmd>Telescope lsp_document_symbols<cr>", { desc = "Symbols" })
map("n", "<leader>ld", "<cmd>Telescope diagnostics<cr>", { desc = "Diagnostics" })

-- ===== Git =====
map("n", "<leader>g", "<cmd>Git<cr>", { desc = "Git status" })
map("n", "<leader>G", "<cmd>Gdiffsplit<cr>", { desc = "Git diff" })

-- ===== LSP (set in lsp.lua on_attach, duplicated here for which-key) =====
map("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "gr", vim.lsp.buf.references, { desc = "References" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover doc" })
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })

-- ===== Formatter =====
map("n", "<leader>f", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format" })

-- ===== Shell =====
map("n", "<leader>sh", ":!")
map("n", "<leader>py", "<cmd>!python3 %<cr>", { desc = "Run python" })

-- ===== Lazy =====
map("n", "<leader>i", "<cmd>Lazy install<cr>", { desc = "Install plugins" })
map("n", "<leader>u", "<cmd>Lazy update<cr>", { desc = "Update plugins" })
