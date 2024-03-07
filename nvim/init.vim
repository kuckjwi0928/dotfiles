call plug#begin()

Plug 'terryma/vim-multiple-cursors'
Plug 'nvim-tree/nvim-web-devicons'
Plug 'romgrk/barbar.nvim'
Plug 'nvim-neo-tree/neo-tree.nvim'
Plug 'MunifTanjim/nui.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }

call plug#end()

let g:material_theme_style = 'darker'

colorscheme material

"shortcut
nnoremap <C-o> :Neotree toggle action=show<cr>
