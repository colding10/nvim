local ls  = require("luasnip")
local s   = ls.snippet
local i   = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmta

return {
    s({ trig = "block", dscr = "regular beamer block" }, fmt([[
    \begin{block}{<>}
        <>
    \end{block}
    ]], { i(1, "Block title"), i(2) })),
    s({ trig = "example", dscr = "example beamer block" }, fmt([[
    \begin{exampleblock}{<>}
        <>
    \end{exampleblock}
    ]], { i(1, "Block title"), i(2) })),
    s({ trig = "conclusion", dscr = "conclusion beamer block" }, fmt([[
    \begin{alertblock}{<>}
        <>
    \end{alertblock}
    ]], { i(1, "Block title"), i(2) })),
}
