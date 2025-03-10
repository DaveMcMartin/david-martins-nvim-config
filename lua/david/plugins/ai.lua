return {
  "olimorris/codecompanion.nvim",
  config = true,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    local codecompanion = require("codecompanion")
    codecompanion.setup({
      strategies = {
        chat = {
          adapter = "deepseek",
        },
        inline = {
          adapter = "deepseek",
        },
      },
    })
  end,
}
