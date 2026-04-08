return {
    -- Catppuccin colorscheme
    {
        "catppuccin/nvim",
        lazy = false,
        priority = 1000,
        config = function()
            vim.cmd([[colorscheme catppuccin-mocha]])
        end,
    },

    -- Which-key
    {
        "folke/which-key.nvim",
        event = "VeryLazy",
        config = function()
            local wk = require("which-key")
            wk.setup({})

            wk.add({
                { "<leader>p", group = "file" },
                { "<leader>pv", group = "explorer" },
                { "<leader>f", group = "format" },
                { "<leader>r", group = "rename" },
                { "<leader>u", group = "undo" },
                { "<leader>A", group = "harpoon" },
                { "<leader>a", group = "harpoon" },
                { "<leader>t", group = "trouble" },
                { "<leader>d", group = "debug" },
                { "<leader>b", group = "breakpoint" },
            })
        end,
    },
}