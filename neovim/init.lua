vim.g.mapleader = " "

-- Line numbering
vim.api.nvim_set_option_value("number", true, { win = 0 })
vim.api.nvim_set_option_value("relativenumber", true, { win = 0 })
vim.api.nvim_set_option_value("wrap", false, { win = 0 })

-- Better Markdown
vim.api.nvim_set_option_value("conceallevel", 0, {})

-- Search case
vim.api.nvim_set_option_value("ignorecase", true, {})
vim.api.nvim_set_option_value("smartcase", true, {})

-- Hide command line
vim.api.nvim_set_option_value("cmdheight", 0, {})

-- Minimal number of lines to scroll when the cursor gets off the screen
vim.api.nvim_set_option_value("scrolloff", 8, {})
vim.api.nvim_set_option_value("sidescrolloff", 8, {})

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
vim.api.nvim_set_option_value("tabstop", 4, {})
vim.api.nvim_set_option_value("shiftwidth", 4, {})
vim.api.nvim_set_option_value("softtabstop", 4, {})
vim.api.nvim_set_option_value("expandtab", true, {})
vim.api.nvim_set_option_value("smartindent", true, {})
vim.cmd("filetype indent plugin on")
