-- nvim-treesitter main branch. Neovim 0.12 does not support the frozen master branch:
-- its queries call node:range() on a nil capture and crash the highlighter.
local ts = require("nvim-treesitter")

-- Guard the master-branch module, which has no install(). vim.pack switches
-- branches on the next update, and calling the old setup enables the queries
-- that crash Neovim 0.12.
if type(ts.install) ~= "function" then
  vim.notify("nvim-treesitter is still on master; skipping setup until it updates to main", vim.log.levels.WARN)
  return
end

ts.setup({
  install_dir = vim.fn.stdpath("data") .. "/site",
})

local languages = {
  "bash",
  "c",
  "c_sharp",
  "css",
  "dart",
  "dockerfile",
  "gitignore",
  "go",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "rust",
  "svelte",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "yaml",
}

-- Install the configured parsers. Already-installed parsers are left alone.
ts.install(languages)

local group = vim.api.nvim_create_augroup("david_treesitter", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = group,
  callback = function(args)
    local filetype = args.match
    -- Some filetypes share a parser (for example typescriptreact -> tsx).
    local lang = vim.treesitter.language.get_lang(filetype) or filetype
    if not lang or lang == "" then
      return
    end

    if not vim.treesitter.language.add(lang) then
      return
    end

    vim.treesitter.start(args.buf, lang)
    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
  end,
})

-- Replacements for the master-branch incremental_selection module.
-- Neovim 0.12 selects nodes with vim.treesitter.select().
vim.keymap.set({ "n", "x" }, "<C-space>", function()
  vim.treesitter.select("parent")
end, { desc = "Expand treesitter selection" })

vim.keymap.set("x", "<bs>", function()
  vim.treesitter.select("child")
end, { desc = "Shrink treesitter selection" })
