return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        local cmp_lsp = require("cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            cmp_lsp.default_capabilities(),
            {
                textDocument = {
                    inlayHint = {
                        dynamicRegistration = true,
                    },
                },
            }
        )

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
                "templ"
            },
            handlers = {
                function(server_name)
                    local lspconfig = require("lspconfig")
                    local server = lspconfig[server_name]
                    local opts = {
                        capabilities = capabilities,
                        on_attach = function(client, bufnr)
                            vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
                            if server_name == "omnisharp" then
                                vim.api.nvim_create_autocmd({ "TextChangedI", "CursorHold" }, {
                                    buffer = bufnr,
                                    callback = function()
                                        vim.lsp.buf.request(bufnr, "textDocument/diagnostic", {
                                            textDocument = vim.lsp.util.make_text_document_params(bufnr),
                                        })
                                    end,
                                })
                            end
                        end,
                    }
                    if server_name == "omnisharp" then
                        opts.settings = {
                            ["csharp.formatting"] = {
                                NewLinesForBracesInLambdaExpressionBody = true,
                                NewLinesForBracesInAnonymousMethods = true,
                                NewLinesForBracesInControlStatements = true,
                                NewLinesForBracesInObjectCollectionArrayInitializers = true,
                                NewLinesForBracesInMethodsAndConstructors = true,
                                NewLinesForBracesInProperties = true,
                                NewLinesForBracesInTypes = true,
                            },
                        }
                    end
                    server.setup(opts)
                end,

                ["textDocument/publishDiagnostics"] = vim.lsp.with(
                    vim.lsp.diagnostic.on_publish_diagnostics,
                    { update_in_insert_mode = true }
                ),

                zls = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.zls.setup({
                        root_dir = lspconfig.util.root_pattern(".git", "build.zig", "zls.json"),
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
                end,
                ["lua_ls"] = function()
                    local lspconfig = require("lspconfig")
                    lspconfig.lua_ls.setup({
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
                end,
            },
        })
    end,
}