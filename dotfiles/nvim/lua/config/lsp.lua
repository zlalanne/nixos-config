-- Snippets
require("luasnip.loaders.from_vscode").lazy_load()
require("luasnip").setup({
  history = true,
  delete_check_events = "TextChanged",
})

-- UI for LSP notifications
require("fidget").setup({})

-- Completion setup
vim.opt.completeopt = "menu,menuone,noselect"

local cmp = require("cmp")
cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-n>"] = cmp.mapping.select_next_item(),
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<C-e>"] = cmp.mapping.abort(),
    ["<C-Space>"] = cmp.mapping.complete(),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "path" },
  }),
  experimental = {
    ghost_text = true,
  },
})

local on_attach = function(client, buffer)
  local bufopts = { noremap = true, silent = true, buffer = buffer }

  vim.keymap.set("n", "<leader>cl", "<cmd>LspInfo<cr>", bufopts)

  vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", bufopts)
  vim.keymap.set("n", "gr", "<cmd>Telescope lsp_references<cr>", bufopts)
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
  vim.keymap.set("n", "gI", "<cmd>Telescope lsp_implementations<cr>", bufopts)
  vim.keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<cr>", bufopts)

  local format = function()
    vim.lsp.buf.format({ bufnr = buffer })
  end

  if client.supports_method("textDocument/formatting") then
    vim.keymap.set("n", "<leader>c=", format, bufopts)
  end
end

-- Language server setup
local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("lspconfig")["lua_ls"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      diagnostics = {
        globals = { "vim", "it", "describe", "before_each", "after_each" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = {
        enable = false,
      },
      completion = {
        callSnippet = "Replace",
      },
    },
  },
})

require("lspconfig")["nil_ls"].setup({
  on_attach = on_attach,
  settings = {
    ["nil"] = {
      formatting = {
        command = { "nixpkgs-fmt" },
      },
    },
  },
  capabilities = capabilities,
})

require("lspconfig")["yamlls"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

require("lspconfig")["marksman"].setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

local null_ls = require("null-ls")
null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua,
  },
})
