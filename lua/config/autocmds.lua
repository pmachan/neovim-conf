-- Loaded by LazyVim on VeryLazy. The GoLand-style LSP keymaps are registered in
-- lua/plugins/lsp.lua (init), so they don't depend on this file's load timing.
-- Format-on-save lives here because saving always happens well after startup.

-- ---------------------------------------------------------------------------
-- Format + organize imports on save (Go). gopls formats with gofumpt (enabled
-- in its settings) and we run the source.organizeImports code action. Uses the
-- Neovim 0.11+ make_range_params signature (window, offset_encoding).
-- ---------------------------------------------------------------------------
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("go_format_on_save", { clear = true }),
  pattern = "*.go",
  callback = function(ev)
    local client = vim.lsp.get_clients({ bufnr = ev.buf, name = "gopls" })[1]
    if client then
      local enc = client.offset_encoding or "utf-16"
      local params = vim.lsp.util.make_range_params(0, enc)
      params.context = { only = { "source.organizeImports" }, diagnostics = {} }
      local result = vim.lsp.buf_request_sync(ev.buf, "textDocument/codeAction", params, 1000)
      for _, res in pairs(result or {}) do
        for _, action in pairs(res.result or {}) do
          if action.edit then
            vim.lsp.util.apply_workspace_edit(action.edit, enc)
          end
        end
      end
    end
    vim.lsp.buf.format({ bufnr = ev.buf })
  end,
})

-- ---------------------------------------------------------------------------
-- Swap-file collisions. snacks.picker / explorer open files via nvim_exec2(),
-- a non-interactive context where Vim's "E325: ATTENTION" swap prompt can't be
-- shown and instead becomes a hard E5108 error. Pre-answering the SwapExists
-- dialog stops that: a leftover swap just opens the file (what you'd pick for a
-- stale swap from a crash). Swap files stay enabled for genuine crash recovery.
--   "e" = edit anyway (current)   "o" = open read-only (safer if you often have
--   the same file open in two live Neovim instances)   remove block = restore prompt.
vim.api.nvim_create_autocmd("SwapExists", {
  group = vim.api.nvim_create_augroup("swap_auto_choice", { clear = true }),
  callback = function()
    vim.v.swapchoice = "e"
  end,
})

-- Format Terraform on save (terraformls).
vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("terraform_format_on_save", { clear = true }),
  pattern = { "*.tf", "*.tfvars" },
  callback = function(ev)
    vim.lsp.buf.format({ bufnr = ev.buf })
  end,
})
