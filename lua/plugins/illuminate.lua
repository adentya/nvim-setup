return {
    {
        "RRethy/vim-illuminate",
        config = function()
            vim.keymap.set("n", "<M-f>", function()
                require("illuminate").goto_next_reference(true)
            end, { desc = "Next reference" })

            vim.keymap.set("n", "<M-F>", function()
                require("illuminate").goto_prev_reference(true)
            end, { desc = "Previous reference" })
        end
    },
}
