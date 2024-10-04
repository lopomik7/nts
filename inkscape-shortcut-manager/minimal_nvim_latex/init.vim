nnoremap , <Leader>
let g:mapleader = " "

" Sample init.vim for minimal_nvim_latex
" Your custom configuration goes here

" Specify vim-plug runtimepath
if empty(glob('~/.config/inkscape-shortcut-manager/minimal_nvim_latex/plug.vim'))
    source ~/.config/inkscape-shortcut-manager/minimal_nvim_latex/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Initialize vim-plug
call plug#begin('~/.config/inkscape-shortcut-manager/minimal_nvim_latex/plugins')

" Specify your plugins here
Plug 'tpope/vim-surround'
Plug 'junegunn/goyo.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ap/vim-css-color'
Plug 'itchyny/vim-gitbranch'
Plug 'lervag/vimtex'
Plug 'ggandor/leap.nvim'

" Lsp - Doesn't include linter, debugger, formatter, snippet engine
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/nvim-cmp'

" For luasnip snippet engine, Ultisnip was slow af.
Plug 'L3MON4D3/LuaSnip', {'tag': 'v2.*', 'do': 'make install_jsregexp'}
Plug 'saadparwaiz1/cmp_luasnip'
" Snippets
Plug 'rafamadriz/friendly-snippets'
Plug 'iurimateus/luasnip-latex-snippets.nvim'

" Add more plugins as needed

" End vim-plug section
call plug#end()

" Highlighting debloat
highlight Pmenu ctermbg=none guibg=none cterm=bold gui=bold blend=0
highlight MatchParen ctermbg=none guibg=none cterm=bold gui=bold blend=0
highlight ErrorMsg ctermfg=none ctermbg=none
highlight Error ctermfg=none ctermbg=none
highlight SpecialKey ctermfg=none ctermbg=none
highlight SpellBad ctermfg=red ctermbg=none gui=bold
highlight SpellCap ctermfg=red ctermbg=none gui=bold
highlight SpellRare ctermfg=red ctermbg=none gui=bold
highlight SpellLocal ctermfg=red ctermbg=none gui=bold
highlight Visual ctermfg=red ctermbg=black gui=bold
highlight Conceal ctermfg=none ctermbg=none
highlight SignColumn ctermbg=none guibg=none cterm=bold gui=bold blend=0
highlight StatusLine ctermbg=none guibg=none cterm=none gui=none blend=0

" Tabsize set to 4 spaces
set tabstop=4      " Number of visual spaces per TAB
set softtabstop=4  " Number of spaces to use in case of <BS> or <Del>
set shiftwidth=4   " Number of spaces to use for auto-indenting
set expandtab      " Use spaces instead of tabs

" Some basics:
nnoremap c "_c
set nocompatible
filetype plugin on
syntax on
set encoding=utf-8
set number relativenumber
set colorcolumn=81
colorscheme vim

" Show white trailing space
set listchars=tab:>~,nbsp:_,trail:.
set list

" Enable autocompletion:
set wildmode=longest,list,full

" Disables automatic commenting on newline:
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Perform dot commands over visual blocks:
vnoremap . :normal .<CR>

" Ensures that every file is unfolded
autocmd BufWinEnter * silent! :%foldopen!

" Filetype is set to .tex
autocmd BufNewFile,BufRead *.tex set filetype=tex

" Some tweaks
" Quickly closing the window by jamming wq
inoremap wq :wq
nnoremap wq :wq
inoremap qw :wq
nnoremap qw :wq

"Quickly getting back on track when I mess something up
inoremap u
vnoremap Iu
nnoremap ui

" Start insert mode between $$'s
autocmd BufEnter * startinsert | call cursor(1, 2)

nnoremap j gj
nnoremap k gk

" Drag text around in visual block, kinda buggy but cool
vnoremap <C-Right>  xpgvlolo
vnoremap <C-left>   xhPgvhoho
vnoremap <C-Down>   xjPgvjojo
vnoremap <C-Up>     xkPgvkoko

" Goyo plugin makes text more readable when writing prose:
nnoremap <silent> <leader>g :Goyo \| set bg=light \| set linebreak<CR>
" Goyo remove syntax
autocmd! User GoyoEnter silent! syntax clear
autocmd! User GoyoLeave silent! syntax enable

" Spell-check set to <leader>o, 'o' for 'orthography'
nnoremap <silent> <leader>o :call ToggleSpellLanguage()<CR>

" Splits open at the bottom and right, unlike vim defaults.
set splitbelow splitright

" Shortcutting split navigation, saving a keypress:
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Tabedit bind
nnoremap <leader>te :tabedit

" Normal mode when focus window is changed
autocmd FocusLost * call feedkeys("\<Esc>")

