return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  -- This will provide type hinting with LuaLS
  ---@module "conform"
  ---@type conform.setupOpts
  opts = {
    -- Define your formatters
    formatters_by_ft = {
      lua = { "stylua" },
      json = { "biome", stop_after_first = true },
      typescript = function()
        if vim.fn.filereadable(".prettierrc.json") == 1 or vim.fn.filereadable("prettier.config.js") == 1 then
          return { "prettierd" }
        elseif vim.fn.filereadable("biome.json") == 1 then
          return { "biome" }
        end
        return { "biome" } -- default fallback
      end,
      typescriptreact = function()
        if vim.fn.filereadable(".prettierrc.json") == 1 or vim.fn.filereadable("prettier.config.js") == 1 then
          return { "prettierd" }
        elseif vim.fn.filereadable("biome.json") == 1 then
          return { "biome" }
        end
        return { "biome" } -- default fallback
      end,
      javascript = { "biome", "prettierd", stop_after_first = true },
      javascriptreact = { "biome", "prettierd", stop_after_first = true },
      yaml = { "prettierd" },
      python = { "black" },
    },
    -- Set default options
    default_format_opts = {
      lsp_format = "fallback",
    },
    -- Set up format-on-save
    format_on_save = {
      timeout_ms = 500,
    },
    -- Customize formatters
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
    },
    log_level = vim.log.levels.DEBUG,
  },
  init = function()
    -- If you want the formatexpr, here is the place to set it
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}
