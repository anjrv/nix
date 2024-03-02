# Current nvim setup

## Non obvious dependencies

Some tools that are useful but not explicitly required:

* `lldb`
* `shellcheck`
* `lua-language-server`
* `mupdf`

Otherwise consider running `:checkhealth` to check for other missing executables.

## Language servers

Ensure language servers that are in use in `lsp-installer.lua` are installed. Language servers can be installed using `:LspInstallInfo`

## DAP & Java

*All of the following is installed in the .config/nvim folder*

nvim-jdtls is extended with third party repositories

```
git clone git@github.com:microsoft/java-debug.github
cd java-debug
./mvnw clean install
```

Extension has telemetry enabled by default. If you opt out to send telemetry data to Microsoft, please set below configuration in settings.json: `telemetry.enableTelemetry = false`

```
git clone git@github.com:microsoft/vscode-java-test.git
cd vscode-java-test
npm install
npm run build-plugin
```

Other third party repositories used by DAP:

```
git clone https://github.com/firefox-devtools/vscode-firefox-debug.git
cd vscode-firefox-debug
npm install
npm run build
```

```
git clone https://github.com/microsoft/vscode-node-debug2.git
cd vscode-node-debug2
npm install
NODE_OPTIONS=--no-experimental-fetch npm run build
```

## `null-ls`

Tools used for additional diagnostics and formatting. The ones that are defined in the current setup are:

* `prettier`
* `black`
* `stylua`
* `google_java_format`
* `flake8`

These all need to be manually installed and on `PATH`. They can also be removed by editing `null-ls.lua` ( original formatting can be re-enabled in `handlers.lua` )
