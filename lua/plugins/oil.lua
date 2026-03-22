return {
    {
        "stevearc/oil.nvim",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            require("oil").setup({
                -- Behaves like a normal buffer, q to quit
                default_file_explorer = true,
                delete_to_trash = true,
                skip_confirm_for_simple_edits = true,

                columns = {
                    "icon",
                    "permissions",
                    "size",
                    "mtime",
                },

                view_options = {
                    -- Show hidden files (dotfiles)
                    show_hidden = true,
                    -- Don't show .. at the top
                    is_always_hidden = function(name, _)
                        return name == ".."
                    end,
                },

                win_options = {
                    wrap = false,
                    signcolumn = "no",
                    cursorcolumn = false,
                    foldcolumn = "0",
                    spell = false,
                    list = false,
                    conceallevel = 3,
                    concealcursor = "nvic",
                },

                -- Float configuration (opens as a centered floating window)
                float = {
                    padding = 2,
                    max_width = 90,
                    max_height = 30,
                    border = "rounded",
                    win_options = { winblend = 10 },
                },

                keymaps = {
                    ["g?"]    = "actions.show_help",
                    ["<CR>"]  = "actions.select",
                    ["<C-s>"] = "actions.select_vsplit",
                    ["<C-h>"] = "actions.select_split",
                    ["<C-t>"] = "actions.select_tab",
                    ["<C-p>"] = "actions.preview",
                    ["<C-c>"] = "actions.close",
                    ["<C-r>"] = "actions.refresh",
                    ["-"]     = "actions.parent",       -- go up a directory
                    ["_"]     = "actions.open_cwd",     -- go to cwd
                    ["`"]     = "actions.cd",
                    ["~"]     = "actions.tcd",
                    ["gs"]    = "actions.change_sort",
                    ["gx"]    = "actions.open_external",
                    ["g."]    = "actions.toggle_hidden",
                    ["g\\"]   = "actions.toggle_trash",
                },
                use_default_keymaps = false,
            })

            -- Open oil in the directory of the current file
            vim.keymap.set("n", "-", "<CMD>Oil<CR>",
                { desc = "Open parent directory" })

            -- Open oil as a floating window
            vim.keymap.set("n", "<leader>-", function()
                require("oil").toggle_float()
            end, { desc = "Toggle oil float" })
        end,
    },
}
