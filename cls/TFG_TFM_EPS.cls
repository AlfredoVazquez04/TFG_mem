%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plantilla para os traballos TFG/TFM da EPS de Enxeñaría
% Ficheiro de clase
% Version 1.0 (12/2/18)
%
% Notas:
% Este ficheiro de clase define a estrutura do documento principal (main.tex).
%
% Class license:
% LPPL v1.3c (http://www.latex-project.org/lppl)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%----------------------------------------------------------------------------------------
%	DEFINCIÓN DA CLASE E PAQUETES
%----------------------------------------------------------------------------------------

%Paquetes requiridos para linguas latinas
\RequirePackage[utf8]{inputenc}
\RequirePackage[T1]{fontenc}
\RequirePackage{lipsum} %para meter texto lorem ipsum
\providecommand{\baseclass}{book}
\RequirePackage{etoolbox}
\RequirePackage{xparse}
\newbool{nolistspace}
\newbool{chapteroneline}
\newbool{listtoc}
\newbool{toctoc}
\newbool{parskip}
\newbool{hyperrefsupport}
\booltrue{hyperrefsupport}
\newbool{headsepline}
\newbool{consistentlayout}

\DeclareOption{nohyperref}{\boolfalse{hyperrefsupport}}
\DeclareOption{nolistspacing}{\booltrue{nolistspace}}
\DeclareOption{liststotoc}{\booltrue{listtoc}}
\DeclareOption{chapterinoneline}{\booltrue{chapteroneline}}
\DeclareOption{toctotoc}{\booltrue{toctoc}}
\DeclareOption{parskip}{\booltrue{parskip}}
\DeclareOption{headsepline}{\booltrue{headsepline}}
\DeclareOption{consistentlayout}{\booltrue{consistentlayout}}
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{\baseclass}}

\ProcessOptions\relax

\LoadClass{\baseclass}


%Unha interfaz simple para que o usuario customice os títulos dos capítulos
\ProvideDocumentCommand{\abovechapterskip}{}{\vspace*{20pt}}
\ProvideDocumentCommand{\chapterbelowskip}{}{\vspace*{40pt}}
\ProvideDocumentCommand{\chapterinbetweenskip}{}{\vspace*{20pt}}
\ProvideDocumentCommand{\autodot}{}{}
\ProvideDocumentCommand{\mdtChapapp}{}{}
\ProvideDocumentCommand{\chapteralign}{}{\raggedright}
\ProvideDocumentCommand{\chapterfont}{}{\Huge\bfseries}
\ProvideDocumentCommand{\chapterprefixfont}{}{\LARGE\bfseries}
\DeclareDocumentCommand{\@makechapterhead}{ m }{%
	\abovechapterskip
	{\parindent \z@ \chapteralign \normalfont
		\ifnum \c@secnumdepth >\m@ne
		\if@mainmatter
		\ifbool{chapteroneline}{%
			\chapterfont \mdtChapapp\thechapter\autodot\enspace
		}{%
			\chapterprefixfont \@chapapp\space \thechapter
			\par\nobreak
			\chapterinbetweenskip
		}%
		\fi
		\fi
		\interlinepenalty\@M%
		\chapterfont #1\par\nobreak
		\chapterbelowskip
	}
	\thispagestyle{\chapter@p@gestyle}
}
\def\@makeschapterhead#1{%
	\abovechapterskip
	{\parindent \z@ \chapteralign
		\normalfont
		\interlinepenalty\@M
		\chapterfont  #1\par\nobreak
		\chapterbelowskip
	}
	\thispagestyle{\chapter@p@gestyle}
}


