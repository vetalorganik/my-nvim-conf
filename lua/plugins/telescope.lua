---@type (string|vim.pack.Spec)[]
vim.pack.add({
	{ src = vim.g.gh("nvim-lua/plenary.nvim") },
	{ src = vim.g.gh("nvim-telescope/telescope.nvim") },
	{ src = vim.g.gh("nvim-telescope/telescope-ui-select.nvim") },
	{ src = vim.g.gh("nvim-telescope/telescope-fzf-native.nvim") },
})

require("telescope").setup({
	extensions = {
		["ui-select"] = { require("telescope.themes").get_dropdown() },
	},
})

pcall(require("telescope").load_extension, "fzf")
pcall(require("telescope").load_extension, "ui-select")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Search Help" })
vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Search Keymaps" })
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "Search Files" })
vim.keymap.set("n", "<leader>ss", builtin.builtin, { desc = "Search select Telescope" })
vim.keymap.set("n", "<leader>sg", builtin.live_grep, { desc = "Search by Grep" })
vim.keymap.set("n", "<leader>sd", builtin.diagnostics, { desc = "Search Diagnostics" })
vim.keymap.set("n", "<leader>sr", builtin.resume, { desc = "Search Resume" })
vim.keymap.set("n", "<leader>s.", builtin.oldfiles, { desc = 'Search Recent Files ("." for repeat)' })
vim.keymap.set("n", "<leader>sc", builtin.commands, { desc = "Search Commands" })
vim.keymap.set("n", "<leader>sb", builtin.buffers, { desc = "Search Buffers" })
vim.keymap.set({ "n", "v" }, "<leader>sw", builtin.grep_string, { desc = "Search Word" })

-- Add Telescope-based LSP pickers when an LSP attaches to a buffer.
-- If you later switch picker plugins, this is where to update these mappings.
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("telescope-lsp-attach", { clear = true }),
	callback = function(event)
		local buf = event.buf

		-- Find references for the word under your cursor.
		vim.keymap.set("n", "grr", builtin.lsp_references, { buffer = buf, desc = "Goto references" })

		-- Jump to the implementation of the word under your cursor.
		-- Useful when your language has ways of declaring types without an actual implementation.
		vim.keymap.set("n", "gri", builtin.lsp_implementations, { buffer = buf, desc = "Goto implementation" })

		-- Jump to the definition of the word under your cursor.
		-- This is where a variable was first declared, or where a function is defined, etc.
		-- To jump back, press <C-t>.
		vim.keymap.set("n", "grd", builtin.lsp_definitions, { buffer = buf, desc = "Goto definition" })

		-- Fuzzy find all the symbols in your current document.
		-- Symbols are things like variables, functions, types, etc.
		vim.keymap.set("n", "gO", builtin.lsp_document_symbols, { buffer = buf, desc = "Open Document Symbols" })

		-- Fuzzy find all the symbols in your current workspace.
		-- Similar to document symbols, except searches over your entire project.
		vim.keymap.set(
			"n",
			"gW",
			builtin.lsp_dynamic_workspace_symbols,
			{ buffer = buf, desc = "Open Workspace Symbols" }
		)

		-- Jump to the type of the word under your cursor.
		-- Useful when you're not sure what type a variable is and you want to see
		-- the definition of its *type*, not where it was *defined*.
		vim.keymap.set("n", "grt", builtin.lsp_type_definitions, { buffer = buf, desc = "Goto type Definition" })
	end,
})

-- Override default behavior and theme when searching
vim.keymap.set("n", "<leader>s/", function()
	-- You can pass additional configuration to Telescope to change the theme, layout, etc.
	builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
		winblend = 10,
		previewer = false,
	}))
end, { desc = "Fuzzily search in current buffer" })

-- It's also possible to pass additional configuration options.
--  See `:help telescope.builtin.live_grep()` for information about particular keys
vim.keymap.set("n", "<leader>s/", function()
	builtin.live_grep({
		grep_open_files = true,
		prompt_title = "Live Grep in Open Files",
	})
end, { desc = "Search in Open Files" })

-- Shortcut for searching your Neovim configuration files
vim.keymap.set("n", "<leader>sn", function()
	builtin.find_files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Search in Neovim config" })
