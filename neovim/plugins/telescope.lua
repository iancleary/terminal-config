local telescope = require("telescope")
local builtin = require("telescope.builtin")

telescope.setup({
	defaults = {
		layout_config = {
			prompt_position = "top",
		},
		layout_strategy = "horizontal",
		sorting_strategy = "ascending",
		use_less = false,
	},
	pickers = {
		find_files = {
			find_command = { "rg", "--files", "--hidden", "--iglob", "!.git" },
		},
	},
})

vim.keymap.set("n", "<leader>f", builtin.find_files, { desc = "Open file picker" })
vim.keymap.set("n", "<leader>r", builtin.buffers, { desc = "Open buffer picker" })
vim.keymap.set("n", "<leader>h", builtin.help_tags, { desc = "Open help tags picker" })
vim.keymap.set("n", "<leader>c", builtin.commands, { desc = "Open help tags picker" })
vim.keymap.set("n", "<leader>/", builtin.live_grep, { desc = "Open live grep" })

vim.keymap.set("n", "<leader>gc", builtin.git_commits, { desc = "Git commits" })
vim.keymap.set("n", "<leader>gb", builtin.git_branches, { desc = "Git branches" })
vim.keymap.set("n", "<leader>gs", builtin.git_status, { desc = "Git status" })
