vim.pack.add({
	{ src = vim.g.gh("folke/lazydev.nvim") },
})

require("lazydev").setup({
	library = {
		{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
	},
})
