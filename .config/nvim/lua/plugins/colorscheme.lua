return {
  -- 1. Setup the plugin
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1, -- Load this first!
    opts = {
      flavour = "storm", -- latte, frappe, macchiato, mocha
      transparent_background = true,
      term_colors = false,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = true,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
        -- Specific integrations for your setup
        native_lsp = {
          --enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
      },
    },
  },

  -- 2. Tell LazyVim to use it
  {
    "LazyVim/LazyVim",
    opts = {
      --colorscheme = "catppuccin",
      colorscheme = "tokyonight",
    },
  },
}


