return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "Cliffback/netcoredbg-macOS-arm64.nvim",
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    "mxsdev/nvim-dap-vscode-js", -- JavaScript/TypeScript adapter
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- Setup dependencies
    require("netcoredbg-macOS-arm64").setup(dap)
    dapui.setup()
    require("nvim-dap-virtual-text").setup({})

    -- C# setup
    local netcoredbg_path = vim.fn.exepath("netcoredbg")
    if netcoredbg_path ~= "" then
      dap.adapters.netcoredbg = {
        type = "executable",
        command = netcoredbg_path,
        args = { "--interpreter=vscode" },
      }
    end

    -- JavaScript/TypeScript setup
    require("dap-vscode-js").setup({
      adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
    })

    for _, language in ipairs({ "typescript", "javascript" }) do
      dap.configurations[language] = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }
    end

    -- Key mappings for DAP actions
    vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>gb", dap.run_to_cursor, { desc = "Run to Cursor" })
    vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
    vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
    vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
    vim.keymap.set("n", "<leader>dt", dap.step_out, { desc = "Step Out" })
    vim.keymap.set("n", "<leader>db", dap.step_back, { desc = "Step back" })
    vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "Restart Debug" })
    vim.keymap.set("n", "<leader>?", function()
      dapui.eval(nil, { enter = true })
    end)
    vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })

    -- DAP UI open/close on events
    dap.listeners.before["dapui_config"] = function()
      dapui.open()
    end

    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end

    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end,
}
