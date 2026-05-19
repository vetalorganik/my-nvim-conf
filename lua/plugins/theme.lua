vim.pack.add({ { src = vim.g.gh("folke/tokyonight.nvim") } })

require("tokyonight").setup({
	styles = {
		comments = { italic = false },
	},
	on_colors = function() end,
	on_highlights = function() end,
})

vim.cmd.colorscheme("tokyonight-night")
