\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{physvsuThesis}[2018/03/22
  Document class for typesetting bachelor and master theses
  at the Faculty of Physics, Voronezh State University]

% The dummy 'ver2018' option is provided for forward-compatibility.
\DeclareOption{ver2018}{\OptionNotUsed}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\ProcessOptions\relax

% NB: Class loading must follow all \DeclareOption, or nothing will work.
\LoadClass[a4paper,14pt]{extarticle}

% FIXME: Add support for other engines.
\RequirePackage{ifluatex}
\ifluatex\else
  \ClassError{physvsuThesis}
    {Sorry, only lualatex is supported at the moment}
    {This is the preliminary version of the class which does not yet
     support every planned use case. Support for plain latex,
     pdflatex and xelatex is coming soon.}
\fi

\RequirePackage{fontspec}
\RequirePackage{polyglossia}
\setmainlanguage{russian}
\setotherlanguage{english}

% TODO: Implement better font-lookup.
\setmainfont[Ligatures=TeX]{Liberation Serif}
\setmonofont[Scale=0.8]{Liberation Mono}
\def\baselinestretch{1.40}

% TODO: Eventually get rid of the 'geometry' package.
\RequirePackage{luatex85}
\RequirePackage{geometry}
\geometry{
  left=3.0cm,
  right=1.5cm,
  top=2.0cm,
  bottom=2.3cm,
  footskip=1.0cm
}

\newcommand\physvsu@missingFieldError[1]{
  \ClassError{physvsuThesis}
    {Command 'physvsuInfo#1' must be given in the document preamble}
    {Proper documents that use 'physvsuThesis' class must provide a number
     of informational fields in their preamble. These fields include
     the students name, the supervisor name, the faculty name, the city
     and the year of the thesis defence, and so on. Please, refer to the
     class documentation for the full list of required fields.}
}

\newcommand\physvsu@declarePreambleField[1]{
  \expandafter\newcommand\csname physvsuInfo#1\endcsname[1]{
    \expandafter\def\csname physvsu@Info#1\endcsname{##1}
  }
  \AtBeginDocument{\ifcsname physvsu@Info#1\endcsname\else
     \physvsu@missingFieldError{#1}
  \fi}
}

\newcommand\physvsu@declarePreambleOptionalField[2]{
  \expandafter\def\csname physvsu@Info#1\endcsname{#2}
  \expandafter\newcommand\csname physvsuInfo#1\endcsname[1]{
    \expandafter\def\csname physvsu@Info#1\endcsname{##1}
  }
}

\physvsu@declarePreambleOptionalField{Title}{?????}
\physvsu@declarePreambleField{Student}
\physvsu@declarePreambleField{Supervisor}
\physvsu@declarePreambleField{Chair}
\physvsu@declarePreambleField{City}
\physvsu@declarePreambleField{Year}
\physvsu@declarePreambleField{ThesisType}
\physvsu@declarePreambleField{Boilerplate}
\physvsu@declarePreambleField{Faculty}
\physvsu@declarePreambleField{Department}
\physvsu@declarePreambleField{UDC}
\physvsu@declarePreambleField{FieldCode}
\physvsu@declarePreambleField{FieldName}
\physvsu@declarePreambleField{Keywords}
\physvsu@declarePreambleOptionalField{Specialization}{}
\physvsu@declarePreambleOptionalField{AllowedBy}{Допущено к защите в ГАК}

