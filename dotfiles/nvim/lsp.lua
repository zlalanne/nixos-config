
-- Completion setup
vim.opt.completeopt="menu,menuone,noselect"

local cmp = require("cmp")
cmp.setup({
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  })
})

-- Language server setup
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("lspconfig")["sumneko_lua"].setup {
  settings = {
    Lua = {
      runtime = {
        -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
        version = "LuaJIT",
      },

      diagnostics = {
        -- Get the language server to recognize the `vim` global
        globals = {"vim"},
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = {
        enable = false,
      },
    },
  },
  capabilities = capabilities,
}

require("lspconfig")["nil_ls"].setup {}
