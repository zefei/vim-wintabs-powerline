function! wintabs_powerline#init()
  let g:wintabs_renderers = {
        \'buffer': function('wintabs_powerline#buffer'),
        \'buffer_sep': function('wintabs_powerline#buffer_sep'),
        \'tab': function('wintabs_powerline#tab'),
        \'tab_sep': function('wintabs_powerline#tab_sep'),
        \'left_arrow': function('wintabs_powerline#left_arrow'),
        \'right_arrow': function('wintabs_powerline#right_arrow'),
        \'line_sep': function('wintabs_powerline#line_sep'),
        \'padding': function('wintabs_powerline#padding'),
        \}

  augroup wintabs_powerline_on_colorscheme
    autocmd!
    autocmd ColorScheme,VimEnter * call wintabs_powerline#on_colorscheme()
  augroup END
endfunction

function! wintabs_powerline#on_colorscheme()
  let s:sep_is_transitional = {}
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
  if a:config.is_leftmost
    return { 'label': '', 'highlight': '' }
  endif

  let highlight = g:wintabs_powerline_higroup_buffer
  if a:config.is_active && a:config.is_left
    let highlight = 'WintabsPowerlineBufferSepActiveBuffer'
  elseif a:config.is_active && a:config.is_right && !a:config.is_rightmost
    let highlight = 'WintabsPowerlineActiveBufferSepBuffer'
  elseif a:config.is_active && a:config.is_rightmost
    let highlight = 'WintabsPowerlineActiveBufferSepEmpty'
  elseif !a:config.is_active && a:config.is_rightmost
    let highlight = 'WintabsPowerlineBufferSepEmpty'
  endif

  let is_transitional = has_key(s:sep_is_transitional, highlight)
        \? s:sep_is_transitional[highlight]
        \: 0
  let label = is_transitional
        \? g:wintabs_powerline_sep_buffer_transition
        \: g:wintabs_powerline_sep_buffer
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
  if a:config.is_rightmost
    return { 'label': '', 'highlight': '' }
  endif

  let highlight = g:wintabs_powerline_higroup_tab
  if a:config.is_active && a:config.is_right
    let highlight = 'WintabsPowerlineTabSepActiveTab'
  elseif a:config.is_active && a:config.is_left && !a:config.is_leftmost
    let highlight = 'WintabsPowerlineActiveTabSepTab'
  elseif a:config.is_active && a:config.is_leftmost
    let highlight = 'WintabsPowerlineActiveTabSepEmpty'
  elseif !a:config.is_active && a:config.is_leftmost
    let highlight = 'WintabsPowerlineTabSepEmpty'
  endif

  let is_transitional = has_key(s:sep_is_transitional, highlight)
        \? s:sep_is_transitional[highlight]
        \: 0
  let label = is_transitional
        \? g:wintabs_powerline_sep_tab_transition
        \: g:wintabs_powerline_sep_tab
  return { 'label': label, 'highlight': highlight }
endfunction

function! wintabs_powerline#left_arrow()
  return {
        \'type': 'left_arrow',
        \'label': g:wintabs_powerline_arrow_left,
        \'highlight': g:wintabs_powerline_higroup_arrow,
        \}
endfunction

function! wintabs_powerline#right_arrow()
  return {
        \'type': 'right_arrow',
        \'label': g:wintabs_powerline_arrow_right,
        \'highlight': g:wintabs_powerline_higroup_arrow,
        \}
endfunction

function! wintabs_powerline#line_sep()
  return {
        \'type': 'sep',
        \'label': '  ',
        \'highlight': g:wintabs_powerline_higroup_empty,
        \}
endfunction

function! wintabs_powerline#padding(len)
  return {
        \'type': 'sep',
        \'label': repeat(' ', a:len),
        \'highlight': g:wintabs_powerline_higroup_empty,
        \}
endfunction

function! s:highlight(higroup, fg_higroup, bg_higroup)
  let fg_color = s:get_color(a:fg_higroup, 'bg')
  let bg_color = s:get_color(a:bg_higroup, 'bg')
  let is_transitional = fg_color != bg_color
  if !is_transitional
    let fg_color = s:get_color(a:fg_higroup, 'fg')
  endif
  let s:sep_is_transitional[a:higroup] = is_transitional

  let cmd = 'highlight! '.a:higroup
  for mode in ['gui', 'cterm']
    let cmd = cmd.' '.mode.'fg='.fg_color[mode]
    let cmd = cmd.' '.mode.'bg='.bg_color[mode]
  endfor
  execute cmd
endfunction

function! s:get_color(higroup, type)
  let color = {}
  for mode in ['gui', 'cterm']
    let value = synIDattr(synIDtrans(hlID(a:higroup)), a:type, mode)
    let color[mode] = empty(value) ? a:type : value
  endfor
  return color
endfunction
