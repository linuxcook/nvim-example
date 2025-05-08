return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'williamboman/mason.nvim',
    },
    opts = {
      servers = {},
    },
    config = function(_, opts)
      local lsp = require('lspconfig')

      -- Setup LSP server configurations (default settings)
      lsp.clangd.setup({}) -- C++ LSP
      lsp.basedpyright.setup({}) -- Python LSP

      vim.api.nvim_create_autocmd('LspAttach', {
        callback = function(args)
          local servers = opts.servers or {}
          local buffer = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          if not client then
            return
          end

          require('plugins.lsp.keymaps').on_attach(client, buffer)

          -- Uncomment for inlay hints (>= nvim 0.10)
          -- if client.supports_method('textDocument/inlayHint') then
          --   vim.lsp.inlay_hint.enable(true, { bufnr = buffer })
          -- end
        end,
      })
    end,
  },
}
