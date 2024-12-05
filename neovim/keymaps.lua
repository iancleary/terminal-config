-- Remove annoying mapping
vim.keymap.set("n", "Q", "<nop>")

-- Navigation
vim.keymap.set("n", "ga", "<CMD>e #<CR>")

-- Copy and paste
vim.keymap.set("v", "<leader>y", '"+y', { desc = "Yank to system register" })
vim.keymap.set("n", "<leader>y", '"+yy', { desc = "Yank to system register" })
vim.keymap.set("v", "<leader>p", '"+p', { desc = "Paste from system register" })
vim.keymap.set("v", "<leader>P", '"+P', { desc = "Paste from system register" })
vim.keymap.set("n", "<leader>p", '"+p', { desc = "Paste from system register" })
vim.keymap.set("n", "<leader>P", '"+P', { desc = "Paste from system register" })
vim.keymap.set("n", "Y", "y$")

-- Visual mode
vim.keymap.set("n", "vv", "V")
vim.keymap.set("n", "V", "v$")

-- Window Splitting
vim.keymap.set("n", "<leader>ws", "<CMD>split<CR>", { desc = "Split window" })
vim.keymap.set("n", "<leader>wv", "<CMD>vsplit<CR>", { desc = "Split window vertically" })

-- Navigation of Split Windows
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Navigate to the left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Navigate to the bottom window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Navigate to the top window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Navigate to the right window" })

-- Neotree
vim.keymap.set("n", "<leader>t", "<CMD>Neotree<CR>", { desc = "Open Neotree" })