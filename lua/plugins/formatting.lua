vim.pack.add({ { src = vim.g.gh("stevearc/conform.nvim") } })

require("conform").setup({
	notify_on_error = false,
	format_on_save = function(bufnr)
		local enabled_filetypes = {
			lua = true,
			python = true,
			javascript = true,
			typescript = true,
			svelte = true,
			rust = true,
		}
		if enabled_filetypes[vim.bo[bufnr].filetype] then
			return { timeout_ms = 500 }
		else
			return nil
		end
	end,

	default_format_opts = {
		lsp_format = "fallback",
	},
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black" },
		rust = { "rustfmt" },

		javascript = { "eslint_d" },
		typescript = { "eslint_d" },
		javascriptreact = { "eslint_d" },

		svelte = { "prettierd", "prettier", stop_after_first = true },
	},
})

vim.keymap.set({ "n", "v" }, "<leader>f", function()
	require("conform").format({ async = true })
	print("Formatting current buffer...")
end, { desc = "Format current buffer" })
vim.keymap.set("n", "<leader>F", function()
	local buffers = vim.api.nvim_list_bufs()
	for _, buf in ipairs(buffers) do
		if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].buflisted then
			require("conform").format({
				bufnr = buf,
				async = true,
				lsp_format = "fallback",
			})
		end
	end
	print("Formatting all open buffers...")
end, { desc = "Format all open buffers" })
