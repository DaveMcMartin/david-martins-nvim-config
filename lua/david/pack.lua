-- Install and configure plugins with Neovim's built-in vim.pack.
-- Works the same on Linux and macOS: plugins are cloned into
-- stdpath("data")/site/pack/core/opt on first launch.
--
-- A checkout that still has manual clones under pack/plugins/start (gitignored)
-- must not load those as well. They are added to the runtimepath only after
-- init.lua, which is too late for the requires below, and loading both copies
-- would run every plugin script twice.

local M = {}

local function github(repo)
  return "https://github.com/" .. repo
end

local function skip_legacy_pack_clones()
  local config = vim.fn.fnamemodify(vim.fn.stdpath("config"), ":p"):gsub("/$", "")
  local kept = {}
  for _, entry in ipairs(vim.opt.packpath:get()) do
    local normalized = vim.fn.fnamemodify(entry, ":p"):gsub("/$", "")
    if normalized ~= config then
      kept[#kept + 1] = entry
    end
  end
  vim.opt.packpath = kept
end

-- Branches the config was written against. Everything else tracks the default branch.
local plugins = {
  { src = github("catppuccin/nvim"), name = "catppuccin" },
  github("rcarriga/nvim-notify"),
  github("stevearc/dressing.nvim"),
  github("nvim-tree/nvim-web-devicons"),
  github("nvim-lua/plenary.nvim"),
  github("MunifTanjim/nui.nvim"),

  -- main is required on Neovim 0.12. master is frozen and its queries crash the highlighter.
  { src = github("nvim-treesitter/nvim-treesitter"), version = "main" },
  { src = github("nvim-treesitter/nvim-treesitter-textobjects"), version = "main" },

  -- v1 still applies the handlers table in lspconfig.lua. v2 ignores it.
  { src = github("mason-org/mason.nvim"), version = "v1.11.0" },
  github("WhoIsSethDaniel/mason-tool-installer.nvim"),
  github("neovim/nvim-lspconfig"),
  { src = github("mason-org/mason-lspconfig.nvim"), version = "v1.32.0" },
  github("hrsh7th/cmp-nvim-lsp"),
  github("folke/neodev.nvim"),
  github("mfussenegger/nvim-lint"),
  github("nvim-flutter/flutter-tools.nvim"),

  github("folke/which-key.nvim"),
  github("akinsho/bufferline.nvim"),
  github("nvim-lualine/lualine.nvim"),
  github("lukas-reineke/indent-blankline.nvim"),
  { src = github("nvim-neo-tree/neo-tree.nvim"), version = "v3.x" },
  github("s1n7ax/nvim-window-picker"),
  { src = github("nvim-telescope/telescope.nvim"), version = "0.1.x" },
  github("nvim-telescope/telescope-fzf-native.nvim"),
  github("folke/noice.nvim"),
  github("folke/todo-comments.nvim"),
  github("folke/trouble.nvim"),
  github("szw/vim-maximizer"),
  github("hrsh7th/nvim-cmp"),
  github("hrsh7th/cmp-buffer"),
  github("hrsh7th/cmp-path"),
  github("hrsh7th/cmp-cmdline"),
  github("onsails/lspkind.nvim"),

  github("windwp/nvim-autopairs"),
  github("numToStr/Comment.nvim"),
  github("JoosepAlviste/nvim-ts-context-commentstring"),
  github("stevearc/conform.nvim"),
  github("nvim-neotest/nvim-nio"),
  github("nvim-neotest/neotest"),
  github("Issafalcon/neotest-dotnet"),
  github("nvim-neotest/neotest-jest"),
  github("antoinemadec/FixCursorHold.nvim"),
  github("gbprod/substitute.nvim"),
  github("kylechui/nvim-surround"),
  github("ThePrimeagen/vim-be-good"),

  github("lewis6991/gitsigns.nvim"),
  github("kdheepak/lazygit.nvim"),

  github("mfussenegger/nvim-dap"),
  github("rcarriga/nvim-dap-ui"),
  github("theHamsta/nvim-dap-virtual-text"),
  github("mxsdev/nvim-dap-vscode-js"),
}

local function on_pack_changed(ev)
  local name, kind = ev.data.spec.name, ev.data.kind
  if name == "telescope-fzf-native.nvim" and (kind == "install" or kind == "update") then
    local result = vim.system({ "make" }, { cwd = ev.data.path }):wait()
    if result.code ~= 0 then
      vim.notify("telescope-fzf-native build failed:\n" .. (result.stderr or ""), vim.log.levels.ERROR)
    end
  end
end

M.setup = function()
  if vim.fn.has("nvim-0.12") == 0 or vim.pack == nil then
    error("This config needs Neovim 0.12 or newer for vim.pack")
  end

  skip_legacy_pack_clones()

  -- Registered before add() so the fzf native extension is built on install.
  vim.api.nvim_create_autocmd("PackChanged", { callback = on_pack_changed })

  -- confirm = false: install missing plugins without a prompt, including headless.
  -- load stays at the init.lua default (false): modules are require()-able now,
  -- and plugin scripts are sourced once later in startup.
  vim.pack.add(plugins, { confirm = false })

  require("david.plugins.ui.colorscheme")
  require("david.plugins.ui.notify")
  require("david.plugins.ui.dressing")

  require("david.plugins.treesitter")

  require("david.plugins.lsp")

  require("david.plugins.ui.which-key")
  require("david.plugins.ui.bufferline")
  require("david.plugins.ui.lualine")
  require("david.plugins.ui.indent-blankline")
  require("david.plugins.ui.neo-tree")
  require("david.plugins.ui.telescope")
  require("david.plugins.ui.noice")
  require("david.plugins.ui.todo-comments")
  require("david.plugins.ui.trouble")
  require("david.plugins.ui.vim-maximizer")
  require("david.plugins.ui.nvim-cmp")

  require("david.plugins.editor")

  require("david.plugins.git")

  require("david.plugins.dap")
end

return M
