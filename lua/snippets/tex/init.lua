local M = {}

local function extend(tbl)
  for _, v in ipairs(tbl) do table.insert(M, v) end
end

extend(require("snippets.tex.commands"))
extend(require("snippets.tex.envs"))
extend(require("snippets.tex.math"))
extend(require("snippets.tex.math-commands"))
extend(require("snippets.tex.beamer"))

return M
