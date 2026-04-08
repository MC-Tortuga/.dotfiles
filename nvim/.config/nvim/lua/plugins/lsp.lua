return {
    -- LSP Config
    {
        "neovim/nvim-lspconfig",
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "nvimtools/none-ls.nvim",
        },
        config = function()
            local capabilities = vim.tbl_deep_extend(
                "force",
                {},
                vim.lsp.protocol.make_client_capabilities(),
                {
                    textDocument = {
                        inlayHint = {
                            dynamicRegistration = true,
                        },
                    },
                }
            )

            local ok, blink_cap = pcall(require, "blink.cmp")
            if ok and blink_cap then
                capabilities = vim.tbl_deep_extend("force", capabilities, blink_cap.get_lsp_capabilities())
            end

            require("mason").setup()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "lua_ls",
                    "gopls",
                    "zls",
                    "omnisharp",
                    "rust_analyzer",
                    "pylsp",
                    "ts_ls",
                    "templ",
                },
                handlers = {
                    function(server)
                        vim.lsp.config(server, {
                            capabilities = vim.tbl_deep_extend("force", capabilities, {
                                inlayHint = { dynamicRegistration = true },
                            }),
                        })
                    end,
                },
            })

            -- Lua
            vim.lsp.config("lua_ls", {
                capabilities = capabilities,
                settings = {
                    Lua = {
                        runtime = { version = "Lua 5.1" },
                        diagnostics = {
                            globals = { "bit", "vim", "it", "describe", "before_each", "after_each" },
                        },
                    },
                },
            })

            -- Zig
            vim.lsp.config("zls", {
                capabilities = capabilities,
                root_dir = vim.fs.root(0, { ".git", "build.zig", "zls.json" }),
                settings = {
                    zls = {
                        enable_inlay_hints = true,
                        enable_snippets = true,
                        warn_style = true,
                    },
                },
            })
            vim.g.zig_fmt_parse_errors = 0
            vim.g.zig_fmt_autosave = 0

            -- C#
            vim.lsp.config("omnisharp", {
                capabilities = capabilities,
                on_attach = function(client, bufnr)
                    vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                    vim.api.nvim_create_autocmd({ "TextChangedI", "CursorHold" }, {
                        buffer = bufnr,
                        callback = function()
                            vim.lsp.buf.request(bufnr, "textDocument/diagnostic", {
                                textDocument = vim.lsp.util.make_text_document_params(bufnr),
                            })
                        end,
                    })
                end,
                settings = {
                    ["csharp.formatting"] = {
                        NewLinesForBracesInLambdaExpressionBody = true,
                        NewLinesForBracesInAnonymousMethods = true,
                        NewLinesForBracesInControlStatements = true,
                        NewLinesForBracesInObjectCollectionArrayInitializers = true,
                        NewLinesForBracesInMethodsAndConstructors = true,
                        NewLinesForBracesInProperties = true,
                        NewLinesForBracesInTypes = true,
                    },
                },
            })

            vim.lsp.enable({ "gopls", "rust_analyzer", "ts_ls", "templ", "pylsp", "lua_ls", "zls", "omnisharp" })
        end,
    },

    -- None-ls (formatters/linters)
    {
        "nvimtools/none-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")

            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.stylua,
                    null_ls.builtins.formatting.gofmt,
                    null_ls.builtins.formatting.prettierd,
                },
            })

            vim.keymap.set("n", "<leader>f", function()
                vim.lsp.buf.format({ async = true })
            end, { desc = "Format" })
        end,
    },
}