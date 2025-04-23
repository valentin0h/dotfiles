return {
  {
    -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
    config = function()
      -- [[ Configure Treesitter ]]
      -- See `:help nvim-treesitter`
      -- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
      require("nvim-treesitter.configs").setup({
        -- Add languages to be installed here that you want installed for treesitter
        ensure_installed = {
          "c",
          "lua",
          "tsx",
          "javascript",
          "typescript",
          "vimdoc",
          "vim",
          "bash",
          "yaml",
        },

        -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
        auto_install = true,

        highlight = { enable = true },
        indent = { enable = true },
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["aa"] = "@parameter.outer",
              ["ia"] = "@parameter.inner",
              ["af"] = "@function.outer",
              ["if"] = "@function.inner",
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]m"] = "@function.outer",
            },
            goto_next_end = {
              ["]M"] = "@function.outer",
            },
            goto_previous_start = {
              ["[m"] = "@function.outer",
            },
            goto_previous_end = {
              ["[M"] = "@function.outer",
            },
          },
        },
      })
    end,
  },
}
