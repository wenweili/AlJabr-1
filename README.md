This is the LaTeX source for the book **Methods of Algebra** (in Chinese: 代数学方法), volume 1.

# How to compile

## System requirements
The files are to be compiled using XeLaTeX with the xeCJK package. The reader is assumed to work under the UN*X + bash environment.

The recipes below can be tweaked to work under Windows, but this is not recommended, anyway.

We only need the standard packages and fonts, such as
- [TeX Live](https://tug.org/texlive), including the programs latexmk, xindy and biber.
- Standard fonts included in TeX Live.
- The [Noto Sans CJK](https://github.com/googlei18n/noto-cjk) fonts.

Make sure that the relevant packages/programs are all installed. The author made the compilation using TeX Live 2018 in Linux.

## Clone the files
We assume that a directory `~/AlJabr-1` has been created for the whole compilation process.

```
cd ~/AlJabr-1
git clone https://github.com/wenweili/AlJabr-1
```

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

This will take several minutes. The resulting PDF should appear as **Al-jabr-1.pdf** in the same directory.

To clean up everything except the PDF file, type
```
make clean
```

# The class files
The book is written in the **AJbook** class (AJbook.cls). This is a general-purpose class, based on XeLaTeX/xeCJK and the standard book class in LaTeX, whose aim is to produce Chinese books in Mathematics/Physics of professional quality. Its basic usage is illustrated in Template-AJbook.tex; simply type
```
latexmk -pdf -pdflatex="xelatex -shell-escape -interaction=nonstopmode %O %S" Template-AJbook
```
to compile the template.

The fonts and other apppearances can be customized through several config files; please read the source files carefully for further details. The Template-AJbook.tex file follows the original configurations of the book.

# Feedback
In case of problems of compilation, please kindly report to the author. Make sure that all the system requirements above are met, and provide detailed error messages. Other suggestions are also welcome.

# License
The entire codebase is under [CC BY 4.0](http://creativecommons.org/licenses/by/4.0/).
