-- Keymaps
vim.keymap.set("n", "e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer", noremap = true, silent = true })
vim.keymap.set("n", "<F1>", ":Stdheader<CR>", { desc = "Insert 42 header", noremap = true,  })
vim.keymap.set("n", "<leader>", ":Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>t", ":Telescope live_grep<CR>", { desc = "Find text" })
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "List buffers" })



-- Options
-- For Formating
vim.opt.expandtab = false	--Taps
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.autoindent = true
vim.opt.number = true
vim.opt.relativenumber = false
vim.opt.mouse = "a"
vim.opt.termguicolors = true
vim.opt.background = "dark"
vim.opt.clipboard = "unnamedplus"

