return {
    {
        "nvim-tree/nvim-tree.lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            -- Disable netrw in favour of nvim-tree
            vim.g.loaded_netrw       = 1
            vim.g.loaded_netrwPlugin = 1

            require("nvim-tree").setup({
                hijack_cursor = true,       -- keep cursor on the filename
                sync_root_with_cwd = true,
                respect_buf_cwd = true,

                update_focused_file = {
                    enable = true,          -- expand tree to show current file
                    update_root = false,
                },

                view = {
                    width = 32,
                    side = "left",
                    preserve_window_proportions = true,
                },

                renderer = {
                    root_folder_label = ":~:s?$?/..?",
                    highlight_git = true,
                    highlight_opened_files = "name",
                    indent_markers = {
                        enable = true,
                        inline_arrows = true,
                        icons = {
                            corner = "└",
                            edge   = "│",
                            item   = "│",
                            bottom = "─",
                            none   = " ",
                        },
                    },
                    icons = {
                        git_placement = "after",
                        modified_placement = "after",
                        padding = " ",
                        symlink_arrow = " ➛ ",
                        glyphs = {
                            default  = "󰈚",
                            symlink  = "",
                            bookmark = "󰆤",
                            modified = "●",
                            folder   = {
                                arrow_closed = "",
                                arrow_open   = "",
                                default      = "",
                                open         = "",
                                empty        = "",
                                empty_open   = "",
                                symlink      = "",
                                symlink_open = "",
                            },
                            git = {
                                unstaged  = "✗",
                                staged    = "✓",
                                unmerged  = "",
                                renamed   = "➜",
                                untracked = "★",
                                deleted   = "",
                                ignored   = "◌",
                            },
                        },
                    },
                },

                filters = {
                    dotfiles = false,       -- show dotfiles by default
                    git_ignored = false,    -- show git-ignored files
                    custom = {
                        "^.git$",           -- but hide the .git folder itself
                    },
                },

                git = {
                    enable = true,
                    ignore = false,
                    show_on_dirs = true,
                    timeout = 400,
                },

                actions = {
                    open_file = {
                        quit_on_open = false,   -- keep tree open after opening a file
                        resize_window = false,
                        window_picker = {
                            enable = true,
                        },
                    },
                },

                -- Gruvbox-matched highlights
                -- (gruvbox.nvim already sets most of these correctly,
                --  these are just tweaks for the tree-specific elements)
                on_attach = function(bufnr)
                    local api = require("nvim-tree.api")
                    local opts = function(desc)
                        return {
                            desc = "nvim-tree: " .. desc,
                            buffer = bufnr,
                            noremap = true,
                            silent = true,
                            nowait = true,
                        }
                    end

                    -- Default keymaps
                    api.config.mappings.default_on_attach(bufnr)

                    -- Additional / overridden keymaps
                    vim.keymap.set("n", "l",   api.node.open.edit,           opts("Open"))
                    vim.keymap.set("n", "h",   api.node.navigate.parent_close, opts("Close directory"))
                    vim.keymap.set("n", "H",   api.tree.collapse_all,        opts("Collapse all"))
                    vim.keymap.set("n", "v",   api.node.open.vertical,       opts("Open vertical split"))
                    vim.keymap.set("n", "s",   api.node.open.horizontal,     opts("Open horizontal split"))
                    vim.keymap.set("n", ".",   api.node.run.cmd,             opts("Run command"))
                    vim.keymap.set("n", "P",   api.node.navigate.parent,     opts("Go to parent"))
                    vim.keymap.set("n", "?",   api.tree.toggle_help,         opts("Help"))
                end,
            })

            -- Toggle the tree
            vim.keymap.set("n", "<leader>e",  "<cmd>NvimTreeToggle<CR>",   { desc = "Toggle file tree" })
            -- Focus the tree without toggling
            vim.keymap.set("n", "<leader>fe", "<cmd>NvimTreeFocus<CR>",    { desc = "Focus file tree" })
            -- Reveal the current file in the tree
            vim.keymap.set("n", "<leader>fE", "<cmd>NvimTreeFindFile<CR>", { desc = "Find file in tree" })
        end,
    },
}
