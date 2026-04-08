return {
    -- Telescope (file search)
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            require("telescope").setup({})

            vim.keymap.set("n", "<leader>pf", function()
                require("telescope.builtin").find_files()
            end, { desc = "Find files" })

            vim.keymap.set("n", "<C-p>", function()
                require("telescope.builtin").git_files()
            end, { desc = "Git files" })

            vim.keymap.set("n", "<leader>pws", function()
                local word = vim.fn.expand("<cword>")
                require("telescope.builtin").grep_string({ search = word })
            end, { desc = "Grep word (cword)" })

            vim.keymap.set("n", "<leader>pWs", function()
                local word = vim.fn.expand("<cWORD>")
                require("telescope.builtin").grep_string({ search = word })
            end, { desc = "Grep word (cWORD)" })

            vim.keymap.set("n", "<leader>ps", function()
                require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
            end, { desc = "Grep prompt" })

            vim.keymap.set("n", "<leader>vh", function()
                require("telescope.builtin").help_tags()
            end, { desc = "Help tags" })
        end,
    },
}