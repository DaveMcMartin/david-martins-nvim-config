-- TreeSitter configuration
require("nvim-treesitter").setup({
  ensure_installed = {
    "bash",
    "c",
    "c_sharp",
    "css",
    "dart",
    "dockerfile",
    "gitignore",
    "go",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "markdown_inline",
    "python",
    "query",
    "rust",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
  },
  auto_install = true,
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-space>",
      node_incremental = "<C-space>",
      scope_incremental = false,
      node_decremental = "<bs>",
    },
  },
})