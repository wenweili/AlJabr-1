% The class file for the book project 《代数学方法》
% Copyright 2018  李文威 (Wen-Wei Li).
% Permission is granted to copy, distribute and/or modify this
% document under the terms of the Creative Commons
% Attribution 4.0 International (CC BY 4.0)
% http://creativecommons.org/licenses/by/4.0/

% We make use of etoolbox. The package ntheorem is implicitly required.
% It will also import the files titles-setup.tex (for titles of sections) and font-setup-open.tex/font-setup-HEP.tex (for fonts).

% Identification
% --------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{AJbook}[2018/03/04 Class for the book project Methods of Algebra]

% 使用 key-val 格式指定选项之用, 一切以 @AJ 起始.
\RequirePackage{kvoptions}
\RequirePackage{etoolbox}

\SetupKeyvalOptions{
	family = @AJ,
	prefix = @AJ@
}

% Declaration of options
% ----------------------
\DeclareBoolOption[false]{draftmark}	% 是否打上未定稿标记
\DeclareBoolOption[true]{colors}	% 是否让链接带颜色
\DeclareBoolOption[true]{CJKthechapter}	% 是否让天眉的各章编号使用中文数字
\DeclareBoolOption[false]{traditional}	% 是否使用繁体中文
\DeclareStringOption[]{coverpage}	% 封面档档名, 默认为空
\DeclareStringOption{fontsetup}	% 字体设定档档名
\DeclareStringOption{titlesetup}	% 章节标题设定档档名
\DeclareStringOption[b5]{geometry}	% 版面 (默认 b5)

\PassOptionsToPackage{dvipsnames}{xcolor}	% 让 xcolor 带 dvipsnames 选项; tikz 随后会载入之.


% Execution of options
% ---------------------
\ProcessKeyvalOptions*
\relax

% Package loading
% ---------------------
% 基于 book class, 选项一并载入.
\LoadClass[10pt]{book}

\RequirePackage{fontspec}				% XeLaTeX
\RequirePackage[CJKchecksingle]{xeCJK}	% XeCJK
\RequirePackage{zhnumber}				% 中文数字转换

% 引入 AMS 宏包 + mathtools
\RequirePackage[intlimits]{amsmath}
\RequirePackage{amssymb}
\RequirePackage[centercolon]{mathtools}

% 支持直接引入 PDF 页面
\RequirePackage{pdfpages}

% 加入字串处理功能
\RequirePackage{xstring}

\RequirePackage{emptypage}
\RequirePackage[many]{tcolorbox}		% 制作方框

\RequirePackage{setspace}	% 设定适于中文排版的行距

% 使用 biblatex + biber 制作书目
\RequirePackage[backend=biber, hyperref=auto, backref=true, backrefstyle=three]{biblatex}

% 要求载入 TikZ
\RequirePackage{tikz}

% 载入 paralist
\RequirePackage{paralist}

% Main codes
% ----------

\usetikzlibrary{shapes.symbols}	% 稍后定义 hint 环境所需

% 定义在 draftmark=true 模式下显示版本信息的指令
\RequirePackage[iso, english]{isodate}  % 使 \today 印出 yyyy-mm-dd
\providecommand{\@AJ@draftstring}{{\color{gray!40}\heiti 未定稿: \today}}

\onehalfspacing	% 行距
%\raggedbottom	% 减小页面空白

\setlength{\parindent}{2em}	% 设置适合于汉语排版的段落缩进

% 扩展 \frontmatter: 制作封面和目录
\g@addto@macro\frontmatter{
	% 当 coverpage 参数非空时, 引入封面档制作封面, 否则 \relax.
	\ifdefempty{\@AJ@coverpage}{%
		\relax
	}{%
		\pagestyle{empty}%	清空页面风格
		\renewcommand{\thepage}{C\arabic{page}}%	封面部分页码以 C 开头 (PDF: logical page numbers)
		\IfEndWith{\@AJ@coverpage}{.pdf}{% 如果档名以 .pdf 或 .PDF 结尾则引入 PDF
			\includepdf{\@AJ@coverpage}
		}{%
			\IfEndWith{\@AJ@coverpage}{.PDF}{%
				\includepdf{\@AJ@coverpage}
			}{%
				\input{\@AJ@coverpage}		% 否则引入 .tex 源代码
			}
		}%
		\pagestyle{fancy}		% 复原页面风格为 fancy
		\pagenumbering{roman}	% 页码复原为小写罗马字母
	}

	% 重设页数: 封面页结束时应已经 \cleardoublepage
	\setcounter{page}{1}
	\thispagestyle{empty}
	\addtocontents{toc}{\protect\thispagestyle{empty}}

	% 重置目录标题
	\if@AJ@traditional
		\renewcommand{\contentsname}{目錄}
	\else
		\renewcommand{\contentsname}{目录}
	\fi

	\tableofcontents	% 印出目录
}

