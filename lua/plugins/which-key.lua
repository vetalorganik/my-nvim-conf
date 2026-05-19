vim.pack.add({ { src = vim.g.gh("folke/which-key.nvim") } })

require("which-key").setup({
	delay = 400,
	icons = { mappings = false },
	spec = {
		{ "<leader>b", group = "Buffers", mode = { "n" } },
		{ "<leader>d", group = "Diagnostics", mode = { "n" } },
		{ "<leader>s", group = "Search", mode = { "n", "v" } },
		{ "<leader>t", group = "Toggle" },
		{ "<leader>h", group = "Git Hunk", mode = { "n", "v" } },
		{ "gr", group = "LSP Actions", mode = { "n" } },
	},
})
