local ls = require("luasnip")
local s = ls.snippet
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta

return {
  s(
    { trig = "gfs", dscr = "Vorlage für GFS Berwertung" },
    fmta(
      [[
%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Define Article %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\documentclass[11pt, twoside]{article}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Using Packages %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\usepackage{amsmath}
\usepackage{fancyhdr}
\usepackage{textcomp}
\usepackage{enumitem}
\usepackage{xcolor}
\usepackage{tabularx}
\usepackage{graphicx}
\usepackage{float}
\usepackage{listings}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%% Page Setting %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\usepackage[left=2cm, right=2cm, top=2cm, bottom=2cm,
    bindingoffset=1cm]{geometry}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%% Header %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\pagestyle{fancy}
\setlength{\headheight}{65.83786pt}
\fancyhead[LO]{\includegraphics{WiggyLogo.jpg}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\begin{document}
\subsection*{Bewertung einer GFS – Vortrag mit Handout – Matejka}

\vspace{0.7cm}
\begin{tabular}{c c c}
	<>, & <>, & <>
\end{tabular}
\vspace{0.5cm}

\subsection*{Bewertungskriterien}

\paragraph{Fachkompetenz:} Fachliche und fachsprachliche Richtigkeit, Vollständigkeit und Relevanz, Problemorientierung, Strukturierung, Beantwortung von Fragen

\paragraph{Kommunikationskompetenz:} Aktivierung und Einbindung des Publikums, Vortragsweise und Auftreten, Verwendung von Sprache

\paragraph{Medienkompetenz:} Auswahl und Umgang mit Medien, Aufbereitung von Folien und Handouts, Umgang mit Quellen

\paragraph{Sonstige Kompetenzen:} Vorbereitung und Termineinhaltung, Einbindung von Experimenten (nur Naturwissenschaften)


\subsection*{Die folgenden Punkte können als besonders gelungen bewertet werden}
\begin{itemize}
  \item <>
\end{itemize}

\subsection*{Hier bestehen Verbesserungsmöglichkeiten}

\begin{itemize}
	\item
\end{itemize}


\subsection*{Gesamtbewertung}

\end{document}
     ]],
      { i(1, "Thema"), i(2, "Schüler"), i(3, "Datum"), i(4) }
    )
  ),
}
