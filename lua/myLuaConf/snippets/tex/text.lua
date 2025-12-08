local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local helpers = require("myLuaConf.luasnip-helper-funcs")
local get_visual = helpers.get_visual
local c = ls.choice_node
local t = ls.text_node
local f = ls.function_node

return {
  s(
    "coiceTest",
    c(1, {
      t("Ugh boring, a text node"),
      i(nil, "At least I can edit something now..."),
      f(function(args)
        return "Still only counts as text!!"
      end, {}),
    })
  ),
  s(
    { trig = "hr", dscr = "The hyperref package's href{}{} command (for url links)" },
    fmta([[\href{<>}{<>}]], {
      i(1, "url"),
      i(2, "display name"),
    })
  ),
  s(
    { trig = "ii", dscr = "Expands 'tii' into LaTeX's textit{} command." },
    fmta("\\textit{<>}", {
      d(1, get_visual),
    })
  ),
  s(
    { trig = "bf", dscr = "Expands 'tbf' into LaTeX's textbf{} command." },
    fmta("\\textbf{<>}", {
      d(1, get_visual),
    })
  ),
}
