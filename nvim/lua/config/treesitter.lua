-- nvim 0.10+: treesitter is built-in, plugin just provides :TSInstall
vim.treesitter.language.register("markdown", "mdx")

-- ensure parsers are installed
local ok, ts_install = pcall(require, "nvim-treesitter.install")
if ok then
  ts_install.prefer_git = false
end

-- try legacy API first, fall back to built-in config
local ok2, ts_configs = pcall(require, "nvim-treesitter.configs")
if ok2 then
  ts_configs.setup({
    ensure_installed = {
      "python", "rust", "go", "lua",
      "javascript", "typescript", "tsx",
      "json", "yaml", "toml", "markdown",
      "bash", "dockerfile", "html", "css",
      "vimdoc", "query",
    },
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<cr>",
        node_incremental = "<cr>",
        node_decremental = "<bs>",
        scope_incremental = "<tab>",
      },
    },
  })
else
  -- nvim 0.12+: just install parsers, highlighting is built-in
  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyDone",
    once = true,
    callback = function()
      local parsers = {
        "python", "rust", "go", "lua",
        "javascript", "typescript", "tsx",
        "json", "yaml", "toml", "markdown",
        "bash", "dockerfile", "html", "css",
        "vimdoc", "query",
      }
      vim.cmd("TSInstall " .. table.concat(parsers, " "))
    end,
  })
end
