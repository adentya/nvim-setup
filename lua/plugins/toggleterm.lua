return {
    {
        'akinsho/toggleterm.nvim', 
        version = "*", 
        opts = {},
        config = function ()
            local Terminal = require("toggleterm.terminal").Terminal
            local swenv_api = require("swenv.api")

            function create_terminal()
                return Terminal:new({
                    direction = "horizontal",
                    on_open = function(term)
                        -- activate venv
                        local venv = swenv_api.get_current_venv()
                        if venv and venv.path then
                            local activate_script = venv.path .. "/bin/activate"
                            local uv = vim.loop
                            if uv.fs_stat(activate_script) then
                                term:send('source "' .. activate_script .. '"', true)
                            else
                                print("⚠️ venv activate script not found: " .. activate_script)
                            end
                        end
                    end,
                })
            end

            mapping_terminal = {}

            vim.keymap.set('n', '<leader>1', function()
                local term_with_venv = nil

                if mapping_terminal[1] then
                    term_with_venv = mapping_terminal[1]
                else
                    term_with_venv = create_terminal()
                    mapping_terminal[1] = term_with_venv
                end

                term_with_venv:toggle()

                vim.schedule(function()
                    local term_win = term_with_venv.window
                    if term_win and vim.api.nvim_win_is_valid(term_win) then
                        vim.api.nvim_set_current_win(term_win)
                        -- vim.cmd("startinsert!")
                    end
                end)
            end)

            vim.keymap.set('n', '<leader>2', function()
                local term_with_venv = nil

                if mapping_terminal[2] then
                    term_with_venv = mapping_terminal[2]
                else
                    term_with_venv = create_terminal()
                    mapping_terminal[2] = term_with_venv
                end

                term_with_venv:toggle()

                vim.schedule(function()
                    local term_win = term_with_venv.window
                    if term_win and vim.api.nvim_win_is_valid(term_win) then
                        vim.api.nvim_set_current_win(term_win)
                        -- vim.cmd("startinsert!")
                    end
                end)
            end)

            vim.keymap.set('n', '<leader>3', function()
                local term_with_venv = nil

                if mapping_terminal[3] then
                    term_with_venv = mapping_terminal[3]
                else
                    term_with_venv = create_terminal()
                    mapping_terminal[3] = term_with_venv
                end

                term_with_venv:toggle()

                vim.schedule(function()
                    local term_win = term_with_venv.window
                    if term_win and vim.api.nvim_win_is_valid(term_win) then
                        vim.api.nvim_set_current_win(term_win)
                        -- vim.cmd("startinsert!")
                    end
                end)
            end)

            -- Map ESC to exit terminal mode
            vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], { noremap = true, silent = true })

        end,
    },
}
