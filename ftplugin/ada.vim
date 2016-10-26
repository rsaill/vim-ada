if exists ("b:did_ftplugin") || version < 700
   finish
endif

let b:did_ftplugin = 45

"nnoremap <buffer> <C-p> :vert bo ptj <C-R>=expand("<cword>")<CR><CR>
nnoremap <buffer> * :let @/="<C-r>=expand("<cword>")<CR>"<CR>

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
"let g:syntastic_mode_map = { 'mode': 'passive' }
let g:syntastic_ada_checkers=['adacheckfile']
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

" User-defined completion

"fun! CompleteInPackage(findstart, base)
"	if a:findstart
"		" locate the start of the word
"		let line = getline('.')
"		let start = col('.') - 1
"		while start > 0 && (line[start - 1] =~ '\w' || line[start - 1] =~ '\.')
"			let start -= 1
"		endwhile
"		return start
"	else
"		let res = []
"		let lst = split(a:base,'\.',1)
"		let tag = lst[-1]
"		let l = len(lst)
"		let taglst = taglist('^'.tag)
"		if l > 1 
"			let pkg = join(lst[0:-2],'.')
"			"echom "-> base=" . a:base . " tag=" . tag . " pkg=" . pkg
"			for dico in taglst 
"				if has_key(dico,'packspec')
"					"echom 'packspec:' . dico['packspec']
"					if dico['packspec'] ==# pkg
"						call add(res, pkg . '.' . dico['name'])
"					endif
"				endif
"			endfor
"		else
"			"echom "-> base=" . a:base . " tag=" . tag . " no pkg"
"			for dico in taglst
"				if has_key(dico,'packspec')
"					"echom 'has_key'
"					call add(res, dico['packspec'] . '.' . dico['name'])
"				endif
"			endfor
"		endif	
"		return res
"	endif
"endfun

setlocal previewheight=80
set completefunc=AdaC
nnoremap <buffer> <silent> <C-p> :call Locate()<CR>
