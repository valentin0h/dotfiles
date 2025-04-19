return {
  {
    "williamboman/mason.nvim",
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)
      -- local lspconfig = require("lspconfig")

      -- Ensure the servers above are installed

      -- Enable the following language servers
      --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
      --
      --  Add any additional override configuration in the following tables. They will be passed to
      --  the `settings` field of the server config. You must look up that documentation yourself.
      --
      --  If you want to override the default filetypes that your language server will attach to you can
      --  define the property 'filetypes' to the map in question.
      local servers = {
        -- ts_ls = {
        --   on_attach = function(client, bufnr)
        --     -- this is important, otherwise tsserver will format ts/js
        --     -- files which we *really* don't want.
        --     client.server_capabilities.documentFormattingProvider = false
        --     local nmap = function(keys, func, desc)
        --       if desc then
        --         desc = "LSP: " .. desc
        --       end
        --
        --       vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        --     end
        --
        --     -- nmap("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
        --     -- nmap("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
        --     -- nmap("gI", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
        --     -- nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")
        --     -- nmap("<leader>ds", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
        --     -- nmap("<leader>ws", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
        --     --
        --     -- -- See `:help K` for why this keymap
        --     -- nmap("K", vim.lsp.buf.hover, "Hover Documentation")
        --   end,
        -- },
        -- lua_ls = {
        --   Lua = {
        --     workspace = { checkThirdParty = false },
        --     telemetry = { enable = false },
        --     -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
        --     -- diagnostics = { disable = { 'missing-fields' } },
        --   },
        -- },
        -- biome = {
        --   single_file_support = true,
        -- },
      }

      -- [[ Configure LSP ]]
      --  This function gets run when an LSP connects to a particular buffer.
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = { "ts_ls", "lua_ls" },
      })
      require("mason-lspconfig").setup_handlers({
        function(server_name)
          local opts = {
            capabilities = vim.lsp.protocol.make_client_capabilities(),
            on_attach = servers[server_name] and servers[server_name].on_attach, -- Assign on_attach here
          }

          -- Add `settings` only if they exist for the server
          if servers[server_name] and servers[server_name].settings then
            opts.settings = servers[server_name].settings
          end

          -- Setup the LSP server
          require("lspconfig")[server_name].setup(opts)
        end,
      })
    end,
  },
}
