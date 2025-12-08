local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local extras = require("luasnip.extras")
local fmta = require("luasnip.extras.fmt").fmta

return {
  s(
    { trig = "abc", dscr = "Expands 'eq' into an equation environment" },
    fmta(
      [[
       \begin{enumerate}[label=\alph*)]
           \item <>
       \end{enumerate}
     ]],
      { i(1) }
    )
  ),
  s(
    { trig = "aufg", dscr = "Aufgabenvorlage für Klausuren" },
    fmta(
      [[
        \begin{luacode}
          punkte = "<>"
        \end{luacode}
        \section*{Aufgabe \directlua{tex.print(getNr(\the\inputlineno))} \directlua{printPunkte(punkte)} }
        <>
      ]],
      { i(1, "2.5+4.5"), i(2) }
    )
  ),
  s(
    { trig = "kar", dscr = "Zeichne einen karierten Bereich mit Tikz" },
    fmta(
      [[
        \kariert{<>}{<>}
     ]],
      { i(1, "16"), i(2) }
    )
  ),
  s(
    { trig = "klausur", dscr = "Vorlage für Klausuren und Klassenarbeiten" },
    fmta(
      [[%!Tex Program = lualatex
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Define Article %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\documentclass[11pt, twoside]{article}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Using Packages %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\usepackage[german]{babel}
\usepackage[
    left = \glqq{},% 
    right = \grqq{},% 
    leftsub = \glq{},% 
    rightsub = \grq{} %
]{dirtytalk}
\usepackage{luacode}
\usepackage{amsmath}
\usepackage{amssymb}
\usepackage{textcomp}
\usepackage{enumitem}
\usepackage{xcolor}
\usepackage{colortbl}
\usepackage{tabularx}
\usepackage{subcaption}
\usepackage{graphicx}
\usepackage{float}
\usepackage{listings}
\usepackage{tikz}
\newcommand{\kariert}[2]{
    \begin{tikzpicture}
    \draw[step=0.5cm,color=gray] (0,0) grid (#1 cm ,#2 cm);
    \end{tikzpicture}
  }
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%% Change section sizes %%%%%%%%%%%%%%%%%%%%%%%%%%
\usepackage{titlesec}
\titleformat*{\section}{\large\bfseries}
\titleformat*{\subsection}{\normalsize\bfseries}
\titleformat*{\subsubsection}{\normalsize\bfseries}
\titleformat*{\paragraph}{\normalsize\bfseries}
\titleformat*{\subparagraph}{\normalsize\bfseries}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%% Page Setting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\usepackage[left=2cm, right=2cm, top=2cm, bottom=2cm]{geometry}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%% Define some useful colors %%%%%%%%%%%%%%%%%%%%%%%%%%
\definecolor{ocre}{RGB}{243,102,25}
\definecolor{mygray}{RGB}{243,243,244}
\definecolor{deepGreen}{RGB}{26,111,0}
\definecolor{shallowGreen}{RGB}{235,255,255}
\definecolor{deepBlue}{RGB}{61,124,222}
\definecolor{shallowBlue}{RGB}{235,249,255}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%% Define an orangebox command %%%%%%%%%%%%%%%%%%%%%%%%
\newcommand\orangebox[1]{\fcolorbox{ocre}{mygray}{\hspace{1em}#1\hspace{1em}}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%% Coding Listing Umgebung %%%%%%%%%%%%%%%%%%%%%%%%%%%%
\definecolor{dkgreen}{rgb}{0,0.6,0}
\definecolor{gray}{rgb}{0.5,0.5,0.5}
\definecolor{mauve}{rgb}{0.58,0,0.82}

\lstset{frame=tb,
  language=Java,
  aboveskip=3mm,
  belowskip=3mm,
  showstringspaces=false,
  columns=flexible,
  basicstyle={\small\ttfamily},
  numberstyle=\tiny\color{codegray},
  numberstyle=\tiny\color{gray},
  keywordstyle=\color{blue},
  commentstyle=\color{dkgreen},
  stringstyle=\color{mauve},
  breaklines=true,
  breakatwhitespace=true,
  tabsize=3,
  numbers = left
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%Punkte der Aufgaben %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\begin{luacode}
  local function toint(n)
    local s = tostring(n)
    local i = s:find("%.")
    if i then
      return tonumber(s:sub(1, i - 1))
    else
      return n
    end
  end

function toGerman(zahl)
	local dot = string.find(zahl, "%.")
	if dot == nil then
		return zahl
	end
	local prefix = string.sub(zahl, 1, dot - 1)
	local rest = string.sub(zahl, dot + 1)
	if tonumber(rest) == 0 then
		return prefix
	end
	local num, _ = string.gsub(zahl, "%.", ",")
	return num
end

function expr_to_number(expr)
	local function rec(ex)
		local plus = string.find(ex, "+")
		if plus == nil then
			return ex
		end
		local prefix = string.sub(ex, 1, plus - 1)
		local sum = prefix
		local rest = string.sub(ex, plus + 1)
		sum = sum + rec(rest)
		return sum
	end

	local sum = rec(expr)
	-- return toGerman(sum)
  return sum
end

function print_equals() 
  return " = "
end

function summe()
  local sum = 0
  dateiname = \luastring{\jobname}..".tex"
  for line in io.lines(dateiname) do
		local _, _, expr = string.find(line, "%s+punkte%s-=%s*(.*)")
    if expr ~= nil then 
			sum = sum + expr_to_number(string.sub(expr, 2, string.len(expr) - 1))
    end
  end
  return toGerman(sum)
end

function printPunkte(expr)
  if string.find(expr, "+") then
    local sum = expr_to_number(expr)
    return tex.print("(" .. toGerman(expr) .. " = " .. toGerman(sum) .." Punkte)")
  end

  return tex.print("(" .. expr .. " Punkte)")
end

function getNr(targetLineNo) 
  local dateiname = \luastring{\jobname}..".tex"
  local nr = 1
  local lineCounter = 1
  for line in io.lines(dateiname) do 
    local i, _ = string.find(line, "section%*")
    local k, _ = string.find(line, "subsection%*")
    if (i ~= nil and k == nil) then 
      nr = nr + 1
    end
    lineCounter = lineCounter + 1
    if lineCounter == targetLineNo then return nr end
  end
  return targetLineNo
end
\end{luacode}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\begin{document}
%%%%%%%%%%%%%%%%%% Header %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\begin{tabularx}{0.9\textwidth} {
	>>{\raggedright\arraybackslash}X
	>>{\centering\arraybackslash}X
	>>{\raggedleft\arraybackslash}X}
  Klasse <>      & <> Klassenarbeit Nr.<>                                 & <>             \\
	\textbf{Name:} & Punkte: \phantom{30,0} von \directlua{tex.print(summe())} & \textbf{Note:} \\
\end{tabularx}
\hrule
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\begin{center}
	\framebox[1\linewidth]{\textbf{Die Darstellung und korrekte Schreibweise gehen in die Benotung ein.}}
	\framebox[1\linewidth][c]{\textbf{Ohne Hilfsmittel}}
\end{center}

\begin{luacode}
  punkte = "2"
\end{luacode}
\section*{Aufgabe \directlua{tex.print(getNr(\the\inputlineno))} \directlua{printPunkte(punkte)} }
<>

\kariert{16}{5}

\newpage
\begin{tabularx}{0.9\textwidth} {
	>>{\raggedright\arraybackslash}X
	>>{\centering\arraybackslash}X
	>>{\raggedleft\arraybackslash}X}
	\textbf{Name:} &                         &    
\end{tabularx}
\hrule

\kariert{16}{22}

\end{document}
     ]],
      {
        i(1, "10"),
        i(2, "Mathe"),
        i(3, "1"),
        i(4, "MT"),
        i(5),
      }
    )
  ),
}
