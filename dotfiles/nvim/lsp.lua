
-- Snippets
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip").setup({
  history = true,
  delete_check_events = "TextChanged",
})

-- Completion setup
vim.opt.completeopt="menu,menuone,noselect"

local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-j>"] = cmp.mapping.select_next_item(),
    ["<C-k>"] = cmp.mapping.select_prev_item(),
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true })
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  })
})

local on_attach = function(client, buffer)
  local bufopts = { noremap=true, silent=true, buffer=buffer}

  vim.keymap.set("n", "<leader>cl", "<cmd>LspInfo<cr>", bufopts)

  vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", bufopts)
  vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", bufopts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gI", "<cmd>Telescope lsp_implementations<cr>", bufopts)
  vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<cr>", bufopts)

  print("Running on attach")

  if client.server_capabilities["documentFormatting"] then
      print("Supports document formatting")
  end
  if client.server_capabilities.documentFormatting then
      print("Supports document formatting2")
  end
  if client.server_capabilities.document_formatting then
      print("Supports document formatting3")
  end
end

-- Language server setup
local capabilities = require('cmp_nvim_lsp').default_capabilities()

require("lspconfig")["sumneko_lua"].setup {
  on_attach = on_attach,
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
      completion = {
        callSnippet = 'Replace',
      },
    },
  },
  capabilities = capabilities,
}

require("lspconfig")["nil_ls"].setup {
  on_attach = on_attach,
}
