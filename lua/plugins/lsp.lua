return {
    {
        "williamboman/mason.nvim",
        config = function()
            require("mason").setup({
                ui = {
                    border = "rounded",
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗",
                    },
                },
            })
        end,
    },

    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "clangd",
                    "jdtls",
                    "pyright",
                    "bashls",
                    "lua_ls",
                    "rust_analyzer",
                    "dockerls",
                },
                automatic_installation = true,
            })
        end,
    },

    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "hrsh7th/cmp-nvim-lsp",
        },
        config = function()
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            local on_attach = function(_, buf)
                local map = function(keys, func, desc)
                    vim.keymap.set("n", keys, func, { buffer = buf, desc = desc })
                end
                map("gd",         vim.lsp.buf.definition,     "Go to definition")
                map("gD",         vim.lsp.buf.declaration,    "Go to declaration")
                map("gr",         vim.lsp.buf.references,     "List references")
                map("gi",         vim.lsp.buf.implementation, "Go to implementation")
                map("K",          vim.lsp.buf.hover,          "Hover docs")
                map("<leader>rn", vim.lsp.buf.rename,         "Rename symbol")
                map("<leader>ca", vim.lsp.buf.code_action,    "Code action")
                map("<leader>f",  vim.lsp.buf.format,         "Format buffer")
                map("[d",         vim.diagnostic.goto_prev,   "Previous diagnostic")
                map("]d",         vim.diagnostic.goto_next,   "Next diagnostic")
                map("<leader>e",  vim.diagnostic.open_float,  "Show diagnostic")
            end

            vim.diagnostic.config({
                virtual_text = true,
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                float = { border = "rounded" },
            })

            local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end

            local handlers = {
                ["textDocument/hover"] = vim.lsp.with(
                    vim.lsp.handlers.hover, { border = "rounded" }
                ),
                ["textDocument/signatureHelp"] = vim.lsp.with(
                    vim.lsp.handlers.signature_help, { border = "rounded" }
                ),
            }

            -- New API: vim.lsp.config instead of lspconfig.X.setup()
            vim.lsp.config("clangd", {
                capabilities = capabilities,
                on_attach = on_attach,
                handlers = handlers,
                cmd = {
                    "clangd",
                    "--background-index",
                    "--clang-tidy",
                    "--header-insertion=iwyu",
                    "--completion-style=detailed",
                },
            })

            vim.lsp.config("pyright", {
                capabilities = capabilities,
                on_attach = on_attach,
                handlers = handlers,
            })

            vim.lsp.config("bashls", {
                capabilities = capabilities,
                on_attach = on_attach,
                handlers = handlers,
            })

            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
                on_attach = on_attach,
                handlers = handlers,
                settings = {
                    Lua = {
                        diagnostics = { globals = { "vim" } },
                        workspace = { library = vim.api.nvim_get_runtime_file("", true) },
                        telemetry = { enable = false },
                    },
                },
            })

            vim.lsp.config("jdtls", {
                capabilities = capabilities,
                on_attach = on_attach,
                handlers = handlers,
            })

            vim.lsp.config("rust_analyzer", {
                capabilities = capabilities,
                on_attach = on_attach,
                handlers = handlers,
                settings = {
                    ["rust_analyzer"] = {
                        checkOnSave = { command = "clippy" }, -- use clippy instead of check
                    },
                },
            })

            vim.lsp.config("dockerls", {
                capabilities = capabilities,
                on_attach = on_attach,
                handlers = handlers,
            })

            -- Enable all configured servers
            vim.lsp.enable({ "clangd", "pyright", "bashls", "lua_ls", "jdtls", "rust_analyzer", "dockerls" })
        end,
    },

    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                window = {
                    completion    = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-e>"]     = cmp.mapping.abort(),
                    ["<CR>"]      = cmp.mapping.confirm({ select = false }),
                    ["<Tab>"]     = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"]   = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp", priority = 1000 },
                    { name = "luasnip",  priority = 750  },
                    { name = "buffer",   priority = 500  },
                    { name = "path",     priority = 250  },
                }),
                formatting = {
                    format = function(entry, item)
                        item.menu = ({
                            nvim_lsp = "[LSP]",
                            luasnip  = "[Snip]",
                            buffer   = "[Buf]",
                            path     = "[Path]",
                        })[entry.source.name]
                        return item
                    end,

                enabled = function()
                    local context = require("cmp.config.context")
                    -- disable in comments
                    if context.in_treesitter_capture("comment") or
                       context.in_syntax_group("Comment") then
                        return false
                    end
                    -- disable in strings (optional, remove if you want string completion)
                    if context.in_treesitter_capture("string") or
                       context.in_syntax_group("String") then
                        return false
                    end
                    return true
                end,
                },
            })

            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = { { name = "buffer" } },
            })

            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources(
                    { { name = "path" } },
                    { { name = "cmdline" } }
                ),
            })
        end,
    },
}
