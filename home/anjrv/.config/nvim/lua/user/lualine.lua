M = {}
local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
	return
end

local function contains(t, value)
	for _, v in pairs(t) do
		if v == value then
			return true
		end
	end
	return false
end

local hide_in_width_60 = function()
	return vim.o.columns > 60
end

local hide_in_width = function()
	return vim.o.columns > 80
end

local diagnostics = {
	"diagnostics",
	sources = { "nvim_diagnostic" },
	sections = { "error", "warn" },
	symbols = { error = " ", warn = " " },
	colored = false,
	update_in_insert = false,
	always_visible = true,
}

local diff = {
	"diff",
	colored = false,
	symbols = { added = "", modified = "", removed = "" },
	cond = hide_in_width_60,
	separator = "",
}

local filetype = {
	"filetype",
	fmt = function(str)
		local ui_filetypes = {
			"help",
			"packer",
			"neogitstatus",
			"NvimTree",
			"Trouble",
			"lir",
			"Outline",
			"spectre_panel",
			"toggleterm",
			"DressingSelect",
			"",
		}

		if str == "toggleterm" then
			-- 
			local term = ""
			-- local term = "%#SLTermIcon#" .. ""
			return term
		end

		if contains(ui_filetypes, str) then
			return ""
		else
			return str
		end
	end,
	icons_enabled = true,
	separator = "|",
}

local branch = {
	"branch",
	icons_enabled = true,
	colored = true,
}

local language_server = {
	function()
		local buf_ft = vim.bo.filetype
		local ui_filetypes = {
			"help",
			"packer",
			"neogitstatus",
			"NvimTree",
			"Trouble",
			"lir",
			"Outline",
			"spectre_panel",
			"toggleterm",
			"DressingSelect",
			"",
		}

		if contains(ui_filetypes, buf_ft) then
			return M.language_servers
		end

		local clients = vim.lsp.buf_get_clients()
		local client_names = {}
		local copilot_active = false

		-- add client
		for _, client in pairs(clients) do
			if client.name ~= "copilot" and client.name ~= "null-ls" then
				table.insert(client_names, client.name)
			end
		end

		-- add formatter
		local s = require("null-ls.sources")
		local available_sources = s.get_available(buf_ft)
		local registered = {}
		for _, source in ipairs(available_sources) do
			for method in pairs(source.methods) do
				registered[method] = registered[method] or {}
				table.insert(registered[method], source.name)
			end
		end

		local formatter = registered["NULL_LS_FORMATTING"]
		local linter = registered["NULL_LS_DIAGNOSTICS"]
		if formatter ~= nil then
			vim.list_extend(client_names, formatter)
		end
		if linter ~= nil then
			vim.list_extend(client_names, linter)
		end

		-- join client names with commas
		local client_names_str = table.concat(client_names, ", ")

		-- check client_names_str if empty
		local language_servers = ""
		local client_names_str_len = #client_names_str
		if client_names_str_len ~= 0 then
			language_servers = " [" .. client_names_str .. "] " .. "%*"
		end

		if client_names_str_len == 0 then
			return ""
		else
			M.language_servers = language_servers
			return language_servers
		end
	end,
	padding = 0,
	cond = hide_in_width,
	separator = " " .. "%*",
}

lualine.setup({
	options = {
		globalstatus = true,
		icons_enabled = true,
		theme = "dracula-nvim",
		disabled_filetypes = { "alpha", "dashboard" },
		always_divide_middle = true,
	},
	sections = {
		lualine_a = { "mode", branch },
		lualine_b = { diagnostics },
		lualine_c = {},
		lualine_x = { diff, filetype, language_server },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = {},
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
	extensions = {},
})
