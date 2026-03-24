return {
    {
        "lukas-reineke/indent-blankline.nvim",
        event = "BufReadPost",
        main = "ibl",
        config = function()
            require("ibl").setup({
                indent = { char = "▏" },
                scope  = { enabled = true, char = "▏" },
                exclude = {
                    filetypes = { "help", "dashboard", "NvimTree", "oil" },
                },
            })
        end,
    },
}

