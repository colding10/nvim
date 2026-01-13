local ls      = require("luasnip")
local s       = ls.snippet
local i       = ls.insert_node
local fmt     = require("luasnip.extras.fmt").fmta

local in_math = function()
    if vim.fn.exists("*vimtex#syntax#in_mathzone") == 1 then
        return vim.fn['vimtex#syntax#in_mathzone']() == 1
    end
    return false
end

return {
    s({ trig = "ali", dscr = "align environment" }, fmt([[
    \begin{align*}
        <>
    \end{align*}
    ]], { i(1) })
    ),

    s({ trig = "soln", dscr = "solution environment" }, fmt([[
    \begin{soln}
        <>
    \end{soln}
    ]], { i(1) })
    ),

    s({ trig = "thm", dscr = "theorem environment" }, fmt([[
    \begin{theorem*}[<>]
        <>
    \end{theorem*}
    ]], { i(1, "Unnamed Theorem"), i(2) })
    ),
    s({ trig = "proof", dscr = "proof environment" }, fmt([[
    \begin{proof}
        <>
    \end{proof}
    ]], { i(1) })
    ),
    s({ trig = "prob", dscr = "problem* environment" }, fmt([[
    \begin{problem*}
        <>
    \end{problem*}
    ]], { i(1) })
    ),
    s({ trig = "exer", dscr = "problem* environment with exercise" }, fmt([[
    \begin{problem*}[Exercise <>]
        <>
    \end{problem*}
    ]], { i(1, "Unnumbered"), i(2) })
    ),
    s({ trig = "prob*", dscr = "problem environment" }, fmt([[
    \begin{problem}
        <>
    \end{problem}
    ]], { i(1) })
    ),
    s({ trig = "sqrt", dscr = "square root" }, fmt([[
    \sqrt{<>}
    ]], { i(1) }), { show_condition = in_math }
    ),

    s({ trig = "nrt", dscr = "nth root" }, fmt([[
    \sqrt[<>]{<>}
    ]], { i(1, "n"), i(2) }), { show_condition = in_math }
    ),
}
