\NeedsTeXFormat{LaTeX2e}[2005/12/01]
\ProvidesClass{BUPTthesis}
[2018/12/12 v7.0 BUPT graduate thesis LaTeX2e class]
\RequirePackage{etoolbox}
\newtoggle{txmath}
\DeclareOption{txmath}{\toggletrue{txmath}}
\newtoggle{review}
\DeclareOption{review}{\toggletrue{review}}
\newtoggle{chapterbib}
\DeclareOption{chapterbib}{\toggletrue{chapterbib}}
% \DeclareOption*{\PassOptionsToClass{\CurrentOption}{ctexbook}}
\ProcessOptions


% config ctex
\LoadClass[a4paper,UTF8,zihao=-4,scheme=chinese,linespread=1.4]{ctexbook}
\ctexset{%
  listfigurename = \bupt@listfigurename,
  listtablename  = \bupt@listtablename,
  part/pagestyle = empty,
  chapter = {%
    format = \zihao{3}\heiti\centering,
    pagestyle = main,
    beforeskip = 0pt,
    afterskip = 40pt,
  },
  section/format = \zihao{4}\heiti,
  subsection/format = \zihao{-4}\heiti,
}
\newcommand{\refname}{\bibname}
\AtEndOfClass{\input{BUPTthesis.cfg}}

