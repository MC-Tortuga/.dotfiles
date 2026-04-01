require("malcolm.set")
require("malcolm.remap")
require("malcolm.lazy_init")
require("malcolm.diagnostics")

local augroup = vim.api.nvim_create_augroup
local yank_group = augroup("HighlightYank", {})

vim.filetype.add({
    extension = {
        templ = 'templ',
    }
})

vim.api.nvim_create_autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})
