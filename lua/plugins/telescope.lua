return {
    {
        'nvim-telescope/telescope.nvim', 
        tag = '0.1.8',
        config = function()
            local builtin = require('telescope.builtin')

            vim.keymap.set('n', 'FF', function()
                builtin.find_files({ cwd = vim.fn.getcwd() })
            end, { desc = 'Telescope find files (including hidden & ignored)' })

            vim.keymap.set('n', 'FG', function()
                builtin.live_grep({ cwd = vim.fn.getcwd() })
            end, { desc = 'Telescope live grep' })

            vim.keymap.set('n', 'B', builtin.buffers, { desc = 'Telescope buffers' })
            vim.keymap.set('n', '?', builtin.help_tags, { desc = 'Telescope help tags' })

            vim.keymap.set('n', '@', function ()
                builtin.lsp_document_symbols({
                    symbols = { "Function", "Method", "Class" }  -- filters only these kinds
                })
            end, {
                    desc = 'LSP Workspace Symbols'
                })

        end,
    },
}
