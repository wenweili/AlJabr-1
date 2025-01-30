This is the LaTeX source for the textbook **Methods of Algebra** (in Chinese: 代数学方法), Volume 1, revised version (February 2023).

The book is originally published in 2019 by Higher Education Press (Beijing), ISBN 978-7-04-050725-6. The revised version has been published.

The PDF version and the errata are available on the author's web page. The contents in this revised version are "frozen": the spotted mistakes will be corrected in the next revision/edition.

It is hoped that these files will be of some help to those professors, students as well as amateurs who wish to write serious Chinese books in Mathematics or Physics without too much TeXnical trouble.

# How to compile

## System requirements
The files are to be compiled using XeLaTeX with the xeCJK package. The reader is assumed to work under the UN*X + bash environment.

The recipes below can be tweaked to work under Windows, but this is not recommended. The simplest solution is to go open-source.

We only need the standard packages and fonts, such as
- [TeX Live](https://tug.org/texlive), including the programs latexmk, xindy and biber.
- Standard fonts included in TeX Live, in particular the Fandol fonts. For some strange reason I used and installed the TeX Gyre Heros fonts in the system. In case of error messages related to these fonts, please look for the OTF files (inside the directories in your computer which store TeX-related fonts) whose names start with **texgyreheros**, and install them manually in your system.
- The **Noto Sans CJK SC** fonts from [Noto CJK](https://github.com/googlei18n/noto-cjk), which should also be installed system-wide.

Make sure that all the relevant packages/programs are installed. For reference, the author made the compilation using Arch-based Linux distributions with TeX Live 2018 and/or 2020; the packages **biber** and **texlive-science** are required.

## Clone the files
Assume that [Git](https://git-scm.com/) has been installed on your computer. As a preparation for the compilation process, we will clone the files into `~/AlJabr-1` in our home directory. In command line, type
```
cd ~
git clone https://github.com/wenweili/AlJabr-1
```

All the source files are encoded in UTF-8, which is the de facto standard for storing multilingual texts. If you encounter problems in opening the source files under Windows, try to re-configure your editor or convert the encoding manually.

## Compile the TeX source

Move to the directory
```
cd ~/AlJabr-1
```
Then, either type
```
latexmk -pdf -pdflatex="xelatex -shell-escape -interaction=nonstopmode %O %S" Al-jabr-1
```
under bash, or more simply
```
make
```

Have a cup of coffee since this will take several minutes. The resulting PDF file should appear as **Al-jabr-1.pdf** in the same directory. Note that the main file is **Al-jabr-1.tex**.

To clean up everything in our directory except the PDF file, type
```
make clean
```

# The document class AJbook
The book is written in the **AJbook** class (AJbook.cls). This is a general-purpose document class, based on XeLaTeX/xeCJK and the standard book class in LaTeX, whose aim is to produce Chinese books in Mathematics/Physics of professional quality. Its basic usage is illustrated in Template-AJbook.tex; type
```
latexmk -pdf -pdflatex="xelatex -shell-escape -interaction=nonstopmode %O %S" Template-AJbook
```
or more simply
```
make template
```
to compile the template.

The fonts and other apppearances are customizable through several config files; please read the source files carefully for further details. The Template-AJbook.tex file follows the original configurations of the book.

# The errata
The errata is produced from **Errata-Al-jabr-1.tex**, which is based on the really simple document class file **AJerrata.cls**. Apart from the standard fonts bundled with TeX, it also depends on **Noto Serif CJK SC** and **Noto Sans CJK SC**; you can install them from [Noto CJK fonts](https://github.com/googlei18n/noto-cjk).

To compile the errata, type
```
xelatex Errata-Al-jabr-1
```
or
```
make errata
```
in the same directory.

The errata to the previous editions are named as **Errata-Al-jabr-1-v0.tex**, and so forth.

# Feedback
In case of problems of compilation, please kindly report to the author. Make sure that all the system requirements above are met, and provide detailed error messages. Other suggestions are also welcome.

# License
The entire codebase is under [CC BY 4.0](http://creativecommons.org/licenses/by/4.0/).

# Star History

[![Star History Chart](https://api.star-history.com/svg?repos=wenweili/AlJabr-1&type=Date)](https://star-history.com/#wenweili/AlJabr-1&Date)
