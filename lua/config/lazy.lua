-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)

vim.o.shell = "/bin/zsh"

-- optionally enable 24-bit colour
vim.opt.termguicolors = true

-- Default mapleader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Custom config
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.wrap = true
vim.opt.autoindent = true
vim.opt.mouse = "a"
vim.opt.scrolloff = 3
vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.list = true
vim.opt.listchars = {
    tab = "» ",
    trail = "·",
    extends = "›",
    precedes = "‹",
    nbsp = "␣",
}
vim.opt.colorcolumn = "100,120"
vim.opt.clipboard = "unnamedplus"


-- Config specific for Neovide app
vim.g.neovide_position_animation_length = 0.00
vim.g.neovide_cursor_animation_length = 0.02
vim.g.neovide_cursor_trail_size = 0
vim.g.neovide_cursor_animate_in_insert_mode = true
vim.g.neovide_cursor_animate_command_line = true
vim.g.neovide_scroll_animation_far_lines = 1
vim.g.neovide_scroll_animation_length = 0.15


-- Custom keymap
local opts = { noremap = true, silent = true }

-- Untuk copy content ke system clipboard
vim.keymap.set("v", "<leader>y", '"+y', opts)
vim.keymap.set("n", "<leader>p", '"+p', opts)
-- Hilangkan background highlight ketika selesai search
vim.keymap.set("n", "<Esc>", ':nohlsearch<CR>', opts)
-- Defaut file exploler bawaan vim
vim.keymap.set("n", "<leader>E", vim.cmd.Ex, opt)
-- Perpindahan antar window
vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
vim.keymap.set("n", "<C-l>", "<C-w>l", opts)
vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
-- Split window
vim.keymap.set("n", "<leader>-", ":split<CR><C-w>j", opts)
vim.keymap.set("n", "<leader>|", ":vsplit<CR><C-w>l", opts)
vim.keymap.set("n", "\\q", ":q<CR>", opts)
vim.keymap.set("n", "\\w", ":w<CR>", opts)
vim.keymap.set("n", "\\x", ":qa!<CR>", opts)


-- Fix default file exploler di nvim yg tidak otomatis tampil number & relativenumber.
vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		vim.wo.number = true
		vim.wo.relativenumber = true
	end,
})


-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- import your plugins
        { import = "plugins" },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    install = { 
        colorscheme = { 
            "tokyonight"
        } 
    }, 
    -- automatically check for plugin updates
    checker = { enabled = true },
})



-- Theme
vim.cmd.colorscheme("tokyonight")



