local neotest = require("neotest")

neotest.setup({
  adapters = {
    require("neotest-dotnet")({
      discovery_root = "solution",
    }),
    require("neotest-jest")({
      jestCommand = "npm test --",
      jestConfigFile = "custom.jest.config.ts",
      env = { CI = true },
      cwd = function(path)
        return vim.fn.getcwd()
      end,
    }),
  },
})

-- set keymaps
local keymap = vim.keymap -- for conciseness

keymap.set("n", "<leader>tt", function()
  neotest.summary.open()
  neotest.run.run()
end, { desc = "Run nearest test" })

keymap.set("n", "<leader>tf", function()
  neotest.summary.open()
  neotest.run.run(vim.fn.expand("%"))
end, { desc = "Run current file" })

keymap.set("n", "<leader>td", function()
  neotest.run.run({ strategy = "dap" })
end, { desc = "Run nearest test in debug mode" })

keymap.set("n", "<leader>ts", function()
  neotest.run.stop()
  neotest.summary.close()
end, { desc = "Stop running the neared test" })

keymap.set("n", "<leader>tc", function()
  neotest.summary.toggle()
end, { desc = "Toggle test summary" })
