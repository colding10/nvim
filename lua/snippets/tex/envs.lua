local ls  = require("luasnip")
local s   = ls.snippet
local rep = require("luasnip.extras").rep
local i   = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmta

return {
    s({ trig = "beg", dscr = "begin environment" }, fmt([[
    \begin{<>}
        <>
    \end{<>}
    ]], { i(1), i(0), rep(1) })),

    s({ trig = "frame", dscr = "frame environment" }, fmt([[
    \begin{frame}
        <>
    \end{frame}
    ]], { i(1) })),

    s({ trig = "-i", dscr = "itemize environment" }, fmt([[
    \begin{itemize}
        \item <>
    \end{itemize}
    ]], { i(1) })),

    s({ trig = "-e", dscr = "enumerate environment" }, fmt([[
    \begin{enumerate}
        \item <>
    \end{enumerate}
    ]], { i(1) }))
}
