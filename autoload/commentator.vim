function! s:strip(string)
    let new_string = substitute(a:string, '^\s*\(.\{-}\)\s*$', '\1', '')
    return new_string
endfunction

function! s:get_split_cmnt_str()
    let surrounding = split(&commentstring, '%s')
    let [l, r] = ["",""]
    if len(surrounding) == 1
        let l = s:strip(surrounding[0])
    endif
    if len(surrounding) == 2
        let r = s:strip(surrounding[1])
    endif
    return [l, r]
endfunction

function! s:surround(l, r, string)
    return a:l .. a:string .. a:r
endfunction

function! commentator#Comment()
    let [left_cmnt_str, right_cmnt_str] = s:get_split_cmnt_str()
    let col = getcurpos()[2]
    exe "normal! 0i" .. left_cmnt_str .. "A" .. right_cmnt_str .. "" .. col  .. "|"
endfunction

function! commentator#Uncomment()
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

