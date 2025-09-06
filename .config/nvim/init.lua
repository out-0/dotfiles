-- Bootstrap lazy.nvim plugin manager (clones it only if not installed)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath
  })
end
vim.opt.rtp:prepend(lazypath)

-- Load and configure plugins using lazy.nvim
require("lazy").setup({

  ------------------------------------------------------------------------
  -- FILE EXPLORER (Like sidebar in VSCode)
  ------------------------------------------------------------------------
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup()
    end,
  },

  ------------------------------------------------------------------------
  -- STATUS LINE (Shows file info, position, mode, git, etc.)
  ------------------------------------------------------------------------
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = { theme = "catppuccin" }
      })
    end,
  },

  ------------------------------------------------------------------------
  -- THEME: Catppuccin (dark mode with soft colors)
  ------------------------------------------------------------------------
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  ------------------------------------------------------------------------
  -- BETTER SYNTAX HIGHLIGHTING + SMART INDENT (uses real parser)
  ------------------------------------------------------------------------
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          "c", "lua", "bash", "python", "html", "json", "css"
        },
        highlight = { enable = true },
        indent = { enable = true }, -- improves auto-indentation
      })
    end,
  },

  ------------------------------------------------------------------------
  -- INDENT LINES (Shows vertical lines for code blocks)
  ------------------------------------------------------------------------
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    config = function()
      require("ibl").setup()
    end,
  },

  ------------------------------------------------------------------------
  -- AUTO PAIRS (automatically close brackets, quotes, etc.)
  ------------------------------------------------------------------------
  {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end,
  },

  ------------------------------------------------------------------------
  -- COMMENT TOGGLER (gcc to toggle line comments)
  ------------------------------------------------------------------------
  { "tpope/vim-commentary" },

  ------------------------------------------------------------------------
  -- FUZZY FINDER (Search files, text, symbols, etc.)
  ------------------------------------------------------------------------
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").setup()
    end,
  },

  ------------------------------------------------------------------------
  -- GIT SIGNS (shows + - ~ signs on the left)
  ------------------------------------------------------------------------
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },

  ------------------------------------------------------------------------
  -- LSP (Language Server Protocol) for code intelligence
  ------------------------------------------------------------------------
  { "neovim/nvim-lspconfig" }, -- base LSP setup
  {
    "williamboman/mason.nvim", -- installs LSPs like clangd
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim", -- connects mason to lspconfig
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "clangd", "lua_ls" },
      })
    end,
  },

  ------------------------------------------------------------------------
  -- AUTO COMPLETION + SNIPPETS (like IntelliSense)
  ------------------------------------------------------------------------
  { "hrsh7th/nvim-cmp" },             -- Completion UI
  { "hrsh7th/cmp-nvim-lsp" },         -- Connect LSP to completion
  { "L3MON4D3/LuaSnip" },             -- Snippet engine
  { "saadparwaiz1/cmp_luasnip" },     -- Use snippets in completion
})

------------------------------------------------------------------
-- GLOBAL OPTIONS
------------------------------------------------------------------

-- Use real tabs (not spaces)
vim.opt.expandtab = false      -- DON'T convert tabs to spaces
vim.opt.tabstop = 4            -- A tab is 4 spaces wide
vim.opt.shiftwidth = 4         -- Used for auto-indent
vim.opt.smarttab = true
vim.opt.autoindent = true

-- Basic UI
vim.opt.number = true          -- Show line numbers
vim.opt.relativenumber = false  -- Show relative line numbers
vim.opt.mouse = "a"            -- Enable mouse support
vim.opt.termguicolors = true   -- Enable 24-bit colors (required for themes)

-- Enable dark background
vim.opt.background = "dark"

-- Use system clipboard
vim.opt.clipboard = "unnamedplus"

-- Recommended key mappings for NvimTree
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })

-- Telescope mappings (example)
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Find text (grep)" })
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "List open buffers" })

-- Make Neovim use terminal background (transparent)
vim.cmd [[
  highlight Normal ctermbg=none guibg=none
  highlight NormalNC ctermbg=none guibg=none
  highlight NormalFloat ctermbg=none guibg=none
]]

