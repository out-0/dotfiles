<<<<<<< HEAD
-- Keymaps
vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
vim.keymap.set("n", "<F1>", ":StdHeader<CR>", { desc = "Insert 42 header" })
vim.keymap.set("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Find text" })
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "List buffers" })

-- Options
vim.opt.expandtab = false
=======
-- Make sure these lines are at the top of your init.lua,
-- BEFORE your lazy.setup() call
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.opt.termguicolors = true

-- 1. Set the <leader> key to Space
-- NOTE: This MUST be at the top, before any keymaps
vim.g.mapleader = " "
vim.g.maplocalleader = " "


-- Keymaps
vim.keymap.set("n", "e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer", noremap = true, silent = true })
vim.keymap.set("n", "<F1>", ":Stdheader<CR>", { desc = "Insert 42 header", noremap = true,  })
vim.keymap.set("n", "<leader>", ":Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>t", ":Telescope live_grep<CR>", { desc = "Find text" })
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "List buffers" })



-- Options
-- For Formating
vim.opt.expandtab = false	--Taps
>>>>>>> test-branch
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

