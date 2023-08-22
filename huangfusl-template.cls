\ProvidesClass{huangfusl-template}
\NeedsTeXFormat{LaTeX2e}

% Document options
    \newif\ifloaded\loadedfalse
    \newif\ifarticle
    \newif\ifbeamer
    \newif\ifbook
    \newif\ifpaper
    \newif\ifstandalone
    \newif\ifcn
    \DeclareOption{article}{
        \ClassInfo{huangfusl-template}{Entering article mode}
        \articletrue\papertrue\standalonefalse
    }
    \DeclareOption{beamer}{
        \ClassInfo{huangfusl-template}{Entering beamer mode}
        \beamertrue\standalonefalse
    }
    \DeclareOption{book}{
        \ClassInfo{huangfusl-template}{Entering book mode}
        \booktrue\papertrue\standalonefalse
    }
    \DeclareOption{standalone}{
        \ClassInfo{huangfusl-template}{Entering standalone mode}
        \standalonetrue
    }
    \DeclareOption{cn}{
        \ClassInfo{huangfusl-template}{Chinese support enabled}
        \cntrue
    }
    \DeclareOption{en}{
        \ClassInfo{huangfusl-template}{Chinese support disabled}
        \cnfalse
    }

% Compatibility control
    % Add new version switches here
    % Switches are backward compatible
    % For example, if enableA is true, enableZero is also true
    % versionX is true if X is the latest version
    \def\@RegisterVersion<#1><#2>{
        \expandafter\newif\csname ifversion#1\endcsname
        \expandafter\newif\csname ifenable#1\endcsname
        \DeclareOption{version=#2}{
            \versionZerofalse
            \csname version#1true\endcsname
            \csname enable#1true\endcsname
        }
    }
    \@RegisterVersion<Zero><0.0>\versionZerotrue % Dummy version
    \@RegisterVersion<A><1.0> % Version 1.0.x
    \@RegisterVersion<B><2.0> % Version 2.0.x

    \ProcessOptions\relax

    % Update latest version here
    % If version not specified, use the latest version
    \ifversionZero
        \ClassWarning{huangfusl-template}{
            Version not specified.
            Latest feature may change in the future.
        }
        \versionAtrue\enableAtrue % Set to the latest version here
    \fi

    % List versions switches here
    \ifenableA\enableZerotrue\fi % Enable the preceding version
    \ifenableB\enableAtrue\fi

    % Usage
    % Use \ifenableX if the feature is to be included in the future
    % Use \ifversionX if the feature is restricted in version X
    % Add \ifenableX\else if the feature is to be removed in version X

% Error processing
    \ifenableA
        \def\@UnknownClassError{
            \ClassError{huangfusl-template}{
                No document class specified
            }{
                Please specify a document class
            }
        }
    \fi

