local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
	s({ trig = "tt", dscr = "Expands 'tt' into '\texttt{}'" }, fmta("\\texttt{<>}", { i(1) })),
	-- Equation
	s(
		{ trig = "eq", dscr = "Expands 'eq' into an equation environment" },
		fmta(
			[[
       \begin{equation*}
           <>
       \end{equation*}
     ]],
			{ i(1) }
		)
	),
}
