-- Abbreviations used in this article and the LuaSnip docs
local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmta = require("luasnip.extras.fmt").fmta
local helpers = require("myLuaConf.luasnip-helper-funcs")
local get_visual = helpers.get_visual
local tex = helpers.get_tex_utils()
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {
  s(
    { trig = "([^%a])ff", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta([[<>\frac{<>}{<>}]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
    }),
    { condition = tex.in_mathzone() }
  ),

  s(
    { trig = "([^%a])ee", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta("<>e^{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = tex.in_mathzone() }
  ),

  -- starting math mode with "mm"
  s(
    { trig = "([^%a])mm", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>$<>$ <>", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
      i(2),
    })
  ),
  -- also trigger at the start of a line
  s(
    { trig = "mm", snippetType = "autosnippet" },
    fmta("<>$<>$ ", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      d(1, get_visual),
    }),
    { condition = line_begin }
  ),
  -- s(
  --   { trig = "pp", snippetType = "autosnippet" },
  --   fmta("<>(<>|<>|<>)", {
  --     i(1),
  --     i(2),
  --     i(3),
  --     i(4),
  --   }),
  --   { condition = tex.in_mathzone() }
  -- ),
  s(
    { trig = "([^%a])pp", wordTrig = false, regTrig = true, snippetType = "autosnippet" },
    fmta("<>$<>(<>|<>|<>)$", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
      i(3),
      i(4),
    })
  ),
  s(
    { trig = "([^%a])pmt", regTrig = true, wordTrig = false, snippetType = "autosnippet" },
    fmta([[<>\begin{pmatrix} <> \\ <> \\ <> \end{pmatrix}]], {
      f(function(_, snip)
        return snip.captures[1]
      end),
      i(1),
      i(2),
      i(3),
    }),
    { condition = tex.in_mathzone() }
  ),
}
