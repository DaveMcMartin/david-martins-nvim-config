local lualine = require("lualine")

lualine.setup({
      options = {
        theme = "catppuccin-mocha",
      },
      sections = {
        lualine_x = {
          { "encoding" },
          { "fileformat" },
          { "filetype" },
        },
    },
  })
