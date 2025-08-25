require("malcolm.set")
require("malcolm.remap")
require("malcolm.lazy_init")

local augroup = vim.api.nvim_create_augroup
local MalcolmGroup = augroup("Malcolm", {})

local autocmd = vim.api.nvim_create_autocmd
local yank_group = augroup("HighlightYank", {})

vim.filetype.add({
    extension = {
        templ = 'templ',
    }
})

autocmd("TextYankPost", {
    group = yank_group,
    pattern = "*",
    callback = function()
        vim.highlight.on_yank({
            higroup = "IncSearch",
            timeout = 40,
        })
    end,
})
