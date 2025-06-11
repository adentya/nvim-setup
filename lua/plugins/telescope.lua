return {
    {
        'nvim-telescope/telescope.nvim', 
        tag = '0.1.8',
        config = function()

            local select_one_or_multi = function(prompt_bufnr)
                local actions = require("telescope.actions")
                local action_state = require("telescope.actions.state")
                local picker = action_state.get_current_picker(prompt_bufnr)
                local multi = picker:get_multi_selection()

                -- fallback to single selection if nothing is marked
                if vim.tbl_isempty(multi) then
                    actions.select_default(prompt_bufnr)
                    return
                end

                actions.close(prompt_bufnr)

                for _, entry in ipairs(multi) do
                    local path = entry.path or entry.filename
                    local lnum = entry.lnum

                    if path then
                        if lnum then
                            vim.cmd(string.format("edit +%d %s", lnum, vim.fn.fnameescape(path)))
                        else
                            vim.cmd(string.format("edit %s", vim.fn.fnameescape(path)))
                        end
                    end
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

        end,
    },
}
