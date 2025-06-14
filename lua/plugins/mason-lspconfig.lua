return {
    {
        "mason-org/mason-lspconfig.nvim",
        opts = {},
        dependencies = {
            { "mason-org/mason.nvim", opts = {} },
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("mason-lspconfig").setup{
                ensure_installed = {
                    "pyright",       -- Python
                    "intelephense",  -- PHP
                    "ts_ls",      -- JS/TS
                    "html",          -- HTML
                    "cssls",         -- CSS
                    "vuels",         -- Vue
                    "emmet_ls",      -- Emmet (untuk HTML, CSS, React)
                },
                automatic_installation = true, -- optional
            }
        end
    }
}