""" + toggle remap arrow keys to resize window panes
nnoremap + :call ToggleResizeMode()<CR>

let s:KeyResizeEnabled = 0

function! ToggleResizeMode()
  if s:KeyResizeEnabled
    call NormalArrowKeys()
    let s:KeyResizeEnabled = 0
  else
    call ResizeArrowKeys()
    let s:KeyResizeEnabled = 1
  endif
endfunction

function! NormalArrowKeys()
  " unmap arrow keys
  echo 'normal arrow keys'
  nunmap <Up>
  nunmap <Down>
  nunmap <Left>
  nunmap <Right>
endfunction

function! ResizeArrowKeys()
  " Remap arrow keys to resize window
  echo 'Resize window with arrow keys'
  nnoremap <Up>    :resize +2<CR>
  nnoremap <Down>  :resize -2<CR>
  nnoremap <Left>  :vertical resize -2<CR>
  nnoremap <Right> :vertical resize +2<CR>
endfunction

" No extra status bar when splitting horizontally
let &statusline='%#Normal# '

" Hides vertical split bar with space
set fillchars=vert:\ ,

" Replace ex mode with gq
map Q gq

" Check file in shellcheck:
map <leader>s :!clear && shellcheck -x %<CR>

" Replace all is aliased to S.
nnoremap S :%s//g<Left><Left>

" Save file as sudo on files that require root permission
cabbrev w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Turns off highlighting on the bits of code that are changed, so the line that is changed is highlighted but the actual text that has changed stands out on the line and is readable.
if &diff
    highlight! link DiffText MatchParen
endif

" Function for toggling the bottom statusbar:
let s:hidden_all = 0
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
    endif
endfunction
nnoremap <silent> <leader>h :call ToggleHiddenAll()<CR>

" Function for toggling the top and bottom statusbar:
  function! ToggleHiddenAllAll()
     if s:hidden_all  == 0
         let s:hidden_all = 1
             set noshowmode
             set noruler
             set laststatus=0
             set noshowcmd
             set showtabline=0
     else
         let s:hidden_all = 0
             set showmode
             set ruler
             set laststatus=2
             set showcmd
             set showtabline=1
     endif
 endfunction
nnoremap <silent> <leader>H :call ToggleHiddenAllAll()<CR>

" Vimtex
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
let g:vimtex_syntax_enabled = 1
let g:vimtex_syntax_minted = 1

" Leap like a kangaroo binds
lua <<EOF
vim.keymap.set({'n', 'x', 'o'}, 's',  '<Plug>(leap-forward)')
vim.keymap.set({'n', 'x', 'o'}, '<c-s>',  '<Plug>(leap-backward)')
vim.keymap.set({'n', 'x', 'o'}, 'gs', '<Plug>(leap-from-window)')
EOF

" Vim-airline settings
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_symbols.colnr = ' C:'
let g:airline_symbols.linenr = ' L:'
let g:airline_symbols.maxlinenr = '☰ '

" Theme and status line on position
let g:airline_theme='transparent'
let g:airline_statusline_ontop = 0

" tab and buffer line
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_alt_sep = ' '
let g:airline#extensions#tabline#show_buffers = 0
let g:airline#extensions#tabline#show_splits = 0
let g:airline#extensions#tabline#show_tabs = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#close_symbol = '×'
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#tab_min_count = 2

" show gitbranch with airline
let g:airline#extensions#branch#custom_head = 'gitbranch#name'

" Luasnip settings and binds
lua << EOF
  -- Lazy load snippets, must be different for custom snippets
    require("luasnip.loaders.from_vscode").lazy_load()
EOF

lua << EOF
  -- Load luasnip-latex-snippets
    require'luasnip-latex-snippets'.setup({ use_treesitter = false })
    require("luasnip").config.setup { enable_autosnippets = true }
EOF

" Luasnip keybinds
imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>'
inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>

lua <<EOF
  -- Set up nvim-cmp.
  local cmp = require'cmp'

  cmp.setup({
    snippet = {
      -- REQUIRED - you must specify a snippet engine
      expand = function(args)
         require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },
    window = {
      -- completion = cmp.config.window.bordered(),
      -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    }),
    sources = cmp.config.sources({
      { name = 'nvim_lsp' },
       { name = 'luasnip' }, -- For luasnip users.
    }, {
      { name = 'buffer' },
    })
  })

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline({ '/', '?' }, {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    }),
    matching = { disallow_symbol_nonprefix_matching = false }
  })

  -- Set up lspconfig.
  local capabilities = require('cmp_nvim_lsp').default_capabilities()

  -- LateX lsp add mode settings if needed
    require('lspconfig')['texlab'].setup {
    capabilities = capabilities
  }

EOF
