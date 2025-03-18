return {
  "saghen/blink.pairs",
  version = "*",
  dependencies = "saghen/blink.download",
  opts = {
    mappings = {
      enabled = true,
      pairs = {
        ["("] = ")",
        ["["] = "]",
        ["{"] = "}",
        ["'"] = { closing = "'", enter = false },
        ['"'] = { closing = '"', enter = false },
        ["`"] = { closing = "`", enter = false },
      },
    },
    highlights = {
      enabled = true,
      groups = {
        "RainbowOrange",
        "RainbowPurple",
        "RainbowBlue",
      },
      priority = 200,
      ns = vim.api.nvim_create_namespace("blink.pairs"),
    },
    debug = false,
  },
}
