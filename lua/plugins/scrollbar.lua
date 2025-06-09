return {
    {
        "petertriho/nvim-scrollbar",
        config = function()
            local colors = require("tokyonight.colors").setup()
            require("scrollbar").setup({
                show = true,
                show_in_active_only = false,
                set_highlights = true,
                handle = {
                    text = " ",
                    color = colors.bg_highlight,
                    color_nr = nil, -- cterm
                    highlight = "CursorColumn",
                    hide_if_all_visible = false,
                },
                marks = {
                    Cursor = {
                        text = "•",
                        priority = 0,
                        color = nil,
                        cterm = nil,
                        highlight = "Normal",
                    },
                    Search = {
                        text = { "-", "=" },
                        priority = 1,
                        color = colors.orange,
                        cterm = nil,
                        highlight = "Search",
                    },
                    Error = {
                        text = { "" },
                        priority = 2,
                        color = colors.error,
                        cterm = nil,
                        highlight = "DiagnosticVirtualTextError",
                    },
                    Warn = {
                        text = { "" },
                        priority = 3,
                        color = colors.warning,
                        cterm = nil,
                        highlight = "DiagnosticVirtualTextWarn",
                    },
                    Info = {
                        text = { "" },
                        priority = 4,
                        color = colors.info,
                        cterm = nil,
                        highlight = "DiagnosticVirtualTextInfo",
                    },
                    Hint = {
                        text = { "" },
                        priority = 5,
                        color = colors.hint,
                        cterm = nil,
                        highlight = "DiagnosticVirtualTextHint",
                    },
                    Misc = {
                        text = { "" },
                        priority = 6,
                        color = colors.purple,
                        cterm = nil,
                        highlight = "Normal",
                    },
                },
                excluded_buftypes = { "terminal", "prompt", "nofile" },
                excluded_filetypes = {
                    "cmp_docs",
                    "cmp_menu",
                    "noice",
                    "prompt",
                    "TelescopePrompt",
                    "TelescopeResults",
                    "dashboard",
                    "NvimTree",
                },
                autocmd = {
                    render = {
                        "BufWinEnter",
                        "TabEnter",
                        "TermEnter",
                        "WinEnter",
                        "CmdwinLeave",
                        "TextChanged",
                        "VimResized",
                        "WinScrolled",
                    },
                    clear = {
                        "BufWinLeave",
                        "TabLeave",
                        "TermLeave",
                        "WinLeave",
                    },
                },
                handlers = {
                    diagnostic = true,
                    search = true,
                    gitsigns = true, -- if using gitsigns.nvim
                    handle = true,
                    cursor = true,
                },

            })

            -- Activate diagnostic and search handlers
            require("scrollbar.handlers.search").setup()
            require("scrollbar.handlers.diagnostic").setup()

        end,
    },
}
