local ls = require("luasnip")
local s = ls.snippet
local fmta = require("luasnip.extras.fmt").fmta

return {
  s(
    { trig = "pgf", dscr = "standalone pgf plot example" },
    fmta(
      [[
\documentclass[tikz,border=1pt]{standalone} 
\usepackage{pgfplots}
\pgfplotsset{compat=1.18}

\begin{document}

\begin{tikzpicture}
	\begin{axis}[
			axis lines=middle,
			axis line style={thick},
			xmin=0,xmax=10,ymin=0,ymax=120,
			xtick distance=1,
			ytick distance=10,
			xlabel near ticks,
			ylabel near ticks,
			xlabel=$Spielrunde$,
			ylabel=$Punktestand$,
			grid=both, minor tick num = 4,
			major grid style={thick, color=gray},
			minor grid style = {color=gray}
		]
	\end{axis}
\end{tikzpicture}
\end{document}
     ]],
      {}
    )
  ),
}
