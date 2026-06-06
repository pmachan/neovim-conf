return {
  ----------------------------------------------------------------
  -- KEYBIND DISCOVERY (popup cheat-sheet)
  -- Press a prefix (e.g. <Space> = leader) and pause: a popup lists
  -- every mapping under it, using the `desc` set on each keymap.
  -- <leader>? = show all buffer-local maps. :WhichKey = browse everything.
  ----------------------------------------------------------------
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 300, -- ms to wait after a prefix before the popup appears
    },
    keys = {
      {
        "<leader>?",
        function() require("which-key").show({ global = false }) end,
        desc = "Buffer keymaps (which-key)",
      },
    },
  },

  ----------------------------------------------------------------
  -- THEME (GoLand "Darcula"-like)
  ----------------------------------------------------------------
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("pi-one-dark")
    end,
  },

  ----------------------------------------------------------------
  -- LEFT PANEL: Project file tree (GoLand "Project" view)
  ----------------------------------------------------------------
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      -- Copy text to the OS clipboard. Writes directly to pbcopy on macOS so it
      -- works even when the GUI frontend doesn't sync the "+" register to the
      -- real system clipboard. Falls back to the "+" register elsewhere.
      local function clip(text, label)
        vim.fn.setreg("+", text)
        if vim.fn.executable("pbcopy") == 1 then
          vim.fn.system({ "pbcopy" }, text)
        end
        vim.notify((label or "Copied") .. ": " .. text)
      end

      require("neo-tree").setup({
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
      })
      vim.keymap.set("n", "<leader>1", "<cmd>Neotree toggle left<cr>", { desc = "Project tree" })
    end,
  },

  ----------------------------------------------------------------
  -- RIGHT PANEL: Code structure / outline (GoLand "Structure")
  ----------------------------------------------------------------
  {
    "stevearc/aerial.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
    config = function()
      require("aerial").setup({
        layout = { default_direction = "right", width = 32 },
        attach_mode = "global",
      })
      vim.keymap.set("n", "<leader>7", "<cmd>AerialToggle right<cr>", { desc = "Structure" })
    end,
  },

  ----------------------------------------------------------------
  -- BOTTOM PANEL: Terminal (GoLand "Terminal", Alt+F12)
  ----------------------------------------------------------------
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    config = function()
      require("toggleterm").setup({
        direction = "horizontal",
        size = 15,
        open_mapping = [[<A-F12>]],
      })
      vim.keymap.set("n", "<leader>tt", "<cmd>ToggleTerm<cr>", { desc = "Terminal" })
    end,
  },

  ----------------------------------------------------------------
  -- BOTTOM PANEL: Diagnostics list (GoLand "Problems")
  ----------------------------------------------------------------
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("trouble").setup({})
      vim.keymap.set("n", "<leader>6", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Problems" })
    end,
  },

  ----------------------------------------------------------------
  -- STATUS BAR
  ----------------------------------------------------------------
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      -- "auto" derives statusline colors from the active colorscheme
      -- (pi-one-dark). The "catppuccin" theme module isn't shipped on the rtp.
      require("lualine").setup({ options = { theme = "auto" } })
    end,
  },

  ----------------------------------------------------------------
  -- SEARCH EVERYWHERE (GoLand double-shift / Ctrl+Shift+F)
  ----------------------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup({
        defaults = {
          sorting_strategy = "ascending", -- results listed top-to-bottom
          layout_strategy = "horizontal",
          layout_config = {
            prompt_position = "top",      -- prompt on top, results below it
            horizontal = {
              mirror = true,        -- results on the RIGHT, preview on the LEFT
              width = 0.75,         -- narrower overall
              height = 0.45,        -- ~50% of the default 0.9 height
              preview_width = 0.5,  -- even split between preview and results
            },
          },
        },
      })

      local b = require("telescope.builtin")

      -- Recent Files (GoLand Cmd+E replacement for editor tabs):
      -- recently used buffers, most-recent first, current file hidden, opens
      -- in normal mode so you can press <CR> immediately to jump to the
      -- previous file or j/k then <CR> to pick another.
      local function recent_files()
        b.buffers({
          sort_mru = true,
          ignore_current_buffer = true,
          initial_mode = "normal",
        })
      end

      vim.keymap.set("n", "<C-S-n>", b.find_files, { desc = "Go to file" })
      vim.keymap.set("n", "<C-S-f>", b.live_grep, { desc = "Find in files" })
      vim.keymap.set("n", "<leader>e", b.diagnostics, { desc = "Diagnostics" })

      -- <D-e> = Cmd+E (only fires if your terminal/GUI forwards Cmd).
      -- <leader><leader> (Space Space) is the always-works fallback.
      vim.keymap.set("n", "<D-e>", recent_files, { desc = "Recent files" })
      vim.keymap.set("n", "<leader><leader>", recent_files, { desc = "Recent files" })
    end,
  },

  ----------------------------------------------------------------
  -- TREESITTER (pinned to legacy master branch)
  ----------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    branch = "master",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "go", "gomod", "gosum", "gowork", "hcl", "terraform", "lua", "json", "yaml" },
        highlight = { enable = true },
        indent = { enable = true },
      })

      -- nvim-treesitter's "master" branch is deprecated and ships markdown
      -- injection queries that crash Neovim 0.12's injection runtime when
      -- opening any markdown file:
      --   treesitter.lua:196: attempt to call method 'range' (a nil value)
      -- Neovim bundles a compatible markdown parser + queries, so override the
      -- broken injection queries with the bundled ones.
      local function use_bundled_query(lang, kind)
        local path = vim.env.VIMRUNTIME .. "/queries/" .. lang .. "/" .. kind .. ".scm"
        local fd = io.open(path, "r")
        if not fd then return end
        local content = fd:read("*a")
        fd:close()
        vim.treesitter.query.set(lang, kind, content)
      end
      use_bundled_query("markdown", "injections")
      use_bundled_query("markdown_inline", "injections")
    end,
  },

  ----------------------------------------------------------------
  -- LSP + completion + Mason
  ----------------------------------------------------------------
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/nvim-cmp",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      require("mason-lspconfig").setup({ ensure_installed = { "gopls", "terraformls" } })

      local cmp = require("cmp")
      local luasnip = require("luasnip")
      cmp.setup({
        snippet = { expand = function(a) luasnip.lsp_expand(a.body) end },
        mapping = cmp.mapping.preset.insert({
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping.select_next_item(),
          ["<S-Tab>"] = cmp.mapping.select_prev_item(),
        }),
        sources = { { name = "nvim_lsp" }, { name = "luasnip" } },
      })

      local caps = require("cmp_nvim_lsp").default_capabilities()

      -- GoLand-like keymaps
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)       -- Ctrl+B
          vim.keymap.set("n", "gr", require("telescope.builtin").lsp_references, opts) -- Alt+F7
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)             -- Ctrl+Q
          vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)         -- Shift+F6
          vim.keymap.set("n", "<A-Enter>", vim.lsp.buf.code_action, opts) -- Alt+Enter
          vim.keymap.set("n", "<C-A-l>", function() vim.lsp.buf.format() end, opts) -- Ctrl+Alt+L
          vim.keymap.set("n", "<leader>th", function()                 -- toggle inlay hints
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
          end, opts)
        end,
      })

      -- New native LSP config API (Neovim 0.11+)
      vim.lsp.config("gopls", {
        capabilities = caps,
        settings = {
          gopls = {
            gofumpt = true,
            staticcheck = true,
            usePlaceholders = true,
            analyses = { unusedparams = true, nilness = true, unusedwrite = true },
            hints = { parameterNames = true, assignVariableTypes = true },
          },
        },
      })

      vim.lsp.config("terraformls", { capabilities = caps })

      vim.lsp.enable({ "gopls", "terraformls" })

      -- Format + organize imports on save (Go)
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.go" },
        callback = function()
          vim.lsp.buf.format()
          local params = vim.lsp.util.make_range_params()
          params.context = { only = { "source.organizeImports" } }
          local r = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
          for _, res in pairs(r or {}) do
            for _, action in pairs(res.result or {}) do
              if action.edit then vim.lsp.util.apply_workspace_edit(action.edit, "utf-8") end
            end
          end
        end,
      })

      -- Format Terraform on save
      vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = { "*.tf", "*.tfvars" },
        callback = function() vim.lsp.buf.format() end,
      })
    end,
  },

  ----------------------------------------------------------------
  -- GO TOOLING (test/run/struct tags/impl)
  ----------------------------------------------------------------
  {
    "ray-x/go.nvim",
    dependencies = { "ray-x/guihua.lua", "neovim/nvim-lspconfig", "nvim-treesitter/nvim-treesitter" },
    ft = { "go", "gomod" },
    build = ':lua require("go.install").update_all_sync()',
    config = function()
      -- lsp_inlay_hints = false: don't auto-enable the grayed-out parameter
      -- name / variable type hints. Toggle them anytime with <leader>th.
      require("go").setup({ lsp_inlay_hints = { enable = false } })
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

  ----------------------------------------------------------------
  -- DEBUGGER (GoLand debug, F8/F9)
  ----------------------------------------------------------------
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "leoluz/nvim-dap-go",
    },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      require("dap-go").setup()
      dapui.setup()
      dap.listeners.after.event_initialized["dapui"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui"] = function() dapui.close() end

      vim.keymap.set("n", "<F9>", dap.toggle_breakpoint, { desc = "Breakpoint" })
      vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug/continue" })
      vim.keymap.set("n", "<F8>", dap.step_over, { desc = "Step over" })
      vim.keymap.set("n", "<F7>", dap.step_into, { desc = "Step into" })
    end,
  },

  ----------------------------------------------------------------
  -- GIT (GoLand VCS gutter)
  ----------------------------------------------------------------
  { "lewis6991/gitsigns.nvim", config = true },
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      vim.keymap.set("n", "<leader>gg", "<cmd>LazyGit<cr>", { desc = "LazyGit" })
    end,
  },
}
