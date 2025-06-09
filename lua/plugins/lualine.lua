return {
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 
            'nvim-tree/nvim-web-devicons',
        },
        config = function()
            --[[local function python_venv()
                local venv = require("swenv.api").get_current_venv()
                if venv then
                    return venv.name
                else
                    return "system"
                end
            end]]

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
                            'swenv',
                            icon = '',
                            colored = true,
                        }
                    },
                    lualine_x = { "encoding", "fileformat", "filetype" },
                    lualine_y = { "progress" },
                    lualine_z = { "location" },
                },
            })
        end,
    },
}
