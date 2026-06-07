-- Loaded by LazyVim on VeryLazy (after plugins), so these override any LazyVim /
-- plugin default mappings with the same lhs. LSP and DAP keymaps live elsewhere
-- (autocmds.lua LspAttach, and the nvim-dap spec in lua/plugins/dap.lua).

local map = vim.keymap.set

-- ---------------------------------------------------------------------------
-- Clipboard (macOS muscle memory). clipboard=unnamedplus routes yanks to the OS
-- clipboard. Cmd (<D-…>) only reaches Neovim if your terminal/GUI forwards it,
-- so Ctrl+C / <leader>w are kept as always-works fallbacks.
-- ---------------------------------------------------------------------------
map("x", "<D-c>", "y", { desc = "Copy selection" })
map("x", "<C-c>", "y", { desc = "Copy selection (fallback)" })
map("n", "<D-v>", '"+p', { desc = "Paste from clipboard" })
map("i", "<D-v>", "<C-r><C-o>+", { desc = "Paste from clipboard" })
map("c", "<D-v>", "<C-r>+", { desc = "Paste from clipboard" })
map("x", "<D-v>", '"_dP', { desc = "Paste over selection" })

-- Cmd+S = save. <cmd>w<cr> returns to the prior mode, so it works from normal
-- AND insert mode. <leader>w (Space w) is the always-works fallback.
-- LazyVim's built-in <C-s> also saves and works without any terminal setup.
map({ "n", "i", "x" }, "<D-s>", "<cmd>w<cr>", { desc = "Save file" })
map("n", "<leader>w", "<cmd>w<cr>", { desc = "Save file" })

-- ---------------------------------------------------------------------------
-- Search Everywhere — now backed by snacks.picker (LazyVim 15.x default),
-- replacing telescope. Same GoLand-flavoured bindings as before.
-- ---------------------------------------------------------------------------
map("n", "<C-S-n>", function() Snacks.picker.files() end, { desc = "Go to file" })
map("n", "<C-S-f>", function() Snacks.picker.grep() end, { desc = "Find in files" })
map("n", "<leader>e", function() Snacks.picker.diagnostics() end, { desc = "Diagnostics" })

-- Recent Files (GoLand Cmd+E): recently-used buffers, current file hidden,
-- opens in normal mode so <CR> jumps straight to the previous file.
local function recent_files()
  Snacks.picker.buffers({
    current = false, -- hide the current buffer
    sort_lastused = true, -- most-recently-used first
    on_show = function()
      vim.cmd.stopinsert() -- start in normal mode
    end,
  })
end
-- <D-e> = Cmd+E (needs Cmd forwarding). <leader><leader> is the fallback.
map("n", "<D-e>", recent_files, { desc = "Recent files" })
map("n", "<leader><leader>", recent_files, { desc = "Recent files" })

-- ---------------------------------------------------------------------------
-- GoLand-style panels
-- ---------------------------------------------------------------------------
-- Problems / diagnostics list (Trouble is bundled with LazyVim).
map("n", "<leader>6", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Problems" })

-- Bottom terminal (GoLand Alt+F12) — snacks.terminal replaces toggleterm and
-- opens a bottom split by default.
local function term()
  Snacks.terminal.toggle(nil, { win = { position = "bottom" } })
end
map({ "n", "t" }, "<A-F12>", term, { desc = "Terminal" })
map("n", "<leader>tt", term, { desc = "Terminal" })

-- Fix out-of-sync colors. Treesitter highlighting (and LSP semantic tokens)
-- occasionally drift on big files; :redraw alone won't help because it just
-- repaints the stale state. This re-attaches the treesitter highlighter,
-- re-requests semantic tokens, clears search highlight, and redraws — without
-- reloading the buffer, so unsaved edits are kept. Runnable as :Rehighlight or
-- via <leader>ur (extends LazyVim's redraw key).
local function rehighlight()
  pcall(vim.treesitter.stop)
  pcall(vim.treesitter.start)
  pcall(function()
    vim.lsp.semantic_tokens.force_refresh()
  end)
  vim.cmd("nohlsearch")
  vim.cmd("redraw!")
end
vim.api.nvim_create_user_command("Rehighlight", rehighlight, { desc = "Refresh treesitter/LSP highlighting" })
map("n", "<leader>ur", rehighlight, { desc = "Refresh highlighting (redraw)" })

-- which-key: list buffer-local mappings.
map("n", "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = "Buffer keymaps (which-key)" })
