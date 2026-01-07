require("noice").setup({
  views = {
    cmdline_popup = {
      position = {
        row = 5,
        col = "50%",
      },
      size = {
        width = 60,
        height = "auto",
      },
    },
    popupmenu = {
      relative = "editor",
      position = {
        row = 8,
        col = "50%",
      },
      size = {
        width = 60,
        height = 10,
      },
      border = {
        style = "rounded",
        padding = { 0, 1 },
      },
      win_options = {
        winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
      },
    },
  },
  routes = {
    {
      view = "notify",
      filter = { event = "msg_showmode" },
    },
    {
      filter = {
        event = "msg_show",
        kind = "",
        find = "search hit BOTTOM",
      },
      opts = { skip = true },
    },
    {
      filter = {
        event = "msg_show",
        kind = "",
        find = "search hit TOP",
      },
      opts = { skip = true },
    },
  },
  cmdline = {
    format = {
      search_down = {
        view = "cmdline",
      },
      search_up = {
        view = "cmdline",
      },
    },
  },
})
