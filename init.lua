-- disable netrw at the very start of your init.lua
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1



vim.o.shell = "/bin/zsh"


-- optionally enable 24-bit colour
vim.opt.termguicolors = true


-- Default mapleader
vim.g.mapleader = "\\"
vim.g.maplocalleader = "\\"


-- Custom config
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.wrap = false
vim.opt.autoindent = true
vim.opt.mouse = "a"
vim.opt.scrolloff = 3
vim.opt.expandtab = true
vim.opt.softtabstop = 4


vim.api.nvim_create_autocmd("FileType", {
    pattern = {"python"},
    callback = function()
        require('swenv.api').auto_venv()
    end
})



-- Fix default file exploler di nvim yg tidak otomatis tampil number & relativenumber.
vim.api.nvim_create_autocmd("FileType", {
	pattern = "netrw",
	callback = function()
		vim.wo.number = true
		vim.wo.relativenumber = true
	end,
})


-- Custom keymap
-- vim.keymap.set("n", "<leader>w", ":w<CR>", { noremap = true, silent = true })
-- vim.keymap.set("n", "<leader>q", ":q!<CR>", { noremap = true, silent = true })
-- Untuk copy content ke system clipboard
vim.keymap.set("v", "<leader>y", '"+y', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>/", ':nohlsearch<CR>', { noremap = true, silent = true })
vim.keymap.set("n", "<leader>E", vim.cmd.Ex, { noremap = true, silent = true })
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>-", ":split<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>|", ":vsplit<CR>", { noremap = true, silent = true })



require("config.lazy")

