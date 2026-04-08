-- Plugin specs
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Colorscheme
    { "catppuccin/nvim", lazy = false, priority = 1000 },

    -- LSP
    require("plugins.lsp"),

    -- Completion
    require("plugins.completion"),

    -- Search
    require("plugins.search"),

    -- UI
    require("plugins.ui"),

    -- DAP
    require("plugins.dap"),

    -- Tools
    require("plugins.tools"),
}, {
    git = {
        url_format = "https://github.com/%s.git",
    },
})