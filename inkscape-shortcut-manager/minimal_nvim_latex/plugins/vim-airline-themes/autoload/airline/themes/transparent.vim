" Colors
let s:gray     = [10, 'NONE']
let s:darkgray = [10, 'NONE']
let s:golden   = [10, '#BBE67E']
let s:pink     = [10, 'NONE']
let s:blue     = [10, 'NONE']
let s:orange   = [10, 'NONE']
let s:outerfg  = [10, 'NONE'] "40 for green, 10 for background color
let s:outerfgi = [10, 'NONE']
" Backgrounds
let s:outerbg  = [ 'NONE', 'NONE']
let s:innerbg  = ['NONE', 'NONE']

" Normal mode
let s:N1 = [s:outerfg[0], s:outerbg[0], s:outerfg[0], s:gray[1]]
let s:N3 = [s:outerfg[0], s:outerbg[0], s:outerfg[0], s:gray[1]]

" Normal mode - modified
let s:NM1 = [s:outerfg[0], s:outerbg[0], s:outerfg[0], s:gray[1]]
let s:NM3 = [s:golden[1]  , s:innerbg[1], s:golden[0], s:innerbg[0]]

" Insert mode
let s:I1 = [s:outerfg[0], s:outerbg[0], s:outerfg[0], s:gray[1]]
let s:I3 = [s:golden[1]  , s:innerbg[1], s:golden[0], s:innerbg[0]]

" Visual mode
let s:V1 = [s:outerfg[0], s:outerbg[0], s:outerfg[0], s:gray[1]]
let s:V3 = [s:gray[1]   , s:innerbg[1], s:gray[0]   , s:innerbg[1]]

" Replace mode
let s:R1 = [s:outerfg[0], s:outerbg[0], s:outerfg[0], s:gray[1]]
let s:R3 = [s:gray[1]   , s:innerbg[1], s:gray[0]   , s:innerbg[1]]

" Inactive pane
let s:IA = [s:outerfg[0], s:outerbg[0], s:outerfg[0], s:gray[1]]
let s:IAc = [s:outerfg[0], s:outerbg[0], s:outerfg[0], s:gray[1]]

let g:airline#themes#transparent#palette = {}
let g:airline#themes#transparent#palette.accents = {
    \ 'red': ['#d70000', '', 160, '', '']}

let g:airline#themes#transparent#palette.inactive = {
    \ 'airline_a': s:IA,
    \ 'airline_b': s:IA,
    \ 'airline_c': s:IAc,
    \ 'airline_x': s:IA,
    \ 'airline_y': s:IA,
    \ 'airline_z': s:IA}

let g:airline#themes#transparent#palette.inactive_modified = {
    \ 'airline_a': s:IA,
    \ 'airline_b': s:IA,
    \ 'airline_c': s:NM3,
    \ 'airline_x': s:IA,
    \ 'airline_y': s:IA,
    \ 'airline_z': s:IA}

let g:airline#themes#transparent#palette.normal = {
    \ 'airline_a': s:N1,
    \ 'airline_b': s:N3,
    \ 'airline_c': s:N3,
    \ 'airline_x': s:N3,
    \ 'airline_y': s:N3,
    \ 'airline_z': s:N3}

let g:airline#themes#transparent#palette.normal_modified = {
    \ 'airline_a': s:NM1,
    \ 'airline_b': s:N3,
    \ 'airline_c': s:N3,
    \ 'airline_x': s:N3,
    \ 'airline_y': s:N3,
    \ 'airline_z': s:NM3}

let g:airline#themes#transparent#palette.insert = {
    \ 'airline_a': s:I1,
    \ 'airline_b': s:N3,
    \ 'airline_c': s:N3,
    \ 'airline_x': s:N3,
    \ 'airline_y': s:N3,
    \ 'airline_z': s:I3}
let g:airline#themes#transparent#palette.insert_modified = {}

let g:airline#themes#transparent#palette.replace = {
    \ 'airline_a': s:R1,
    \ 'airline_b': s:N3,
    \ 'airline_c': s:N3,
    \ 'airline_x': s:N3,
    \ 'airline_y': s:N3,
    \ 'airline_z': s:R3}
let g:airline#themes#transparent#palette.replace_modified = {}

let g:airline#themes#transparent#palette.visual = {
    \ 'airline_a': s:V1,
    \ 'airline_b': s:N3,
    \ 'airline_c': s:N3,
    \ 'airline_x': s:N3,
    \ 'airline_y': s:N3,
    \ 'airline_z': s:V3}
let g:airline#themes#transparent#palette.visual_modified = {}


" Warnings
let g:airline#themes#transparent#palette.normal.airline_warning = s:NM1

let g:airline#themes#transparent#palette.normal_modified.airline_warning =
    \ g:airline#themes#transparent#palette.normal.airline_warning

let g:airline#themes#transparent#palette.insert.airline_warning =
    \ g:airline#themes#transparent#palette.normal.airline_warning

let g:airline#themes#transparent#palette.insert_modified.airline_warning =
    \ g:airline#themes#transparent#palette.normal.airline_warning

let g:airline#themes#transparent#palette.visual.airline_warning =
    \ g:airline#themes#transparent#palette.normal.airline_warning

let g:airline#themes#transparent#palette.visual_modified.airline_warning =
    \ g:airline#themes#transparent#palette.normal.airline_warning

let g:airline#themes#transparent#palette.replace.airline_warning =
    \ g:airline#themes#transparent#palette.normal.airline_warning

let g:airline#themes#transparent#palette.replace_modified.airline_warning =
    \ g:airline#themes#transparent#palette.normal.airline_warning


" Errors
let g:airline#themes#transparent#palette.normal.airline_error = s:V1

let g:airline#themes#transparent#palette.normal_modified.airline_error =
      \ g:airline#themes#transparent#palette.normal.airline_error

let g:airline#themes#transparent#palette.insert.airline_error =
      \ g:airline#themes#transparent#palette.normal.airline_error

let g:airline#themes#transparent#palette.insert_modified.airline_error =
      \ g:airline#themes#transparent#palette.normal.airline_error

let g:airline#themes#transparent#palette.insert_modified.airline_error =
      \ g:airline#themes#transparent#palette.normal.airline_error

let g:airline#themes#transparent#palette.visual.airline_error =
      \ g:airline#themes#transparent#palette.normal.airline_error

let g:airline#themes#transparent#palette.visual_modified.airline_error =
      \ g:airline#themes#transparent#palette.normal.airline_error

let g:airline#themes#transparent#palette.replace.airline_error =
      \ g:airline#themes#transparent#palette.normal.airline_error

let g:airline#themes#transparent#palette.replace_modified.airline_error =
      \ g:airline#themes#transparent#palette.normal.airline_error
