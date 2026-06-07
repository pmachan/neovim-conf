-- Use the custom islands-dark colorscheme (lives in colors/islands-dark.lua)
-- as LazyVim's active scheme instead of the default tokyonight. A Neovim port
-- of JetBrains' GoLand/IntelliJ "Islands Dark" theme. The previous pi-one-dark
-- scheme is still available via :colorscheme pi-one-dark.
return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "islands-dark",
    },
  },
}
