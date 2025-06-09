return {
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
}
