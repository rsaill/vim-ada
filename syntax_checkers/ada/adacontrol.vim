function! SyntaxCheckers_ada_adacontrol_GetLocList() dict
  let makeprg = self.makeprgBuild({ 'exe': 'adacontrol' })
  let errorformat='%f:%l:%c:%m'
  return SyntasticMake( { 'makeprg': makeprg, 'errorformat': errorformat })
endfunction

call g:SyntasticRegistry.CreateAndRegisterChecker( { 'filetype': 'ada',  'name': 'adacontrol' } )
