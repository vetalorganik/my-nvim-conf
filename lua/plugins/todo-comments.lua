vim.pack.add({ { src = vim.g.gh("folke/todo-comments.nvim") } })

require("todo-comments").setup({ signs = false })
