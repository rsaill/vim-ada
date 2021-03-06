function! SyntaxCheckers_ada_adacheckfile_GetLocList() dict
  let makeprg = self.makeprgBuild({ 'exe': 'adacheckfile' })
  let errorformat='%f:%l:%c:%m'
  return SyntasticMake( { 'makeprg': makeprg, 'errorformat': errorformat })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker( { 'filetype': 'ada',  'name': 'adacheckfile' } )
