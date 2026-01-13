local ls  = require("luasnip")
local s   = ls.snippet
local i   = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmta

return {
    s({ trig = "tt", dscr = "texttt" }, fmt([[\texttt{<>}]], { i(1) })),
    s({ trig = "bf", dscr = "textbf" }, fmt([[\textbf{<>}]], { i(1) })),
    s({ trig = "it", dscr = "textit" }, fmt([[\textit{<>}]], { i(1) })),
    s({ trig = "qq", dscr = "enquote" }, fmt([[\enquote{<>}]], { i(1) })),

    s({ trig = "sec", dscr = "section" }, fmt([[\section{<>}]], { i(1) })),
    s({ trig = "sec*", dscr = "section*" }, fmt([[\section*{<>}]], { i(1) })),
    s({ trig = "ssec", dscr = "subsection" }, fmt([[\subsection{<>}]], { i(1) })),
    s({ trig = "ssec*", dscr = "subsection*" }, fmt([[\subsection*{<>}]], { i(1) })),

    s({ trig = "para", dscr = "paragraph" }, fmt([[\paragraph{<>}]], { i(1) })),


    s({ trig = "title", dscr = "frame title" }, fmt([[\frametitle{<>}]], { i(1) })),
}
