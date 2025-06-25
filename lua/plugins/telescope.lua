return {
    {
        'nvim-telescope/telescope.nvim', 
        -- tag = '0.1.8',
        config = function()

            local select_one_or_multi = function(prompt_bufnr)
                local picker = require('telescope.actions.state').get_current_picker(prompt_bufnr)
                local multi = picker:get_multi_selection()

                if not vim.tbl_isempty(multi) then
                    require('telescope.actions').close(prompt_bufnr)
                    for _, j in pairs(multi) do
                        if j.path ~= nil then
                            if j.lnum ~= nil then
                                vim.cmd(string.format("%s +%s %s", "edit", j.lnum, j.path))
                            else
                                vim.cmd(string.format("%s %s", "edit", j.path))
                            end
                        end
                    end
                else
                    require('telescope.actions').select_default(prompt_bufnr)
                end
            end

            require("telescope").setup({
                defaults = {
                    mappings = {
                        i = { ["<CR>"] = select_one_or_multi },
                        n = { ["<CR>"] = select_one_or_multi },
                    },
                },
            })


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

            vim.keymap.set('n', 'FS', require('telescope.builtin').current_buffer_fuzzy_find, { desc = 'Search in current file' })

        end,
    },
}
