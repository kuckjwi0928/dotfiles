call plug#begin()

Plug 'terryma/vim-multiple-cursors'
Plug 'folke/tokyonight.nvim', { 'branch': 'main' }
Plug 'nvim-tree/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'nvim-neo-tree/neo-tree.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-lua/plenary.nvim'

call plug#end()

colorscheme tokyonight-night

"shortcut
nnoremap <C-/> :Neotree toggle action=show<cr>
