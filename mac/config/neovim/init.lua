vim.cmd.coloscheme('vim')

if vim.g.neovide then
	vim.g.neovide_input_macos_option_key_is_meta = 'both'	

	-- Prevent cursor from blinking.
	vim.o.guicursor = vim.o.guicursor .. ',a:blinkwait0-blinkoff0-blinkon0'

	-- For plugins which show icons.
	vim.opt.guifont = 'monospace,Symbols Nerd Font Mono'
end

-- Oil is an alternative for netrw.
-- Deleting to trash seems like the way to go.
require('oil').setup({ delete_to_trash = true })
