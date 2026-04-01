return {
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
}
