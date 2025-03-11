return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    local codecompanion = require("codecompanion")
    local keymap = vim.keymap -- for conciseness

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

    keymap.set("n", "<leader>cc", "<cmd>CodeCompanionChat<CR>", { desc = "Opens code companion chat" })
    keymap.set("n", "<leader>co", "<cmd>CodeCompanionActions<CR>", { desc = "Opens code companion actions" })
  end,
}
