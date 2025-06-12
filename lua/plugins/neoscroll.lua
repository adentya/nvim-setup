return {
    {
        "karb94/neoscroll.nvim",
        opts = {},
        config = function()
            require("neoscroll").setup{
                duration_multiplier = 1.0,
                easing = 'quadratic',
            }
        end
    },
}
