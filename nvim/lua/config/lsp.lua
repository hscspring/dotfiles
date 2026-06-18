require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "pyright",
    "lua_ls",
    "rust_analyzer",
  },
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- nvim 0.11+: use vim.lsp.config if available, fall back to lspconfig
if vim.lsp.config then
  vim.lsp.config("pyright", { capabilities = capabilities })
  vim.lsp.config("rust_analyzer", { capabilities = capabilities })
  vim.lsp.config("gopls", { capabilities = capabilities })
  vim.lsp.config("ts_ls", { capabilities = capabilities })
  vim.lsp.config("lua_ls", {
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = { checkThirdParty = false },
      },
    },
  })
  vim.lsp.enable({ "pyright", "rust_analyzer", "gopls", "ts_ls", "lua_ls" })
else
  local lspconfig = require("lspconfig")
  local servers = { "pyright", "rust_analyzer", "gopls", "ts_ls" }
  for _, server in ipairs(servers) do
    lspconfig[server].setup({ capabilities = capabilities })
  end
  lspconfig.lua_ls.setup({
    capabilities = capabilities,
    settings = {
      Lua = {
        diagnostics = { globals = { "vim" } },
        workspace = { checkThirdParty = false },
      },
    },
  })
end

vim.diagnostic.config({
  virtual_text = { prefix = "●" },
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})
