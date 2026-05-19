-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})

-- Auto save files after editing
do
	local autosave_group = vim.api.nvim_create_augroup("Autosave", { clear = true })

	vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
		group = autosave_group,
		pattern = "*", -- Apply to all files
		callback = function(args)
			local bufnr = args.buf

			-- Safeguards: Only save if the file is actually modifiable,
			-- has a name, and isn't a special buffer type (like neo-tree, terminal, help)
			if vim.bo[bufnr].modifiable and vim.api.nvim_buf_get_name(bufnr) ~= "" and vim.bo[bufnr].buftype == "" then
				-- Silently write the file to disk without printing "file written" messages
				vim.schedule(function()
					vim.cmd("silent! update")
				end)
			end
		end,
	})
end
