-- Go tooling (test / run / coverage / impl / whole-program dead code).
-- The lang.go extra already handles gopls, gofumpt, treesitter and DAP, so
-- go.nvim is configured NOT to touch the LSP, keymaps or DAP — it only provides
-- the extra :Go* commands.
return {
  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
    config = function()
      require("go").setup({
        lsp_cfg = false, -- LazyVim configures gopls; don't double-register it
        lsp_keymaps = false, -- LazyVim owns the LSP keymaps
        lsp_inlay_hints = { enable = false }, -- toggle on demand with <leader>th
        dap_debug = false, -- nvim-dap-go (from dap.core/lang.go) owns debugging
      })

      vim.keymap.set("n", "<leader>gt", "<cmd>GoTest<cr>", { desc = "Go test" })
      vim.keymap.set("n", "<leader>gr", "<cmd>GoRun<cr>", { desc = "Go run" })
      vim.keymap.set("n", "<leader>gc", "<cmd>GoCoverage<cr>", { desc = "Coverage" })
      vim.keymap.set("n", "<leader>gi", "<cmd>GoImpl<cr>", { desc = "Impl iface" })

      -- Whole-program dead code (incl. unused EXPORTED funcs that gopls can't
      -- flag). Install once: go install golang.org/x/tools/cmd/deadcode@latest
      vim.keymap.set("n", "<leader>gd", function()
        local bin = vim.fn.exepath("deadcode")
        if bin == "" then
          local fallback = vim.fn.expand("~/go/bin/deadcode") -- GUI may strip PATH
          if vim.fn.executable(fallback) == 1 then bin = fallback end
        end
        if bin == "" then
          vim.notify("Install: go install golang.org/x/tools/cmd/deadcode@latest", vim.log.levels.WARN)
          return
        end
        local out = vim.fn.systemlist({ bin, "./..." })
        if #out == 0 then
          vim.notify("deadcode: no dead code found")
          return
        end
        vim.fn.setqflist({}, " ", { title = "deadcode", lines = out })
        vim.cmd("copen")
      end, { desc = "Dead code (whole program)" })
    end,
  },
}
