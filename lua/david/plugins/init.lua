return {
  -- Core
  "nvim-lua/plenary.nvim", -- lua functions that many plugins use

  -- Utils
  { import = "david.plugins.utils" },

  -- UI
  { import = "david.plugins.ui" },

  -- TreeSitter
  { import = "david.plugins.treesitter" },

  -- Git
  { import = "david.plugins.git" },

  -- Editor
  { import = "david.plugins.editor" },

  -- AI
  { import = "david.plugins.ai" },

  -- DAP
  { import = "david.plugins.dap" },
}