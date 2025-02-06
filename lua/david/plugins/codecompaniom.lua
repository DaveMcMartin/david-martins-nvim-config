return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    local codecompanion = require("codecompanion")
    codecompanion.setup({
      strategies = {
        chat = {
          adapter = "ollama",
        },
        inline = {
          adapter = "ollama",
        },
      },
    })
  end,
  keys = {
    { "<leader>ch", "<cmd>CodeCompanionChat Toggle<cr>", desc = "Opens code companion" },
    { "<leader>cc", "<cmd>CodeCompanionActions<cr>", desc = "Opens code companion actions" },
    { "<leader>ci", "<cmd>CodeCompanionChat Add<cr>", desc = "Add selected text to chat" },
  },
}
