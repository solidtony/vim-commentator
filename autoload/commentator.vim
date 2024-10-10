function! s:strip(string)
    let new_string = substitute(a:string, '^\s*\(.\{-}\)\s*$', '\1', '')
    return new_string
endfunction

function! s:get_split_cmnt_str()
    let surrounding = split(&commentstring, '%s')
    let [l, r] = ["",""]
    if len(surrounding) > 0
        let l = surrounding[0]
    endif
    if len(surrounding) > 1
        let r = surrounding[1]
    endif
    return [l, r]
endfunction

function! s:surround(l, r, string)
    return a:l .. a:string .. a:r
endfunction

function! commentator#Comment()
    let [left_cmnt_str, right_cmnt_str] = s:get_split_cmnt_str()
    let col = getcurpos()[2]
    exe "normal! I" .. left_cmnt_str .. "A" .. right_cmnt_str .. "" .. col  .. "|"
endfunction

function! commentator#Uncomment()
    let [left_cmnt_str, right_cmnt_str] = s:get_split_cmnt_str()
    let [_,cur_line, cur_col, _, _] = getcurpos()
    let line = getline(".")
    let reg_pattern = '^\(\s*\)\(' .. left_cmnt_str .. '\)\(.*\)\(' .. right_cmnt_str .. '\)\s*$'
    let new_line = substitute(line, reg_pattern, '\1\3', '')
    call setline(cur_line, new_line)
endfunction

