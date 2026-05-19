vim.pack.add({ { src = vim.g.gh("lewis6991/gitsigns.nvim") } })

require("gitsigns").setup({
	signs = {
		add = { text = "+" }, ---@diagnostic disable-line: missing-fields
		change = { text = "~" }, ---@diagnostic disable-line: missing-fields
		delete = { text = "_" }, ---@diagnostic disable-line: missing-fields
		topdelete = { text = "‾" }, ---@diagnostic disable-line: missing-fields
		changedelete = { text = "~" }, ---@diagnostic disable-line: missing-fields
	},
	on_attach = function(bufnr)
		local gitsigns = require("gitsigns")

		local function map(mode, l, r, opts)
			opts = opts or {}
			opts.buffer = bufnr
			vim.keymap.set(mode, l, r, opts)
		end

		-- Navigation
		map("n", "]c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "]c", bang = true })
			else
				gitsigns.nav_hunk("next")
			end
		end, { desc = "Jump to next git change" })

		map("n", "[c", function()
			if vim.wo.diff then
				vim.cmd.normal({ "[c", bang = true })
			else
				gitsigns.nav_hunk("prev")
			end
		end, { desc = "Jump to previous git change" })

		-- Actions
		-- visual mode
		map("v", "<leader>hs", function()
			gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "Git stage hunk" })
		map("v", "<leader>hr", function()
			gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
		end, { desc = "Git reset hunk" })
		-- normal mode
		map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Git stage hunk" })
		map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Git reset hunk" })
		map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Git stage buffer" })
		map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Git reset buffer" })
		map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Git preview hunk" })
		map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Git preview hunk inline" })
		map("n", "<leader>hb", function()
			gitsigns.blame_line({ full = true })
		end, { desc = "Git blame line" })
		map("n", "<leader>hd", gitsigns.diffthis, { desc = "Git diff against index" })
		map("n", "<leader>hD", function()
			gitsigns.diffthis("@")
		end, { desc = "Git diff against last commit" })
		map("n", "<leader>hQ", function()
			gitsigns.setqflist("all")
		end, { desc = "Git hunk Quickfix list (all files in repo)" })
		map("n", "<leader>hq", gitsigns.setqflist, { desc = "Git hunk quickfix list (all changes in this file)" })
		map("n", "<leader>hx", "<cmd>diffoff! | wincmd p | close<CR>", { desc = "Git close diff" })

		-- Toggles
		map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle git show blame line" })
		map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Toggle git intra-line word diff" })

		-- Text object
		map({ "o", "x" }, "ih", gitsigns.select_hunk, {desc = "Git select hunk"})
	end,
})
