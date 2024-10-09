function! s:get_split_cmnt_str()
    let surrounding = split(&commentstring, '%s')
    if len(surrounding) == 0
        let surrounding = ["", ""]
    endif
    if len(surrounding) == 1
        let surrounding = surrounding + [""]
    endif
    return surrounding
endfunction

function! s:surround(l, r, string)
    return a:l .. a:string .. a:r
endfunction

function! Comment()
    let [left_cmnt_str, right_cmnt_str] = s:get_split_cmnt_str()
    let col = getcurpos()[2]
    exe "normal! _i" .. left_cmnt_str .. "A" .. right_cmnt_str .. "" .. col  .. "|"
endfunction

function! Uncomment()
    let [left_cmnt_str, right_cmnt_str] = s:get_split_cmnt_str()
    let cur_col = getcurpos()[2]
    exe "normal! _"
    line = getline()
    let line = getline(".")
    let pattern = left_cmnt_str .. ".*" .. right_cmnt_str
    echo pattern
    
    "substitute(line, left_cmnt_str .. ".*" .. right_cmnt_str, "")
    "setline(line)
    "echo line
endfunction

nmap <leader>c :call Comment()<CR>
nmap <leader>u :call Uncomment()<CR>

