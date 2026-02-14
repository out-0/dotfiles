return {
  'barkinunal/floaterminal.nvim',
  -- Commands that will trigger the plugin to load
  cmd = { 
    "Floaterminal", 
    "FloaterminalTabNew", 
    "FloaterminalTabC", 
    "FloaterminalTabN", 
    "FloaterminalTabP" 
  },
  keys = {
    -- Main Toggle
    { "<leader>t", "<cmd>Floaterminal<cr>", desc = "Toggle Floaterminal", mode = { "n", "t" } },

    -- Tab Management (Uncomment these to enable them)
    --{ "<leader><leader>", "<cmd>FloaterminalTabNew<cr>", desc = "New Terminal Tab", mode = { "n", "t" } },
    --{ "<leader>td", "<cmd>FloaterminalTabC<cr>", desc = "Close Terminal Tab", mode = { "n", "t" } },
    --{ "<leader>]", "<cmd>FloaterminalTabN<cr>", desc = "Next Terminal Tab", mode = { "n", "t" } },
    --{ "<leader>[", "<cmd>FloaterminalTabP<cr>", desc = "Prev Terminal Tab", mode = { "n", "t" } },
  },
  config = function()
    require('floaterminal').setup({
      width = 0.8,
      height = 0.8,
      border = "rounded",
      max_tab_size = 3,
    })
  end,
}

