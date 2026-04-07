if vim.g.neovide then
	for _, setting in pairs({
		-- Copy and cut.
		{ 'v', '<D-c>', '"+y' },
		{ 'v', '<D-x>', '"+d' },

		-- Paste.
		{ 'i', '<D-v>', '<ESC>l"+Pli' },
		{ 'n', '<D-v>', '"+P' },
		{ 'v', '<D-v>', '"+P' },
		{ 'c', '<D-v>', '<C-R>+' },
		{ 't', '<D-v>', '<C-\\><C-n>"+pa<Right>' },
	}) do
		vim.keymap.set(unpack(setting))
	end

	vim.g.neovide_input_macos_option_key_is_meta = 'both'	

	-- Prevent cursor from blinking.
	vim.o.guicursor = vim.o.guicursor .. ',a:blinkwait0-blinkoff0-blinkon0'
end

-- Oil (an alternative for netrw).

require('oil').setup({
	-- Don't want icons (which would be the default otherwise).
	columns = {},

	delete_to_trash = true,
	
})

-- Go up via "-" in normal mode.
vim.keymap.set('n', '-', '<cmd>Oil<cr>', { desc = 'Open parent directory' })
