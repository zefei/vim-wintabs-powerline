# vim-wintabs-powerline
Powerline fonts renderers for [wintabs](https://github.com/zefei/vim-wintabs).

# Screenshots

![image](https://raw.githubusercontent.com/zefei/vim-wintabs-powerline/master/screenshots/screenshot1.png)

# Installation

Use your favorite package manager to install:

* [Pathogen](https://github.com/tpope/vim-pathogen)
  * `git clone https://github.com/zefei/vim-wintabs-powerline ~/.vim/bundle/vim-wintabs-powerline`
* [Vundle](https://github.com/gmarik/Vundle.vim)
  * `Plugin 'zefei/vim-wintabs-powerline'`
* [NeoBundle](https://github.com/Shougo/neobundle.vim)
  * `NeoBundle 'zefei/vim-wintabs-powerline'`

# Configuration

- `let g:wintabs_powerline_arrow_left = " \u25c0 "`

  Left pointing arrow, used as previous buffers indicator.

- `let g:wintabs_powerline_arrow_right = " \u25b6 "`

  Right pointing arrow, used as next buffers indicator.

- `let g:wintabs_powerline_sep_buffer_transition, "\ue0b0"`

  Separator between inactive and active buffers.

- `let g:wintabs_powerline_sep_buffer = "\ue0b1"`

  Separator between inactive buffers.

- `let g:wintabs_powerline_sep_tab_transition = "\ue0b2"`

  Separator between inactive and active vimtabs.

- `let g:wintabs_powerline_sep_tab = "\ue0b3"`

  Separator between inactive vimtabs.

- `let g:wintabs_powerline_higroup_empty = 'TabLineFill'`

  Highlight group for tabline background.

- `let g:wintabs_powerline_higroup_buffer = 'TabLine'`

  Highlight group for inactive buffer.

- `let g:wintabs_powerline_higroup_active_buffer = 'TabLineSel'`

  Highlight group for active buffer.

- `let g:wintabs_powerline_higroup_tab = 'TabLine'`

  Highlight group for inactive vimtab.

- `let g:wintabs_powerline_higroup_active_tab = 'TabLineSel'`

  Highlight group for active vimtab.

- `let g:wintabs_powerline_higroup_arrow = 'TabLine'`

  Highlight group for arrows.

# License

MIT License.
