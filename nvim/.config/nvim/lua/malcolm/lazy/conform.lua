return {
    'stevearc/conform.nvim',
    config = function()
        require("conform").setup({
            formatters_by_ft = {
                lua = { "stylua" },
                go = { "gofmt" },
                csharp = { "csharpier" },
                rust = { "rustfmt" },
                javascript = { "prettierd" },
                typescript = { "prettierd" },
                python = { "pylsp" },
                zig = { "zigfmt" },
            },
        })
    end
}
