return {
  "nvim-flutter/flutter-tools.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "stevearc/dressing.nvim", -- Optional, for a better UI
  },
  config = function()
    require("flutter-tools").setup({})
  end,
}
