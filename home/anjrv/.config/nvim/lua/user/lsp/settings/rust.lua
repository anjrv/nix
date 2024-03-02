return {
  tools = {
    -- on_initialized = function()
    --   vim.api.nvim_create_autocmd({ "BufWritePost", "BufEnter", "CursorHold", "InsertLeave" }, {
    --     pattern = { "*.rs" },
    --     callback = function()
    --       vim.lsp.codelens.refresh()
    --     end,
    --   })
    -- end,
  },
  server = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,

    settings = {
      ["rust-analyzer"] = {
        lens = {
          enable = false,
        },
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
}
