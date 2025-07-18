return {
  -- Command and arguments to start the server.
  cmd = { "typescript-language-server", "--stdio" },
  -- Filetypes to automatically attach to.
  filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  root_markers = { "package.json" },

  -- On attach function to set up organize imports keymap
  on_attach = function(client, bufnr)
    -- Organize imports keymap
    vim.keymap.set("n", "<leader>co", function()
      vim.lsp.buf.code_action({
        context = { only = { "source.organizeImports" } },
        apply = true,
      })
    end, { buffer = bufnr, desc = "Organize imports" })
  end,
}
