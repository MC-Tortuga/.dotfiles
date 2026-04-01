vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>f", function()
    require("conform").format({ async = true, lsp_fallback = true })
    require("vim.lsp.buf").code_action({ apply = true })
end)
vim.keymap.set("n", "<leader>rn", function() require("vim.lsp.buf").rename() end)
vim.keymap.set("n", "<leader>y", ":%y+<CR>", { desc = "Copy entire file to clipboard" })
