return {
    {
        'neovim/nvim-lspconfig',
        config = function()
            -- Diagnostic signs
            vim.diagnostic.config({
                signs = {
                    text = {
                        [vim.diagnostic.severity.ERROR] = " ",
                        [vim.diagnostic.severity.WARN] = " ",
                        [vim.diagnostic.severity.INFO] = "󰋼 ",
                        [vim.diagnostic.severity.HINT] = "󰌵 ",
                    },
                    numhl = {
                        [vim.diagnostic.severity.ERROR] = "",
                        [vim.diagnostic.severity.WARN] = "",
                        [vim.diagnostic.severity.HINT] = "",
                        [vim.diagnostic.severity.INFO] = "",
                    },
                },
            })

            vim.api.nvim_set_keymap('n', '<leader>`', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap=true, silent=true })
            vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap=true, silent=true })
            vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap=true, silent=true })
            vim.api.nvim_set_keymap('n', '<leader>~', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap=true, silent=true })

            vim.keymap.set("v", "<leader>f", function()
                vim.lsp.buf.range_formatting({}, vim.api.nvim_buf_get_mark(0, "<"), vim.api.nvim_buf_get_mark(0, ">"))
            end, { desc = "Format selected lines with LSP" })
            

            require('lspconfig').pyright.setup {
                settings = {
                    python = {
                        analysis = {
                            typeCheckingMode = "basic",  -- "off", "basic", "strict"
                            autoSearchPaths = true,
                            useLibraryCodeForTypes = true,
                            diagnosticMode = "openFilesOnly", -- or "openFilesOnly"
                        }
                    }
                }
            }


            require('lspconfig').intelephense.setup {
                settings = {
                    intelephense = {
                        stubs = {
                            "apache", "bcmath", "bz2", "calendar", "com_dotnet", "Core", "ctype",
                            "curl", "date", "dba", "dom", "enchant", "exif", "FFI", "fileinfo", "filter",
                            "fpm", "ftp", "gd", "gettext", "gmp", "hash", "iconv", "imap", "intl", "json",
                            "ldap", "libxml", "mbstring", "meta", "mysqli", "oci8", "odbc", "openssl",
                            "pcntl", "pcre", "PDO", "pdo_ibm", "pdo_mysql", "pdo_pgsql", "pdo_sqlite",
                            "pgsql", "Phar", "posix", "pspell", "readline", "Reflection", "session",
                            "shmop", "SimpleXML", "snmp", "soap", "sockets", "sodium", "SPL", "sqlite3",
                            "standard", "superglobals", "sysvmsg", "sysvsem", "sysvshm", "tidy",
                            "tokenizer", "xml", "xmlreader", "xmlrpc", "xmlwriter", "xsl", "Zend OPcache",
                            "zip", "zlib"
                        },
                    }
                }
            }


        end,
    },
}
