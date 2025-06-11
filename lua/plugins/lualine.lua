return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            function get_env()
                local venv = require("venv-selector").get_active_venv()
                if venv then
                    return vim.fn.fnamemodify(venv, ":t")  -- Show only venv folder name
                else
                    return "system"
                end
            end
            require('lualine').setup({
                options = {
                    theme = "auto",
                    section_separators = "",
                    component_separators = "",
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
