vim.g.mapleader = " "

-- Line numbering
vim.api.nvim_set_option_value("number", true, nil)
vim.api.nvim_set_option_value("relativenumber", true. nil)
vim.api.nvim_set_option_value("wrap", false, nil)

-- Better Markdown
vim.api.nvim_set_option_value("conceallevel", 0, nil)

-- Search case
vim.api.nvim_set_option_value("ignorecase", true, nil)
vim.api.nvim_set_option_value("smartcase", true, nil)

-- Hide command line
vim.api.nvim_set_option_value("cmdheight", 0, nil)

-- Minimal number of lines to scroll when the cursor gets off the screen
vim.api.nvim_set_option_value("scrolloff", 8, nil)
vim.api.nvim_set_option_value("sidescrolloff", 8, nil)

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- Add missing commentstring for nix files
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "nix", "terraform" },
	group = vim.api.nvim_create_augroup("SetHashCommentstring", { clear = true }),
	callback = function()
		vim.bo.commentstring = "# %s"
	end,
})

-- Indents
vim.api.nvim_set_option_value("tabstop", 4, nil)
vim.api.nvim_set_option_value("shiftwidth", 4, nil)
vim.api.nvim_set_option_value("softtabstop", 4, nil)
vim.api.nvim_set_option_value("expandtab", true, nil)
vim.api.nvim_set_option_value("smartindent", true, nil)
vim.cmd("filetype indent plugin on")
