if exists ("b:did_ftplugin") || version < 700
   finish
endif

let b:did_ftplugin = 45

" Indentation
setlocal expandtab
setlocal shiftwidth=3
setlocal softtabstop=3

" Completion
setlocal complete=.,t
inoremap <buffer> <C-Space> <C-n>

" Misc
setlocal cc=80

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
nnoremap <buffer> <F4> :SyntasticCheck adacheck<cr>

" Tagbar
nnoremap <buffer> <F8> :TagbarToggle<CR>
let g:tagbar_type_ada = {
  \ 'ctagstype': 'ada',
  \ 'ctagsbin': 'adatags',
  \ 'ctagsargs': '-f - --format=2 --excmd=pattern --fields=nksaSmt',
  \ 'kinds' : [
      \'P:package specs',
      \'p:packages',
      \'t:type',
      \'u:subtypes',
      \'c:record type components',
      \'l:enum type literals',
      \'v:variables',
      \'f:formal parameters',
      \'n:constants',
      \'x:exceptions',
      \'R:subprogram specs',
      \'r:subprograms:1',
      \'K:task specs',
      \'k:tasks',
      \'O:protected data specs',
      \'o:protected data',
      \'e:entries',
      \'b:labels',
      \'i:identifiers'
  \],
  \ 'sro' : '.',
  \ 'kind2scope': { 'r' : 'subprogram', 'p' : 'package' }
  \}

" Go to spec/code
nnoremap <buffer> <F1> :call ToggleSpecImplem ()<cr>
