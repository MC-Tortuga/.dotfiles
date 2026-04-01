vim.diagnostic.config({
    update_in_insert_mode = true,
    virtual_text = {
        prefix = "●",
    },
    float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
    },
})