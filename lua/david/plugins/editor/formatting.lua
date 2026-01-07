local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    javascript = { "prettier" },
    typescript = { "prettier" },
    javascriptreact = { "prettier" },
    typescriptreact = { "prettier" },
    css = { "prettier" },
    html = { "prettier" },
    xml = { "prettier" },
    json = { "prettier" },
    yaml = { "yamlfix" },
    markdown = { "prettier" },
    graphql = { "prettier" },
    lua = { "stylua" },
    python = { "black" },
    csharp = { "csharpier" },
    ruby = { "rubocop" },
    eruby = { "rubocop" },
  },
  format_on_save = false,
})

vim.keymap.set({ "n", "v" }, "<leader>fc", function()
  conform.format({
    lsp_fallback = true,
    async = false,
    timeout_ms = 1000,
  })
end, { desc = "Format file or range (in visual mode)" })
