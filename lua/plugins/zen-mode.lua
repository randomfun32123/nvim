return {
    {
        "folke/zen-mode.nvim",
        cmd = "ZenMode",
        config = function()
            require("zen-mode").setup({
                window = { width = 90 },
            })
            vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<CR>", { desc = "Zen mode" })
        end,
    },
}
