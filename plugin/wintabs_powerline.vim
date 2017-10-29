if exists('g:loaded_wintabs_powerline') || v:version < 700
  finish
endif
let g:loaded_wintabs_powerline = 1

" configurations
function! s:set(var, value)
  if !exists(a:var)
    let {a:var} = a:value
  endif
endfunction

call s:set('g:wintabs_powerline_arrow_left', " \u25c0 ")
call s:set('g:wintabs_powerline_arrow_right', " \u25b6 ")
call s:set('g:wintabs_powerline_sep_buffer_transition', "\ue0b0")
call s:set('g:wintabs_powerline_sep_buffer', "\ue0b1")
call s:set('g:wintabs_powerline_sep_tab_transition', "\ue0b2")
call s:set('g:wintabs_powerline_sep_tab', "\ue0b3")
call s:set('g:wintabs_powerline_higroup_empty', 'TabLineFill')
call s:set('g:wintabs_powerline_higroup_buffer', 'TabLine')
call s:set('g:wintabs_powerline_higroup_active_buffer', 'TabLineSel')
call s:set('g:wintabs_powerline_higroup_tab', 'TabLine')
call s:set('g:wintabs_powerline_higroup_active_tab', 'TabLineSel')
call s:set('g:wintabs_powerline_higroup_arrow', 'TabLine')

" configure wintabs renderers
call wintabs_powerline#init()
