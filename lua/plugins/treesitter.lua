return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",          -- explicit: you're on the new branch
        build = ":TSUpdate",
        config = function()
            -- Parser installation is separate from feature activation.
            -- You can also just run :TSInstall manually.
            require("nvim-treesitter").install({
                "c", "cpp", "java", "python", "bash",
                "html", "css", "javascript", "typescript",
                "json", "yaml", "toml", "xml",
                "markdown", "markdown_inline",
                "fish", "lua", "vim", "vimdoc",
                "rust", "go", "zig", "dockerfile",
                "cmake", "make", "query",
            })

            -- New main-branch API: setup() does NOT enable highlighting/indent.
            require("nvim-treesitter").setup({})

            -- Manually start Tree-sitter for the filetypes you care about.
            vim.api.nvim_create_autocmd("FileType", {
                pattern = {
                    "python", "markdown", "lua", "vim", "bash",
                    "javascript", "typescript", "c", "cpp",
                    "java", "rust", "go", "zig", "yaml",
                    "json", "toml", "html", "css", "xml",
                },
                callback = function()
                    -- Syntax highlighting (including injections)
                    vim.treesitter.start()
                end,
            })
        end,
    },
}
