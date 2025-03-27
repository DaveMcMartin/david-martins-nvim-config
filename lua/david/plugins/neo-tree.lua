return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    { "3rd/image.nvim", opts = {} },
    {
      "s1n7ax/nvim-window-picker",
      name = "window-picker",
      event = "VeryLazy",
      version = "2.*",
      opts = {},
    },
  },
  config = function()
    local neotree = require("neo-tree")
    local keymap = vim.keymap

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
          avante_add_files = function(state)
            local node = state.tree:get_node()
            local filepath = node:get_id()
            local relative_path = require("avante.utils").relative_path(filepath)

            local sidebar = require("avante").get()

            local open = sidebar:is_open()
            -- ensure avante sidebar is open
            if not open then
              require("avante.api").ask()
              sidebar = require("avante").get()
            end

            sidebar.file_selector:add_selected_file(relative_path)

            -- remove neo tree buffer
            if not open then
              sidebar.file_selector:remove_selected_file("neo-tree filesystem [1]")
            end
          end,
        },
        window = {
          mappings = {
            ["oa"] = "avante_add_files",
            ["<tab>"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
            ["<leader>ec"] = "close_all_nodes",
          },
        },
      },
    })

    keymap.set("n", "<leader>ee", "<cmd>Neotree filesystem toggle left<cr>", { desc = "Toggle file explorer" })
    keymap.set("n", "<leader>eb", "<cmd>Neotree buffers toggle right<cr>", { desc = "Toggle buffer explorer" })
  end,
}
