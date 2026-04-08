-- Keymaps
vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end)

vim.keymap.set("n", "<leader>y", ":%y+<CR>", { desc = "Copy entire file to clipboard" })