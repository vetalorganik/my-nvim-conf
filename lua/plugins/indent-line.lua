vim.pack.add({ { src = vim.g.gh("lukas-reineke/indent-blankline.nvim") } })

require("ibl").setup({
	-- Change the indentation character (e.g., "│", "┃", "┆", "┊")
	indent = {
		char = "┊",
	},

	-- Configuration for the scope (the current block of code your cursor is inside)
	scope = {
		enabled = true, -- Underlines/highlights the active code block lines
		show_start = false, -- Don't put an underline under the starting statement
		show_end = false, -- Don't put an underline under the ending statement
	},

	-- Exclude specific files and windows where indentation lines don't make sense
	exclude = {
		filetypes = {
			"help",
			"alpha",
			"dashboard",
			"neo-tree",
			"lazy",
			"mason",
			"notify",
			"toggleterm",
		},
		buftypes = {
			"terminal",
			"nofile",
		},
	},
})
