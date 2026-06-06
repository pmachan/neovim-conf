-- Completion: blink.cmp is the LazyVim 15.x default (replaces nvim-cmp).
-- Replicate the previous nvim-cmp keybindings:
--   <CR>      confirm the selected item
--   <Tab>     select next item   (<S-Tab> previous)
--   <C-Space> trigger completion / toggle docs
-- LSP + snippet + path + buffer sources are already wired up by LazyVim.
return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
        ["<C-Space>"] = { "show", "show_documentation", "hide_documentation" },
      },
      completion = {
        -- Preselect the first item so <CR> confirms it without needing <Tab>
        -- first, matching the old cmp.confirm({ select = true }) behaviour.
        list = {
          selection = { preselect = true, auto_insert = false },
        },
      },
    },
  },
}