% Version 1.0.x
\ifenableA

    % Check and load document class
    \ifloaded\else
        \ifarticle\LoadClass[a4paper, 12pt]{article}\loadedtrue\fi
        \ifbeamer\LoadClass[aspectratio=169]{beamer}\loadedtrue\fi
        \ifbook\LoadClass[a4paper, 12pt]{book}\loadedtrue\fi
        \ifstandalone\LoadClass[varwidth]{standalone}\loadedtrue\fi

        % if no more versions can be loaded
        \ifloaded\else\ifversionA\@UnknownClassError\fi\fi
    \fi

    % Common packages

    % Hyperlinks and references
    \RequirePackage{hyperref}
    \RequirePackage[sort&compress]{gbt7714}

    % Colors
    \RequirePackage{xcolor} % Color

    % Chinese Support
    \ifcn
    \RequirePackage[zihao=-4]{ctex}
    \fi

    % Styles and fonts
    \RequirePackage[T1]{fontenc}
    \RequirePackage{fontspec}
    \RequirePackage{setspace}
    \RequirePackage{soul}

    % Math
    \RequirePackage{amsmath}
    \RequirePackage{amssymb}

    % Floating objects (figures, tables, etc.)
    \RequirePackage{algorithm2e}
    \RequirePackage{booktabs}
    \RequirePackage{subfigure}

    % Tikz
    \RequirePackage{tikz}
    \RequirePackage{ifthen}
    \RequirePackage{pgf}
    \RequirePackage{pgfplots}
    \RequirePackage{import} % Used to import matplotlib generated pgf plots

    % Standalone mode
    \ifstandalone

    \fi

    % Beamer mode
    \ifbeamer

    \RequirePackage{pdfcomment} % Beamer only
    \RequirePackage{calligra} % Used in \mythanks
    % \RequirePackage{tsinghua} % Obsolete

    % Template config
    \usetheme{Berlin}
    \usecolortheme[rgb={0.0,0.0,0.4}]{structure}
    \useoutertheme{smoothbars}
    \useinnertheme{circles}
    \setbeamertemplate{footline}
    {
        \begin{beamercolorbox}[colsep=1.5pt]{upper separation line foot}
        \end{beamercolorbox}
        \begin{beamercolorbox}[ht=2.5ex,dp=1.125ex,leftskip=.3cm,rightskip=.3cm plus1fil]{author in head/foot}
            {
                \usebeamerfont{author in head/foot}\insertshortauthor
            }
            \hfill
            {
                \usebeamerfont{institute in head/foot}
                \usebeamercolor[fg]{institute in head/foot}
                \insertshortinstitute
            }
        \end{beamercolorbox}
        \begin{beamercolorbox}[ht=2.5ex,dp=1.125ex,leftskip=.3cm,rightskip=.3cm plus1fil]{title in head/foot}
            {
                \usebeamerfont{title in head/foot}\insertshorttitle
            }
            \hfill
            {
                \usebeamerfont{frame number}
                \usebeamercolor[fg]{frame number}
                \insertframenumber~/~\inserttotalframenumber
            }
        \end{beamercolorbox}
        \begin{beamercolorbox}[colsep=1.5pt]{lower separation line foot}
        \end{beamercolorbox}
    }
    \makeatother

    % Table of contents
    \providecommand{\splitsections}{
        \AtBeginSection[]{
            \begin{frame}
                \tableofcontents[
                    sectionstyle        =show/hide,
                    subsectionstyle     =show/show/hide,
                    subsubsectionstyle  =show/show/hide
                ]
            \end{frame}
        }
        \AtBeginSubsection[]{
            \begin{frame}
                \tableofcontents[
                    sectionstyle        =show/hide,
                    subsectionstyle     =show/shaded/hide,
                    subsubsectionstyle  =hide
                ]
            \end{frame}
        }
    }

    % Spacing
    \setlength{\parskip}{6pt}
    \abovedisplayshortskip=0pt
    \belowdisplayshortskip=0pt
    \abovedisplayskip=0pt
    \belowdisplayskip=0pt

    % Hyperlinks and references
    \hypersetup{pdfpagemode=FullScreen}
    \providecommand{\reseteq}{\setcounter{equation}{0}}

    % Misc
    \providecommand{\mythanks}{{\begin{center}\Huge\calligra{Thanks}\end{center}}}
    % Used for Présentation.app
    % http://iihm.imag.fr/blanch/software/osx-presentation/
    \providecommand{\pdfnote}[1]{\marginnote{\pdfcomment[icon=note]{#1}}}
    \fi

    % Article & book mode
    \ifpaper
    \RequirePackage{geometry} % Page layout
    \RequirePackage{fancyhdr} % Headers and footers
    \RequirePackage{enumitem} % Incompatible with beamer
    \RequirePackage{titling} % Hooks for title, author, date

    % Title format
    \pretitle{\begin{center}\huge\bfseries}
    \posttitle{\end{center}}
    \preauthor{\begin{center}\large}
    \postauthor{\end{center}}
    \predate{\begin{center}\large\itshape}
    \postdate{\end{center}}

    \hypersetup{colorlinks=true}
    \setmainfont{Times New Roman}
    \linespread{1.5}

    \pagestyle{fancy}
    \providecommand{\MakeTitle}{\maketitle}
    \providecommand{\TableOfContents}{\tableofcontents}
    \providecommand{\clearheader}{
        \fancyhead{}
        \fancypagestyle{plain}{\fancyhead{}}
        \renewcommand{\headrulewidth}{0pt}
    }
    \providecommand{\clearfooter}{
        \fancyfoot{}
        \fancypagestyle{plain}{\fancyfoot{}}
    }
    \providecommand{\clearhf}{\clearheader\clearfooter}
    \providecommand{\header}{}
    \providecommand{\footer}{}
    \clearhf
    \fi

    % Article mode
    \ifarticle

    % Title
    \setlength{\droptitle}{-1cm}

    % Geometry
    \ifversionA
        \savegeometry{standard}
        \newgeometry{
            top=1in,
            bottom=1in,
            left=1.25in,
            right=1.25in,
        }
        \savegeometry{word-normal}
        \newgeometry{
            top=0.5in,
            bottom=0.5in,
            left=0.5in,
            right=0.5in,
        }
        \savegeometry{word-narrow}
        \newgeometry{
            top=1in,
            bottom=1in,
            left=0.75in,
            right=0.75in,
        }
        \savegeometry{word-moderate}
        \newgeometry{
            top=1in,
            bottom=1in,
            left=2in,
            right=2in,
        }
        \savegeometry{word-wide}
        \loadgeometry{standard}
    \fi

    % Header and footer
    \renewcommand{\header}[1]{
        \renewcommand{\headrulewidth}{1pt}
        \fancyhead[C]{#1}
        \fancypagestyle{plain}{\fancyhead[C]{#1}}
    }
    \renewcommand{\footer}[1]{
        \fancyfoot[C]{#1}
        \fancypagestyle{plain}{\fancyfoot[C]{#1}}
    }
    \header{\thetitle}
    \footer{--\thepage--}
    \fi

    % Book mode
    \ifbook

    % Header and footer
    \renewcommand{\MakeTitle}{\maketitle\thispagestyle{empty}}
    \renewcommand{\TableOfContents}{
        \frontmatter
        \tableofcontents\thispagestyle{fancy}
        \mainmatter
    }
    % Clear header at the beginning of each chapter

    \renewcommand{\header}[1]{
        \renewcommand{\headrulewidth}{1pt}
        \fancyhead[LO, RE]{#1}
        \fancyhead[RO, LE]{\itshape\thepage}
        \fancypagestyle{plain}{
            \fancyhead[LO, RE]{}
            \fancyhead[RO, LE]{\itshape\thepage}
            \renewcommand{\headrulewidth}{0pt}
        }
    }
    \header{\thetitle}
    \fi

    % Common settings

    % Colors
    \colorlet{darkred}{red!60!black}
    \colorlet{darkgreen}{green!60!black}
    \colorlet{darkblue}{blue!60!black}
    \colorlet{lightred}{red!30!white}
    \colorlet{lightgreen}{green!30!white}
    \colorlet{lightblue}{blue!30!white}

    % Math letters
    % Refact: use \@buildmath to build math letters
    \def\@buildmath#1{
        \expandafter\def\csname bb#1\endcsname{\mathbb{#1}}
        \expandafter\def\csname bs#1\endcsname{\boldsymbol{#1}}
        \expandafter\def\csname cal#1\endcsname{\mathcal{#1}}
        \expandafter\def\csname rm#1\endcsname{\mathrm{#1}}
        \expandafter\def\csname bf#1\endcsname{\mathbf{#1}}
    }
    % Cycle through letters
    \def\@buildmathletters#1{
        \ifx#1\relax\else
            \@buildmath{#1}
            \expandafter\@buildmathletters
        \fi
    }
    \@buildmathletters ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz\relax

    % Other math
    % Fix: \geq and \leq
    \renewcommand{\geq}{\geqslant}
    \renewcommand{\leq}{\leqslant}
    \DeclareMathOperator{\Cov}{Cov}
    \DeclareMathOperator{\doop}{do}
    \DeclareMathOperator{\diag}{diag}
    \DeclareMathOperator{\sgn}{sgn}
    \DeclareMathOperator{\dis}{dis}

    % Algorithm
    \SetKw{KwInit}{Initialization}
    \SetKw{KwTo}{to}
    \SetKw{KwReturn}{return}

    % Tikz settings
    \pgfplotsset{compat=1.18}
\fi

\ifenableB
    % Fix: headheight warning
    \ifpaper
        \setlength{\headheight}{15pt}
    \fi

    % Feat: add \subtitle to article class
    \ifarticle
        \newcommand{\subtitle}[1]{\def\@subtitle{#1}}
        \def\@maketitle{
            \newpage
            \null
            \vskip 2em
            \begin{center}
            \let \footnote \thanks
                {\bfseries \LARGE \@title \par}
                \ifdefined\@subtitle
                    \vskip 0.5em
                    {\Large \@subtitle \par}
                \fi
                \vskip 1.5em
                {\large
                \lineskip .5em
                \begin{tabular}[t]{c}
                    \@author
                \end{tabular}\par}
                \vskip 1em
                {\itshape \large \@date}
            \end{center}
            \par
            \vskip 1.5em
        }
    \fi

    % Feat: add `\ssection`, `\ssubsection`, `\ssubsubsection` to hide section number
    \def\@silent#1{
        \expandafter\def\csname @@s#1\endcsname[##1]##2{
            \begingroup
                \let\@seccntformat\@gobble
                \csname #1\endcsname[##1]{##2}
            \endgroup
        }
        \expandafter\def\csname @s#1\endcsname##1{
            \csname @@s#1\endcsname[##1]{##1}
        }
        \expandafter\DeclareRobustCommand\csname s#1\endcsname{
            \@ifnextchar[
                {\csname @@s#1\endcsname}
                {\csname @s#1\endcsname}
        }
    }
    \@silent{section}
    \@silent{subsection}
    \@silent{subsubsection}

    % Deprecate: saved geometry settings

    % Feat: add a new command, `\articlefront`, to provide title and table of contents
    \ifarticle
        \newcommand{\articlefront}{
            \maketitle
            \tableofcontents
            \newpage
        }
    \fi
\fi
