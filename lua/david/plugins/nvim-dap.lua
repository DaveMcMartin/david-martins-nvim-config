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
      dap.adapters.coreclr = {
        type = "executable",
        command = netcoredbg_path,
        args = { "--interpreter=vscode" },
      }

      -- Helper function to read project type from .csproj file
      local function is_executable_project(csproj_path)
        local file = io.open(csproj_path, "r")
        if not file then
          return false
        end
        local content = file:read("*all")
        file:close()
        -- Check if it's an executable project
        return content:match("<OutputType>Exe</OutputType>") ~= nil
      end

      dap.configurations.cs = {
        {
          type = "coreclr",
          name = "Launch - NetCoreDbg",
          request = "launch",
          program = function()
            -- Find all .csproj files
            local handle = io.popen('find "' .. vim.fn.getcwd() .. '" -name "*.csproj"')
            local result = handle:read("*a")
            handle:close()

            local csproj_files = {}
            for path in result:gmatch("[^\n]+") do
              table.insert(csproj_files, path)
            end

            if #csproj_files == 0 then
              print("No .csproj files found.")
              return nil
            end

            -- Prioritize projects based on common patterns
            local function get_project_priority(path)
              local filename = vim.fn.fnamemodify(path, ":t:r")
              local is_exe = is_executable_project(path)

              -- Highest priority: Executable projects with common main project names
              if is_exe then
                if
                  filename:match("%.Web$")
                  or filename:match("%.Api$")
                  or filename:match("%.Host$")
                  or filename:match("%.Service$")
                then
                  return 1
                end
                -- Second priority: Any executable project
                return 2
              end

              -- Third priority: Non-executable projects with common main project names
              if
                filename:match("%.Web$")
                or filename:match("%.Api$")
                or filename:match("%.Host$")
                or filename:match("%.Service$")
              then
                return 3
              end

              -- Lowest priority: Other projects
              return 4
            end

            -- Sort projects by priority
            table.sort(csproj_files, function(a, b)
              return get_project_priority(a) < get_project_priority(b)
            end)

            -- Function to find corresponding dll/exe
            local function find_output_file(csproj_path)
              local project_dir = vim.fn.fnamemodify(csproj_path, ":h")
              local project_name = vim.fn.fnamemodify(csproj_path, ":t:r")

              local possible_extensions = { ".dll", ".exe" }
              local possible_frameworks = { "net9.0", "net8.0", "net7.0", "net6.0", "net5.0" }

              for _, ext in ipairs(possible_extensions) do
                for _, fw in ipairs(possible_frameworks) do
                  local path = project_dir .. "/bin/Debug/" .. fw .. "/" .. project_name .. ext
                  if vim.fn.filereadable(path) == 1 then
                    return path
                  end
                end
              end

              return nil
            end

            -- Try to find the output file for each project in priority order
            for _, csproj_path in ipairs(csproj_files) do
              local output_path = find_output_file(csproj_path)
              if output_path then
                print("Using output file: " .. output_path)
                return output_path
              end
            end

            -- If no output file is found automatically, fall back to manual input
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
          end,
        },
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
