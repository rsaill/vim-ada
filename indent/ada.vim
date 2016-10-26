function! GetLineWithoutComments(lnum)
	return substitute( getline(a:lnum), '--.*$', '', '' )
endfunction

function! GetPreviousNonBlankLine()
	if v:lnum <= 1
		return 0
	else
		let nb = v:lnum - 1
		while 1
			"let line = substitute( getline(nb), '--.*$', '', '' )
			let line = GetLineWithoutComments(nb)
			if line !~ '^\s*$'
				return nb
			else
				if nb <= 1
					return 0
				else
					let nb = nb - 1
				endif
			endif
		endwhile
	endif
endfunction

let s:start_kw = '\<declare\>\|\<is\_s\+[^an]\|\<is\_s\+n[^e]\|\<is\_s\+ne[^w]\|\<is\_s\+a[^r]\|\<is\_s\+ar[^r]\|\<is\_s\+arr[^a]\|\<is\_s\+arra[^y]\|\<while\>\|\<if\>\_s*[^;]\|\<for\>\|(' 
let s:end_kw = '\<end\>\|)' 
let s:skip ='synIDattr(synID(line("."), col("."), 0), "name") ' . '=~? "string\\|comment"'

function! GetBlockIndent()
	" Get the indentation in the current block.
	" If the block begins with '(', the indentation is the column of the
	" first non blank character following the '('
	" Otherwise, the indentation is the indentation of the line containing
	" the begining of the block + 3
	" When there is no block, the indentation is 0

	let [ln,cn] = searchpairpos(s:start_kw,'',s:end_kw,'bW',s:skip)
	if ln > 0
		if getline(ln)[cn-1] =~ '('
			let line_ln = GetLineWithoutComments(ln)
			return matchend(line_ln, '(\s*', cn-1)
		else
			return indent(ln) + 3
		endif
	endif

	return 0
endfunction

let s:dec = '\<procedure\>\|\<function\>\|\<type\>'
let s:middle_kw = '\<begin\>\|\<loop\>\|\<then\>\|\<else\>\|\<elsif\>\|\<record\>' 

function! GetAdaIndent()

	" First line of the file
	if v:lnum <= 1
		return 0
	endif 

	" If the line is blank or fully commented, we take the indent of the
	" current block
	let current_line = GetLineWithoutComments(v:lnum)

	" Commented line
	if current_line =~ '^\s*$'
		return GetBlockIndent()
	endif

	" If the line begins with an intermediate or block ending keyword, we take the indentation
	" of the line containing the corresponding opening kewyword
	if ( current_line =~? '^\s*\(' . s:middle_kw . '\|' . s:end_kw . '\)' )
		let [ln,cn] = searchpairpos(s:start_kw,'',s:end_kw,'bW',s:skip)
		return indent(ln)
	endif

	" If the line begins with 'is', we take the indentation of the
	" corresponding defined entity (package, type, record, etc)
	if current_line =~ '^\s*\<is\>'
		let [ln,cn] = searchpos(s:dec,'bW')
		return indent(ln)
	endif
	
	" If the line is a begining of statement, we take the indentation of
	" the current block.
	" A line is a beginning of statement if the previous line ends with
	" ',', ';', '=>' or a begining or intermediate block keyword or 'is'
	let previous_line_number = GetPreviousNonBlankLine()
	if previous_line_number == 0
		return 0
	endif
	let previous_line = GetLineWithoutComments(l:previous_line_number)
	if l:previous_line =~? '[;,]\s*$' || l:previous_line =~? '\(' . s:middle_kw . '\)\s*$' || l:previous_line =~? '\(' . s:start_kw . '\)\s*$' || l:previous_line =~? '\<is\>\s*$' || l:previous_line =~? '=>\s*$'
		return GetBlockIndent()
	endif

	" Otherwise the line is a continuation of statement, so the indent is that
	" of the previous line + 2
	return indent(previous_line_number) + 2

endfunction
setlocal indentexpr=GetAdaIndent()
