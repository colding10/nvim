local ls = require("luasnip")
local s  = ls.snippet
local t  = ls.text_node
local i  = ls.insert_node
local c  = ls.choice_node
local d  = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmta

-- autosnippet decorator (keeps snippetType out of trigger table)
local autosnippet = ls.extend_decorator.apply(s, { snippetType = "autosnippet" })

-- safe math-zone check (works even if vimtex not installed)
local in_math = function()
  if vim.fn.exists("*vimtex#syntax#in_mathzone") == 1 then
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
  end
  return false
end

local M = {}

-- ---------- simple autosuperscripts ----------
local supers = {
  { trig = "sr", text = "^2"  },
  { trig = "cb", text = "^3"  },
  { trig = "compl", text = "^{c}" },
  { trig = "vtr", text = "^{T}" },
  { trig = "inv", text = "^{-1}" },
}
for _, sdef in ipairs(supers) do
  table.insert(M, autosnippet({ trig = sdef.trig, wordTrig = false }, { t(sdef.text) }, { condition = in_math, show_condition = in_math }))
end

-- EPSILON DELTA FOR SEQUENCE
table.insert(M, autosnippet(
  { trig = "nig", name = "Sequence Limit Definition", dscr = "Formal definition of limit of a sequence" },
  fmt([[
    \forall\, \varepsilon >> 0,\; \exists\, N >> 0,\; \forall\, n,\; n >> N \implies \left|<> - <>\right| << \varepsilon
  ]], {
    i(1, "a_n"),
    i(2, "L"),
  }),
  { condition = in_math, show_condition = in_math }
))
-- ---------- fractions ----------
-- simple '//' -> \frac{<1>}{<2>}
table.insert(M, autosnippet({ trig = "//", name = "fraction", dscr = "fraction" },
  fmt("\\frac{<>}{<>}<>", { i(1), i(2), i(0) }, { delimiters = "<>" }),
  { condition = in_math, show_condition = in_math }
))

-- ---------- limits / sums / products ----------
table.insert(M, autosnippet(
  { trig = "lim", name = "lim", dscr = "Limit n to infinity" },
  fmt("\\lim_{<> \\to <>} <>", {
    i(1, "n"),
    i(2, "\\infty"),
    i(0)
  }, { delimiters = "<>" }),
  { condition = in_math, show_condition = in_math }
))
table.insert(M, autosnippet({ trig = "sum", dscr = "summation" },
  fmt("\\sum<> <>", { c(1, { fmt("_{<>}^{<>}", { i(1, "k = 0"), i(2, "n") }), t("") }), i(0) }),
  { condition = in_math, show_condition = in_math }
))

table.insert(M, autosnippet({ trig = "prod", dscr = "product" },
  fmt("\\prod<> <>", { c(1, { fmt("_{<>}^{<>}", { i(1, "i = 0"), i(2, "\\infty") }), t("") }), i(0) }),
  { condition = in_math, show_condition = in_math }
))

-- ---------- set builder and binomial ----------
table.insert(M, autosnippet({ trig = "set", dscr = "set builder" },
  fmt("\\left\\{<>\\right\\}<>", {
    c(1, {
      i(1), -- simple: { X }
      fmt("{<> \\mid <>}", { i(1), i(2) }), -- { X \mid ... }
      fmt("{<> \\colon <>}", { i(1), i(2) }) -- { X \colon ... }
    }),
    i(0)
  }),
  { condition = in_math, show_condition = in_math }
))

table.insert(M, autosnippet({ trig = "choose", dscr = "binomial" },
  fmt("\\binom{<>}{<>}<>", { i(1), i(2), i(0) }),
  { condition = in_math, show_condition = in_math }
))

-- ---------- partial derivative ----------
table.insert(M, autosnippet({ trig = "pd", dscr = "partial derivative" },
  fmt("\\frac{\\partial <>}{\\partial <>}<>", { i(1), i(2), i(0) }),
  { condition = in_math, show_condition = in_math }
))

-- ---------- auto-backslash commands (sin, cos, log, ...) ----------
local auto_backslash = {
  "sin","cos","tan","arcsin","arccos","arctan","cot","csc","sec",
  "log","ln","exp","det","max","min","argmax","argmin","deg","angle",
}
for _, name in ipairs(auto_backslash) do
  -- e.g. typing "sin" in math becomes "\sin{}" with cursor inside braces
  table.insert(M, autosnippet({ trig = name, wordTrig = false }, fmt("\\"..name.."{<>}", { i(1) }), { condition = in_math, show_condition = in_math }))
end

-- ---------- greek symbols ----------
local greek = {
  alpha="\\alpha", beta="\\beta", gam="\\gamma", Gam="\\Gamma",
  delta="\\delta", DD="\\Delta", eps="\\varepsilon",
  zeta="\\zeta", theta="\\theta", Theta="\\Theta",
  iota="\\iota", kappa="\\kappa", lmbd="\\lambda", Lmbd="\\Lambda",
  mu="\\mu", nu="\\nu", pi="\\pi", rho="\\rho",
  sig="\\sigma", Sig="\\Sigma", tau="\\tau", ups="\\upsilon",
  phi="\\phi", vphi="\\varphi", chi="\\chi", psi="\\psi",
  omega="\\omega", Omega="\\Omega",
}
for trig, cmd in pairs(greek) do
  table.insert(M, autosnippet({ trig = trig, wordTrig = false }, { t(cmd) }, { condition = in_math, show_condition = in_math }))
end

-- ---------- common symbol mappings (simple commands) ----------
local symbols = {
  ["!="] = "\\neq", ["<="] = "\\leq", [">="] = "\\geq",
  ["<<"] = "\\ll", [">>"] = "\\gg", ["~~"] = "\\sim", ["~="] = "\\approx",
  ["-="] = "\\equiv", [":="] = "\\coloneqq", ["**"] = "\\cdot", ["..."] = "\\dots",
  ["xx"] = "\\times", ["NN"] = "\\mathbb{N}", ["ZZ"] = "\\mathbb{Z}",
  ["QQ"] = "\\mathbb{Q}", ["RR"] = "\\mathbb{R}", ["CC"] = "\\mathbb{C}",
  ["OO"] = "\\emptyset", ["::"] = "\\colon", ["AA"] = "\\forall", ["EE"] = "\\exists",
  ["inn"] = "\\in", ["!W"] = "\\bigwedge", ["->"] = "\\implies",
  ["-->"] = "\\longrightarrow", ["<->"] = "\\iff", ["ooo"] = "\\infty",
  ["lll"] = "\\ell", ["dag"] = "\\dagger", ["+-"] = "\\pm", ["-+"] = "\\mp",
}
for trig, cmd in pairs(symbols) do
  table.insert(M, autosnippet({ trig = trig, wordTrig = false }, { t(cmd) }, { condition = in_math, show_condition = in_math }))
end

-- ---------- single-command snippets (wrap argument) ----------
-- e.g. trigger 'tt' -> \text{<here>}
local single_cmd = {
  tt = "\\text", sbf = "\\symbf", syi = "\\symit", udd = "\\underline",
  conj = "\\overline", sbt = "\\substack"
}
for trig, cmd in pairs(single_cmd) do
  table.insert(M, autosnippet({ trig = trig, wordTrig = false }, fmt(cmd.."{<>}", { i(1) }), { condition = in_math, show_condition = in_math }))
end

-- return table of snippets
return M
