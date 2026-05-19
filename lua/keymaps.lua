-- Disable arrow keys in normal mode
vim.keymap.set("n", "<left>", '<cmd>echo "Use h to move!!"<CR>')
vim.keymap.set("n", "<right>", '<cmd>echo "Use l to move!!"<CR>')
vim.keymap.set("n", "<up>", '<cmd>echo "Use k to move!!"<CR>')
vim.keymap.set("n", "<down>", '<cmd>echo "Use j to move!!"<CR>')

-- Remove highlight after the search
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

-- Diagnostic / Location lists
vim.keymap.set("n", "<leader>do", vim.diagnostic.setloclist, { desc = "Diagnostics open list" })
vim.keymap.set("n", "<leader>dc", "<cmd>lclose<CR>", { silent = true, desc = "Diagnostics close list" })
vim.keymap.set("n", "<leader>df", function()
	-- If the current window is the location list, jump back to the previous window
	if vim.bo.filetype == "qf" then
		vim.cmd("wincmd p")
	else
		-- Otherwise, try to find an open location list window and jump into it
		local qf_win = vim.fn.getloclist(0, { winid = 0 }).winid
		if qf_win > 0 then
			vim.api.nvim_set_current_win(qf_win)
		else
			print("Diagnostic window is not open!")
		end
	end
end, { desc = "Diagnostics Toggle focus" })

-- Exit terminal mode in the builtin terminal
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Navagete across opened splits
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the upper window" })

-- Save the current file quickly
vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file", silent = true })
vim.keymap.set("n", "<leader>W", "<cmd>wa<CR>", { desc = "Save all files" })
vim.keymap.set("n", "<leader>q", "<cmd>wq<CR>", { desc = "Save and quit file" })
vim.keymap.set("n", "<leader>Q", "<cmd>q!<CR>", { desc = "Quit without saving" })

-- Exit insert mode quickly by smashing 'jk'
vim.keymap.set("i", "jk", "<Esc>", { desc = "Exit insert mode", silent = true })

-- Move cursor in Insert mode using Alt + hjkl
vim.keymap.set("i", "<A-h>", "<Left>", { desc = "Move left in insert mode" })
vim.keymap.set("i", "<A-j>", "<Down>", { desc = "Move down in insert mode" })
vim.keymap.set("i", "<A-k>", "<Up>", { desc = "Move up in insert mode" })
vim.keymap.set("i", "<A-l>", "<Right>", { desc = "Move right in insert mode" })

-- Move selected lines Up/Down
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv")
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv")

-- Manually trigger LSP completion
vim.keymap.set("i", "<C-Space>", "<C-x><C-o>", { desc = "Trigger completion" })

-- Custom Paste Mappings
vim.keymap.set("i", "<A-p>", "<C-r>+", { desc = "Paste system clipboard in insert mode" })
vim.keymap.set({ "n", "v" }, "<A-p>", '"+p', { desc = "Paste system clipboard" })
