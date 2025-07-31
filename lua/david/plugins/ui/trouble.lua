return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = { "Trouble", "TroubleToggle" },
  keys = {
    { "<leader>xx", "<cmd>Trouble<CR>", desc = "Toggle Trouble list" },
    { "<leader>xw", "<cmd>Trouble workspace_diagnostics<CR>", desc = "Workspace Diagnostics" },
    { "<leader>xd", "<cmd>Trouble document_diagnostics<CR>", desc = "Document Diagnostics" },
    { "<leader>xl", "<cmd>Trouble loclist<CR>", desc = "Location List" },
    { "<leader>xq", "<cmd>Trouble quickfix<CR>", desc = "Quickfix List" },
  },
  config = function()
    require("trouble").setup({})
  end,
}
