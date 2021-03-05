% The class file for the book project 《代数学方法》-- Errata
% Copyright 2018  李文威 (Wen-Wei Li).
% Permission is granted to copy, distribute and/or modify this
% document under the terms of the Creative Commons
% Attribution 4.0 International (CC BY 4.0)
% http://creativecommons.org/licenses/by/4.0/

% Identification
% --------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{AJerrata}[2018/12/08 Class for the errata for the book project Methods of Algebra]

% Package loading
% ---------------------
% 基于 book class, 选项一并载入.

\LoadClass[10pt]{article}

\RequirePackage{fontspec}				% XeLaTeX
\RequirePackage[CJKchecksingle]{xeCJK}	% XeCJK
\RequirePackage{CJKnumb}				% 使用 CJK 数字

% 引入 AMS 宏包 + mathtools
\RequirePackage[intlimits]{amsmath}
\RequirePackage{amssymb}
\RequirePackage[centercolon]{mathtools}

% 引入 tcolorbox 和 xcolor
\RequirePackage[svgnames]{xcolor}
\RequirePackage[many]{tcolorbox}

% 载入 paralist 以制作列表
\RequirePackage{paralist}

\RequirePackage[iso, english]{isodate}  % 使 \today 印出 yyyy-mm-dd

\setlength{\parindent}{2em}	% 设置适合于汉语排版的段落缩进

\defaultfontfeatures{Ligatures=TeX} 
\XeTeXlinebreaklocale "zh"
\XeTeXlinebreakskip = 0pt plus 1pt minus 0.1pt

\RequirePackage{zhlineskip}	% 设置适合中文排版的间距

% 排版``原文''方块
\newtcbox{\OriginalBox}{
	enhanced,
	nobeforeafter,
	tcbox raise base,
	boxrule = 0.4pt,
	arc = 0mm,
	top = 0mm,
	bottom = 0mm,
	right = 0mm,
	left = 0.5mm,
	right skip = 4mm,
	boxsep = 2pt,
	colframe = red!70!black,
	coltext=red!60!black,
	colback=yellow!10!white,
	fontupper = \sffamily,
	overlay = {
		\coordinate (A) at (frame.north east);
		\coordinate (B) at (frame.south east);
		\coordinate (C) at ($(A)!.5!30:(B)$);
		\fill[color=red!70!black] (A) -- (B) -- (C) --cycle;
	}
}

% 排版``更正''方块
\newtcbox{\CorrectionBox}{
	enhanced,
	nobeforeafter,
	tcbox raise base,
	boxrule = 0.4pt,
	arc = 0mm,
	top = 0mm,
	bottom = 0mm,
	right = 0mm,
	left = 0.5mm,
	right skip = 4mm,
	boxsep = 2pt,
	colframe = green!70!black,
	coltext=green!60!black,
	colback=green!10!white,
	fontupper = \sffamily,
	overlay = {
		\coordinate (A) at (frame.north east);
		\coordinate (B) at (frame.south east);
		\coordinate (C) at ($(A)!.5!30:(B)$);
		\fill[color=green!70!black] (A) -- (B) -- (C) --cycle;
	}
}

\newcommand{\Orig}{\OriginalBox{原文}}	% ``原文''命令
\newcommand{\Corr}{\;\CorrectionBox{更正}}	% ``更正''命令
\newcommand{\Thx}[1]{\hspace{1em}\hfill\textsf{\footnotesize #1}}	% ``感谢''命令

\AtEndPreamble{
	% 设置页面尺寸
	\RequirePackage{geometry}
	\geometry{
		paper=b5paper,
		headheight=5ex,
		headsep=5ex,
		textwidth=132mm,
		textheight=198mm,
		twoside,
		% bindingoffset=18pt,
		asymmetric	% 单双数页不分
	}

	\renewcommand{\descriptionlabel}[1]{$\diamond$ {\bfseries #1}\hspace{1em}}
	\newenvironment{Errata}{%
		\begin{description}%
			}{	% 结束
		\end{description}
	}
}
