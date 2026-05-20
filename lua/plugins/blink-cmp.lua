vim.pack.add({
	{ src = vim.g.gh("saghen/blink.cmp"), version = "v1.10.2" },
})

require("blink.cmp").setup({
	keymap = { preset = "super-tab" },
	appearance = {
		nerd_font_variant = "mono",
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	completion = {
		documentation = { auto_show = true, auto_show_delay_ms = 200 },
	},
})
