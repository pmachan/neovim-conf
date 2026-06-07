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
        -- Show gitignored + hidden (dotfile) entries in the explorer tree, so
        -- folders like .terraform/, .idea/ and vendor/ are visible. They appear
        -- collapsed and greyed (SnacksPickerPathIgnored); a folder's contents
        -- only load when you expand it, so the big caches stay a single line
        -- until you open them — like GoLand.
        sources = {
          explorer = {
            hidden = true,
            ignored = true,
          },
        },
        layouts = {
          mirror = {
            layout = {
              box = "horizontal",
              width = 0.85,
              height = 0.65,
              -- No dimming backdrop: snacks defaults to backdrop=60, which dims
              -- the whole UI — including the project sidebar — and its fade
              -- in/out reads as flicker. All built-in presets set this false.
              backdrop = false,
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
