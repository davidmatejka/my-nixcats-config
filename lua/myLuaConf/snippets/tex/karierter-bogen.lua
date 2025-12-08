local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta
local helpers = require("myLuaConf.luasnip-helper-funcs")

return {
  s(
    { trig = "karierterBogen", dscr = "Karierter Klausurbogen" },
    fmta(
      [[

\documentclass[11pt, twoside]{article}

\usepackage{tabularx}
\usepackage{tikz}
\newcommand{\kariert}[2]{
    \begin{tikzpicture}
    \draw[step=0.5cm,color=gray] (0,0) grid (#1 cm ,#2 cm);
    \end{tikzpicture}
  }

\usepackage[left=2cm, right=2cm, top=2cm, bottom=2cm,
    bindingoffset=1cm]{geometry}

\begin{document}
\begin{tabularx}{0.9\textwidth} { 
   >>{\raggedright\arraybackslash}X 
   >>{\centering\arraybackslash}X 
   >>{\raggedleft\arraybackslash}X  }
  \textbf{Name:} & <> <>.KA & Klasse <> MT\\
 \hline \\
\end{tabularx}
\flushleft
\kariert{16}{22}

\newpage
\kariert{16}{23}

\newpage
\kariert{16}{23}

\newpage
\kariert{16}{23}
\end{document}

    ]],
      {
        i(1, "Mathe"),
        i(2, "1"),
        i(3, "10"),
      }
    )
  ),
}
