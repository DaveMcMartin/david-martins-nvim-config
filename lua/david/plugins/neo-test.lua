return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "Issafalcon/neotest-dotnet",
    "nvim-neotest/neotest-jest",
  },
  config = function()
    local neotest = require("neotest")

    neotest.setup({
      adapters = {
        require("neotest-dotnet"),
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
      neotest.run.run()
    end, { desc = "Run nearest test" })

    keymap.set("n", "<leader>ti", function()
      neotest.run.run(vim.fn.expand("%"))
    end, { desc = "Run current file" })

    keymap.set("n", "<leader>td", function()
      neotest.run.run({ strategy = "dap" })
    end, { desc = "Run nearest file in debug mode" })

    keymap.set("n", "<leader>ts", function()
      neotest.run.stop()
    end, { desc = "Stop running the neared test" })

    keymap.set("n", "<leader>ta", function()
      neotest.run.attach()
    end, { desc = "Attach to the nearest test" })
  end,
}
