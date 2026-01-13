local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local c = ls.choice_node
local fmt = require("luasnip.extras.fmt").fmta

-- autosnippet decorator
local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })

-- Check if cursor is in Typst math zone using treesitter
local in_math = function()
    local ok, ts_utils = pcall(require, "nvim-treesitter.ts_utils")
    if not ok then return false end

    local node = ts_utils.get_node_at_cursor()
    while node do
        local node_type = node:type()
        if node_type == "math" or node_type == "equation" then
            return true
        end
        node = node:parent()
    end
    return false
end

local M = {}

-- ---------- simple autosuperscripts ----------
local supers = {
    { trig = "sr",    text = "^2" },
    { trig = "cb",    text = "^3" },
    { trig = "compl", text = "^(c)" },
    { trig = "vtr",   text = "^(T)" },
    { trig = "inv",   text = "^(-1)" },
}
for _, sdef in ipairs(supers) do
    table.insert(M, autosnippet(
        { trig = sdef.trig, wordTrig = false },
        { t(sdef.text) },
        { condition = in_math, show_condition = in_math }
    ))
end

-- ---------- fractions ----------
table.insert(M, autosnippet(
    { trig = "//", name = "fraction", dscr = "fraction" },
    fmt("frac(<>, <>)<>", { i(1), i(2), i(0) }, { delimiters = "<>" }),
    { condition = in_math, show_condition = in_math }
))

-- ---------- limits / sums / products ----------
table.insert(M, autosnippet(
    { trig = "lim", name = "limit", dscr = "Limit" },
    fmt("lim_(<> ->> <>)<>", { i(1, "n"), i(2, "infinity"), i(0) }, { delimiters = "<>" }),
    { condition = in_math, show_condition = in_math }
))

table.insert(M, autosnippet(
    { trig = "sum", dscr = "summation" },
    fmt("sum<> <>", {
        c(1, {
            fmt("_(<>)^(<>)", { i(1, "k = 0"), i(2, "n") }),
            t("")
        }),
        i(0)
    }),
    { condition = in_math, show_condition = in_math }
))

table.insert(M, autosnippet(
    { trig = "prod", dscr = "product" },
    fmt("product<> <>", {
        c(1, {
            fmt("_(<>)^(<>)", { i(1, "i = 0"), i(2, "infinity") }),
            t("")
        }),
        i(0)
    }),
    { condition = in_math, show_condition = in_math }
))

-- ---------- set builder and binomial ----------
table.insert(M, autosnippet(
    { trig = "set", dscr = "set builder" },
    fmt("{<>}<>", {
        c(1, {
            i(1),
            fmt("<> | <>", { i(1), i(2) }),
            fmt("<> : <>", { i(1), i(2) })
        }),
        i(0)
    }),
    { condition = in_math, show_condition = in_math }
))

table.insert(M, autosnippet(
    { trig = "choose", dscr = "binomial" },
    fmt("binom(<>, <>)<>", { i(1), i(2), i(0) }),
    { condition = in_math, show_condition = in_math }
))

-- ---------- partial derivative ----------
table.insert(M, autosnippet(
    { trig = "pd", dscr = "partial derivative" },
    fmt("(diff <>)/(diff <>)<>", { i(1), i(2), i(0) }),
    { condition = in_math, show_condition = in_math }
))

-- ---------- common symbol mappings (Typst native) ----------
local symbols = {
    ["!="]  = "eq.not",
    ["<="]  = "lt.eq",
    [">="]  = "gt.eq",
    ["<<"]  = "lt.lt",
    [">>"]  = "gt.gt",
    ["~~"]  = "tilde.op",
    ["~="]  = "approx",
    ["-="]  = "equiv",
    [":="]  = "colon.eq",
    ["**"]  = "dot.op",
    ["..."] = "dots",
    ["xx"]  = "times",
    ["NN"]  = "NN",
    ["ZZ"]  = "ZZ",
    ["QQ"]  = "QQ",
    ["RR"]  = "RR",
    ["CC"]  = "CC",
    ["OO"]  = "emptyset",
    ["AA"]  = "forall",
    ["EE"]  = "exists",
    ["inn"] = "in",
    ["->"]  = "=>",
    ["-->"] = "-->",
    ["<->"] = "<==>",
    ["ooo"] = "infinity",
    ["lll"] = "ell",
    ["+-"]  = "plus.minus",
    ["-+"]  = "minus.plus",
}
for trig, sym in pairs(symbols) do
    table.insert(M, autosnippet(
        { trig = trig, wordTrig = false },
        { t(sym) },
        { condition = in_math, show_condition = in_math }
    ))
end

return M
