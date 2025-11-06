-- Bootstrap lazy.nvim if not installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git", lazypath,
    "--branch=stable",
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load your keymaps and options
require("config")

-- Plugins
require("lazy").setup({
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function() require("nvim-tree").setup({
			sort = {
				sorter = "case_sensitive",
			},
			view = {
				width = 30,
			},
			renderer = {
          		group_empty = true,
          -- This tells nvim-tree to use the icons
          		icons = {
            		show = {
              			file = true,
              			folder = true,
              			folder_arrow = true,
              			git = true,
            		},
          		},
        	},
			filters = {
          		dotfiles = false, -- Set to false to SHOW dotfiles
        	},
		}) end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({ options = { theme = "catppuccin" } })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = { "c", "lua", "bash", "python" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
  { "windwp/nvim-autopairs", config = function() require("nvim-autopairs").setup() end },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function() require("telescope").setup() end,
  },
  { "lewis6991/gitsigns.nvim", config = function() require("gitsigns").setup() end },
  {
    "vinicius507/header42.nvim",
    opts = { login = "aarid", email = "aarid@student.42.fr" },
    config = function(_, opts) require("header42").setup(opts) end,
  },
})