\let\physvsu@stdTitleCommand\title
\renewcommand\title[1]{
  \def\physvsu@InfoTitle{#1}
  \physvsu@stdTitleCommand{#1}
}

% --- Title page ---
\renewcommand\@maketitle{
\begin{titlepage}
  \parindent=0mm
  \parskip=0mm
  \begin{minipage}[t][16cm]{\linewidth}
    \centering
    {\physvsu@InfoBoilerplate}\par
    \vspace{1cm}
    {\physvsu@InfoFaculty}\par
    {\physvsu@InfoDepartment}\par
    \vspace{1cm}
    \textbf{\@title}\par
    \vspace{1cm}
    {\physvsu@InfoThesisType}\par
    {\physvsu@InfoFieldCode}~«{\physvsu@InfoFieldName}»\par
    {\physvsu@InfoSpecialization}\par
  \end{minipage}
  \begingroup
    \newcommand\@signline[2]{
      \parbox[t]{3.5cm}{##1}~$\underset{\text{\tiny\it подпись}}{\underline{\hspace{3cm}}}$~\parbox[t]{8cm}{##2}\par
    }
    \@signline{Студент:}{\physvsu@InfoStudent}
    \@signline{Руководитель:}{\physvsu@InfoSupervisor}
    \@signline{Зав.\,кафедрой:}{\physvsu@InfoChair}
  \endgroup
  \vfill
  \parbox[t]{\linewidth}{\centering \physvsu@InfoCity{} – \physvsu@InfoYear}
\end{titlepage}
\addtocounter{page}{1}}

% --- Abstract ---
\renewenvironment{abstract}
  {\clearpage
   \parindent=0mm
   \begin{center}
     \mbox{УДК\,\physvsu@InfoUDC}\hfill\mbox{\physvsu@InfoStudent}\par
     \vspace{-\baselineskip}
     \textbf{Реферат}\par
   \end{center}
   \vspace{\baselineskip}
   {\physvsu@InfoTitle}.
   {\physvsu@InfoThesisType} по направлению
   {\physvsu@InfoFieldCode}~«{\physvsu@InfoFieldName}»,
   {\physvsu@InfoCity}, {\physvsu@InfoYear}\,г.\par
   \vspace{\baselineskip}
   \textbf{Ключевые слова:} {\physvsu@InfoKeywords}.\par
   \vspace{\baselineskip}}
  {\clearpage}


\clubpenalty=10000
\widowpenalty=10000

\parindent=1cm
\raggedbottom

% -- Lists ---
\RequirePackage{enumitem}
\setenumerate{
    leftmargin = \parindent,
    topsep     = 0cm,
    itemsep    = 0cm,
    parsep     = 0cm,
    partopsep  = 0cm}
\setitemize{
    label      = {–},
    leftmargin = \parindent,
    topsep     = 0cm,
    itemsep    = 0cm,
    parsep     = 0cm,
    partopsep  = 0cm}
\setdescription{
    topsep     = 0cm,
    leftmargin = \parindent,
    itemsep    = 0cm,
    parsep     = 0cm,
    partopsep  = 0cm}

\newlist{where}{itemize}{1}
\setlist[where]{
    label      = ,
    leftmargin = \parindent,
    topsep     = 0cm,
    itemsep    = 0cm,
    parsep     = 0cm,
    partopsep  = 0cm}

\newlist{abbrevlist}{description}{1}
\setlist[abbrevlist]{
    font       = \normalfont,
    leftmargin = 3cm,
    style      = sameline,
    topsep     = 0cm,
    itemsep    = 0cm,
    parsep     = 0cm,
    partopsep  = 0cm}

% --- Section titles ---
\RequirePackage[explicit]{titlesec}
\titleformat{\section}{\newpage\normalfont\bfseries}{\thesection.}{0.5em}{#1}
\titleformat{\subsection}{\normalfont\bfseries}{\thesubsection.}{0.5em}{#1}
\titleformat{\subsubsection}{\normalfont\bfseries}{\thesubsubsection.}{0.5em}{#1}

% --- Appendix titles ---
\let\physvsu@originalSection\section
\let\physvsu@originalSubsection\subsection

\newcommand\physvsu@appendixSection[1]{%
  \refstepcounter{section}%
  \physvsu@originalSection*{Приложение~\@arabic\c@section. #1}%
}

\newcommand\physvsu@appendixSubsection[1]{%
  \refstepcounter{subsection}%
  \physvsu@originalSubsection*{Приложение~\thesubsection. #1}%
  \addcontentsline{toc}{subsection}{\protect\numberline{\thesubsection}#1}%
}

\g@addto@macro\appendix{
  \let\section\physvsu@appendixSection
  \let\subsection\physvsu@appendixSubsection
  \renewcommand{\thesection}{\arabic{section}}
}

% --- TOC ---
\let\physvsu@originalToc\tableofcontents
\renewcommand\tableofcontents{
  \begingroup
  \hyphenpenalty=10000
  \physvsu@originalToc
  \endgroup
  \titleformat{name=\section,numberless}
    {\clearpage\normalfont\bfseries}{}
    {0em}
    {\addcontentsline{toc}{section}{##1}##1}%
  \clearpage}

\RequirePackage[dotinlabels]{titletoc}
\contentsmargin{1.5em}
\dottedcontents{section}[1.2em]{}{1.2em}{1pc}
\dottedcontents{subsection}[3.2em]{}{2em}{1pc}
