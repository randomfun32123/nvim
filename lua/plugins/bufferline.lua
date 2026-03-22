return {
    {
        "akinsho/bufferline.nvim",
        version = "*",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local gruvbox = {
                fill               = "#1d2021",
                background         = "#282828",
                buffer_selected    = "#ebdbb2",
                buffer_visible     = "#a89984",
                close_button       = "#928374",
                separator          = "#1d2021",
                indicator_selected = "#fe8019",
                modified           = "#fabd2f",
                modified_selected  = "#fabd2f",
                tab                = "#282828",
                tab_selected       = "#1d2021",
                tab_close          = "#cc241d",
            }

            require("bufferline").setup({
                options = {
                    mode = "buffers",
                    numbers = "none",
                    close_command = "bdelete! %d",
                    right_mouse_command = "bdelete! %d",
                    left_mouse_command = "buffer %d",
                    indicator = {
                        icon = "▎",
                        style = "icon",
                    },
                    buffer_close_icon = "󰅖",
                    modified_icon = "●",
                    close_icon = "",
                    left_trunc_marker = "",
                    right_trunc_marker = "",
                    max_name_length = 30,
                    max_prefix_length = 30,
                    tab_size = 21,
                    diagnostics = "nvim_lsp",
                    diagnostics_indicator = function(_, _, diag)
                        local icons = {
                            error   = " ",
                            warning = " ",
                            hint    = "󰠠 ",
                            info    = " ",
                        }
                        local result = ""
                        if diag.error then
                            result = result .. icons.error .. diag.error .. " "
                        end
                        if diag.warning then
                            result = result .. icons.warning .. diag.warning
                        end
                        return vim.trim(result)
                    end,
                    offsets = {
                        {
                            filetype   = "oil",
                            text       = "  File Explorer",
                            highlight  = "Directory",
                            separator  = true,
                        },
                        {
                            filetype = "NvimTree",
                            text = "File Explorer",
                            highlight = "Directory",
                            separator = true
                        },
                    },
                    show_buffer_icons = true,
                    show_buffer_close_icons = true,
                    show_close_icon = false,
                    show_tab_indicators = true,
                    persist_buffer_sort = true,
                    separator_style = "thin",
                    enforce_regular_tabs = false,
                    always_show_bufferline = true,
                    hover = {
                        enabled = true,
                        delay = 150,
                        reveal = { "close" },
                    },
                },
                highlights = {
                    fill                 = { bg = gruvbox.fill },
                    background           = { fg = gruvbox.buffer_visible, bg = gruvbox.background },
                    buffer_visible       = { fg = gruvbox.buffer_visible, bg = gruvbox.background },
                    buffer_selected      = { fg = gruvbox.buffer_selected, bg = gruvbox.tab_selected, bold = true },
                    indicator_selected   = { fg = gruvbox.indicator_selected, bg = gruvbox.tab_selected },
                    separator            = { fg = gruvbox.separator, bg = gruvbox.background },
                    separator_selected   = { fg = gruvbox.separator, bg = gruvbox.tab_selected },
                    separator_visible    = { fg = gruvbox.separator, bg = gruvbox.background },
                    close_button         = { fg = gruvbox.close_button, bg = gruvbox.background },
                    close_button_visible = { fg = gruvbox.close_button, bg = gruvbox.background },
                    close_button_selected = { fg = gruvbox.tab_close, bg = gruvbox.tab_selected },
                    modified             = { fg = gruvbox.modified, bg = gruvbox.background },
                    modified_selected    = { fg = gruvbox.modified_selected, bg = gruvbox.tab_selected },
                    tab                  = { fg = gruvbox.buffer_visible, bg = gruvbox.tab },
                    tab_selected         = { fg = gruvbox.buffer_selected, bg = gruvbox.tab_selected },
                    tab_close            = { fg = gruvbox.tab_close, bg = gruvbox.fill },
                    diagnostic_selected  = { bg = gruvbox.tab_selected, bold = true },
                    error                = { fg = "#cc241d", bg = gruvbox.background },
                    error_selected       = { fg = "#fb4934", bg = gruvbox.tab_selected, bold = true },
                    warning              = { fg = "#d79921", bg = gruvbox.background },
                    warning_selected     = { fg = "#fabd2f", bg = gruvbox.tab_selected, bold = true },
                    hint_selected        = { bg = gruvbox.tab_selected, bold = true },
                    info_selected        = { bg = gruvbox.tab_selected, bold = true },
                },

            })

            -- Navigation keymaps
            vim.keymap.set("n", "<S-l>",      "<cmd>BufferLineCycleNext<CR>",     { desc = "Next buffer" })
            vim.keymap.set("n", "<S-h>",      "<cmd>BufferLineCyclePrev<CR>",     { desc = "Previous buffer" })
            vim.keymap.set("n", "<leader>bd", "<cmd>bdelete!<CR>",                { desc = "Close buffer" })
            vim.keymap.set("n", "<leader>bp", "<cmd>BufferLineTogglePin<CR>",     { desc = "Pin buffer" })
            vim.keymap.set("n", "<leader>bP", "<cmd>BufferLineGroupClose ungrouped<CR>", { desc = "Close unpinned buffers" })
        end,
    },
}
