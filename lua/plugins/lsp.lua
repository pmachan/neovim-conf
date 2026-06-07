-- LSP server settings. LazyVim sets servers up with the native vim.lsp.config /
-- vim.lsp.enable API (Neovim 0.11+). The lang.go and lang.terraform extras
-- register gopls and terraformls; here we merge in the exact gopls settings from
-- the previous setup and keep inlay hints off until toggled (<leader>th).
return {
  {
    "neovim/nvim-lspconfig",
    -- Registered in init (runs at startup) so the GoLand-style LSP keymaps are
    -- guaranteed to be in place before any LSP attaches — even when launching
    -- `nvim somefile.go` directly, where attach can beat the VeryLazy event.
    init = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("goland_lsp_keys", { clear = true }),
        callback = function(ev)
          local function m(lhs, rhs, desc)
            vim.keymap.set("n", lhs, rhs, { buffer = ev.buf, desc = desc })
          end
          m("<F2>", vim.lsp.buf.rename, "Rename") -- Shift+F6
          m("<A-Enter>", vim.lsp.buf.code_action, "Code action") -- Alt+Enter
          m("<C-A-l>", function() vim.lsp.buf.format() end, "Format") -- Ctrl+Alt+L
          m("<leader>th", function() -- toggle inlay hints
            local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = ev.buf })
            vim.lsp.inlay_hint.enable(not enabled, { bufnr = ev.buf })
          end, "Toggle inlay hints")
        end,
      })

      -- Terragrunt + OpenTofu: modules/providers live in .terragrunt-cache, not
      -- .terraform, but terraform-ls still runs plain `terraform validate` — which
      -- (with no `terraform init` and none of terragrunt's generated inputs)
      -- always reports false "Module not installed" / "Missing required provider"
      -- errors. Drop diagnostics from that source; terraform-ls's HCL syntax/parse
      -- diagnostics use a different source and are kept, and real validation is
      -- handled by terragrunt/tofu + tflint.
      -- Wrap the final diagnostic sink so it catches both push
      -- (publishDiagnostics) and pull (textDocument/diagnostic) paths —
      -- terraform-ls uses pull diagnostics, so a publishDiagnostics handler
      -- never sees these.
      if not vim.g._tf_validate_filtered then
        vim.g._tf_validate_filtered = true
        local orig_set = vim.diagnostic.set
        ---@diagnostic disable-next-line: duplicate-set-field
        vim.diagnostic.set = function(ns, bufnr, diagnostics, opts)
          if type(diagnostics) == "table" then
            diagnostics = vim.tbl_filter(function(d)
              return d.source ~= "terraform validate"
            end, diagnostics)
          end
          return orig_set(ns, bufnr, diagnostics, opts)
        end
      end
    end,
    opts = {
      -- Off by default; toggle per-buffer with <leader>th (or LazyVim's <leader>uh).
      inlay_hints = { enabled = false },
      servers = {
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              staticcheck = true,
              usePlaceholders = true,
              analyses = {
                unusedparams = true,
                nilness = true,
                unusedwrite = true,
              },
              hints = {
                parameterNames = true,
                assignVariableTypes = true,
              },
            },
          },
        },
        terraformls = {},
      },
    },
  },
}
