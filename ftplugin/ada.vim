if exists ("b:did_ftplugin") || version < 700
   finish
endif

let b:did_ftplugin = 45


" Indentation

setlocal expandtab
setlocal shiftwidth=3
setlocal softtabstop=3

" Misc
setlocal cc=80
nnoremap <buffer> * :let @/="<C-r>=expand("<cword>")<CR>"<CR>

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

" Completion

if !exists('*Completion')
	function! Completion(findstart, base)
		if a:findstart
			" locate the start of the word
			let line = getline('.')
			let start = col('.') - 1
			while start > 0 && (line[start - 1] =~ '\w' || line[start - 1] =~ '\.')
				let start -= 1
			endwhile
			return start
		else
			let scope = expand('%:t:r')
			let res = systemlist("adaquery -p myproject -complete '" . a:base . "' -scope '" . scope . "'")
			if v:shell_error
				echo "Location not found."
				return []
			else
				return res
			endif
		endif
	endfun
endif

setlocal complete=.
inoremap <buffer> <C-Space> <C-n>
set completefunc=Completion

" Navigation

if !exists('*ToggleSpecImplem')
	function! ToggleSpecImplem()
		let fn_no_ext = expand('%:r')
		let ext = expand('%:e')

		if ext ==? "adb"
			execute "normal! :e " . fn_no_ext . ".ads\<cr>"
		elseif ext ==? "ads"
			execute "normal! :e " . fn_no_ext . ".adb\<cr>"
		endif
	endfunction
endif

if !exists('*Locate')
	function! Locate()
		let word = expand('<cfile>') " FIXME this is hacky
		let scope = expand('%:t:r')
		let lst = systemlist("adaquery -p myproject -locate '" . word . "' -scope '" .scope . "'")
		"echom "adaquery -p myproject -locate '" . word . "' -scope '" .scope . "'"
		if v:shell_error
			echo "Location not found."
		elseif !empty(lst)
			"    echom "lst[0] is " . lst[0]
			execute "vert bo pedit +" . lst[1] . " " . lst[0]
		endif
	endfun
endif

if !exists('*GoToDef')
	function! GoToDef()
		let word = expand('<cfile>') " FIXME this is hacky
		let scope = expand('%:t:r')
		let lst = systemlist("adaquery -p myproject -locate '" . word . "' -scope '" .scope . "'")
		"echom "adaquery -p myproject -locate '" . word . "' -scope '" .scope . "'"
		if v:shell_error
			echo "Location not found."
		elseif !empty(lst)
			"    echom "lst[0] is " . lst[0]
			execute "edit +" . lst[1] . " " . lst[0]
		endif
	endfun
endif

nnoremap <F1> :call ToggleSpecImplem()<cr>
setlocal previewheight=80
nnoremap <buffer> <silent> <C-p> :call Locate()<CR>
nnoremap <buffer> <silent> <C-]> :call GoToDef()<CR>
