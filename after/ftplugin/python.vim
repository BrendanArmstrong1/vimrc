set include=^\\s*\\(from\\\|import\\)\\s*\\zs\\(\\S\\+\\s\\{-}\\)*\\ze\\($\\\|\ as\\)
"from http.server import HTTPServer, BaseHTTPRequestHandler (2)
"http/server/HTTPServer.py http/server.py
"import cgi (1)
"cgi.py
function! PyInclude(fname)
    let parts = split(a:fname, ' import ')
    let l = parts[0]
    if len(parts) > 1
        let r = parts[1]
        let items = split(r, ", ")
        for item in items
            echom item
        endfor
        let joined = join([l,r], '.')
        let fp = substitute(joined, '\.', '/', 'g') . '.py'
        let found = glob(fp, 1)
        if len(found)
            return found
        endif
    endif
    let fp = substitute(l, '\.', '/', 'g') . '.py'
    echom fp
    return fp
endfunction

setlocal includeexpr=PyInclude(v:fname)
