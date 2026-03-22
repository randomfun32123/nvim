return {
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            local wk = require("which-key")

            wk.setup({
                preset = "modern",
                delay = 400,        -- ms before the popup appears
                icons = {
                    breadcrumb = "»",
                    separator  = "➜",
                    group      = "+",
                    ellipsis   = "…",
                    rules      = false,
                    colors     = true,
                },
                win = {
                    border   = "rounded",
                    padding  = { 1, 2 },
                    wo = { winblend = 10 },
                },
                layout = {
                    width  = { min = 20, max = 50 },
                    spacing = 3,
                },
                filter = function(map)
                    -- Only show mappings that have a description
                    return map.desc and map.desc ~= ""
                end,
            })

            -- Group labels — these make the popup organized by category
            -- instead of just a flat list of bindings
            wk.add({
                { "<leader>b",  group = "buffer" },
                { "<leader>f",  group = "file / find" },
                { "<leader>e",  desc  = "Toggle file tree" },
                { "<leader>-",  desc  = "Toggle oil float" },
                { "<leader>rn", desc  = "Rename symbol" },
                { "<leader>ca", desc  = "Code action" },
                { "<leader>f",  desc  = "Format buffer",    mode = "n" },
                { "<leader>e",  desc  = "Show diagnostic",  mode = "n" },
                -- Oil
                { "-",          desc  = "Open parent directory (oil)" },
                -- LSP
                { "gd",         desc  = "Go to definition" },
                { "gD",         desc  = "Go to declaration" },
                { "gr",         desc  = "List references" },
                { "gi",         desc  = "Go to implementation" },
                { "K",          desc  = "Hover documentation" },
                { "[d",         desc  = "Previous diagnostic" },
                { "]d",         desc  = "Next diagnostic" },
                -- Bufferline
                { "<S-h>",      desc  = "Previous buffer" },
                { "<S-l>",      desc  = "Next buffer" },
            })
        end,
    },
}
