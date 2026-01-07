local keymap = vim.keymap

keymap.set("n", "<leader>xx", "<cmd>Trouble<CR>", { desc = "Toggle Trouble list" })
keymap.set("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<CR>", { desc = "Workspace Diagnostics" })
keymap.set("n", "<leader>xd", "<cmd>Trouble document_diagnostics<CR>", { desc = "Document Diagnostics" })
keymap.set("n", "<leader>xl", "<cmd>Trouble loclist<CR>", { desc = "Location List" })
keymap.set("n", "<leader>xq", "<cmd>Trouble quickfix<CR>", { desc = "Quickfix List" })

require("trouble").setup({})
