-- Native Vim Pack plugin loader
-- Plugins are loaded from pack/plugins/start automatically
-- This file sets up plugin configurations

local M = {}

M.setup = function()
  -- Load plugin configurations in the correct order
  -- Dependencies first, then features
  
  -- Core dependencies
  require("david.plugins.ui.colorscheme")
  require("david.plugins.ui.notify")
  require("david.plugins.ui.dressing")
  
  -- TreeSitter (needed by many plugins)
  require("david.plugins.treesitter")
  
  -- LSP
  require("david.plugins.lsp")
  
  -- UI components
  require("david.plugins.ui.which-key")
  require("david.plugins.ui.bufferline")
  require("david.plugins.ui.lualine")
  require("david.plugins.ui.indent-blankline")
  require("david.plugins.ui.neo-tree")
  require("david.plugins.ui.telescope")
  require("david.plugins.ui.noice")
  require("david.plugins.ui.todo-comments")
  require("david.plugins.ui.trouble")
  require("david.plugins.ui.vim-maximizer")
  require("david.plugins.ui.nvim-cmp")
  
  -- Editor features
  require("david.plugins.editor")
  
  -- Git
  require("david.plugins.git")
  
  -- DAP
  require("david.plugins.dap")
end

return M
