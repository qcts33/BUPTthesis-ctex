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
  subsubsection/format = \zihao{-4},
}
\newcommand{\refname}{\bibname}
% \AtEndOfClass{\input{BUPTthesis.cfg}}

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
\RequirePackage{mathtools,amsfonts,amssymb,empheq,bm}
\RequirePackage{graphicx}
\RequirePackage[per-mode=symbol]{siunitx}
\RequirePackage{longtable}
\RequirePackage{ulem}
\RequirePackage{booktabs}

%caption
\RequirePackage{caption}
\RequirePackage{subcaption}
\RequirePackage{floatrow}
\DeclareCaptionFont{kaiti}{\zihao{5}\kaishu}
\captionsetup[figure]{font=kaiti}
\floatsetup[table]{capposition=top}
\captionsetup[subfigure]{
  justification=raggedright,
  labelformat=simple,
  list=off,
  font=kaiti,
}
\floatsetup[subfigure]{
  style=plain,
  heightadjust=object,
  capbesideposition={left,top},
  capbesidesep=none,
}
\renewcommand\thesubfigure{(\alph{subfigure})}

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

% theorem like style

\declaretheoremstyle[
  style=definition,
  headpunct={},
  postheadspace={.5\ccwd},
  headindent={\parindent},
  numberwithin=chapter,
]{Theorem}

\declaretheorem[name={假设},style=Theorem]{assumption}
\declaretheorem[name={定义},style=Theorem]{definition}
\declaretheorem[name={命题},style=Theorem]{proposition}
\declaretheorem[name={引理},style=Theorem]{lemma}
\declaretheorem[name={定理},style=Theorem]{theorem}
\declaretheorem[name={公理},style=Theorem]{axiom}
\declaretheorem[name={推论},style=Theorem]{corollary}
\declaretheorem[name={注释},style=Theorem]{remark}
\declaretheorem[name={问题},style=Theorem]{problem}
\declaretheorem[name={猜想},style=Theorem]{conjecture}
\declaretheorem[name={例},style=Theorem]{example}

\declaretheoremstyle[
  style=definition,
  numbered=no,
  headindent={\parindent},
  headpunct={：},
  qed=\qedsymbol
]{Proof}

\declaretheorem[name={证明},style=Proof]{Proof}
\renewenvironment{proof}{\begin{Proof}}{\end{Proof}}

% algorithm
\RequirePackage{algorithm, algpseudocode}

% cleveref
\RequirePackage[sort]{cleveref}

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

