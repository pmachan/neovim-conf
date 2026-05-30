vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- GoLand-like base options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.scrolloff = 8
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.clipboard = "unnamedplus"
vim.opt.updatetime = 250

-- Force the clipboard provider to use pbcopy/pbpaste directly. The GUI frontend
-- syncs yanks to the OS clipboard but NOT programmatic "+" register writes (e.g.
-- file-tree copy mappings), so route every "+"/"*" op straight to the macOS
-- pasteboard. Fixes "copy in tree doesn't paste outside Neovim".
if vim.fn.executable("pbcopy") == 1 and vim.fn.executable("pbpaste") == 1 then
  vim.g.clipboard = {
    name = "pbcopy",
    copy = { ["+"] = "pbcopy", ["*"] = "pbcopy" },
    paste = { ["+"] = "pbpaste", ["*"] = "pbpaste" },
    cache_enabled = 0,
  }
end

-- Normal-editor clipboard (clipboard=unnamedplus routes yanks to the OS clipboard).
-- NOTE: Cmd (<D-…>) only reaches Neovim if your terminal/GUI forwards it (same
-- caveat as Cmd+E). Ctrl+C is kept as an always-works copy fallback.
vim.keymap.set("x", "<D-c>", "y", { desc = "Copy selection" })
vim.keymap.set("x", "<C-c>", "y", { desc = "Copy selection (fallback)" })
vim.keymap.set("n", "<D-v>", '"+p', { desc = "Paste from clipboard" })
vim.keymap.set("i", "<D-v>", "<C-r><C-o>+", { desc = "Paste from clipboard" })
vim.keymap.set("c", "<D-v>", "<C-r>+", { desc = "Paste from clipboard" })
vim.keymap.set("x", "<D-v>", '"_dP', { desc = "Paste over selection" })

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({ "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("plugins")
