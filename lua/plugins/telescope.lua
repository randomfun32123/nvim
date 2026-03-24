return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
        },
        config = function()
            local telescope = require("telescope")
            local builtin = require("telescope.builtin")

            telescope.setup({
                defaults = {
                    prompt_prefix = "   ",
                    selection_caret = "  ",
                    path_display = { "truncate" },
                    sorting_strategy = "ascending",
                    layout_config = {
                        horizontal = {
                            prompt_position = "top",
                            preview_width = 0.55,
                        },
                    },
                },
            })

            telescope.load_extension("fzf")

            -- Keymaps
            vim.keymap.set("n", "<leader>ff", builtin.find_files,   { desc = "Find files" })
            vim.keymap.set("n", "<leader>fg", builtin.live_grep,    { desc = "Live grep" })
            vim.keymap.set("n", "<leader>fb", builtin.buffers,      { desc = "Find buffers" })
            vim.keymap.set("n", "<leader>fh", builtin.help_tags,    { desc = "Help tags" })
            vim.keymap.set("n", "<leader>fs", builtin.lsp_document_symbols, { desc = "Document symbols" })
            vim.keymap.set("n", "<leader>fr", builtin.oldfiles,     { desc = "Recent files" })
            vim.keymap.set("n", "<leader>fd", builtin.diagnostics,  { desc = "Diagnostics" })
            vim.keymap.set("n", "<leader>gc", builtin.git_commits,  { desc = "Git commits" })
            vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Git branches" })
        end,
    },
}
