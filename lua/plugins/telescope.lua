return {
    {
        'nvim-telescope/telescope.nvim', 
        tag = '0.1.8',
        config = function()
            local builtin = require('telescope.builtin')

            vim.keymap.set('n', '<leader>ff', function()
                builtin.find_files({ hidden = true })
            end, { desc = 'Telescope find files (including hidden & ignored)' })

            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

            vim.keymap.set('n', '<leader>@', function ()
                builtin.lsp_document_symbols({
                    symbols = { "Function", "Method" }  -- filters only these kinds
                })
            end, {
                    desc = 'LSP Workspace Symbols'
                })

        end,
    },
}
