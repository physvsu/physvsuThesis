\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{physvsuThesis}[2018/03/22
  Document class for typesetting bachelor and master theses
  at the Faculty of Physics, Voronezh State University]

\LoadClass[a4paper,14pt]{extarticle}
\RequirePackage{ifluatex}
\RequirePackage{luatex85}

\ifluatex\else
  \ClassError{physvsuThesis}
    {Sorry, only lualatex is supported at the moment}
    {This is the preliminary version of the class which does not yet
     support every planned use case. Support for plain latex,
     pdflatex and xelatex is coming soon.}
\fi

% The dummy 'ver2018' option is provided for forward-compatibility.
\DeclareOption{ver2018}{\OptionNotUsed}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\ProcessOptions\relax

\RequirePackage{fontspec}
\RequirePackage{polyglossia}
\setmainlanguage{russian}
\setotherlanguage{english}

% TODO: Implement better font-lookup.
\newfontfamily\russianfont[Script=Cyrillic]{Times New Roman}
\renewcommand{\baselinestretch}{1.40}

% TODO: Eventually get rid of the 'geometry' package.
\RequirePackage{geometry}
\geometry{
  left=3.0cm,
  right=2.0cm,
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
  \expandafter\def\csname physvsuInfo#1\endcsname{#2}
  \expandafter\newcommand\csname physvsu@Info#1\endcsname[1]{
    \expandafter\def\csname physvsu@Info#1\endcsname{##1}
  }
}

\physvsu@declarePreambleField{Student}
\physvsu@declarePreambleField{Supervisor}
\physvsu@declarePreambleField{Chair}
\physvsu@declarePreambleField{City}
\physvsu@declarePreambleField{Year}
\physvsu@declarePreambleField{ThesisType}
\physvsu@declarePreambleField{Boilerplate}
\physvsu@declarePreambleField{Faculty}
\physvsu@declarePreambleField{Department}
\physvsu@declarePreambleOptionalField{AllowedBy}{Допущено к защите в ГАК}

% --- Title page ---
\renewcommand\@maketitle{
\begin{titlepage}
  \parindent=0mm
  \begin{minipage}[t][5cm]{0.9\linewidth}
    \centering
    \physvsu@InfoBoilerplate
  \end{minipage}
  \par
  \begin{minipage}[t][5cm]{0.9\linewidth}
    \centering
    \physvsu@InfoFaculty\\
    \physvsu@InfoDepartment
  \end{minipage}
  \par
  \begin{minipage}[t][5cm]{0.9\linewidth}
    \centering
    \textbf{\@title}
  \end{minipage}
  \par
  \begin{minipage}[t][5cm]{0.9\linewidth}
    \centering
    \physvsu@InfoThesisType
  \end{minipage}
  \par
  \begingroup
    \newcommand\@signline[2]{
      \parbox[t]{6cm}{##1}\parbox[t]{6cm}{##2}\underline{\hspace{25mm}}\par
    }
    \@signline{\physvsu@strStudent:}{\physvsu@InfoStudent}
    \@signline{\physvsu@strSupervisor:}{\physvsu@InfoSupervisor}
    \@signline{\physvsu@strChair:}{\physvsu@InfoChair}
  \endgroup
  \vfill
  \parbox[t]{\linewidth}{\centering \physvsu@InfoCity{} — \physvsu@InfoYear}
\end{titlepage}}

% --- Named strings ---
\def\physvsu@strStudent    {Студент}
\def\physvsu@strSupervisor {Руководитель}
\def\physvsu@strChair      {Зав.\,кафедрой}
