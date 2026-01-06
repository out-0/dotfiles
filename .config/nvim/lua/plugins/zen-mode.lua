-- lua/plugins/zen-mode.lua
return {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  keys = {
    { "<leader>z", function() require("zen-mode").toggle() end, desc = "Toggle Zen Mode" },
  },
  opts = {
    -- 1. Main Window Settings
    window = {
      width = 100, -- width of the Zen window
      options = {
        number = false,         -- disable line numbers
        relativenumber = false, -- disable relative numbers
        signcolumn = "yes",      -- disable signcolumn (Gitsigns/LSP icons)
        cursorline = false,     -- disable cursor line highlighting
        cursorcolumn = false,   -- disable cursor column highlighting
        foldcolumn = "0",       -- disable fold column
        list = false,           -- disable whitespace characters (tabs/spaces icons)
      },
    },
    -- 2. External UI/Plugin Integrations
    plugins = {
      options = {
        enabled = true,
        ruler = false,      -- disables ruler text in cmd line
        showcmd = false,    -- disables command display in last line
        laststatus = 0,     -- hide the statusline completely
      },
      twilight = { enabled = true }, -- dims inactive code blocks
      -- Kitty Terminal specific settings
      kitty = {
        enabled = false,    -- set to true if kitty remote control is configured
        font = "+4",        -- increase font size
      },
    },
  },
}
