vim.pack.add({ { src = vim.g.gh("nvim-mini/mini.nvim") } })

local starter = require("mini.starter")
starter.setup({
	evaluate_single = true,
	header = table.concat({
		"███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
		"████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
		"██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
		"██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
		"██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
		"╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
	}, "\n"),
	items = {
		{
			{ name = "f Find File", action = "Telescope find_files", section = "Quick Actions" },
			{ name = "g Live Grep", action = "Telescope live_grep", section = "Quick Actions" },
			{ name = "n New File", action = "ene | startinsert", section = "Quick Actions" },
			{ name = "q Quit", action = "qall", section = "Quick Actions" },
		},
	},
	content_hooks = {
		starter.gen_hook.adding_bullet(""),
		starter.gen_hook.aligning("center", "center"),
	},
	footer = "",
})

vim.api.nvim_create_autocmd("User", {
	pattern = "MiniStarterOpened",
	callback = function(ev)
		vim.keymap.set("n", "j", function()
			starter.update_current_item("next")
		end, { buffer = ev.buf, nowait = true })
		vim.keymap.set("n", "k", function()
			starter.update_current_item("prev")
		end, { buffer = ev.buf, nowait = true })
	end,
})

require("mini.pairs").setup()

-- Add/delete/replace surroundings (brackets, quotes, etc.)
-- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
-- - sd'   - [S]urround [D]elete [']quotes
-- - sr)'  - [S]urround [R]eplace [)] [']
require("mini.surround").setup()

-- Better Around/Inside textobjects
--  - va)  - [V]isually select [A]round [)]paren
--  - yiiq - [Y]ank [I]nside [I]+1 [Q]uote
--  - ci'  - [C]hange [I]nside [']quote
require("mini.ai").setup({
	mappings = {
		around_next = "aa",
		inside_next = "ii",
	},
	n_lines = 500,
})

-- Mini statusline.
local statusline = require("mini.statusline")
statusline.setup({ use_icons = true })
---@diagnostic disable-next-line: duplicate-set-field
statusline.section_location = function()
	return "%2l:%-2v"
end

-- Mini tabline
local tabline = require("mini.tabline")
tabline.setup({ use_icons = true })

-- Keymaps for switching tabs
vim.keymap.set("n", "<leader>bn", ":bnext<CR>", { silent = true, desc = "Buffer next" })
vim.keymap.set("n", "<leader>bp", ":bprevious<CR>", { silent = true, desc = "Buffer previous" })
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { silent = true, desc = "Buffer delete current" })
vim.keymap.set("n", "<leader>ba", ":%bd|e#|bd#<CR>", { silent = true, desc = "Buffer delete all" })
