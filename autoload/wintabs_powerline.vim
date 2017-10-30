function! wintabs_powerline#init()
  let g:wintabs_renderers = {
        \'buffer': function('wintabs_powerline#buffer'),
        \'buffer_sep': function('wintabs_powerline#buffer_sep'),
        \'tab': function('wintabs_powerline#tab'),
        \'tab_sep': function('wintabs_powerline#tab_sep'),
        \'left_arrow': function('wintabs_powerline#left_arrow'),
        \'right_arrow': function('wintabs_powerline#right_arrow'),
        \'line_sep': function('wintabs_powerline#line_sep'),
        \}

  augroup wintabs_powerline_on_colorscheme
    autocmd!
    autocmd ColorScheme,VimEnter * call wintabs_powerline#on_colorscheme()
  augroup END
endfunction

function! wintabs_powerline#on_colorscheme()
  " set default tabline/statusline highlight to empty
  if g:wintabs_display == 'tabline'
    call s:highlight(
          \'TabLineFill',
          \g:wintabs_powerline_higroup_empty,
          \g:wintabs_powerline_higroup_empty,
          \)
  else
    call s:highlight(
          \'StatusLine',
          \g:wintabs_powerline_higroup_empty,
          \g:wintabs_powerline_higroup_empty,
          \)
    call s:highlight(
          \'StatusLineNC',
          \g:wintabs_powerline_higroup_empty,
          \g:wintabs_powerline_higroup_empty,
          \)
  endif

  " create highlights for transitional separators
  call s:highlight(
        \'WintabsPowerlineBufferSepActiveBuffer',
        \g:wintabs_powerline_higroup_buffer,
        \g:wintabs_powerline_higroup_active_buffer,
        \)
  call s:highlight(
        \'WintabsPowerlineActiveBufferSepBuffer',
        \g:wintabs_powerline_higroup_active_buffer,
        \g:wintabs_powerline_higroup_buffer,
        \)
  call s:highlight(
        \'WintabsPowerlineActiveBufferSepEmpty',
        \g:wintabs_powerline_higroup_active_buffer,
        \g:wintabs_powerline_higroup_empty,
        \)
  call s:highlight(
        \'WintabsPowerlineBufferSepEmpty',
        \g:wintabs_powerline_higroup_buffer,
        \g:wintabs_powerline_higroup_empty,
        \)
  call s:highlight(
        \'WintabsPowerlineTabSepActiveTab',
        \g:wintabs_powerline_higroup_tab,
        \g:wintabs_powerline_higroup_active_tab,
        \)
  call s:highlight(
        \'WintabsPowerlineActiveTabSepTab',
        \g:wintabs_powerline_higroup_active_tab,
        \g:wintabs_powerline_higroup_tab,
        \)
  call s:highlight(
        \'WintabsPowerlineActiveTabSepEmpty',
        \g:wintabs_powerline_higroup_active_tab,
        \g:wintabs_powerline_higroup_empty,
        \)
  call s:highlight(
        \'WintabsPowerlineTabSepEmpty',
        \g:wintabs_powerline_higroup_tab,
        \g:wintabs_powerline_higroup_empty,
        \)
endfunction

function! wintabs_powerline#buffer(bufnr, config)
  let label = wintabs#renderers#buf_label(a:bufnr)
  let highlight = a:config.is_active
        \? g:wintabs_powerline_higroup_active_buffer
        \: g:wintabs_powerline_higroup_buffer
  return { 'label': label, 'highlight': highlight }
endfunction

function! wintabs_powerline#buffer_sep(config)
  let label = g:wintabs_powerline_sep_buffer
  let highlight = g:wintabs_powerline_higroup_buffer

  if a:config.is_leftmost
    let label = ''
    let highlight = ''
  elseif a:config.is_active || a:config.is_rightmost
    let label = g:wintabs_powerline_sep_buffer_transition

    if a:config.is_active && a:config.is_left
      let highlight = 'WintabsPowerlineBufferSepActiveBuffer'
    elseif a:config.is_active && a:config.is_right && !a:config.is_rightmost
      let highlight = 'WintabsPowerlineActiveBufferSepBuffer'
    elseif a:config.is_active && a:config.is_rightmost
      let highlight = 'WintabsPowerlineActiveBufferSepEmpty'
    elseif !a:config.is_active && a:config.is_rightmost
      let highlight = 'WintabsPowerlineBufferSepEmpty'
    endif
  endif

  return { 'label': label, 'highlight': highlight }
endfunction

function! wintabs_powerline#tab(tabnr, config)
  let label = ' '.wintabs#renderers#tab_label(a:tabnr).' '
  let highlight = a:config.is_active
        \? g:wintabs_powerline_higroup_active_tab
        \: g:wintabs_powerline_higroup_tab
  return { 'label': label, 'highlight': highlight }
endfunction

function! wintabs_powerline#tab_sep(config)
  let label = g:wintabs_powerline_sep_tab
  let highlight = g:wintabs_powerline_higroup_tab

  if a:config.is_rightmost
    let label = ''
    let highlight = ''
  elseif a:config.is_active || a:config.is_leftmost
    let label = g:wintabs_powerline_sep_tab_transition

    if a:config.is_active && a:config.is_right
      let highlight = 'WintabsPowerlineTabSepActiveTab'
    elseif a:config.is_active && a:config.is_left && !a:config.is_leftmost
      let highlight = 'WintabsPowerlineActiveTabSepTab'
    elseif a:config.is_active && a:config.is_leftmost
      let highlight = 'WintabsPowerlineActiveTabSepEmpty'
    elseif !a:config.is_active && a:config.is_leftmost
      let highlight = 'WintabsPowerlineTabSepEmpty'
    endif
  endif

  return { 'label': label, 'highlight': highlight }
endfunction

function! wintabs_powerline#left_arrow()
  return {
        \'type': 'left_arrow',
        \'label': g:wintabs_powerline_arrow_left,
        \'highlight': g:wintabs_powerline_higroup_arrow
        \}
endfunction

function! wintabs_powerline#right_arrow()
  return {
        \'type': 'right_arrow',
        \'label': g:wintabs_powerline_arrow_right,
        \'highlight': g:wintabs_powerline_higroup_arrow
        \}
endfunction

function! wintabs_powerline#line_sep()
  return { 'type': 'sep', 'label': '  ', 'highlight': '' }
endfunction

function! s:highlight(higroup, fg_higroup, bg_higroup)
  let fg_color = s:get_bg(a:fg_higroup)
  let bg_color = s:get_bg(a:bg_higroup)
  let cmd = 'highlight! '.a:higroup
  for mode in ['gui', 'cterm']
    let cmd = cmd.' '.mode.'fg='.fg_color[mode]
    let cmd = cmd.' '.mode.'bg='.bg_color[mode]
  endfor
  execute cmd
endfunction

function! s:get_bg(higroup)
  let color = {}
  for mode in ['gui', 'cterm']
    let bg = synIDattr(synIDtrans(hlID(a:higroup)), 'bg', mode)
    let color[mode] = empty(bg) ? 'bg' : bg
  endfor
  return color
endfunction
