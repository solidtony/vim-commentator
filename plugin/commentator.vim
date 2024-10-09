" Title:        commentator Plugin
" Description:  A plugin to provide an example for creating Vim plugins.
" Last Change:  9 October 2024
" Maintainer:   Anthony Garcia <https://github.com/example-user>

" Prevents the plugin from being loaded multiple times. If the loaded
" variable exists, do nothing more. Otherwise, assign the loaded
" variable and continue running this instance of the plugin.
if exists("g:loaded_commentator")
    finish
endif
let g:loaded_commentator = 1

" Exposes the plugin's functions for use as commands in Vim.
nmap <leader>c :call commentator#Comment()<CR>
nmap <leader>u :call commentator#Uncomment()<CR>

