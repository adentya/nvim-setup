return {
    {
        "nvim-tree/nvim-tree.lua",
        -- version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            -- vim.cmd [[
            --     highlight! link NvimTreeOpenedFileName TermCursor
            -- ]]

            require("nvim-tree").setup {
                sort = {
                    sorter = "case_sensitive",
                },
                view = {
                    width = 35,
                },
                filters = {
                    dotfiles = false,
                    custom = {},
                },
                git = {
                    enable = true,
                    ignore = false,
                },
                update_focused_file = {
                    enable = true,
                    update_cwd = true, -- optional: updates Neovim's working dir
                },
                renderer = {
                    highlight_opened_files = "all", -- options: "none", "icon", "name", "all"
                },
            }

            vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>tf", ":NvimTreeFindFile<CR>", { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>ts1", ":NvimTreeResize 10<CR>", { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>ts2", ":NvimTreeResize 20<CR>", { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>ts3", ":NvimTreeResize 30<CR>", { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>ts4", ":NvimTreeResize 40<CR>", { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>ts5", ":NvimTreeResize 50<CR>", { noremap = true, silent = true })


        end,
    },
}
