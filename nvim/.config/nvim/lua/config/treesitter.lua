-- Native treesitter (Neovim 0.10+)
local skip_fts = {
    "lazy",
    "TelescopePrompt",
    "TelescopeResults",
    "lazy_backdrop",
    "nofile",
    "terminal",
    "quickfix",
    "netrw",
}

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function(args)
        local ft = args.match
        if vim.tbl_contains(skip_fts, ft) then
            return
        end
        if vim.treesitter.language.get_lang(ft) then
            pcall(vim.treesitter.start)
        end
    end,
})

vim.treesitter.language.register("templ", "templ")