return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "Cliffback/netcoredbg-macOS-arm64.nvim",
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio",
    "theHamsta/nvim-dap-virtual-text",
    "leoluz/nvim-dap-go", -- Go adapter
    "mxsdev/nvim-dap-vscode-js", -- JavaScript/TypeScript adapter
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- Setup dependencies
    require("netcoredbg-macOS-arm64").setup(dap)
    dapui.setup()
    require("dap-go").setup()
    require("nvim-dap-virtual-text").setup({})

    -- Elixir setup
    local elixir_ls_debugger = vim.fn.exepath("elixir-ls-debugger")
    if elixir_ls_debugger ~= "" then
      dap.adapters.mix_task = {
        type = "executable",
        command = elixir_ls_debugger,
      }

      dap.configurations.elixir = {
        {
          type = "mix_task",
          name = "phoenix server",
          task = "phx.server",
          request = "launch",
          projectDir = "${workspaceFolder}",
          exitAfterTaskReturns = false,
          debugAutoInterpretAllModules = false,
        },
      }
    end

    -- C# setup
    local netcoredbg_path = vim.fn.exepath("netcoredbg")
    if netcoredbg_path ~= "" then
      dap.adapters.coreclr = {
        type = "executable",
        command = netcoredbg_path,
        args = { "--interpreter=vscode" },
      }

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "Launch - NetCoreDbg",
          request = "launch",
          program = function()
            return vim.fn.input("Path to DLL: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
          end,
        },
      }
    end

    -- Go debugger setup
    dap.adapters.go = function(callback, config)
      local handle
      local port = 38697
      handle = vim.loop.spawn("dlv", {
        args = { "dap", "-l", "127.0.0.1:" .. port },
      }, function(code)
        handle:close()
        print("Delve exited with exit code: " .. code)
      end)
      -- Wait for delve to start
      vim.defer_fn(function()
        dap.repl.open()
        callback({
          type = "server",
          host = "127.0.0.1",
          port = port,
        })
      end, 100)
    end

    dap.configurations.go = {
      {
        type = "go",
        name = "Debug",
        request = "launch",
        program = "${file}",
      },
    }

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
    local keymaps = {
      ["<leader>b"] = dap.toggle_breakpoint,
      ["<leader>gb"] = dap.run_to_cursor,
      ["<leader>dc"] = dap.continue,
      ["<leader>di"] = dap.step_into,
      ["<leader>do"] = dap.step_over,
      ["<leader>dt"] = dap.step_out,
      ["<leader>db"] = dap.step_back,
      ["<leader>dr"] = dap.restart,
      ["<leader>?"] = function()
        dapui.eval(nil, { enter = true })
      end,
      -- DAP UI
      ["<leader>du"] = dapui.toggle, -- Toggle DAP UI
    }

    for key, cmd in pairs(keymaps) do
      vim.keymap.set("n", key, cmd)
    end

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
