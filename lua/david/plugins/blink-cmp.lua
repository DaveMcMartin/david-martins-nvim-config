return {
  "saghen/blink.cmp",
  dependencies = {
    "rafamadriz/friendly-snippets",
    "Kaiser-Yang/blink-cmp-avante",
    "folke/noice.nvim",
    {
      "saghen/blink.compat",
      version = "*",
      lazy = true,
      opts = {
        impersonate_nvim_cmp = true,
      },
    },
  },
  version = "*",
  opts = {
    keymap = {
      preset = "super-tab",
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-b>"] = { "scroll_documentation_up", "fallback" },
      ["<C-f>"] = { "scroll_documentation_down", "fallback" },
      ["<C-s>"] = { "show", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = "Nerd Font",
    },
    sources = {
      providers = {
        avante = {
          module = "blink-cmp-avante",
          name = "Avante",
          opts = {},
        },
      },
      default = { "avante", "lsp", "snippets", "buffer", "path" },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 500 },
      ghost_text = { enabled = true },
      menu = {
        draw = {
          columns = {
            { "kind_icon", "label", "label_description", gap = 1 },
            { "source_name" },
          },
        },
      },
    },
    signature = { enabled = true },
  },
  opts_extend = { "sources.default" },
}
