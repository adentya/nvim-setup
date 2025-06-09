return {
    {
        "linux-cultist/venv-selector.nvim",
        lazy = true,
        dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
        cmd = { "VenvSelect", "VenvSelectCached" },  -- lazy-load on command
        opts = {
            -- Set to your workspace/project folder or virtualenv root
            search_venv_managers = true,  -- optional: auto-detect pipenv, poetry, etc.
            name = ".venv",               -- or "venv", etc.
            -- change this to customize behavior on activation
            on_venv_activated = function(venv_path)
                vim.notify("Activated venv: " .. venv_path, vim.log.levels.INFO)
                vim.cmd("LspRestart")  -- optional: reload LSP when venv changes
            end,
        },
        keys = {
            { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select VirtualEnv" },
            { "<leader>vc", "<cmd>VenvSelectCached<cr>", desc = "Select Cached VirtualEnv" },
        },
        init = function()
            -- Auto-select venv on startup
            vim.api.nvim_create_autocmd("VimEnter", {
                callback = function()
                    require("venv-selector").retrieve_from_cache()
                end
            })

            vim.keymap.set("n", "<leader>vs", "<cmd>VenvSelect<CR>", {
                desc = "Select Python Virtual Environment"
            })

        end

    }
}
