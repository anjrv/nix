local servers = {
	"rust_analyzer",
	"clangd",
	"cmake",
	-- "r_language_server",
	"pyright",
	"tsserver",
	"yamlls",
	"lua_ls",
	"nil_ls",
}

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
	return
end

local opts = {}

for _, server in pairs(servers) do
	opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}

	if server == "sumneko_lua" then
		local sumneko_opts = require("user.lsp.settings.sumneko_lua")
		opts = vim.tbl_deep_extend("force", sumneko_opts, opts)
	end

	if server == "pyright" then
		local pyright_opts = require("user.lsp.settings.pyright")
		opts = vim.tbl_deep_extend("force", pyright_opts, opts)
	end

	if server == "rust_analyzer" then
		local rust_opts = require("user.lsp.settings.rust")
		require("rust-tools").setup(rust_opts)
		goto continue
	end

	if server == "nil_ls" then
		local nil_opts = require("user.lsp.settings.nil")
		opts = vim.tbl_deep_extend("force", nil_opts, opts)
	end

	if server == "jdtls" then --jdtls is handled by ftplugin call
		goto continue
	end

	lspconfig[server].setup(opts)
	::continue::
end
