return {
    'stevearc/conform.nvim',
    opts = {},
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                go = { "gofmt" },
                csharp = { "omnisharp" },
                rust = { "rustfmt" },
                javascript = { "prettierd" },
                typesscript = { "prettierd" },
                python = { "pylsp" },
                zig = { "zigfmt" },
            }
        })
    end
}
