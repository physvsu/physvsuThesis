\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{physvsuThesis}[2018/03/22 Example LaTeX class]

\LoadClass[a4paper,14pt]{extarticle}
\DeclareOption{masterthesis}{\OptionNotUsed}
\DeclareOption{bachelorthesis}{\OptionNotUsed}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{extarticle}}
\ProcessOptions\relax

\RequirePackage[T2A]{fontenc}
\RequirePackage[utf8]{inputenc}
\RequirePackage{csquotes} % since babel insists on it.
\RequirePackage[english,russian]{babel}

% FIXME: Uncomment later.
%\RequirePackage[style=gost-numeric,maxnames=10,language=auto]{biblatex}

\RequirePackage{geometry}
\geometry{
    left=2.5cm,
    right=1.5cm,
    top=1.5cm,
    bottom=1.0cm,
    footskip=1cm,
    includefoot}


\makeatletter

\newcommand\physvsuInfoStudent[1]{\def\physvsu@InfoStudent{#1}}
\newcommand\physvsuInfoSupervisor[1]{\def\physvsu@InfoSupervisor{#1}}
\newcommand\physvsuInfoChair[1]{\def\physvsu@InfoChair{#1}}
\newcommand\physvsuInfoCity[1]{\def\physvsu@InfoCity{#1}}
\newcommand\physvsuInfoYear[1]{\def\physvsu@InfoYear{#1}}
\newcommand\physvsuInfoThesisType[1]{\def\physvsu@InfoThesisType{#1}}
\newcommand\physvsuInfoBoilerplate[1]{\def\physvsu@InfoBoilerplate{#1}}
\newcommand\physvsuInfoFaculty[1]{\def\physvsu@InfoFaculty{#1}}
\newcommand\physvsuInfoDepartment[1]{\def\physvsu@InfoDepartment{#1}}
\newcommand\physvsuInfoAllowedBy[1]{\def\physvsu@InfoAllowedBy{#1}}

\renewcommand\@maketitle{%
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
  \def\@uline{\underline{\hspace{25mm}}}
  \parbox[t]{6cm}{Студен:}\parbox[t]{6cm}{\physvsu@InfoStudent}\@uline\par
  \parbox[t]{6cm}{Руководитель:}\parbox[t]{6cm}{\physvsu@InfoSupervisor}\@uline\par
  \parbox[t]{6cm}{Заведующий кафедрой:}\parbox[t]{6cm}{\physvsu@InfoChair}\@uline\par
  \vfill
  \parbox[t]{\linewidth}{\centering \physvsu@InfoCity — \physvsu@InfoYear}
\end{titlepage}}


\makeatother
