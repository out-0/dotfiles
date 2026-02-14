local map = vim.keymap.set

-- 1. Disable LazyVim/Snacks Conflicts
pcall(vim.keymap.del, { "n", "x" }, "<leader>gB")
pcall(vim.keymap.del, { "n", "x" }, "<leader>gY")

-- 2. Basic Edits (Move lines & Clipboard)
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Up" })
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to System Clipboard" })
map("n", "<leader>Y", [["+Y]], { desc = "Copy Line to System Clipboard" })

-- 3. Harpoon 2 Keymaps (SAFE CHECK)
local status_ok, harpoon = pcall(require, "harpoon")
if status_ok then
    -- Basic Navigation
    map("n", "<leader>ha", function() harpoon:list():add() end, { desc = "Harpoon: Add File" })
    map("n", "<leader>ht", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = "Harpoon: Menu" })
    
end

-- 4. Python/Ruff Format
map("n", "<leader>cf", function()
  vim.lsp.buf.format({ name = "ruff" })
  print("🧹 Code cleaned via Ruff")
end, { desc = "Format Py with Ruff" })



-- Delete keys:
pcall(vim.keymap.del, "n", "<leader>1")
pcall(vim.keymap.del, "n", "<leader>2")
pcall(vim.keymap.del, "n", "<leader>3")
pcall(vim.keymap.del, "n", "<leader>4")
pcall(vim.keymap.del, "n", "<leader>5")
pcall(vim.keymap.del, "n", "<leader>6")
pcall(vim.keymap.del, "n", "<leader>7")
pcall(vim.keymap.del, "n", "<leader>8")
pcall(vim.keymap.del, "n", "<leader>9")
pcall(vim.keymap.del, "n", "<leader>H")

pcall(vim.keymap.del, "n", "<leader>cF")
pcall(vim.keymap.del, "n", "<leader>cd")
pcall(vim.keymap.del, "n", "<leader>cs")
pcall(vim.keymap.del, "n", "<leader>cS")

pcall(vim.keymap.del, "n", "<leader>E")
pcall(vim.keymap.del, "n", "<leader>K")
pcall(vim.keymap.del, "n", "<leader>S")
pcall(vim.keymap.del, "n", "<leader>,")
pcall(vim.keymap.del, "n", "<leader>.")
pcall(vim.keymap.del, "n", "<leader>/")
pcall(vim.keymap.del, "n", "<leader>`")
pcall(vim.keymap.del, "n", "<leader>-")
pcall(vim.keymap.del, "n", "<leader>y")
pcall(vim.keymap.del, "n", "<leader>Y")
pcall(vim.keymap.del, "n", "<leader>Y")

