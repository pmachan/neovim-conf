-- Leader must be set before lazy.nvim processes any plugin `keys`.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

require("lazy").setup({
  spec = {
    -- LazyVim core. The exact commit is pinned in lazy-lock.json (currently
    -- v16.0.0), so upgrades only happen when you run :Lazy update.
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },

    -- Language / tooling extras. These pull in the modern packages that
    -- replace the old hand-rolled setup:
    --   lang.go        -> gopls (native vim.lsp.config), gofumpt, nvim-dap-go,
    --                     go treesitter parsers
    --   lang.terraform -> terraformls + terraform_fmt + hcl/terraform parsers
    --   dap.core       -> nvim-dap + nvim-dap-ui + nvim-nio + mason-nvim-dap
    { import = "lazyvim.plugins.extras.lang.go" },
    { import = "lazyvim.plugins.extras.lang.terraform" },
    { import = "lazyvim.plugins.extras.dap.core" },

    -- Your overrides / additions
    { import = "plugins" },
  },
  defaults = {
    lazy = false,
    version = false, -- use latest git commit for plugins (LazyVim itself is pinned above)
  },
  -- Fall back to a bundled scheme during install if pi-one-dark isn't ready yet.
  install = { colorscheme = { "pi-one-dark", "habamax" } },
  checker = {
    enabled = true,
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