% define names
\newcommand{\studentid}[1]{\def\bupt@meta@studentid{#1}}
\newcommand{\ctitle}[1]{\def\bupt@meta@ctitle{#1}}
\newcommand{\etitle}[1]{\def\bupt@meta@etitle{#1}}
\newcommand{\cdegree}[1]{\def\bupt@meta@cdegree{#1}}
\newcommand{\cdepartment}[1]{\def\bupt@meta@cdepartment{#1}}
\newcommand{\edepartment}[1]{\def\bupt@meta@edepartment{#1}}
\newcommand{\cmajor}[1]{\def\bupt@meta@cmajor{#1}}
\newcommand{\emajor}[1]{\def\bupt@meta@emajor{#1}}
\newcommand{\cauthor}[1]{\def\bupt@meta@cauthor{#1}}
\newcommand{\eauthor}[1]{\def\bupt@meta@eauthor{#1}}
\newcommand{\csupervisor}[1]{\def\bupt@meta@csupervisor{#1}}
\newcommand{\esupervisor}[1]{\def\bupt@meta@esupervisor{#1}}
\newcommand{\ckeywords}[1]{\def\bupt@meta@ckeywords{#1}}
\newcommand{\ekeywords}[1]{\def\bupt@meta@ekeywords{#1}}
\newcommand{\cdate}[1]{\def\bupt@meta@cdate{#1}}
\newcommand{\edate}[1]{\def\bupt@meta@edate{#1}}


% Load packages
\RequirePackage{amsthm,thmtools}
\RequirePackage{newtxtext}
\iftoggle{txmath}{\RequirePackage{newtxmath}}{}
\RequirePackage{mathtools,amsfonts,amssymb,bm}
\RequirePackage{graphicx}
\RequirePackage{subcaption}
\RequirePackage[per-mode=symbol]{siunitx}
\RequirePackage{algorithm, algorithmicx}
\RequirePackage{longtable}
\RequirePackage{ulem}

%caption
\RequirePackage{caption}
\captionsetup{font={small}}

% biblatex
\iftoggle{chapterbib}{\PassOptionsToPackage{refsection=chapter}{biblatex}}{}
\RequirePackage[backend=biber,style=gb7714-2015,gbnamefmt=familyahead,gbpub=false,doi=false]{biblatex}
\iftoggle{chapterbib}
{%
  \newcommand{\chapterbib}{\printbibliography[heading=subbibliography]}
  \newcommand{\mainbib}{\relax}
}
{%
  \newcommand{\chapterbib}{\relax}
  \newcommand{\mainbib}{\printbibliography}
}

% hyperref
\AtBeginDocument{
	\hypersetup{
		colorlinks,
		urlcolor=black,
		linkcolor=black,
		citecolor=black,
		pdfauthor={\bupt@meta@cauthor},
		pdftitle={\bupt@meta@ctitle},
	}
}
\RequirePackage{hyperref}

% cleveref
\RequirePackage{cleveref}

\newcommand{\creflastconjunction}{和~}
\newcommand{\crefpairconjunction}{和~}

\crefformat{chapter}{第~#2#1#3~章}
\crefrangeformat{chapter}{第~#3#1#4~-~#5#2#6~章}

\crefformat{section}{第~#2#1#3~节}
\crefrangeformat{section}{第~#3#1#4~-~#5#2#6~节}

\crefformat{subsection}{第~#2#1#3~小节}
\crefrangeformat{subsection}{第~#3#1#4~-~#5#2#6~小节}

\crefformat{subsubsection}{第~#2#1#3~项}
\crefrangeformat{subsubsection}{第~#3#1#4~-~#5#2#6~项}

\crefname{table}{表}{表}
\creflabelformat{table}{#2#1#3~}
\crefrangelabelformat{table}{#3#1#4~-~#5#2#6~}

\crefname{figure}{图}{图}
\creflabelformat{figure}{#2#1#3~}
\crefrangelabelformat{figure}{#3#1#4~-~#5#2#6~}

\crefname{equation}{式}{式}
\creflabelformat{equation}{(#2#1#3)~}
\crefrangelabelformat{equation}{(#3#1#4)~-~(#5#2#6)~}

% glossaries
\RequirePackage[nomain,nogroupskip,toc,section=chapter]{glossaries}
\newglossarystyle{bupt@acronyms@style}{  % 设置自定义缩略语表格式
  \setglossarystyle{long}                % 以 long 样式为基础
  \renewcommand*{\glossentry}[2]{%
    \glossentryname{##1} & \glossentrydesc{##1}, \glossentrysymbol{##1}\\
  }
}
\setlength{\glsdescwidth}{0.9\linewidth} % 缩略语描述列宽
\setglossarystyle{bupt@acronyms@style} % 选择自定义的缩略语表样式
% 设置 acronym 词汇表的标题
\newglossary[alg]{acronym}{acr}{acn}{\bupt@label@listofacronyms}
\makeglossaries
% 重载 \newacronym 命令
\renewcommand{\newacronym}[4]{%
  \newglossaryentry{#1}{%
    type=\acronymtype,%
    name={#2},%
    description={#3},%
    text={#2},%
    descriptionplural={#3\acrpluralsuffix},%
    first={#2}, %{#3 (#2)},%
    plural={#2\acrpluralsuffix},%
    firstplural={\@glo@descplural\space (\@glo@plural)},%
    symbol={#4}%
  }%
}
% 重载 \cs{glsdisplayfirst} 命令
\renewcommand{\glsdisplayfirst}[4]{{#3} ({#2}, {#1})}
\renewcommand{\glsdefaulttype}{acronym}
\renewcommand{\glossarysection}[2][\@gls@title]{\chapter{#2}}
\newcommand{\tableofacronyms}{\printglossary[type=\acronymtype]}

% config page
\RequirePackage[paper=a4paper,total={155mm,230mm},includehead,hcentering]{geometry}

% config toc lof lot
\RequirePackage{tocloft}
\tocloftpagestyle{main}
\setlength\cftbeforetoctitleskip{0pt}
\setlength\cftaftertoctitleskip{40pt}
\renewcommand{\cfttoctitlefont}{\hfill\zihao{3}\heiti}
\renewcommand{\cftaftertoctitle}{\hfill}
\renewcommand{\cftchapleader}{\cftdotfill{\cftdotsep}}
\renewcommand{\cftchapfont}{\normalfont}
\renewcommand{\cftchappagefont}{\normalfont}
\setcounter{secnumdepth}{3}
\setcounter{tocdepth}{2}

\setlength\cftbeforeloftitleskip{0pt}
\setlength\cftafterloftitleskip{40pt}
\renewcommand{\cftloftitlefont}{\hfill\zihao{3}\heiti}
\renewcommand{\cftafterloftitle}{\hfill}

\setlength\cftbeforelottitleskip{0pt}
\setlength\cftafterlottitleskip{40pt}
\renewcommand{\cftlottitlefont}{\hfill\zihao{3}\heiti}
\renewcommand{\cftafterlottitle}{\hfill}

% define heading
\usepackage{fancyhdr}
\fancypagestyle{main}{%
  \fancyhf{}
  \fancyhead[CE]{\zihao{-5}\bupt@page@head}
  \fancyhead[CO]{\zihao{-5}\leftmark}
  \fancyfoot[C]{\zihao{5}\thepage}
}
\appto\frontmatter{\pagestyle{main}\pagenumbering{roman}}
\appto\mainmatter{\pagestyle{main}\pagenumbering{arabic}}


% 使用enumitem宏包配制列表环境
% 紧凑间距
\RequirePackage[inline]{enumitem}
\setlist{nosep}

% config numbering for equation fig table and so on.
\AtBeginDocument{%
  \renewcommand{\theequation}{\thechapter-\arabic{equation}}
  \renewcommand{\thefigure}{\thechapter-\arabic{figure}}
  \renewcommand\p@subfigure{\thefigure}
  \renewcommand{\thetable}{\thechapter-\arabic{table}}
  \renewcommand{\thealgorithm}{\thechapter-\arabic{algorithm}}
}

% draw front pages
\newtoggle{addcover}
\IfFileExists{bsong.ttf}
{%
  \setCJKfamilyfont{bsong}{bsong.ttf}
  \newcommand*{\bsong}{\CJKfamily{bsong}}
}
{\newcommand*{\bsong}{\songti}}
\IfFileExists{cover.tex}
{%
	\input{cover.tex}
	\renewcommand\maketitle{%
	 \makechinesetitle
	 \makeenglishtitle
	 \makedeclaration
  }
  \toggletrue{addcover}
}{}
\IfFileExists{cover.pdf}
{%
	\RequirePackage{pdfpages}
  \renewcommand\maketitle{\includepdf[pages=-]{cover.pdf}}
  \toggletrue{addcover}
}{}
\nottoggle{addcover}{\renewcommand{\maketitle}{\relax}}{}

% 中英文摘要+关键词
\newenvironment{cabstract}
{%
	\cleardoublepage
  \pdfbookmark[0]{\bupt@label@cabstract}{abstract}
  \begin{center}
    {\zihao{3}\heiti\bupt@meta@ctitle}
    \vskip 20pt
    {\zihao{-3}\heiti\bupt@label@cabstract}
  \end{center}
  \markboth{\bupt@label@cabstract}{}
  \zihao{4}
  \par
}
{
  \par
	\vspace{20pt}
	\noindent
	{\zihao{4} {\heiti\bupt@label@ckeywords} {\bupt@meta@ckeywords}}
}

\newenvironment{eabstract}
{%
	\cleardoublepage
  \pdfbookmark[0]{\bupt@label@cabstract}{ebstract}
  \begin{center}
    \begin{minipage}{110mm}
      \centering
      {\zihao{3}\bfseries\bupt@meta@etitle}
      \vskip 20pt
      {\zihao{-3}\bfseries\bupt@label@eabstract}
    \end{minipage}
  \end{center}
  \markboth{\bupt@label@eabstract}{}
  \vskip 20pt
  \zihao{4}
  \par
}
{
  \par
	\vspace{20pt}
	\noindent
	{\zihao{4} {\bfseries\bupt@label@ekeywords} {\bupt@meta@ekeywords}}
}

\newenvironment{notations}
{%
  \chapter*{\bupt@label@notations}
  \markboth{\bupt@label@notations}{}
  \begin{longtable}{lp{120mm}}
}
{\end{longtable}}

\newenvironment{acknowledgement}
{%
  \chapter*{\bupt@label@acknowledgement}
  \markboth{\bupt@label@acknowledgement}{}
}
{}

\endinput
