-- Local function to determine formatter preference (prettier first, then biome)
local function get_js_formatter()
  if vim.fn.filereadable(".prettierrc.json") == 1 or vim.fn.filereadable("prettier.config.js") == 1 then
    return { "prettierd" }
  elseif vim.fn.filereadable("biome.json") == 1 then
    return { "biome" }
  end
  return { "biome" } -- default fallback
end

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
      json = get_js_formatter,
      typescript = get_js_formatter,
      typescriptreact = get_js_formatter,
      javascript = get_js_formatter,
      javascriptreact = get_js_formatter,
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
