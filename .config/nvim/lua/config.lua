-- Keymaps
vim.keymap.set("n", "e", ":NvimTreeToggle<CR>", { desc = "Toggle file explorer", noremap = true, silent = true })
vim.keymap.set("n", "<F1>", ":Stdheader<CR>", { desc = "Insert 42 header", noremap = true,  })
vim.keymap.set("n", "<leader>", ":Telescope find_files<CR>", { desc = "Find files" })
vim.keymap.set("n", "<leader>t", ":Telescope live_grep<CR>", { desc = "Find text" })
vim.keymap.set("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "List buffers" })




