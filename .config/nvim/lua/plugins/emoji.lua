return {
  -- 1. Setup the emoji plugin
  {
    "allaman/emoji.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      enable_cmp_integration = true,
    },
  },

  -- 2. Correctly hook into Telescope
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      -- This ensures 'load_extension' runs after Telescope setup
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").load_extension("emoji")
      end)
    end,
    keys = {
      -- This keybind triggers telescope AND the extension
      { "<leader>j", "<cmd>Telescope emoji<cr>", desc = "Emoji Search" },
    },
  },

  -- 3. Autocomplete (Insert mode)
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },
}
