-- Debugger keymaps (GoLand F-keys). nvim-dap, dap-ui (auto open/close) and
-- nvim-dap-go come from the dap.core + lang.go extras; we just add the F-keys.
return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<F9>", function() require("dap").toggle_breakpoint() end, desc = "Breakpoint" },
      { "<F5>", function() require("dap").continue() end, desc = "Debug/continue" },
      { "<F8>", function() require("dap").step_over() end, desc = "Step over" },
      { "<F7>", function() require("dap").step_into() end, desc = "Step into" },
    },
  },
}
