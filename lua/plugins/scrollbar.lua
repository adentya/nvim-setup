return {
    {
        "petertriho/nvim-scrollbar",
        config = function()

            -- Activate diagnostic and search handlers
            require("scrollbar.handlers.search").setup()
            require("scrollbar.handlers.diagnostic").setup()

            require("scrollbar").setup({
                handle = {
                    text = "▓▓"
                },
                handlers = {
                    diagnostic = true,
                    gitsigns = true,
                    search = true,
                }
            })

        end,
    },
}
