vim.pack.add({
	{ src = vim.g.gh("nvim-neo-tree/neo-tree.nvim"), version = vim.version.range("*") },
	{ src = vim.g.gh("nvim-tree/nvim-web-devicons") },
	{ src = vim.g.gh("nvim-lua/plenary.nvim") },
	{ src = vim.g.gh("MunifTanjim/nui.nvim") },
})

require("neo-tree").setup({
	close_if_last_window = true,
	event_handlers = {
		{
			event = "file_opened",
			handler = function()
				require("neo-tree.command").execute({ action = "close" })
			end,
		},
	},
	window = {
		width = 30,
	},
	default_component_configs = {
		git_status = {
			symbols = {
				added = "✚",
				modified = "",
				deleted = "✖",
				untracked = "",
				ignored = "",
			},
		},
	},
	filesystem = {
		bind_to_cwd = true,
		hijack_netrw_behavior = "open_default",
		follow_current_file = {
			enabled = true, -- Automatically focuses the current file in the sidebar
			leave_dirs_open = false, -- Closes other directories to keep the tree clean
		},
	},
})

vim.keymap.set("n", "<leader>e", "<Cmd>Neotree toggle reveal<CR>", { desc = "NeoTree toggle reveal", silent = true })
