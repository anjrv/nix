local status_ok, ibl = pcall(require, "ibl")
if not status_ok then
	return
end

ibl.setup(
	{
		indent = { highlight = { "LineNr" }, char = "│" },
		exclude = {
			filetypes = {
				"help",
				"alpha",
				"dashboard",
				"*oil*",
				"neo-tree",
				"Trouble",
				"lazy",
				"mason",
				"notify",
				"toggleterm",
				"lazyterm",
				"asm",
			},
		},
	}
	-- {
	-- 	show_current_context = true,
	-- 	indent_blankline_char = "▏",
	-- 	indent_blankline_show_trailing_blankline_indent = false,
	-- 	indent_blankline_show_first_indent_level = true,
	-- 	indent_blankline_use_treesitter = true,
	-- 	indent_blankline_show_current_context = true,
	-- 	indent_blankline_buftype_exclude = { "terminal", "nofile" },
	-- 	indent_blankline_filetype_exclude = {
	-- 		"help",
	-- 		"packer",
	-- 		"NvimTree",
	-- 	},
	-- }
)
