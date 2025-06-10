return {
    {
        "smartpde/telescope-recent-files",
        config = function()
            require("telescope").load_extension("recent_files")
            vim.api.nvim_set_keymap("n", "H",
                [[<cmd>lua require('telescope').extensions.recent_files.pick()<CR>]],
                {noremap = true, silent = true})
        end
    },
}
