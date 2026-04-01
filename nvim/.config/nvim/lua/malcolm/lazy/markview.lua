return {
    "OXY2DEV/markview.nvim",
    event = { "BufRead", "BufNewFile" },
    ft = { "markdown", "md" },
    config = function()
        require("markview").setup({
            markdown = {
                enable = true,
                headings = {
                    icon = "󰉋 ",
                    highlight = "Title",
                },
                code_blocks = {
                    style = "language",
                    border = "rounded",
                },
            },
            markdown_inline = {
                enable = true,
                checkboxes = {
                    unchecked = { icon = "󰄱 ", highlight = "Comment" },
                    checked = { icon = "󰱒 ", highlight = "String" },
                },
            },
            preview = {
                enable = true,
                debounce = 150,
            },
        })
    end,
}