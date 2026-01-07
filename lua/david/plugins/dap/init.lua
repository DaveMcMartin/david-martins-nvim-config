local dap = require("dap")
local dapui = require("dapui")

dapui.setup()
require("nvim-dap-virtual-text").setup({})

    -- highlight current Breakpoint Line
    local sign = vim.fn.sign_define

    sign("DapBreakpoint", { text = "●", texthl = "DapBreakpoint", linehl = "", numhl = "" })
    sign("DapBreakpointCondition", { text = "●", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
    sign("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })
    sign("DapStopped", { text = "", texthl = "DapStopped", linehl = "DapStopped", numhl = "DapStopped" })

    -- Function to find the main project file and its corresponding DLL
    local function find_main_project()
      -- First, find Program.cs
      local program_cs = vim.fn.glob("**/Program.cs", false, true)
      if #program_cs == 0 then
        print("No Program.cs found in the workspace")
        return nil
      end

      -- Get the directory containing Program.cs
      local program_dir = vim.fn.fnamemodify(program_cs[1], ":h")

      -- Find the corresponding .csproj file in the same directory
      local csproj_files = vim.fn.glob(program_dir .. "/*.csproj", false, true)
      if #csproj_files == 0 then
        print("No .csproj file found in the Program.cs directory")
        return nil
      end

      return csproj_files[1]
    end

    local function get_dll_path()
      local main_project = find_main_project()
      if not main_project then
        return nil
      end

      -- Build the project
      local project_dir = vim.fn.fnamemodify(main_project, ":h")
      local project_name = vim.fn.fnamemodify(main_project, ":t:r")

      -- Run dotnet build
      local result = vim.fn.system(string.format("dotnet build -c Debug %s", main_project))
      if vim.v.shell_error ~= 0 then
        print("Build failed: " .. result)
        return nil
      end

      -- Look for the DLL in standard output paths
      local possible_paths = {
        string.format("%s/bin/Debug/net9.0/%s.dll", project_dir, project_name),
        string.format("%s/bin/Debug/net8.0/%s.dll", project_dir, project_name),
        string.format("%s/bin/Debug/net7.0/%s.dll", project_dir, project_name),
        string.format("%s/bin/Debug/net6.0/%s.dll", project_dir, project_name),
      }

      for _, path in ipairs(possible_paths) do
        if vim.fn.filereadable(path) == 1 then
          return path
        end
      end

      print("Could not find DLL file after build")
      return nil
    end

-- C# setup
local netcoredbg_path = vim.fn.exepath("netcoredbg")

if netcoredbg_path ~= "" then
  dap.adapters.coreclr = {
    type = "executable",
    command = netcoredbg_path,
    args = { "--interpreter=vscode" },
    env = {
      ASPNETCORE_ENVIRONMENT = "development",
    },
  }
  dap.adapters.netcoredbg = vim.deepcopy(dap.adapters.coreclr)
end

dap.configurations.cs = {
  {
    type = "coreclr",
    name = "Launch - .NET Core",
    request = "launch",
    program = function()
      return get_dll_path() or ""
    end,
    cwd = "${workspaceFolder}",
    stopAtEntry = false,
    env = {
      ASPNETCORE_ENVIRONMENT = "development",
    },
  },
}

-- JavaScript/TypeScript setup (unchanged)
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

-- Key mappings (unchanged)
vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.keymap.set("n", "<leader>gb", dap.run_to_cursor, { desc = "Run to Cursor" })
vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Continue" })
vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Step Into" })
vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Step Over" })
vim.keymap.set("n", "<leader>dt", dap.step_out, { desc = "Step Out" })
vim.keymap.set("n", "<leader>db", dap.step_back, { desc = "Step Back" })
vim.keymap.set("n", "<leader>dr", dap.restart, { desc = "Restart Debug" })
vim.keymap.set("n", "<leader>?", function()
  dapui.eval(nil, { enter = true })
end)
vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Toggle DAP UI" })

-- DAP UI event handlers (unchanged)
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end

dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end

dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
