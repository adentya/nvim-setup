return {
    {
        enabled = false,
        "AckslD/swenv.nvim",
        lazy = false,
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

        end
    },
}
