-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", {})
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", {})

vim.keymap.set("n", "<leader>y", '"+y', {})
vim.keymap.set("v", "<leader>y", '"+y', {})

-- vim.keymap.set("n", "<leader>sm", ":Telescope harpoon marks<CR>", {})
vim.keymap.set("n", "<leader>ht", ":lua require('harpoon.ui').toggle_quick_menu()<CR>", {})
vim.keymap.set("n", "<leader>ha", ":lua require('harpoon.mark').add_file()<CR>", {})
vim.keymap.set("n", "<leader>hd", ":lua require('harpoon.mark').rm_file()<CR>", {})
vim.keymap.set("n", "<leader>hp", ":lua require('harpoon.ui').nav_prev()<CR>", {})
vim.keymap.set("n", "<leader>hn", ":lua require('harpoon.ui').nav_next()<CR>", {})

