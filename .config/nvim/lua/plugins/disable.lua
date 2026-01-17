return {
  {
    "folke/snacks.nvim",
    opts = {
      indent = { enabled = false },
      scope = { enabled = false },
    },
  },
  -- Also disable the old one just in case you're on an older version
  { "lukas-reineke/indent-blankline.nvim", enabled = false },
  -- gitsigns for github features
  { "lewis6991/gitsigns.nvim", enabled = false },
  { "nvim-lualine/lualine.nvim", enabled = true},
  { "akinsho/bufferline.nvim", enabled = false },
}
