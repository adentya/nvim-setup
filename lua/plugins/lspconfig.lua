return {
    {
        'neovim/nvim-lspconfig',
        config = function()
            vim.lsp.enable('pyright')

            -- Diagnostic signs
            vim.diagnostic.config({
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = " ",
                        [vim.diagnostic.severity.WARN] = " ",
                        [vim.diagnostic.severity.INFO] = "󰋼 ",
                        [vim.diagnostic.severity.HINT] = "󰌵 ",
                    },
                    numhl = {
                        [vim.diagnostic.severity.ERROR] = "",
                        [vim.diagnostic.severity.WARN] = "",
                        [vim.diagnostic.severity.HINT] = "",
                        [vim.diagnostic.severity.INFO] = "",
                    },
                },
            })


            vim.lsp.config('pyright', {
                filetypes = { 'python' }
            })

            vim.api.nvim_set_keymap('n', '<leader>`', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap=true, silent=true })
            vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap=true, silent=true })
            vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap=true, silent=true })
            vim.api.nvim_set_keymap('n', '<leader>~', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap=true, silent=true })

            vim.keymap.set("v", "<leader>f", function()
                vim.lsp.buf.range_formatting({}, vim.api.nvim_buf_get_mark(0, "<"), vim.api.nvim_buf_get_mark(0, ">"))
            end, { desc = "Format selected lines with LSP" })

        end,
    },
}
