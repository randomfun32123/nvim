return {
    {
        "ellisonleao/gruvbox.nvim",
        priority = 1000,    -- load before all other plugins
        lazy = false,       -- load immediately, not on demand
        config = function()
            require("gruvbox").setup({
                contrast = "hard",
                transparent_mode = true,
            })
            vim.o.background = "dark"
            vim.cmd([[colorscheme gruvbox]])
        end,
    },
}
