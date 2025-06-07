return {
	{ 
		"catppuccin/nvim", 
		name = "catppuccin", 
		priority = 1000 ,
		lazy = false,
	},
	{
		"folke/tokyonight.nvim",
	  	lazy = false,
	  	priority = 1000,
	  	opts = {},
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
		---@module "ibl"
		---@type ibl.config
		opts = {},
	},
	{ 
		"nvim-tree/nvim-web-devicons", 
		opts = {},
	},
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 
			'nvim-tree/nvim-web-devicons',
		},
		init = function()
			require('lualine').setup()
		end,
	},
	{
		"nvim-lua/plenary.nvim",
	},
	{ 
		'nvim-telescope/telescope-fzf-native.nvim', 
		build = 'make',
	},
	{
		'nvim-telescope/telescope.nvim', 
		tag = '0.1.8',
		config = function()
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
			vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
			vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
			vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter", 
		branch = 'master', 
		lazy = false, 
		build = ":TSUpdate",
		config = function()
			require'nvim-treesitter.configs'.setup {
				-- A list of parser names, or "all" (the listed parsers MUST always be installed)
				ensure_installed = { "python", "html", "javascript", "css", "php" },
				-- Install parsers synchronously (only applied to `ensure_installed`)
				sync_install = false,
				-- Automatically install missing parsers when entering buffer
				-- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
				auto_install = false,

				highlight = {
					enable = true,
					-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
					-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
					-- Using this option may slow down your editor, and you may see some duplicate highlights.
					-- Instead of true it can also be a list of languages
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = true,
				}
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
				map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
				map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)
				-- Re-order to previous/next
				map('n', '<A-;>', '<Cmd>BufferMovePrevious<CR>', opts)
				map('n', "<A-'>", '<Cmd>BufferMoveNext<CR>', opts)
				-- Goto buffer in position...
				map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
				map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
				map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
				map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
				map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
				map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
				map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
				map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
				map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
				map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)
				-- Pin/unpin buffer
				map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)
				-- Close buffer
				map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)

			end,
			opts = {
			  -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
			  -- animation = true,
			  -- insert_at_start = true,
			  -- …etc.
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
			require("nvim-tree").setup {
			  sort = {
				sorter = "case_sensitive",
			  },
			  view = {
				width = 60,
			  },
			  renderer = {
				group_empty = true,
			  },
			  filters = {
				dotfiles = true,
			  },
			}

			vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { noremap = true, silent = true })
			-- Go to the tree on the left
			-- vim.keymap.set("n", "<leader>tt", "<C-w>h", { noremap = true, silent = true })
			-- Go to editor (assuming tree is on the left, and editor is on the right)
			-- vim.keymap.set("n", "<leader>te", "<C-w>l", { noremap = true, silent = true })
			-- Find current editing file in tree sidebar
			vim.keymap.set("n", "<leader>tf", ":NvimTreeFindFile<CR>", { noremap = true, silent = true })
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

