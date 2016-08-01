function! SyntaxCheckers_ada_adacheck_GetLocList() dict
  let makeprg = self.makeprgBuild({ 'exe': 'adacheckfast' })
  let errorformat='%f:%l:%c:%m'
  return SyntasticMake( { 'makeprg': makeprg, 'errorformat': errorformat })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker( { 'filetype': 'ada',  'name': 'adacheck' } )
