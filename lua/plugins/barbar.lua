return {
    {
        'romgrk/barbar.nvim',
        dependencies = {
            'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
            'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        init = function() 
            vim.g.barbar_auto_setup = false 

            local map = vim.api.nvim_set_keymap
            local opts = { noremap = true, silent = true }

            -- Move to previous/next
            map('n', '<S-Tab>', '<Cmd>BufferPrevious<CR>', opts)
            map('n', '<Tab>', '<Cmd>BufferNext<CR>', opts)
            -- Re-order to previous/next
            map('n', '<A-,>', '<Cmd>BufferMovePrevious<CR>', opts)
            map('n', "<A-.>", '<Cmd>BufferMoveNext<CR>', opts)
            -- Goto buffer in position...
            map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
            map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
            map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
            map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
            map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
            map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
            -- Pin/unpin buffer
            map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
            -- Close buffer
            map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)

            vim.keymap.set('n', '<leader>bc', '<Cmd>BufferPickDelete<CR>', { noremap = true, silent = true })

        end,
        opts = {
            icons = {
                buffer_index = true,
            },
        },
        version = '^1.0.0', -- optional: only update when a new 1.x version is released
    },
}
