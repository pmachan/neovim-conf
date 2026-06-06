-- snacks.picker layout: mirror the old Telescope setup — preview on the LEFT,
-- results on the RIGHT, prompt on top. Applied as the default layout, so
-- Cmd+E (buffers), Ctrl+Shift+N (files) and Ctrl+Shift+F (grep) all match.
-- The explorer / select / vscode sources set their own layouts, so they're
-- unaffected.
return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        layouts = {
          mirror = {
            layout = {
              box = "horizontal",
              width = 0.85,
              height = 0.65,
              -- preview on the LEFT
              { win = "preview", title = "{preview}", border = true, width = 0.5 },
              -- prompt on top, results below it — on the RIGHT
              {
                box = "vertical",
                border = true,
                title = "{title} {live} {flags}",
                { win = "input", height = 1, border = "bottom" },
                { win = "list", border = "none" },
              },
            },
          },
        },
        layout = { preset = "mirror" },
      },
    },
  },
}
