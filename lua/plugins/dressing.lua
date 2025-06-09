return {
    {
        'stevearc/dressing.nvim',
        opts = {},
        config = function()
            require('dressing').setup({
                input = {
                    enabled = true,
                },
                select = {
                    enabled = true,
                    backend = {"telescope", "fzf_lua", "fzf", "builtin", "nui"},
                    trim_prompt = true,
                },
            })
        end,
    },
}
