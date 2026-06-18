require("telescope").setup({
  defaults = {
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.55 },
    file_ignore_patterns = {
      "node_modules", ".git/", "__pycache__", "%.pyc",
      "%.o", "%.so", "%.a", "%.class",
    },
    mappings = {
      i = {
        ["<C-j>"] = "move_selection_next",
        ["<C-k>"] = "move_selection_previous",
        ["<esc>"] = "close",
      },
    },
  },
  pickers = {
    find_files = { hidden = true },
    live_grep = { additional_args = function() return { "--hidden" } end },
  },
})
