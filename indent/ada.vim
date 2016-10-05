function! GetLineWithoutComments(lnum)
	return substitute( getline(a:lnum), '--.*$', '', '' )
endfunction

function! GetPreviousNonBlankLine()
	if v:lnum <= 1
		return 1
	else
		let nb = v:lnum - 1
		while 1
			"let line = substitute( getline(nb), '--.*$', '', '' )
			let line = GetLineWithoutComments(nb)
			if line !~ '^\s*$'
				return nb
			else
				if nb <= 1
					return 1
				else
					let nb = nb - 1
				endif
			endif
		endwhile
	endif
endfunction

let s:start_kw = '\<procedure\>\|\<function\>\|\<package\>\|\<while\>\|\<if\>\_s*[^;]' 
let s:middle_kw = '\<is\>\|\<begin\>\|\<loop\>\|\<then\>\|\<else\>' 
let s:end_kw = '\<end\>' 

function! GetAdaIndent()

	" First line of the file
	if v:lnum <= 1
		"echom 'first line'
		return 0
	endif 

	" blank line
	if getline(v:lnum) =~ '^\s*$'
		"echom 'blank line'
		return 0
	endif

	let s_skip ='synIDattr(synID(line("."), col("."), 0), "name") ' . '=~? "string\\|comment"'
	let current_line = GetLineWithoutComments(v:lnum)

	" Commented line
	if current_line =~ '^\s*$'
		"echom 'commented line'
		let [ln,cn] = searchpairpos(s:start_kw,'',s:end_kw,'b',s_skip)
		return indent(ln) + 3
	endif

	" middle/end block keyword
	if ( current_line =~? s:middle_kw || current_line =~? s:end_kw ) && ( current_line !~? '^\s*\(' . s:start_kw . '\)' )
		"echom 'middle/end block line'
		let [ln,cn] = searchpairpos(s:start_kw,'',s:end_kw,'b',s_skip)
		return indent(ln)
	endif

	let previous_line_number = GetPreviousNonBlankLine()
	let previous_line = GetLineWithoutComments(l:previous_line_number)

	" previous line terminated by ;
	if l:previous_line =~? ';\s*$'
		"echom 'previous line ends with ;'
		let [ln,cn] = searchpairpos('(','',')','bW',s_skip,v:lnum-15)
		if ln > 0
			let ind = matchend(GetLineWithoutComments(ln), '(\s*', cn-1)
			return ind
		else
			let [ln,cn] = searchpairpos(s:start_kw,'',s:end_kw,'bW',s_skip)
			if ln > 0
				return (indent(ln) + 3)
			else
				return 0
			endif
		endif
	endif

	" last line terminated by ,
	if l:previous_line =~? ',\s*$'
		"echom 'previous line ends with ,'
		let [ln,cn] = searchpairpos('(','',')','bW',s_skip)
		let ind = matchend(GetLineWithoutComments(ln), '(\s*', cn-1)
		return ind
	endif

	" otherwise
	"echom 'nothing special'
	let ind = indent(previous_line_number) + 3
	return ind
endfunction
setlocal indentexpr=GetAdaIndent()
