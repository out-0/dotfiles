return {
  "akinsho/toggleterm.nvim",
  version = "*",
  -- 1. Define the key to open/toggle the terminal
  keys = {
    { "<leader>t", "<cmd>ToggleTerm direction=horizontal<cr>", desc = "Terminal Bottom" },
  },
  opts = {
    size = 20,
    direction = "horizontal",
    shade_terminals = true,
    start_in_insert = true,
    persist_size = true,
  },
  -- 2. This function runs when the plugin loads
  config = function(_, opts)
    require("toggleterm").setup(opts)

    -- Handle the "Terminal Mode Trap" inside the plugin
    function _G.set_terminal_keymaps()
      local opt = { buffer = 0 }
      vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opt)
      vim.keymap.set("t", "jk", [[<C-\><C-n>]], opt)
      -- Allow easy window navigation from terminal
      vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opt)
      vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], opt)
      vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opt)
      vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opt)
    end

    -- Automatically apply these mappings when a terminal opens
    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
  end,
}
