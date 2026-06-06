-- Left project tree (neo-tree), right structure outline (aerial), and the
-- which-key popup delay. snacks.picker (search), snacks.terminal, trouble and
-- lazygit are all provided by LazyVim core / the keymaps in lua/config/.

-- Copy text to the OS clipboard. Writes directly to pbcopy on macOS so it works
-- even when the GUI frontend doesn't sync the "+" register; falls back to "+".
local function clip(text, label)
  vim.fn.setreg("+", text)
  if vim.fn.executable("pbcopy") == 1 then
    vim.fn.system({ "pbcopy" }, text)
  end
  vim.notify((label or "Copied") .. ": " .. text)
end

return {
  ----------------------------------------------------------------
  -- LEFT PANEL: Project file tree (GoLand "Project" view)
  ----------------------------------------------------------------
  {
    "nvim-neo-tree/neo-tree.nvim",
    version = "v3.41.0", -- pinned (tag is "3.41.0"; lazy strips the v prefix)
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>1", "<cmd>Neotree toggle left<cr>", desc = "Project tree" },
    },
    opts = {
      close_if_last_window = true,
      window = {
        position = "left",
        width = 32,
        mappings = {
          -- copy the node's path to the system clipboard, then paste anywhere
          ["Y"] = function(state) -- absolute path
            clip(state.tree:get_node():get_id(), "Copied path")
          end,
          ["gy"] = function(state) -- path relative to cwd
            clip(vim.fn.fnamemodify(state.tree:get_node():get_id(), ":."), "Copied relative path")
          end,
          ["gn"] = function(state) -- filename only
            clip(vim.fn.fnamemodify(state.tree:get_node():get_id(), ":t"), "Copied name")
          end,
        },
      },
      filesystem = {
        follow_current_file = { enabled = true },
        use_libuv_file_watcher = true,
      },
    },
  },

  ----------------------------------------------------------------
  -- RIGHT PANEL: Code structure / outline (GoLand "Structure")
  ----------------------------------------------------------------
  {
    "stevearc/aerial.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    cmd = { "AerialToggle", "AerialOpen", "AerialNavToggle" },
    keys = {
      { "<leader>7", "<cmd>AerialToggle right<cr>", desc = "Structure" },
    },
    opts = {
      layout = { default_direction = "right", width = 32 },
      attach_mode = "global",
    },
  },

  ----------------------------------------------------------------
  -- which-key popup delay (ms to wait after a prefix)
  ----------------------------------------------------------------
  {
    "folke/which-key.nvim",
    opts = {
      delay = 300,
    },
  },

  ----------------------------------------------------------------
  -- NO BUFFER TABS: match the previous setup — one file visible at a
  -- time, no tab bar at the top. Splits (:split / :vsplit, plus the
  -- neo-tree / aerial / terminal panels) still work natively. Buffer
  -- cycling (<S-h>/<S-l>) and Cmd+E recent-files still work too.
  ----------------------------------------------------------------
  { "akinsho/bufferline.nvim", enabled = false },
}
