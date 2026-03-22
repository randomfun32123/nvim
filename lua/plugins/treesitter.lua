return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter").setup({
                -- Install all of these automatically
                ensure_installed = {
                    -- Your primary languages
                    "c", "cpp", "java", "python", "bash",
                    -- Web
                    "html", "css", "javascript", "typescript",
                    -- Config / markup
                    "json", "jsonc", "yaml", "toml", "xml",
                    "markdown", "markdown_inline",
                    -- Shell / scripting
                    "fish", "lua", "vim", "vimdoc",
                    -- Systems
                    "rust", "go", "zig", "dockerfile",
                    -- Build systems
                    "cmake", "make",
                    -- Query language (treesitter itself)
                    "query",
                },
                auto_install = true,   -- install missing parsers automatically on open
                highlight = {
                    enable = true,
                    -- Disable for very large files to avoid lag
                    disable = function(_, buf)
                        local max_filesize = 500 * 1024 -- 500 KB
                        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                        if ok and stats and stats.size > max_filesize then
                            return true
                        end
                    end,
                },
                indent = { enable = true },
            })
        end,
    },
}
