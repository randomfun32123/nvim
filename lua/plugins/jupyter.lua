return {
    -- Inline image renderer (used by Molten for plot output)
    {
        "3rd/image.nvim",
        ft = { "python", "markdown", "ipynb" },
        build = false,   -- see note below on Magick / backend requirements
        opts = {
            backend            = "kitty",       -- "kitty" | "ueberzug" | "sixel" | "viu"
            processor          = "magick_cli",  -- or "magick_rock"
            integrations = {
                markdown = {
                    enabled = true,
                    only_render_image_at_cursor = false,
                    filetypes = { "markdown", "vimwiki" },
                },
                neorg = { enabled = false },
                html  = { enabled = false },
                css   = { enabled = false },
            },
            max_width  = nil,
            max_height = nil,
            max_width_window_percentage  = nil,
            max_height_window_percentage = 50,
            window_overlap_clear_enabled = false,
            window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
            editor_only_render_when_focused = false,
            tmux_show_only_in_active_window = false,
            hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" },
        },
    },

    -- Molten: run code cells through a Jupyter kernel, inline output
    {
        "benlubas/molten-nvim",
        version = "^1.0.0",
        build = ":UpdateRemotePlugins",
        ft = { "python", "markdown", "ipynb" },
        init = function()
            vim.g.molten_virt_text_output      = true
            vim.g.molten_virt_lines_off_by_1   = true
            vim.g.molten_wrap_output           = true
            vim.g.molten_image_provider        = "image.nvim"
            vim.g.molten_output_win_max_height = 20
        end,
        config = function()
            local function molten_eval_cell()
                local ok, parser = pcall(vim.treesitter.get_parser, 0, "markdown")
                if not ok or not parser then
                    vim.notify("molten: could not get markdown parser", vim.log.levels.WARN)
                    return
                end

                local tree = parser:parse()[1]
                local cursor = vim.api.nvim_win_get_cursor(0)
                local row, col = cursor[1] - 1, cursor[2]

                local node = tree:root():named_descendant_for_range(row, col, row, col)
                while node do
                    if node:type() == "fenced_code_block" then
                        local content
                        for child in node:iter_children() do
                            if child:type() == "code_fence_content" then
                                content = child
                                break
                            end
                        end
                        if not content then
                            vim.notify("molten: empty code block", vim.log.levels.WARN)
                            return
                        end

                        local sr, _, er, ec = content:range()
                        local start_line = sr + 1
                        local end_line = (ec > 0) and (er + 1) or er
                        if end_line < start_line then end_line = start_line end

                        vim.fn.MoltenEvaluateRange(start_line, end_line)
                        return
                    end
                    node = node:parent()
                end

                vim.notify("molten: cursor is not inside a fenced code block", vim.log.levels.WARN)
            end

            vim.keymap.set("n", "<localleader>je", molten_eval_cell,                   { desc = "Molten: evaluate current cell" })
            vim.keymap.set("n", "<localleader>ji", ":MoltenInit<CR>",                  { desc = "Molten: init kernel" })
            vim.keymap.set("n", "<localleader>jl", ":MoltenEvaluateLine<CR>",          { desc = "Molten: eval line" })
            vim.keymap.set("v", "<localleader>jr", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "Molten: eval visual" })
            vim.keymap.set("n", "<localleader>jc", ":MoltenReevaluateCell<CR>",        { desc = "Molten: re-eval cell" })
            vim.keymap.set("n", "<localleader>jo", ":noautocmd MoltenEnterOutput<CR>", { desc = "Molten: open output" })
            vim.keymap.set("n", "<localleader>jd", ":MoltenDelete<CR>",                { desc = "Molten: delete output" })
            vim.keymap.set("n", "<localleader>ji", ":MoltenInit<CR>",                  { desc = "Molten: init kernel" })
            vim.keymap.set("n", "<localleader>jx", ":MoltenInterrupt<CR>",             { desc = "Molten: interrupt kernel" })
            vim.keymap.set("n", "<localleader>jR", ":MoltenRestart!<CR>",              { desc = "Molten: restart kernel" })
        end,
    },

    -- Jupytext: transparent .ipynb <-> Markdown conversion.
    -- MUST NOT be lazy-loaded or .ipynb files open as raw JSON.
    {
        "goerz/jupytext.nvim",
        version = "0.2.0",
        lazy = false,
        opts = {
            format = "markdown",

            filetype = function(path, format, metadata)
                if format == "markdown" or format == "md" then
                    return "markdown"
                end
                local kernelspec = metadata and metadata.kernelspec
                local lang = kernelspec and kernelspec.language
                if lang == "python" then
                    return "python"
                elseif lang == "r" or lang == "R" then
                    return "r"
                end

                return "python"
            end,
        }
    },

    {
    "quarto-dev/quarto-nvim",
        dependencies = {
            "jmbuhr/otter.nvim", -- for LSP features in code chunks
        },
        ft = { "markdown" },
        config = function()
            require("quarto").setup({
                lspFeatures = {
                    languages = { "python" }, -- add others if you use them
                    chunks = "all",
                    diagnostics = { enabled = true },
                    completion = { enabled = true },
                },
                codeRunner = {
                    enabled = true,
                    default_method = "molten",
                },
            })

            vim.api.nvim_create_autocmd("FileType", {
                pattern = "markdown",
                callback = function()
                    -- Using the built-in command is the simplest approach
                    vim.cmd("QuartoActivate")

                    -- Alternatively, you can call the function directly:
                    -- require("quarto").activate()
                end,
            })

            local runner = require("quarto.runner")
            vim.keymap.set("n", "<localleader>jA", runner.run_all, { desc = "Run all cells" })
        end,
    }
}
