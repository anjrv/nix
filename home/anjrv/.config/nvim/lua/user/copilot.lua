local status_ok, copilot = pcall(require, "copilot")
if not status_ok then
	return
end

copilot.setup({
	cmp = {
		enabled = true,
		method = "getCompletionsCycling",
	},
	panel = { -- no config options yet
		enabled = false,
	},
	suggestion = { enabled = false },
	ft_disable = { "markdown" },
	-- server_opts_overrides = {
	-- 	settings = {
	-- 		advanced = {
	-- 			inlineSuggestCount = 3,
	-- 		},
	-- 	},
	-- },
})
