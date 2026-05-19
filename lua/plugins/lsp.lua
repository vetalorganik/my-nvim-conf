vim.pack.add({
	{ src = vim.g.gh("neovim/nvim-lspconfig") },
	{ src = vim.g.gh("mason-org/mason.nvim") },
	{ src = vim.g.gh("mason-org/mason-lspconfig.nvim") },
	{ src = vim.g.gh("j-hui/fidget.nvim") },
})

require("fidget").setup({})
require("mason").setup({})

-- This function gets run when an LSP attaches to a particular buffer.
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc, mode)
			mode = mode or "n"
			vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
		end

		map("grn", vim.lsp.buf.rename, "Rename")
		map("gra", vim.lsp.buf.code_action, "Goto code action", { "n", "x" })
		map("grD", vim.lsp.buf.declaration, "Goto declaration")

		local client = vim.lsp.get_client_by_id(event.data.client_id)

		if client and client:supports_method("textDocument/documentHighlight", event.buf) then
			local highlight_augroup = vim.api.nvim_create_augroup("kickstart-lsp-highlight", { clear = false })
			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.document_highlight,
			})

			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				buffer = event.buf,
				group = highlight_augroup,
				callback = vim.lsp.buf.clear_references,
			})

			vim.api.nvim_create_autocmd("LspDetach", {
				group = vim.api.nvim_create_augroup("kickstart-lsp-detach", { clear = true }),
				callback = function(event2)
					vim.lsp.buf.clear_references()
					vim.api.nvim_clear_autocmds({ group = "kickstart-lsp-highlight", buffer = event2.buf })
				end,
			})
		end

		if client and client:supports_method("textDocument/inlayHint", event.buf) then
			map("<leader>th", function()
				vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
			end, "Toggle inlay hints")
		end
	end,
})

-- Core server dictionary: Keeps custom configs intact
local servers = {
	lua_ls = {
		on_init = function(client)
			client.server_capabilities.documentFormattingProvider = false
		end,
		settings = {
			Lua = {
				format = { enable = false },
				runtime = { version = "LuaJIT", path = { "lua/?.lua", "lua/?/init.lua" } },
				workspace = {
					checkThirdParty = false,
					library = {
						vim.env.VIMRUNTIME,
						"${3rd}/luv/library",
						"${3rd}/busted/library",
					},
				},
			},
		},
	},
}

-- DYNAMIC AUTO-DETECTION SCRIPT
-- Scans whatever you have installed inside Mason locally and merges it seamlessly
local success_reg, mason_registry = pcall(require, "mason-registry")
local success_map, mappings_mod = pcall(require, "mason-lspconfig.mappings")

if success_reg and success_map then
	local package_to_lspconfig = mappings_mod.get_mason_map().package_to_lspconfig
	local installed_packages = mason_registry.get_installed_package_names()
	for _, pkg_name in ipairs(installed_packages) do
		local lsp_name = package_to_lspconfig[pkg_name]
		if lsp_name and not servers[lsp_name] then
			servers[lsp_name] = {}
		end
	end
end

-- Enable and initialize all detected + explicitly declared servers
for name, server in pairs(servers) do
	vim.lsp.config(name, server)
	vim.lsp.enable(name)
end
