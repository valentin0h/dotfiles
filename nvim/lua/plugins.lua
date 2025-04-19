return {
  "nvim-lua/plenary.nvim",
  --NOTE: First, some plugins that don't require any configuration

  -- Git related plugins
  "tpope/vim-fugitive",
  {
    "tpope/vim-rhubarb",
    config = function()
      -- [[ Configure GitHub links ]]
      -- for repository page
      -- for current file page
      vim.api.nvim_set_keymap(
        "n",
        "<leader>of",
        ":GBrowse <CR>",
        { silent = true, noremap = true, desc = "[O]pen GitHub [F]ile page" }
      )
      vim.api.nvim_set_keymap(
        "v",
        "<leader>of",
        ":GBrowse <CR>",
        { silent = true, noremap = true, desc = "[O]pen GitHub [F]ile Lines" }
      )
    end,
  },

  -- Detect tabstop and shiftwidth automatically
  "tpope/vim-sleuth",

  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
  },
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
  },

  -- Useful plugin to show you pending keybinds.
  { "folke/which-key.nvim", opts = {} },
  {
    -- Set lualine as statusline
    "nvim-lualine/lualine.nvim",
    opts = {
      tabline = {
        lualine_a = { "buffers" },
        lualine_z = { "tabs" },
      },
      sections = {
        lualine_c = {
          {
            "filename",
            path = 1,
          },
        },
      },
    },
  },
  {
    -- Add indentation guides even on blank lines
    "lukas-reineke/indent-blankline.nvim",
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = "ibl",
    opts = {},
  },

  -- "gc" to comment visual regions/lines
  { "numToStr/Comment.nvim", opts = {} },
  { "akinsho/git-conflict.nvim", version = "*", config = true },
  "dmmulroy/tsc.nvim",
  "f-person/git-blame.nvim",
  "github/copilot.vim",
}