\crefname{equation}{}{}
\creflabelformat{equation}{(#2#1#3)}
\crefrangelabelformat{equation}{(#3#1#4)~-~(#5#2#6)}

\crefname{assumption}{假设}{假设}
\creflabelformat{assumption}{#2#1#3~}
\crefrangelabelformat{assumption}{#3#1#4~-~#5#2#6~}

\crefname{definition}{定义}{定义}
\creflabelformat{definition}{#2#1#3~}
\crefrangelabelformat{definition}{#3#1#4~-~#5#2#6~}

\crefname{proposition}{命题}{命题}
\creflabelformat{proposition}{#2#1#3~}
\crefrangelabelformat{proposition}{#3#1#4~-~#5#2#6~}

\crefname{lemma}{引理}{引理}
\creflabelformat{lemma}{#2#1#3~}
\crefrangelabelformat{lemma}{#3#1#4~-~#5#2#6~}

\crefname{theorem}{定理}{定理}
\creflabelformat{theorem}{#2#1#3~}
\crefrangelabelformat{theorem}{#3#1#4~-~#5#2#6~}

\crefname{axiom}{公理}{公理}
\creflabelformat{axiom}{#2#1#3~}
\crefrangelabelformat{axiom}{#3#1#4~-~#5#2#6~}

\crefname{corollary}{推论}{推论}
\creflabelformat{corollary}{#2#1#3~}
\crefrangelabelformat{corollary}{#3#1#4~-~#5#2#6~}

\crefname{remark}{注释}{注释}
\creflabelformat{remark}{#2#1#3~}
\crefrangelabelformat{remark}{#3#1#4~-~#5#2#6~}

\crefname{problem}{问题}{问题}
\creflabelformat{problem}{#2#1#3~}
\crefrangelabelformat{problem}{#3#1#4~-~#5#2#6~}

\crefname{conjecture}{猜想}{猜想}
\creflabelformat{conjecture}{#2#1#3~}
\crefrangelabelformat{conjecture}{#3#1#4~-~#5#2#6~}

\crefname{example}{例}{例}
\creflabelformat{example}{#2#1#3~}
\crefrangelabelformat{example}{#3#1#4~-~#5#2#6~}

\crefname{algorithm}{算法}{算法}
\creflabelformat{example}{#2#1#3~}
\crefrangelabelformat{example}{#3#1#4~-~#5#2#6~}


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
      {\zihao{3}\bfseries\MakeUppercase\bupt@meta@etitle}
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\bupt@page@head{北京邮电大学工学博士学位论文}
\def\bupt@label@covertitle{博士学位论文}
\def\bupt@label@ecovertitle{Thesis for Doctor Degree}
\def\bupt@label@cmajor{专\hspace{2em}业}
\def\bupt@label@emajor{Subject}

\def\bupt@label@cauthor{姓\hspace{2em}名}
\def\bupt@label@eauthor{Candidate}
\def\bupt@label@csupervisor{导\hspace{2em}师}
\def\bupt@label@esupervisor{Supervisor}
\def\bupt@label@cdepartment{学\hspace{2em}院}
\def\bupt@label@edepartment{Institute}
\def\bupt@label@studentid{学\hspace{2em}号}
\def\bupt@label@estudentid{Student No.}
\def\bupt@label@classlevel{密级}

\def\bupt@label@ctitle{题目}
\def\bupt@label@etitle{Topic}
\def\bupt@label@classdur{保密期限}
\def\bupt@label@cschoolname{北京邮电大学}
\def\bupt@label@eschoolname{Beijing University of Posts and Telecommunications}
\def\bupt@title@sep{：}
\def\bupt@title@esep{:}

\def\bupt@declaration@title{独创性（或创新性）声明}
\long\def\bupt@declaration@body{%
  本人声明所呈交的论文是本人在导师指导下进行的研究工作及取得的研究成果。%
  尽我所知，除了文中特别加以标注和致谢中所罗列的内容以外，论文中不包含其他人已经发表或撰写过的研究成果，也不包含为获得北京邮电大学或其他教育机构的学位或证书而使用过的材料。%
  与我一同工作的同志对本研究所做的任何贡献均已在论文中作了明确的说明并表示了谢意。\par%
  申请学位论文与资料若有不实之处，本人承担一切相关责任。%
}
\def\bupt@authorization@title{关于论文使用授权的说明}
\long\def\bupt@authorization@body{%
  本人完全了解并同意北京邮电大学有关保留、使用学位论文的规定，即：北京邮电大学拥有以下关于学位论文的无偿使用权，具体包括：学校有权保留并向国家有关部门或机构送交论文，有权允许学位论文被查阅和借阅；%
  学校可以公布学位论文的全部或部分内容，有权允许采用影印、缩印或其它复制手段保存、汇编学位论文，将学位论文的全部或部分内容编入有关数据库进行检索。%
  （保密的学位论文在解密后遵守此规定）%
}
\def\bupt@label@authorsigniture{本人签名：}
\def\bupt@label@supervisorsigniture{导师签名：}
\def\bupt@label@date{日期：}
\def\bupt@label@ckeywords{关键词：}
\def\bupt@label@ekeywords{KEY WORDS:}
\def\bupt@label@cabstract{摘\hspace{1em}要}
\def\bupt@label@eabstract{ABSTRACT}
\def\bupt@label@notations{符号说明}
\def\kwsep{\quad}
\def\bupt@label@refname{参考文献}
\def\bupt@label@listofacronyms{缩略语表}
\def\bupt@label@tableofpublications{攻读学位期间发表的学术论文目录}
\def\bupt@label@acknowledgement{致谢}

\def\bupt@meta@classlevel{公开}


\def\bupt@figurename{图}
\def\bupt@listfigurename{插图索引}
\def\bupt@tablename{表}
\def\bupt@listtablename{表格索引}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\endinput
