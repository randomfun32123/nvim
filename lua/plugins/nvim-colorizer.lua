return {
    {
        "NvChad/nvim-colorizer.lua",
        event = "BufReadPost",
        config = function()
            require("colorizer").setup({
                filetypes = { "css", "javascript", "html", "lua", "conf", "*" },
                user_default_options = {
                    RGB      = true,
                    RRGGBB   = true,
                    names    = false,
                    mode     = "background",
                },
            })
        end,
    },
}
