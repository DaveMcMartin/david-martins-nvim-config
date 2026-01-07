local neotree = require("neo-tree")
local keymap = vim.keymap

require("window-picker").setup({})

neotree.setup({
      event_handlers = {
        {
          event = "neo_tree_buffer_enter",
          handler = function(arg)
            vim.cmd([[
          setlocal relativenumber
        ]])
          end,
        },
      },
      filesystem = {
        filtered_items = {
          visible = true,
        },
        commands = {
        },
        window = {
          mappings = {
            ["<tab>"] = { "toggle_preview", config = { use_float = true, use_image_nvim = false } },
            ["<leader>ec"] = "close_all_nodes",
          },
        },
      },
    })

keymap.set("n", "<leader>ee", "<cmd>Neotree filesystem toggle left<cr>", { desc = "Toggle file explorer" })
keymap.set("n", "<leader>eb", "<cmd>Neotree buffers toggle right<cr>", { desc = "Toggle buffer explorer" })
