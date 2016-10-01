function! ToggleSpecImplem()
	let fn_no_ext = expand('%:r')
	let ext = expand('%:e')

	if ext ==? "adb"
		execute "normal! :e " . fn_no_ext . ".ads\<cr>"
	elseif ext ==? "ads"
		execute "normal! :e " . fn_no_ext . ".adb\<cr>"
	endif
endfunction
