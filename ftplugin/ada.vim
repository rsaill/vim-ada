if exists ("b:did_ftplugin") || version < 700
   finish
endif

let b:did_ftplugin = 45

" MEMO
" For generating tags use the following command:
" ls -R dir1 dir2 dir3 | grep '.ads$' | ctags -L -

" Indentation

setlocal expandtab
setlocal shiftwidth=3
setlocal softtabstop=3
" TODO use custum indent function

" Go to Spec/Body
nnoremap <F1> :call ToggleSpecImplem()<cr>

" Completion

setlocal complete=.,t
inoremap <buffer> <C-Space> <C-n>
" TODO add custum omnicompletion function

" Misc
setlocal cc=80

" Syntastic
let g:syntastic_mode_map = { 'mode': 'passive' }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
nnoremap <buffer> <F3> :SyntasticCheck gcc<cr>
nnoremap <buffer> <F4> :SyntasticCheck adacheckfile<cr>
nnoremap <buffer> <F5> :SyntasticCheck adacontrol<cr>

" Tagbar
nnoremap <buffer> <F8> :TagbarToggle<CR>
let g:tagbar_type_ada = {
  \ 'ctagstype': 'ada',
  \ 'ctagsbin': 'ctags',
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

" NERDCommenter
noremap <silent> <F2> :call NERDComment("n", "Toggle")<CR>
