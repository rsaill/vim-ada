function! ToggleSpecImplem()
	let fn_no_ext = expand('%:r')
	let ext = expand('%:e')

	if ext ==? "adb"
		execute "normal! :e " . fn_no_ext . ".ads\<cr>"
	elseif ext ==? "ads"
		execute "normal! :e " . fn_no_ext . ".adb\<cr>"
	endif
endfunction

function! AdaC(findstart, base)
	if a:findstart
		" locate the start of the word
		let line = getline('.')
		let start = col('.') - 1
		while start > 0 && (line[start - 1] =~ '\w' || line[start - 1] =~ '\.')
			let start -= 1
		endwhile
		return start
	else
		let res = systemlist("adac -search '" . a:base . "'")
		return res
	endif
endfun

function! Locate()
	let word = expand('<cfile>') " FIXME this is hacky
        let lst = systemlist("adac -locate '" . word . "'")
        "echom "adac -locate '" . word . "'"
        if !empty(lst)
       "    echom "lst[0] is " . lst[0]
           execute "vert bo pedit +" . lst[1] . " " . lst[0]
        endif
endfun
