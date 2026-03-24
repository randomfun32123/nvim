return {
    {
        "NeogitOrg/neogit",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "sindrets/diffview.nvim",   -- better diff views, pairs perfectly
            "nvim-telescope/telescope.nvim",
        },
        event = "VeryLazy",
        config = function()
            require("neogit").setup({
                integrations = {
                    diffview   = true,
                    telescope  = true,
                },
                signs = {
                    hunk       = { "", "" },
                    item       = { "", "" },
                    section    = { "", "" },
                },
            })
            vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<CR>",        { desc = "Open Neogit" })
            vim.keymap.set("n", "<leader>gc", "<cmd>Neogit commit<CR>", { desc = "Git commit" })
            vim.keymap.set("n", "<leader>gp", "<cmd>Neogit push<CR>",   { desc = "Git push" })
            vim.keymap.set("n", "<leader>gl", "<cmd>Neogit pull<CR>",   { desc = "Git pull" })
        end,
    },

    -- Pair with diffview for side-by-side diffs and file history
    {
        "sindrets/diffview.nvim",
        cmd = { "DiffviewOpen", "DiffviewFileHistory" },
        config = function()
            require("diffview").setup()
            vim.keymap.set("n", "<leader>gd", "<cmd>DiffviewOpen<CR>",             { desc = "Diff view" })
            vim.keymap.set("n", "<leader>gh", "<cmd>DiffviewFileHistory %<CR>",    { desc = "File history" })
        end,
    },
}
