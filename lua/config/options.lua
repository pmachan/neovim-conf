-- Loaded by LazyVim AFTER its own defaults, so anything set here wins.
-- See lua/config/lazy.lua for leader (set early, before plugins).

local opt = vim.opt

-- GoLand-like base options (ported from the previous standalone config)
opt.number = true
opt.relativenumber = true
opt.signcolumn = "yes"
opt.termguicolors = true
opt.expandtab = true
opt.shiftwidth = 4 -- LazyVim defaults to 2; you wanted 4
opt.tabstop = 4
opt.scrolloff = 8 -- LazyVim defaults to 4
opt.splitright = true
opt.splitbelow = true
opt.clipboard = "unnamedplus"
opt.updatetime = 250

-- Select text like a normal editor: hold Shift + arrows (and Ctrl+Shift+arrows
-- for word-wise) to start/extend a selection. It enters Visual mode, so your
-- Cmd+C / Ctrl+C copy and Cmd+V paste mappings work on it. A non-shifted arrow
-- clears the selection and just moves (stopsel). Works in normal AND insert mode.
opt.keymodel = "startsel,stopsel"

-- Only format-on-save for Go and Terraform (see lua/config/autocmds.lua),
-- matching the previous setup. Disable LazyVim's blanket conform autoformat so
-- other filetypes aren't reformatted unexpectedly. Flip to true if you ever want
-- LazyVim's format-everything-on-save behaviour.
vim.g.autoformat = false

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