% Addchap provides unnumbered chapters with an entry in the table of contents as well as an updated header
\ProvideDocumentCommand{\addchap}{ s o m }{%
	\chapter*{#3}%
	\markboth{}{}%
	\IfBooleanTF{#1}{%
	}{%
		\IfNoValueTF{#2}{%
			\addchaptertocentry{#3}%
			\markboth{\MakeMarkcase{#3}}{\MakeMarkcase{#3}}%
		}{%
			\addchaptertocentry{#2}%
			\markboth{\MakeMarkcase{#2}}{\MakeMarkcase{#2}}%
		}%
	}%
}%

\ProvideDocumentCommand{\addsec}{ s o m }{%
	\section*{#3}%
	\markright{}%
	\IfBooleanTF{#1}{%
	}{%
		\IfNoValueTF{#2}{%
			\addcontentsline{toc}{section}{#3}%
			\markright{\MakeMarkcase{#3}}%%
		}{%
			\addcontentsline{toc}{section}{#2}%
			\markright{\MakeMarkcase{#2}}%
		}%
	}%
}%





%----------------------------------------------------------------------------------------
%	OPCIÓNS DA CLASE
%----------------------------------------------------------------------------------------

\ifbool{parskip}{\RequirePackage{parskip}} % Se a opción parskip se lle pasa a clase, cargase o paquete parskip


\ifbool{listtoc}{% Se a opción  liststotoc se lle pasa a clase, engadese a lista táboa de contidos
	\patchcmd{\listoftables}{\@starttoc{lot}}{%
		\addchaptertocentry{\listtablename}\@starttoc{lot}%
	}{}{}%
	\patchcmd{\listoffigures}{\@starttoc{lof}}{%
		\addchaptertocentry{\listfigurename}\@starttoc{lof}%
	}{}{}%
}

\ifbool{toctoc}{% Se a opcion toctotoc se lle pasa a clase, engadese a táboa de contidos á táboa de contidos
	\patchcmd{\tableofcontents}{\@starttoc{toc}%
}{%
	\addchaptertocentry{\contentsname}\@starttoc{toc}}{}{}%
}

\patchcmd{\tableofcontents}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\tableofcontents}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\listoffigures}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\listoffigures}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\listoftables}{\MakeUppercase}{\MakeMarkcase}{}{}
\patchcmd{\listoftables}{\MakeUppercase}{\MakeMarkcase}{}{}

% If the option `nolistspacing' is given, the spacing in the different lists is reduced to single spacing. This option is only useful, if the spacing of the document has been changed to onehalfspacing or doublespacing.
\ifbool{nolistspace}{
	\patchcmd{\listoffigures}{%
		\@starttoc{lof}
	}{%
		\begingroup%
		\singlespace\@starttoc{lof}\endgroup%
	}{}{}%
	\patchcmd{\listoftables}{%
		\@starttoc{lot}
	}{%
		\begingroup%
		\singlespace\@starttoc{lot}\endgroup%
	}{}{}%
	\patchcmd{\tableofcontents}{%
		\@starttoc{toc}
	}{%
		\begingroup%
		\singlespace\@starttoc{toc}\endgroup%
	}{}{}%
}{}


%----------------------------------------------------------------------------------------
%	PAQUETES REQUIRIDOS
%----------------------------------------------------------------------------------------
\RequirePackage[paper=A4,pagesize]{typearea}
\RequirePackage{afterpage}
\RequirePackage{mathpazo} % Empregamos a fonte Palatino por defecto
\RequirePackage{pdfpages} %para incluir documentos pdf
\RequirePackage{babel} % Required for automatically changing names of document elements to languages besides english
\RequirePackage{scrbase} % Required for handling language-dependent names of sections/document elements
\RequirePackage{scrhack} % Loads fixes for various packages
\RequirePackage{setspace} % Required for changing line spacing
\RequirePackage{longtable} % Required for tables that span multiple pages (used in the symbols, abbreviations and physical constants pages)
\RequirePackage{supertabular}
\RequirePackage{booktabs}
\RequirePackage{color} %include colors
\RequirePackage[absolute,overlay]{textpos} %posicionamento de obxectos en coord absolutas
\RequirePackage{siunitx} % Required for \SI commands
\RequirePackage{graphicx} % Required to include images
\RequirePackage{booktabs} % Required for better table rules
\RequirePackage{caption} % Required for customising the captions
\captionsetup{justification=centerlast,font=small,labelfont=sc,margin=50pt}



%----------------------------------------------------------------------------------------
%	DEFINIMOS OS COMANDOS COA INFORMACIÓN DO TFG/TFM
%----------------------------------------------------------------------------------------

\NewDocumentCommand{\thesistitle} { o m }{%
 \IfValueTF{#1}{\def\shorttitle{#1}}{\def\shorttitle{#2}}%
 \def\@title{#2}%
 \def\ttitle{#2}%
}
\DeclareDocumentCommand{\author}{m}{\newcommand{\authorname}{#1}\renewcommand{\@author}{#1}}
\NewDocumentCommand{\supervisor}{m}{\newcommand{\supname}{#1}}
\NewDocumentCommand{\department}{m}{\newcommand{\deptname}{#1}}
\NewDocumentCommand{\supervisorseg}{m}{\newcommand{\supnameseg}{#1}}
\NewDocumentCommand{\departmentseg}{m}{\newcommand{\deptnameseg}{#1}}
\NewDocumentCommand{\supervisorter}{m}{\newcommand{\supnameter}{#1}}
\NewDocumentCommand{\departmentter}{m}{\newcommand{\deptnameter}{#1}}
\NewDocumentCommand{\examiner}{m}{\newcommand{\examname}{#1}}

\def \tipotraballo {Trabajo Fin de Grado} % Traballo Fin de Grao ou Traballo de Fin de Máster
\def \degreename{Grado en Robótica} % Grado ou Máster, imprimese na páxina do títilo e na do resume,  amosase co comando \degreename
% \NewDocumentCommand{\degree}{m}{\newcommand{\degreename}{#1}}

\NewDocumentCommand{\addresses}{m}{\newcommand{\addressname}{#1}}

%Institución e centro
\def \univname{\href{http://www.usc.es}{Universidade de Santiago de Compostela}} % Nome e URL da universidade. Amósase co nome \univname
\def \facname{\href{https://www.usc.gal/es/centro/escuela-politecnica-superior-ingenieria}{Escola Politécnica Superior de Enxeñaría}} % Nome e URL da Escola. Amósase co nome \facname
% \NewDocumentCommand{\university}{m}{\newcommand{\univname}{#1}}
\NewDocumentCommand{\group}{m}{\newcommand{\groupname}{#1}}
% \NewDocumentCommand{\faculty}{m}{\newcommand{\facname}{#1}}
\NewDocumentCommand{\subject}{m}{\newcommand{\subjectname}{#1}}
\NewDocumentCommand{\keywords}{m}{\newcommand{\keywordnames}{#1}}

\newcommand{\checktoopen}{
	\if@openright\cleardoublepage\else\clearpage\fi
	\ifdef{\phantomsection}{\phantomsection}{}% The \phantomsection command is necessary for hyperref to jump to the correct page
}

\NewDocumentCommand{\bhrule}{}{\typeout{--------------------}}
\NewDocumentCommand{\tttypeout}{m}{\bhrule\typeout{\space #1}\bhrule}

\newcommand{\HRule}{\rule{.9\linewidth}{.6pt}}
\newcommand{\decoRule}{\rule{.4\textwidth}{.4pt}} % Rgra baixo as figuras

\setcounter{tocdepth}{3} % Profundidade que se imprime no indice
\ProvideDocumentCommand{\addchaptertocentry}{ m }{%
	\addcontentsline{toc}{chapter}{#1}%
}

%----------------------------------------------------------------------------------------
%	CORES
%----------------------------------------------------------------------------------------

\usepackage{xcolor} % Requirido para customizar as cores
\colorlet{mdtRed}{red!50!black}

%Cores empregadas no deseño da tapa
\definecolor{cpiGray}{RGB}{106,100,100}
\definecolor{cpiOrange}{RGB}{241,85,44}
\definecolor{azulUSC}{RGB}{1,66,137}
\definecolor{verdeCTERRA}{RGB}{110,131,132}


%----------------------------------------------------------------------------------------
%	MARXES
%----------------------------------------------------------------------------------------

\RequirePackage{geometry}
\geometry{
	headheight=4ex,
	includehead,
	includefoot
}

\raggedbottom

%----------------------------------------------------------------------------------------
%	PENALIZACIÓNS
%----------------------------------------------------------------------------------------

\doublehyphendemerits=10000
\brokenpenalty=10000 % non romper palabras a traves de columnas/paxinas
\widowpenalty=9999
\clubpenalty=9999
\interfootnotelinepenalty=9999 % Nunca romper os footnotes

%----------------------------------------------------------------------------------------
%	CABECEIRAS E FONDALES
%----------------------------------------------------------------------------------------

\RequirePackage[markcase=used]{scrlayer-scrpage}
\providepairofpagestyles{thesisSimple}{%
	\clearpairofpagestyles%
	\automark[chapter]{chapter}
	\ihead{\headmark}
	\cfoot[\pagemark]{\pagemark}
}
\ifoot{}% Inner footer
\ofoot{}% Outer footer
\pagestyle{thesisSimple}
\providepairofpagestyles[thesisSimple]{thesis}{%
	\automark*[section]{}%
}
\providepairofpagestyles[thesisSimple]{review}{%
	\ofoot[\shorttitle/\authorname]{\shorttitle/\authorname}
	\ifoot[\today]{\today}
}
\pagestyle{thesis}
\ifbool{headsepline}{\KOMAoption{headsepline}{true}}{}
\PreventPackageFromLoading[\ClassError{\classname}{Package `fancyhdr' is
incompatible\MessageBreak with this class}{The pagesyles are defined
	using package `scrlayer-scrpage', please consult the\MessageBreak
KOMA-script documentation for details.}]{fancyhdr}


%\newcommand{\blank@p@gestyle}{empty}
\newcommand{\blank@p@gestyle}{plain}
\newcommand{\chapter@p@gestyle}{plain}
\NewDocumentCommand{\blankpagestyle}{ m }{%
	\ClassWarning{\classname}{\string\blankpagestyle\space is
	obsolete,\MessageBreak use \string\setblankpagestyle \space  instead}\renewcommand{\blank@p@gestyle}{}{#1}
}
\NewDocumentCommand{\setblankpagestyle}{ m }{\renewcommand{\blank@p@gestyle}{#1}}
\NewDocumentCommand{\setchapterpagestyle}{ m }{\renewcommand{\chapter@p@gestyle}{#1}}

\DeclareDocumentCommand\cleardoublepage{}{\clearpage\if@twoside \ifodd\c@page\else
	\hbox{}
	\thispagestyle{\blank@p@gestyle}
	\newpage
	\if@twocolumn\hbox{}\newpage\fi\fi\fi%
}

%----------------------------------------------------------------------------------------
%	DESEÑO DA PÁXINA DE ABEREVIACIÓNS
%----------------------------------------------------------------------------------------

\newcommand{\abbrevname}{Lista de Abreviaciones}
%\providecaptionname{spanish}{\abbrevname}{Lista de Abreviacións}

\NewDocumentEnvironment{abbreviations}{ m }{%
	\ifbool{nolistspace}{\begingroup\singlespacing}{}
	\ifbool{listtoc}{\addchap{\abbrevname}}{\addchap*{\abbrevname}}
	\begin{supertabular}{#1}
	}{%
	\end{supertabular}
	\addtocounter{table}{-1}% Don't count this table as one of the document tables
	\ifbool{nolistspace}{\endgroup}{}
}

%----------------------------------------------------------------------------------------
%	DESEÑO DA PAXINA RESUMO
%----------------------------------------------------------------------------------------

\DeclareDocumentCommand{\abstractauthorfont}{}{}
\DeclareDocumentCommand{\abstracttitlefont}{}{}
\newcommand{\byname}{por}
\newcommand{\abstractname}{Resumo}
\newcommand{\palabrasChave}{Palabras Chave: }
%\providecaptionname{german,ngerman,austrian,naustrian}{\byname}{von}
%\providecaptionname{spanish}{\abstractname}{Resumo}
\ifbool{consistentlayout}{
	\DeclareDocumentEnvironment{abstract}{ O{} }{%
		\addchap*{\abstractname}%
		{\chapteralign\normalsize\abstractauthorfont \authorname \par}% Author name
		\vspace{\baselineskip}
		{\chapteralign\parbox{.7\linewidth}{\chapteralign\normalsize\itshape\abstracttitlefont\@title}\par}% Thesis title
		\bigskip\noindent\ignorespaces
	}%
	{}%end alt-abstract
}{%
	\DeclareDocumentEnvironment{abstract}{ O{\ttitle} }{
		\cleardoublepage % Asegura que empiece en página nueva
		% \tttypeout{\abstractname} <-- ELIMINADO: esto causaba el texto plano
		\thispagestyle{plain}
		\begin{center}
			{\Huge\textit{\abstractname} \par}
			\bigskip
			{\huge\bfseries #1 \par} % Tu título personalizado o el por defecto
			\medskip
			{\normalsize \byname{}\\ \authorname \par}
			\bigskip
			{\normalsize \textbf{\palabrasChave} \keywordnames \par}
			\bigskip
		\end{center}
	}
	{
		\vfill\null
	}
}

\DeclareDocumentEnvironment{extraAbstract}{ O{\null\vfill} }{
	\checktoopen
	\tttypeout{\abstractname}
	#1%added to be able to have abstract more than one page long
	\thispagestyle{empty}
	\begin{center}
		%{\normalsize \MakeUppercase{\univname} \par}% University name in capitals
		%\bigskip
		{\Huge\textit{\abstractname} \par}
		\bigskip
		%{\normalsize \facname \par}% Faculty name
		%{\normalsize \deptname \par}% Department name
		%\bigskip
		%{\normalsize \degreename\par}% Degree name
		%\bigskip
		{\huge\bfseries \@title \par}% Thesis title
		\medskip
		{\normalsize \byname{}\\ \authorname \par}% Author name
		\bigskip
		{\normalsize \textbf{Palabras Clave:} {\keywordnames} \par}% palabras clave
		\bigskip
	\end{center}
}
{
	\vfill\null
}

%----------------------------------------------------------------------------------------
%	DESEÑO DA PÁXINA DE AGRADECEMENTOS
%----------------------------------------------------------------------------------------

\usepackage{xcolor}
\colorlet{mdtRed}{red!50!black}
\newcommand{\acknowledgementname}{Agradecimientos}

\ifbool{consistentlayout}{
	\DeclareDocumentEnvironment{acknowledgements}{}{%
		\tttypeout{\acknowledgementname}
		\addchap*{\acknowledgementname}
	}
}
{
	\DeclareDocumentEnvironment{acknowledgements}{}{%
		\checktoopen
		\tttypeout{\acknowledgementname}
		\thispagestyle{plain}
		\begin{center}{\huge\textit{\acknowledgementname}\par}\end{center}
	}
	{
		\vfil\vfil\null
	}
}

%----------------------------------------------------------------------------------------
%	DESEÑO DA PAXINA DE AUTORIZACIÓN
%----------------------------------------------------------------------------------------

\newcommand{\authorshipname}{Autorización}
%\providecaptionname{galician}{Declaración de Autoría}


\ifbool{consistentlayout}{
	\DeclareDocumentEnvironment{declaration}{}{
		\addchap*{\authorshipname}
		}{}%
}{
	\DeclareDocumentEnvironment{declaration}{}{
		\checktoopen
		\tttypeout{\authorshipname}
		\thispagestyle{plain}
		\null\vfil
		{\noindent\huge\bfseries\authorshipname\par\vspace{10pt}}
	}{}
}




%----------------------------------------------------------------------------------------
%	DESEÑO DA PAXINA DE VISTO E PRACE DO TITOR
%----------------------------------------------------------------------------------------

\newcommand{\titorshipname}{Visto e Prace do Titor}
\ifbool{consistentlayout}{
	\DeclareDocumentEnvironment{titor}{}{
		\addchap*{\titorshipname}
	}{}%
}{
	\DeclareDocumentEnvironment{titor}{}{
		\checktoopen
		\tttypeout{\titorshipname}
		\thispagestyle{plain}
		\null\vfil
		{\noindent\huge\bfseries\titorshipname\par\vspace{10pt}}
	}{}
}



%----------------------------------------------------------------------------------------
%	DESEÑO DA PÁXINA DE DIDICATORIA
%----------------------------------------------------------------------------------------

\ifbool{consistentlayout}{
	\DeclareDocumentCommand{\dedicatory}{
		m O{\vspace*{.7\textheight} }  }{
			\checktoopen\tttypeout{Dedicatory}
			\markboth{}{}
			#2
			{\hfill\parbox{.4\textwidth}{\flushright#1\par}}
		}
}{
	\newcommand\dedicatory[1]{
		\checktoopen
		\tttypeout{Dedicatory}
		\null\vfil
		\thispagestyle{plain}
		\begin{center}{\Large\slshape #1}\end{center}
		\vfil\null
	}
}


%----------------------------------------------------------------------------------------
%	DESEÑO DA PÁXINA PARA DEFINIR CONSTANTES
%----------------------------------------------------------------------------------------

\newcommand{\constantsname}{Constantes Empleadas}


\NewDocumentEnvironment{constants}{ m }{%
	\ifbool{nolistspace}{\begingroup\singlespacing}{}
	\ifbool{listtoc}{\addchap{\constantsname}}{\addchap*{\constantsname}}
	\begin{supertabular}{#1}
	}{%
	\end{supertabular}
	\addtocounter{table}{-1}% Non contamos esta táboa
	\ifbool{nolistspace}{\endgroup}{}
}

%----------------------------------------------------------------------------------------
%	DESEÑO DA PÁXINA DE SÍMBOLOS
%----------------------------------------------------------------------------------------

\newcommand{\symbolsname}{Lista de Símbolos}


\NewDocumentEnvironment{symbols}{ m }{%
	\ifbool{nolistspace}{\begingroup\singlespacing}{}
	\ifbool{listtoc}{\addchap{\symbolsname}}{\addchap*{\symbolsname}}
	\begin{supertabular}{#1}
	}{%
	\end{supertabular}
	\addtocounter{table}{-1}% Non contamos esta táboa
	\ifbool{nolistspace}{\endgroup}{}
}

%----------------------------------------------------------------------------------------

\ifbool{hyperrefsupport}{% Se a clase nohyperref non foi especificada
\AtEndPreamble{\RequirePackage{hyperref}
\hypersetup{pdfpagemode={UseOutlines},
bookmarksopen=true,
bookmarksopenlevel=0,
hypertexnames=false,
colorlinks=true,% Asignar a false para desabilitar a cor das ligazóns
citecolor=magenta,% Especificamos a cor das referencias
linkcolor=red,% Especificamos a cor das referencia a lugares do documento (secións, figuras, etc)
urlcolor=mdtRed,% Cor das ligazóns a recursos de Internet (URLs)
pdfstartview={FitV},
unicode,
breaklinks=true,
}

\pdfstringdefDisableCommands{
	\let\\\space%
}
	}
}{%nothing
}

%----------------------------------------------------------------------------------------

\endinput
% lazyLizardTracer
