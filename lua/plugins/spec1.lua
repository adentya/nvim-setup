return {
    --[[{ 
        "catppuccin/nvim", 
        name = "catppuccin", 
        priority = 1000 ,
        lazy = false,
    },]]
    {
        "folke/tokyonight.nvim",
        lazy = false,
        priority = 1000,
        opts = {},
    },
    {
        "nvim-lua/plenary.nvim",
    },
    {
        "karb94/neoscroll.nvim",
        opts = {},
    },
    {
        "easymotion/vim-easymotion",
    },
    {
        "lewis6991/gitsigns.nvim",
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        main = "ibl",
        opts = {},
    },
    { 
        "nvim-tree/nvim-web-devicons", 
        opts = {},
    },
    { 
        'nvim-telescope/telescope-fzf-native.nvim', 
        build = 'make',
    },
    {
        'numToStr/Comment.nvim',
        opts = {
            -- add any options here
        },
        config = function()
            require('Comment').setup()
        end
    },
    {
        "smartpde/telescope-recent-files",
        config = function()
            require("telescope").load_extension("recent_files")
            vim.api.nvim_set_keymap("n", "<Leader>h",
                [[<cmd>lua require('telescope').extensions.recent_files.pick()<CR>]],
                {noremap = true, silent = true})
        end
    },
    {
        'stevearc/dressing.nvim',
        opts = {},
        config = function()
            require('dressing').setup({
                input = {
                    enabled = true,
                },
                select = {
                    enabled = true,
                    backend = {"telescope", "fzf_lua", "fzf", "builtin", "nui"},
                    trim_prompt = true,
                },
            })
        end,
    },
    {
        "RRethy/vim-illuminate",
        config = function()
            vim.keymap.set("n", "<M-f>", function()
                require("illuminate").goto_next_reference(true)
            end, { desc = "Next reference" })

            vim.keymap.set("n", "<M-F>", function()
                require("illuminate").goto_prev_reference(true)
            end, { desc = "Previous reference" })
        end
    },
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
    {
        'saghen/blink.cmp',
        dependencies = { 'rafamadriz/friendly-snippets' },
        version = '1.*',
        opts = {
            -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
            -- 'super-tab' for mappings similar to vscode (tab to accept)
            -- 'enter' for enter to accept
            -- 'none' for no mappings
            --
            -- All presets have the following mappings:
            -- C-space: Open menu or open docs if already open
            -- C-n/C-p or Up/Down: Select next/previous item
            -- C-e: Hide menu
            -- C-k: Toggle signature help (if signature.enabled = true)
            --
            -- See :h blink-cmp-config-keymap for defining your own keymap
            keymap = { preset = 'enter' },
            appearance = {
                nerd_font_variant = 'mono'
            },
            completion = { documentation = { auto_show = false } },
            sources = {
                default = { 'lsp', 'path', 'snippets', 'buffer' },
            },
            fuzzy = { implementation = "prefer_rust_with_warning" },
            signature = { enabled = true },
        },
        opts_extend = { "sources.default" }
    },
    {
        'neovim/nvim-lspconfig',
        config = function()
            vim.lsp.enable('pyright')
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
    {
        "AckslD/swenv.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig", },
        config = function ()
            require("swenv").setup({
                venvs_path = vim.fn.getcwd() .. "/.venv", -- equivalent to `:pwd` in terminal
                auto_create_venv = true,
                auto_create_venv_dir = ".venv",
                post_set_venv = function()
                    -- Restart pyright safely
                    for _, client in pairs(vim.lsp.get_clients()) do
                        if client.name == "pyright" then
                            client.stop()
                        end
                    end
                    vim.defer_fn(function()
                        vim.cmd("edit")
                    end, 100)
                end,
            })
            vim.keymap.set("n", "<leader>pv", function()
                require("swenv.api").pick_venv()
            end, { noremap = true, silent = true, desc = "Pick Python venv" })

        end
    },
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
    {
        'nvim-telescope/telescope.nvim', 
        tag = '0.1.8',
        config = function()
            local builtin = require('telescope.builtin')

            vim.keymap.set('n', '<leader>ff', function()
                builtin.find_files({ hidden = true })
            end, { desc = 'Telescope find files (including hidden & ignored)' })

            vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
            vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

            vim.keymap.set('n', '@', function ()
                builtin.lsp_document_symbols({
                    symbols = { "Function", "Method" }  -- filters only these kinds
                })
            end, {
                    desc = 'LSP Workspace Symbols'
                })

        end,
    },
    {
        "nvim-treesitter/nvim-treesitter", 
        branch = 'master', 
        lazy = false, 
        build = ":TSUpdate",
        config = function()
            require'nvim-treesitter.configs'.setup {
                ensure_installed = { "python", "html", "javascript", "css", "php" },
                sync_install = false,
                -- Automatically install missing parsers when entering buffer
                -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
                auto_install = false,
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = true,
                },
                indent = {
                    enable = true,
                },
                update_focused_file = {
                    enable = true,
                    update_cwd = true,
                },
                reload_on_bufenter = true,
                refactor = {
                    highlight_definitions = {
                        enable = true,
                        clear_on_cursor_move = true,
                    },
                },
            }
        end,
    },
    {
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
    },
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            vim.cmd [[
                highlight! link NvimTreeOpenedFileName TermCursor
            ]]

            require("nvim-tree").setup {
                sort = {
                    sorter = "case_sensitive",
                },
                view = {
                    width = 50,
                },
                filters = {
                    dotfiles = false,
                    custom = {},
                },
                git = {
                    enable = true,
                    ignore = false,
                },
                update_focused_file = {
                    enable = true,
                    update_cwd = true, -- optional: updates Neovim's working dir
                },
                renderer = {
                    highlight_opened_files = "all", -- options: "none", "icon", "name", "all"
                },
            }

            vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>tf", ":NvimTreeFindFile<CR>", { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>ts2", ":NvimTreeResize 20<CR>", { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>ts3", ":NvimTreeResize 30<CR>", { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>ts4", ":NvimTreeResize 40<CR>", { noremap = true, silent = true })
            vim.keymap.set("n", "<leader>ts5", ":NvimTreeResize 50<CR>", { noremap = true, silent = true })


        end,
    },
    {
        "kevinhwang91/nvim-hlslens",
        config = function()
            local kopts = {noremap = true, silent = true}
            vim.api.nvim_set_keymap('n', 'n',
                [[<Cmd>execute('normal! ' . v:count1 . 'n')<CR><Cmd>lua require('hlslens').start()<CR>]],
                kopts)
            vim.api.nvim_set_keymap('n', 'N',
                [[<Cmd>execute('normal! ' . v:count1 . 'N')<CR><Cmd>lua require('hlslens').start()<CR>]],
                kopts)
            vim.api.nvim_set_keymap('n', '*', [[*<Cmd>lua require('hlslens').start()<CR>]], kopts)
            vim.api.nvim_set_keymap('n', '#', [[#<Cmd>lua require('hlslens').start()<CR>]], kopts)
            vim.api.nvim_set_keymap('n', 'g*', [[g*<Cmd>lua require('hlslens').start()<CR>]], kopts)
            vim.api.nvim_set_keymap('n', 'g#', [[g#<Cmd>lua require('hlslens').start()<CR>]], kopts)
            vim.api.nvim_set_keymap('n', '<Leader>l', '<Cmd>noh<CR>', kopts)
        end,
    },
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

