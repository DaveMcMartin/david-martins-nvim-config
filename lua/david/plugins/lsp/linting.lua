local lint = require("lint")

lint.linters_by_ft = {
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  python = { "pylint" },
  erb = { "erb_lint" },
}

-- Add a custom path for pylint
lint.linters.pylint.cmd = vim.fn.expand("~") .. "/.local/share/nvim/mason/bin/pylint"

local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  group = lint_augroup,
  callback = function()
    lint.try_lint()
  end,
})

vim.keymap.set("n", "<leader>l", function()
  lint.try_lint()
end, { desc = "Trigger linting for current file" })
