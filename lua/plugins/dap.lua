return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "mfussenegger/nvim-dap-python",
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",   -- hard dependency of dap-ui
        },
        config = function()
            local dap   = require("dap")
            local dapui = require("dapui")

            -- Point at the interpreter you want to debug. If you use
            -- venv-selector, you can call this again on `VenvSelect` via
            -- the plugin's `on_venv_activated` hook, or just launch nvim
            -- from an activated venv and keep the "python" default.
            require("dap-python").setup("python")

            dapui.setup()
            dap.listeners.after.event_initialized["dapui_config"] = dapui.open
            dap.listeners.before.event_terminated["dapui_config"] = dapui.close
            dap.listeners.before.event_exited["dapui_config"]     = dapui.close

            vim.keymap.set("n", "<F5>",  dap.continue,                { desc = "DAP: continue" })
            vim.keymap.set("n", "<F10>", dap.step_over,               { desc = "DAP: step over" })
            vim.keymap.set("n", "<F11>", dap.step_into,               { desc = "DAP: step into" })
            vim.keymap.set("n", "<F12>", dap.step_out,                { desc = "DAP: step out" })
            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint,  { desc = "DAP: toggle breakpoint" })
            vim.keymap.set("n", "<leader>du", dapui.toggle,           { desc = "DAP: toggle UI" })
            vim.keymap.set("n", "<leader>dc", dap.run_to_cursor,      { desc = "DAP: run to cursor" })
        end,
    },
}
