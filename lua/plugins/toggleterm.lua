return {
    {
        'akinsho/toggleterm.nvim', 
        -- version = "*", 
        opts = {},
        config = function ()
            local Terminal = require("toggleterm.terminal").Terminal

            function create_terminal(direction)
                direction = direction or "horizontal"
                return Terminal:new({
                    direction = direction,
                    shell = vim.o.shell,
                    on_open = function(term)
                        -- Check if we've already activated the venv in this terminal buffer
                        if vim.b[term.bufnr].venv_activated then
                            return
                        end

                        -- activate venv
                        local venv_path = require("venv-selector").get_active_venv()
                        if venv_path then
                            -- Send the activate command into the terminal
                            term:send("source " .. venv_path .. "/bin/activate && clear", true)

                            -- Mark this terminal buffer as having the venv activated
                            vim.b[term.bufnr].venv_activated = true
                        else
                            vim.notify("No virtual environment selected.", vim.log.levels.WARN)
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

            vim.keymap.set('n', '<leader>0', function()
                local term_with_venv = nil

                if mapping_terminal[0] then
                    term_with_venv = mapping_terminal[0]
                else
                    term_with_venv = create_terminal("float")
                    mapping_terminal[0] = term_with_venv
                end

                local terminals = require("toggleterm.terminal").get_all()
                for _, term in pairs(terminals) do
                    if term.direction == "float" and term ~= term_with_venv then
                        term:close()
                    end
                end

                if term_with_venv:is_open() then
                    term_with_venv:close()
                else
                    term_with_venv:toggle()
                end

                vim.schedule(function()
                    local term_win = term_with_venv.window
                    if term_win and vim.api.nvim_win_is_valid(term_win) then
                        vim.api.nvim_set_current_win(term_win)
                        -- vim.cmd("startinsert!")
                    end
                end)
            end)

            vim.keymap.set('n', '<leader>9', function()
                local term_with_venv = nil

                if mapping_terminal[9] then
                    term_with_venv = mapping_terminal[9]
                else
                    term_with_venv = create_terminal("float")
                    mapping_terminal[9] = term_with_venv
                end

                local terminals = require("toggleterm.terminal").get_all()
                for _, term in pairs(terminals) do
                    if term.direction == "float" and term ~= term_with_venv then
                        term:close()
                    end
                end

                if term_with_venv:is_open() then
                    term_with_venv:close()
                else
                    term_with_venv:toggle()
                end

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
