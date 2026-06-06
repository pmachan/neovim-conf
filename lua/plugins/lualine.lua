-- Keep LazyVim's lualine layout but derive colors from the active colorscheme
-- (pi-one-dark) via the "auto" theme, instead of a fixed theme module.
return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      opts.options = opts.options or {}
      opts.options.theme = "auto"
      return opts
    end,
  },
}
