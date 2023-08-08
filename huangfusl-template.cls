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
    \DeclareOption{article}{\articletrue\papertrue\standalonefalse}
    \DeclareOption{beamer}{\beamertrue\standalonefalse}
    \DeclareOption{book}{\booktrue\papertrue\standalonefalse}
    \DeclareOption{standalone}{\standalonetrue}
    \DeclareOption{cn}{\cntrue}
    \DeclareOption{en}{\cnfalse}

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
    \RequirePackage{calligra}
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
    \providecommand{\bba}{\mathbb a}
    \providecommand{\bbb}{\mathbb b}
    \providecommand{\bbc}{\mathbb c}
    \providecommand{\bbd}{\mathbb d}
    \providecommand{\bbe}{\mathbb e}
    \providecommand{\bbf}{\mathbb f}
    \providecommand{\bbg}{\mathbb g}
    \providecommand{\bbh}{\mathbb h}
    \providecommand{\bbi}{\mathbb i}
    \providecommand{\bbj}{\mathbb j}
    \providecommand{\bbk}{\mathbb k}
    \providecommand{\bbl}{\mathbb l}
    \providecommand{\bbm}{\mathbb m}
    \providecommand{\bbn}{\mathbb n}
    \providecommand{\bbo}{\mathbb o}
    \providecommand{\bbp}{\mathbb p}
    \providecommand{\bbq}{\mathbb q}
    \providecommand{\bbr}{\mathbb r}
    \providecommand{\bbs}{\mathbb s}
    \providecommand{\bbt}{\mathbb t}
    \providecommand{\bbu}{\mathbb u}
    \providecommand{\bbv}{\mathbb v}
    \providecommand{\bbw}{\mathbb w}
    \providecommand{\bbx}{\mathbb x}
    \providecommand{\bby}{\mathbb y}
    \providecommand{\bbz}{\mathbb z}
    \providecommand{\bbA}{\mathbb A}
    \providecommand{\bbB}{\mathbb B}
    \providecommand{\bbC}{\mathbb C}
    \providecommand{\bbD}{\mathbb D}
    \providecommand{\bbE}{\mathbb E}
    \providecommand{\bbF}{\mathbb F}
    \providecommand{\bbG}{\mathbb G}
    \providecommand{\bbH}{\mathbb H}
    \providecommand{\bbI}{\mathbb I}
    \providecommand{\bbJ}{\mathbb J}
    \providecommand{\bbK}{\mathbb K}
    \providecommand{\bbL}{\mathbb L}
    \providecommand{\bbM}{\mathbb M}
    \providecommand{\bbN}{\mathbb N}
    \providecommand{\bbO}{\mathbb O}
    \providecommand{\bbP}{\mathbb P}
    \providecommand{\bbQ}{\mathbb Q}
    \providecommand{\bbR}{\mathbb R}
    \providecommand{\bbS}{\mathbb S}
    \providecommand{\bbT}{\mathbb T}
    \providecommand{\bbU}{\mathbb U}
    \providecommand{\bbV}{\mathbb V}
    \providecommand{\bbW}{\mathbb W}
    \providecommand{\bbX}{\mathbb X}
    \providecommand{\bbY}{\mathbb Y}
    \providecommand{\bbZ}{\mathbb Z}
    \providecommand{\bsa}{\boldsymbol a}
    \providecommand{\bsb}{\boldsymbol b}
    \providecommand{\bsc}{\boldsymbol c}
    \providecommand{\bsd}{\boldsymbol d}
    \providecommand{\bse}{\boldsymbol e}
    \providecommand{\bsf}{\boldsymbol f}
    \providecommand{\bsg}{\boldsymbol g}
    \providecommand{\bsh}{\boldsymbol h}
    \providecommand{\bsi}{\boldsymbol i}
    \providecommand{\bsj}{\boldsymbol j}
    \providecommand{\bsk}{\boldsymbol k}
    \providecommand{\bsl}{\boldsymbol l}
    \providecommand{\bsm}{\boldsymbol m}
    \providecommand{\bsn}{\boldsymbol n}
    \providecommand{\bso}{\boldsymbol o}
    \providecommand{\bsp}{\boldsymbol p}
    \providecommand{\bsq}{\boldsymbol q}
    \providecommand{\bsr}{\boldsymbol r}
    \providecommand{\bss}{\boldsymbol s}
    \providecommand{\bst}{\boldsymbol t}
    \providecommand{\bsu}{\boldsymbol u}
    \providecommand{\bsv}{\boldsymbol v}
    \providecommand{\bsw}{\boldsymbol w}
    \providecommand{\bsx}{\boldsymbol x}
    \providecommand{\bsy}{\boldsymbol y}
    \providecommand{\bsz}{\boldsymbol z}
    \providecommand{\bsA}{\boldsymbol A}
    \providecommand{\bsB}{\boldsymbol B}
    \providecommand{\bsC}{\boldsymbol C}
    \providecommand{\bsD}{\boldsymbol D}
    \providecommand{\bsE}{\boldsymbol E}
    \providecommand{\bsF}{\boldsymbol F}
    \providecommand{\bsG}{\boldsymbol G}
    \providecommand{\bsH}{\boldsymbol H}
    \providecommand{\bsI}{\boldsymbol I}
    \providecommand{\bsJ}{\boldsymbol J}
    \providecommand{\bsK}{\boldsymbol K}
    \providecommand{\bsL}{\boldsymbol L}
    \providecommand{\bsM}{\boldsymbol M}
    \providecommand{\bsN}{\boldsymbol N}
    \providecommand{\bsO}{\boldsymbol O}
    \providecommand{\bsP}{\boldsymbol P}
    \providecommand{\bsQ}{\boldsymbol Q}
    \providecommand{\bsR}{\boldsymbol R}
    \providecommand{\bsS}{\boldsymbol S}
    \providecommand{\bsT}{\boldsymbol T}
    \providecommand{\bsU}{\boldsymbol U}
    \providecommand{\bsV}{\boldsymbol V}
    \providecommand{\bsW}{\boldsymbol W}
    \providecommand{\bsX}{\boldsymbol X}
    \providecommand{\bsY}{\boldsymbol Y}
    \providecommand{\bsZ}{\boldsymbol Z}
    \providecommand{\cala}{\mathcal a}
    \providecommand{\calb}{\mathcal b}
    \providecommand{\calc}{\mathcal c}
    \providecommand{\cald}{\mathcal d}
    \providecommand{\cale}{\mathcal e}
    \providecommand{\calf}{\mathcal f}
    \providecommand{\calg}{\mathcal g}
    \providecommand{\calh}{\mathcal h}
    \providecommand{\cali}{\mathcal i}
    \providecommand{\calj}{\mathcal j}
    \providecommand{\calk}{\mathcal k}
    \providecommand{\call}{\mathcal l}
    \providecommand{\calm}{\mathcal m}
    \providecommand{\caln}{\mathcal n}
    \providecommand{\calo}{\mathcal o}
    \providecommand{\calp}{\mathcal p}
    \providecommand{\calq}{\mathcal q}
    \providecommand{\calr}{\mathcal r}
    \providecommand{\cals}{\mathcal s}
    \providecommand{\calt}{\mathcal t}
    \providecommand{\calu}{\mathcal u}
    \providecommand{\calv}{\mathcal v}
    \providecommand{\calw}{\mathcal w}
    \providecommand{\calx}{\mathcal x}
    \providecommand{\caly}{\mathcal y}
    \providecommand{\calz}{\mathcal z}
    \providecommand{\calA}{\mathcal A}
    \providecommand{\calB}{\mathcal B}
    \providecommand{\calC}{\mathcal C}
    \providecommand{\calD}{\mathcal D}
    \providecommand{\calE}{\mathcal E}
    \providecommand{\calF}{\mathcal F}
    \providecommand{\calG}{\mathcal G}
    \providecommand{\calH}{\mathcal H}
    \providecommand{\calI}{\mathcal I}
    \providecommand{\calJ}{\mathcal J}
    \providecommand{\calK}{\mathcal K}
    \providecommand{\calL}{\mathcal L}
    \providecommand{\calM}{\mathcal M}
    \providecommand{\calN}{\mathcal N}
    \providecommand{\calO}{\mathcal O}
    \providecommand{\calP}{\mathcal P}
    \providecommand{\calQ}{\mathcal Q}
    \providecommand{\calR}{\mathcal R}
    \providecommand{\calS}{\mathcal S}
    \providecommand{\calT}{\mathcal T}
    \providecommand{\calU}{\mathcal U}
    \providecommand{\calV}{\mathcal V}
    \providecommand{\calW}{\mathcal W}
    \providecommand{\calX}{\mathcal X}
    \providecommand{\calY}{\mathcal Y}
    \providecommand{\calZ}{\mathcal Z}
    \providecommand{\dd}{\mathrm d}

    % Other math
    \providecommand{\geq}{\geqslant}
    \providecommand{\leq}{\leqslant}
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
