local config = require("metals").bare_config()
if not config then
	return
end

config.settings = {
	showImplicitArguments = true,
	-- excludedPackages = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
}

config.capabilities = require("user.lsp.handlers").capabilities
config.on_attach = require("user.lsp.handlers").on_attach

require("metals").initialize_or_attach(config)
