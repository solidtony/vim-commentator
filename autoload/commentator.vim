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

function! s:escape_for_regex(string)
    return escape(a:string, '^$.*?/\[]~')
endfunction

function! commentator#Comment()
    let [l, r] = s:get_split_cmnt_str()
    let col = getcurpos()[2] + len(l)
    exe "normal! I" .. l .. "A" .. r .. "" .. col  .. "|"
endfunction

function! commentator#Uncomment()
    let [l, r] = s:get_split_cmnt_str()
    let [_,cur_line, cur_col, _, _] = getcurpos()
    let line = getline(".")
    let reg_pattern = '^\(\s*\)\(' .. s:escape_for_regex(l) .. '\)\(.*\)\(' .. s:escape_for_regex(r) .. '\)\s*$'
    let new_line = substitute(line, reg_pattern, '\1\3', '')
    call setline(cur_line, new_line)
    call cursor(cur_line, cur_col-len(l))
endfunction

