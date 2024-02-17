-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false
vim.opt.clipboard = unnamedplus
vim.opt.relativenumber = true
vim.opt.wrap = true

lvim.plugins = {
	{
		"ggandor/leap.nvim",
		name = "leap",
		config = function()
			require("leap").add_default_mappings()
		end,
	},
	{
		"lervag/vimtex",
		config = function()
			vim.g.vimtex_view_method = 'zathura'
			vim.g.vimtex_compiler_latexmk_engines = {
				_ = '-xelatex'
			}
			vim.g.vimtex_quickfix_enabled = 1
			vim.g.vimtex_syntax_enabled = 1
			vim.g.vimtex_quickfix_mode = 0
		end,
	},
	{ 'edluffy/hologram.nvim' },
	{
		"toppair/peek.nvim",
		event = { "VeryLazy" },
		build = "deno task --quiet build:fast",
		config = function()
			require("peek").setup()
			-- refer to `configuration to change defaults`
			vim.api.nvim_create_user_command("PeekOpen", require("peek").open, {})
			vim.api.nvim_create_user_command("PeekClose", require("peek").close, {})
		end,
	},
	{
		'chomosuke/typst-preview.nvim',
		lazy = false, -- or ft = 'typst'
		version = '0.1.*',
		build = function() require 'typst-preview'.update() end,
	}
}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
	{ command = "latexindent", filetypes = { "tex" } },
}

local dap = require('dap')
dap.adapters.lldb = {
	id = 'cppdbg',
	type = 'executable',
	command = '/usr/bin/lldb-vscode',
}

local dap = require('dap')
dap.configurations.cpp = {
	{
		name = 'Launch',
		type = 'lldb',
		request = 'launch',
		program = function()
			return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
		end,
		cwd = '${workspaceFolder}',
		stopOnEntry = false,
		args = {},

		-- 💀
		-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
		--
		--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
		--
		-- Otherwise you might get the following error:
		--
		--    Error on launch: Failed to attach to the target process
		--
		-- But you should be aware of the implications:
		-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
		-- runInTerminal = false,
	},
}

-- If you want to use this for Rust and C, add something like this:

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp
