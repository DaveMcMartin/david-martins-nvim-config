local palette = require("catppuccin.palettes").get_palette("mocha")

require("bufferline").setup({
  options = {
    mode = "tabs",
  },
  highlights = {
    fill = { bg = "NONE" },
    background = { fg = palette.overlay1, bg = "NONE" },
    buffer_visible = { fg = palette.overlay1, bg = "NONE" },
    buffer_selected = { fg = palette.text, bg = "NONE", bold = true, italic = false },
    tab = { fg = palette.overlay1, bg = "NONE" },
    tab_selected = { fg = palette.blue, bg = "NONE", bold = true },
    tab_separator = { fg = palette.surface1, bg = "NONE" },
    tab_separator_selected = { fg = palette.blue, bg = "NONE" },
    separator = { fg = palette.surface1, bg = "NONE" },
    separator_selected = { fg = palette.blue, bg = "NONE" },
    indicator_selected = { fg = palette.blue, bg = "NONE" },
    modified = { fg = palette.peach, bg = "NONE" },
    modified_selected = { fg = palette.peach, bg = "NONE" },
    close_button = { fg = palette.overlay1, bg = "NONE" },
    close_button_selected = { fg = palette.red, bg = "NONE" },
  },
})
