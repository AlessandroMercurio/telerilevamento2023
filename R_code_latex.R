# Create an article with Latex 

\documentclass[a4paper,12pt]{article} # define the tipe of document and is structure

\usepackage[utf8]{inputenc}  # for encoding
\usepackage{graphicx} # package for graphs
\usepackage{color} # for colors
\usepackage{lineno} # for line numbers
\usepackage{hyperref} # to create hyperlinks
\usepackage{natbib} # for bibliography
\usepackage{listings} # to insert external code into the code

\documentclass[a4paper,12pt]{article}





\linenumbers
%  COLORI TESTO 
%  items

\title{This is my first LaTeX document!}
\author{Duccio Rocchini $^1$, Student2 $^2$}

% le funzioni in latex si indicano con \ e gli argomenti vanno all'interno di parentesi graffe

\begin{document}
\maketitle

$^1$ Alma Mater Studiorum University of Bologna

$^2$ NASA

\tableofcontents

\begin{abstract}
Here is the abstract of my Master Thesis.

The Master Thesis is dealing with something.

Concluding, I made beautiful science.
\end{abstract}
