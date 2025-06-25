return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 
            'nvim-tree/nvim-web-devicons',
            'lewis6991/gitsigns.nvim',
        },
        config = function()
            local function get_env()
                local venv = require("venv-selector").get_active_venv()
                if venv then
                    return vim.fn.fnamemodify(venv, ":t")  -- Show only venv folder name
                else
                    return "system"
                end
            end

            local function blame_line()
                local gs = vim.b.gitsigns_blame_line_dict
                if gs then
                    local author = gs.author or "Unknown"
                    local date = gs.author_time and os.date("%Y-%m-%d", gs.author_time) or ""
                    local summary = string.sub(gs.summary, 1, 25) .. "..." or ""
                    return string.format("%s • %s • %s", author, date, summary)
                end
                return ""
            end

            local function tab_spaces()
                local expandtab = vim.bo.expandtab and "Spaces" or "Tabs"
                local shiftwidth = vim.bo.shiftwidth
                return string.format("%s: %d", expandtab, shiftwidth)
            end


            require('lualine').setup({
                options = {
                    theme = "auto",
                    -- section_separators = "",
                    -- component_separators = "",
                },
                sections = {
                    lualine_a = { "mode" },
                    lualine_b = { "branch" },
                    -- lualine_c = {"fileformat", "swenv", "fileformat" },
                    lualine_c = {
                        {
                            get_env,
                            icon = '',
                            colored = true,
                        },
                        {'filename', path = 1}
                    },
                    lualine_x = {
                        {
                            'diagnostics',
                            sources = {'nvim_diagnostic'},
                            sections = {'error', 'warn', 'info', 'hint'},
                            symbols = {
                                error = ' ',
                                warn  = ' ',
                                info  = ' ',
                                hint  = ' ',
                            },
                            colored = true,
                            update_in_insert = false,
                            always_visible = false,
                        },
                        { blame_line, icon = "", colored = true},
                        tab_spaces,
                        "encoding", 
                        "fileformat", 
                        "filetype",
                    },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
            })
        end,
    },
}
