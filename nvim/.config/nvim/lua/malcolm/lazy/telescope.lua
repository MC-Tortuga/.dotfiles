return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		require("telescope").setup({})

		local builtin = require("telescope.builtin")
		vim.keymap.set("n", "<leader>pf", function()
			require("telescope.builtin").find_files()
		end, {})
		vim.keymap.set("n", "<C-p>", function()
			require("telescope.builtin").git_files()
		end, {})
		vim.keymap.set("n", "<leader>pws", function()
			local word = vim.fn.expand("<cword>")
			require("telescope.builtin").grep_string({ search = word })
		end)
		vim.keymap.set("n", "<leader>pWs", function()
			local word = vim.fn.expand("<cWORD>")
			require("telescope.builtin").grep_string({ search = word })
		end)
		vim.keymap.set("n", "<leader>ps", function()
			require("telescope.builtin").grep_string({ search = vim.fn.input("Grep > ") })
		end)
		vim.keymap.set("n", "<leader>vh", function()
			require("telescope.builtin").help_tags()
		end, {})
	end,
}
