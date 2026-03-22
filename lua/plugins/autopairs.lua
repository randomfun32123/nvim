return {
    {
        "windwp/nvim-autopairs",
        event = "InsertEnter",
        dependencies = { "hrsh7th/nvim-cmp" },
        config = function()
            local autopairs = require("nvim-autopairs")
            local cmp_autopairs = require("nvim-autopairs.completion.cmp")
            local cmp = require("cmp")

            autopairs.setup({
                check_ts = true,          -- use treesitter to understand context
                ts_config = {
                    -- Don't pair inside strings or comments in these languages
                    lua  = { "string", "source" },
                    javascript = { "string", "template_string" },
                    java = false,         -- java treesitter can be slow, disable
                },
                -- Don't add a pair if the next character is one of these
                fast_wrap = {
                    map = "<M-e>",        -- Alt+e to wrap selection in a pair
                    chars = { "{", "[", "(", '"', "'" },
                    pattern = [=[[%'%"%>%]%)%}%,]]=],
                    offset = 0,
                    end_key = "$",
                    keys = "qwertyuiopzxcvbnmasdfghjkl",
                    check_comma = true,
                    highlight = "PmenuSel",
                    highlight_grey = "LineNr",
                },
            })

            -- Tell nvim-cmp to insert the closing pair when confirming a completion
            cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end,
    },
}
