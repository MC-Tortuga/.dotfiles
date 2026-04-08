return {
    -- Snippets (LuaSnip replacement - mini.snippets is built into blink.cmp)
    {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            local ls = require("luasnip")
            ls.filetype_extend("javascript", { "jsdoc" })
            ls.filetype_extend("cs", { "csharp" })

            vim.keymap.set({ "i" }, "<C-s>e", function()
                require("luasnip").expand()
            end, { silent = true })

            vim.keymap.set({ "i", "s" }, "<C-s>;", function()
                require("luasnip").jump(1)
            end, { silent = true })
            vim.keymap.set({ "i", "s" }, "<C-s>,", function()
                require("luasnip").jump(-1)
            end, { silent = true })

            vim.keymap.set({ "i", "s" }, "<C-E>", function()
                if require("luasnip").choice_active() then
                    require("luasnip").change_choice(1)
                end
            end, { silent = true })
        end,
    },

    -- Harpoon
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local harpoon = require("harpoon")
            harpoon:setup()

            vim.keymap.set("n", "<leader>A", function()
                require("harpoon").list():prepend()
            end)
            vim.keymap.set("n", "<leader>a", function()
                require("harpoon").list():add()
            end)
            vim.keymap.set("n", "<C-e>", function()
                require("harpoon.ui"):toggle_quick_menu(require("harpoon").list())
            end)

            vim.keymap.set("n", "<C-h>", function()
                require("harpoon").list():select(1)
            end)
            vim.keymap.set("n", "<C-t>", function()
                require("harpoon").list():select(2)
            end)
            vim.keymap.set("n", "<C-n>", function()
                require("harpoon").list():select(3)
            end)
            vim.keymap.set("n", "<C-s>", function()
                require("harpoon").list():select(4)
            end)

            vim.keymap.set("n", "<leader><C-h>", function()
                require("harpoon").list():replace_at(1)
            end)
            vim.keymap.set("n", "<leader><C-t>", function()
                require("harpoon").list():replace_at(2)
            end)
            vim.keymap.set("n", "<leader><C-n>", function()
                require("harpoon").list():replace_at(3)
            end)
            vim.keymap.set("n", "<leader><C-s>", function()
                require("harpoon").list():replace_at(4)
            end)
        end,
    },

    -- Undotree
    {
        "mbbill/undotree",
        config = function()
            vim.keymap.set("n", "<leader>u", function() vim.cmd.UndotreeToggle() end)
        end,
    },

    -- Trouble
    {
        "folke/trouble.nvim",
        cmd = "Trouble",
        keys = {
            { "<leader>tt", "<cmd>Trouble diagnostics toggle<cr>", desc = "Diagnostics (Trouble)" },
            { "<leader>tT", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics (Trouble)" },
            { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Symbols (Trouble)" },
            { "<leader>cl", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "LSP Definitions / references" },
            { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List (Trouble)" },
            { "<leader>tQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List (Trouble)" },
        },
    },

    -- Markview (Markdown preview)
    {
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
    },
}