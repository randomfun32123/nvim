return {
    -- Python virtualenv switcher, wired into Pyright's interpreter.
    -- Default keymaps: <leader>cv (select), <leader>cV (search all).
    {
        "linux-cultist/venv-selector.nvim",
        dependencies = {
            "neovim/nvim-lspconfig",
            "nvim-telescope/telescope.nvim",
        },
        ft = "python",
        opts = {
            -- Uncomment to point at an external `fd` (very fast on large trees)
            -- search = {
            --     my_venvs = {
            --         command = "fd . $VIRTUAL_ENV --max-depth 4 --type d --full-path",
            --     },
            -- },
            settings = {
                options = {
                    notify_user_on_venv_activation = true,
                },
            },

            on_venv_activated = function(venv_path)
                require("dap-python").setup(venv_path .. "/bin/python")
            end,
        },
    },
}