% 扩张 \appendix: 重置天眉
\g@addto@macro\appendix{
	% 为附录重置天眉格式
	\if@AJ@traditional
		\renewcommand{\appendixname}{附錄}
		\renewcommand{\chaptermark}[1]{\markboth{附錄 \thechapter \quad #1}{}}
	\else
		\renewcommand{\appendixname}{附录}
		\renewcommand{\chaptermark}[1]{\markboth{附录 \thechapter \quad #1}{}}
	\fi
	\renewcommand{\sectionmark}[1]{\markright{\S\thesection \quad #1}}
}

% 扩展 \backmatter: 设置文献显示方式. 注意: 若有附录则须重置天眉格式
\g@addto@macro\backmatter{
	\renewcommand{\em}{\itshape} % 书目部分以斜体表示强调
	% 汉化参考文献标题
	\if@AJ@traditional
		\renewcommand{\refname}{參考文獻}
		\renewcommand{\bibname}{參考文獻}
	\else
		\renewcommand{\refname}{参考文献}
		\renewcommand{\bibname}{参考文献}
	\fi
}

% 以下设置 biblatex.
% bibLaTeX 部分第一步: 基本设置与汉化.
\DeclareFieldFormat{postnote}{#1}	% 功能是印出 \cite[postnote]{Book}
\if@AJ@traditional
	\DefineBibliographyStrings{english}{%
		in = {刊於},
		editor = {主編},
		byeditor = {編者為},
		backrefpage = {引用於 p.\!},
		backrefpages = {引用於 pp.\!},
	}
	\else
		\DefineBibliographyStrings{english}{%
			in = {刊于},
			editor = {主编},
			byeditor = {编者为},
			backrefpage = {引用于 p.\!},
			backrefpages = {引用于 pp.\!},
	}
\fi
% biblatex 部分第二步: 要求在 doi 和 URL 并存时移除 URL. 仅适用于 Biblatex + Biber. 源码取自 https://tex.stackexchange.com/questions/119136/biblatex-convert-doi-url-into-doi-field  原文如下.
% The actual value inside \regexp can be adjusted.
% In the first step we create a doi field for each entry where the url field matches the regexp, and the novel field has the value of the url field. In the second step we remove the doi "namespace".
% In the second \map sequence the url and urldate fields are cleared if a doi field is present, to mimic the behavior in the first part of the original question. 
\DeclareSourcemap{
	\maps[datatype=bibtex]{
		\map{
			\step[ % copies url to doi field if it starts with http://dx.doi.org/
			fieldsource=url,
			match=\regexp{http://dx.doi.org/(.+)},
			fieldtarget=doi,
			]
			\step[ % removes http://dx.doi.org/ string from doi field
			fieldsource=doi,
			match=\regexp{http://dx.doi.org/(.+)},
			replace=\regexp{$1}
			]
		}
		\map{ % removes url + urldate field from all entries that have a doi field
			\step[fieldsource=doi, final]
			\step[fieldset=url, null]
			\step[fieldset=urldate, null]
		}
	}
}

% 汉化 figure 和 table 环境
\if@AJ@traditional
	\renewcommand{\figurename}{圖}
	\renewcommand{\tablename}{表}
\else
	\renewcommand{\figurename}{图}
	\renewcommand{\tablename}{表}
\fi

% 汉化 figure 和 table 索引
\if@AJ@traditional
	\renewcommand{\listfigurename}{圖片索引}
	\renewcommand{\listtablename}{表格索引}
\else
	\renewcommand{\listfigurename}{图片索引}
	\renewcommand{\listtablename}{表格索引}
\fi

% 将 figure 和 table 索引加入目录: 使用 etoolbox 提供的 patching
\pretocmd{\listoffigures}{%
	\cleardoublepage
	\phantomsection
	\addcontentsline{toc}{chapter}{\listfigurename}
}{}{}
\pretocmd{\listoftables}{%
	\cleardoublepage
	\phantomsection
	\addcontentsline{toc}{chapter}{\listtablename}
}{}{}

% 输入字体设置
\input{\@AJ@fontsetup}
% 输入章节标题设置
\input{\@AJ@titlesetup}

% 设置习题环境, 置于每章最后: 不用 \section* 以免格式混淆
\if@AJ@traditional
	\newenvironment{Exercises}{%
		\markright{習題}
		\addcontentsline{toc}{section}{習題}
		\vspace{1em}\begin{center}
			\Large\CJKfamily{sectionfont} 習題
		\end{center}\vspace{0.7em}
		\begin{small}\begin{enumerate}[\bfseries 1.] %
			}{	% 结束
		\end{enumerate}\end{small}
	}
\else
	\newenvironment{Exercises}{%
		\markright{习题}
		\addcontentsline{toc}{section}{习题}
		\vspace{1em}\begin{center}
			\Large\CJKfamily{sectionfont} 习题
		\end{center}\vspace{0.7em}
		\begin{small}\begin{enumerate}[\bfseries 1.] %
			}{	% 结束
		\end{enumerate}\end{small}
	}
\fi

% 习题提示 (定义为环境, 穿插文中)
\newenvironment{hint}{%
	\ifvmode % 用 \ifvmode 测试: 如果提示另起新段, 则不加空白.
		\ignorespaces	% 消除横向空白, 优于 \unskip
	\else
		\quad	% 否则加入空白.
	\fi
	\begin{tikzpicture}[baseline=(H.base), every node/.style={signal, draw, very thin, signal to=east, signal from=nowhere, signal pointer angle=120, inner sep=2pt}]
		\node[anchor=mid west] (H) at (0,0) {\heiti\footnotesize 提示};
	\end{tikzpicture}
}{}

% 每章开头的学习提示 (定义为环境)
\if@AJ@traditional
	\newtcolorbox{wenxintishi}{
		breakable,
		enhanced,
		width = \textwidth,
		colback = white, colbacktitle = white,
		colframe = gray!50, boxrule=0.2mm,
		coltitle = black,
		fonttitle = \sffamily,
		attach boxed title to top left = {yshift=-\tcboxedtitleheight/2,  xshift=\tcboxedtitlewidth/4},
		boxed title style = {boxrule=0pt, colframe=white},
		before skip = 0.5cm,
		top = 3mm,
		bottom = 3mm,
		title={閱讀提示}
	}
\else
	\newtcolorbox{wenxintishi}{
		breakable,
		enhanced,
		width = \textwidth,
		colback = white, colbacktitle = white,
		colframe = gray!50, boxrule=0.2mm,
		coltitle = black,
		fonttitle = \sffamily,
		attach boxed title to top left = {yshift=-\tcboxedtitleheight/2,  xshift=\tcboxedtitlewidth/4},
		boxed title style = {boxrule=0pt, colframe=white},
		before skip = 0.5cm,
		top = 3mm,
		bottom = 3mm,
		title={阅读提示}
	}
\fi

\AtEndPreamble{
	\RequirePackage[thmmarks, amsmath, hyperref]{ntheorem}	% 设置定理环境所需
	
	% 若 hyperref 已载入, 则按 colors 的 Bool 值设置链接色彩.
	\@ifpackageloaded{hyperref}{
		\if@AJ@colors
			\hypersetup{
			colorlinks = true,
			linkcolor = blue,
			citecolor = red,
			urlcolor = teal}
		\else
			\hypersetup{hidelinks}
		\fi}
	{}
	
	% 设置页面尺寸
	\RequirePackage{geometry}
	\IfStrEq{\@AJ@geometry}{b5}{% 载入 b5 版面设置
	\geometry{
		paper=b5paper,
		headheight=5ex,
		headsep=5ex,
		textwidth=132mm,
		textheight=198mm,
		twoside,
		% bindingoffset=18pt,
		asymmetric	% 单双数页不分
	}}{}

	\IfStrEq{\@AJ@geometry}{a4}{% 载入 a4 版面设置
	\geometry{
		paper=a4paper,
		top=3cm,
		inner=2.54cm,
		outer=2.54cm,
		bottom=3cm,
		headheight=6ex,
		headsep=6ex,
		twoside,
		asymmetric
	}}{}

	% 设置天眉所需
	\RequirePackage{fancyhdr}
	% 使空页恒空
	\fancypagestyle{plain}{
		\fancyhead{}
		\renewcommand{\headrulewidth}{0pt}
	}
	
	% 设置天眉
	\pagestyle{fancy}
	\if@AJ@CJKthechapter
		\renewcommand{\chaptermark}[1]{\markboth{
			第\zhnumber{\thechapter}章\quad #1
			}{}}
	\else
		\renewcommand{\chaptermark}[1]{\markboth{
			第 \thechapter 章\quad #1
			}{}}
	\fi
	\renewcommand{\sectionmark}[1]{\markright{\S\arabic{chapter}.\arabic{section} \quad #1}}
	\fancyhf{} % 先清空
	\fancyhead[EC]{\CJKfamily{hei2}\footnotesize{\leftmark}\vspace{1mm}}
	\fancyhead[OC]{\CJKfamily{hei2}\footnotesize{\rightmark}\vspace{1mm}}
	\fancyhead[LE,RO]{{\footnotesize \thepage}\vspace{1mm}} %
	\fancyhead[RE,LO]{}
	\if@AJ@draftmark
		\fancyfoot[C]{\@AJ@draftstring} % 在 draftmark=true 时打印版本信息
	\fi
	\renewcommand{\headrulewidth}{0pt}	% 天眉暂不加横线
	\renewcommand{\footrulewidth}{0pt}
	\addtolength{\headheight}{0.5pt}
}

\AtBeginDocument{
	% 重置 \Re, \Im, \emptyset. 由于可能用到 unicode-math, 这必须在 \begin{document} 后进行.
	\renewcommand{\Re}{\operatorname{Re}}
	\renewcommand{\Im}{\operatorname{Im}}
	\renewcommand{\emptyset}{\ensuremath{\varnothing}}
	
	\newcommand{\openbox}{\leavevmode	% 复制 amsthm 的 QED 符号: 空心方格
	\hbox to.77778em{%
		\hfil\vrule
		\vbox to.675em{\hrule width.6em\vfil\hrule}%
		\vrule\hfil}}
		
	\theorembodyfont{\fangsong}	% 以下用 ntheorem 定义定理等环境
	\theoremheaderfont{\sffamily\bfseries\thmheiti}	% 须与 \setsansfont 选择的字体兼容
	\theoremseparator{\ }
	\setlength{\theorempreskipamount}{2mm}
	\setlength{\theorempostskipamount}{2mm}
	
	\if@AJ@traditional
		\newtheorem{theorem}{定理}[section] % 按section编号
		\newtheorem{corollary}[theorem]{推論}
		\newtheorem{lemma}[theorem]{引理}
		\newtheorem{proposition}[theorem]{命題}
		\newtheorem{definition}[theorem]{定義}
		\newtheorem{definition-theorem}[theorem]{定義--定理}
		\newtheorem{definition-proposition}[theorem]{定義--命題}
		\newtheorem{hypothesis}[theorem]{假設}
		\newtheorem{conjecture}[theorem]{猜想}

		\theorembodyfont{\songti}
		\newtheorem{example}[theorem]{例}
		\newtheorem{remark}[theorem]{注記}
		\newtheorem{convention}[theorem]{約定}
		\newtheorem{exercise}[theorem]{練習}		% 穿插于文中的习题

		\theorembodyfont{}
		\theoremstyle{nonumberplain}
		\theoremheaderfont{\sffamily\bfseries\CJKfamily{pffont}}
		\theoremseparator{\enspace}
		\theoremsymbol{\openbox} % 模拟标准的 Proof 环境
		\newtheorem{proof}{證明}
	\else
		\newtheorem{theorem}{定理}[section] % 按section编号
		\newtheorem{corollary}[theorem]{推论}
		\newtheorem{lemma}[theorem]{引理}
		\newtheorem{proposition}[theorem]{命题}
		\newtheorem{definition}[theorem]{定义}
		\newtheorem{definition-theorem}[theorem]{定义--定理}
		\newtheorem{definition-proposition}[theorem]{定义--命题}
		\newtheorem{hypothesis}[theorem]{假设}
		\newtheorem{conjecture}[theorem]{猜想}

		\theorembodyfont{\songti}
		\newtheorem{example}[theorem]{例}
		\newtheorem{remark}[theorem]{注记}
		\newtheorem{convention}[theorem]{约定}
		\newtheorem{exercise}[theorem]{练习}		% 穿插于文中的习题

		\theorembodyfont{}
		\theoremstyle{nonumberplain}
		\theoremheaderfont{\sffamily\bfseries\CJKfamily{pffont}}
		\theoremseparator{\enspace}
		\theoremsymbol{\openbox} % 模拟标准的 Proof 环境
		\newtheorem{proof}{证明}
	\fi
}

\AtEndDocument{
}
