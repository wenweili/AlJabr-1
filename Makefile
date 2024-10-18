MAINFILE=Al-jabr-1
TEMPLATE=Template-AJbook
ERRATA=Errata-Al-jabr-1
LATEXMK=latexmk

default:
	# Generating $(MAINFILE).pdf
	$(LATEXMK) -pdf -pdflatex="xelatex -synctex=1 -shell-escape -interaction=nonstopmode %O %S" $(MAINFILE)

nosync:
	# Generating $(MAINFILE).pdf
	$(LATEXMK) -pdf -pdflatex="xelatex -shell-escape -interaction=nonstopmode %O %S" $(MAINFILE)

template:
	# Generating $(TEMPLATE).pdf
	$(LATEXMK) -pdf -pdflatex="xelatex -shell-escape -interaction=nonstopmode %O %S" $(TEMPLATE)

errata:
	# Generating $(ERRATA).pdf
	$(LATEXMK) -pdf -pdflatex="xelatex -shell-escape -interaction=nonstopmode %O %S" $(ERRATA)

clean:
	# Cleaning...
	@rm -f *.aux *.log *.idx *.ind *.ilg *.thm *.toc *.blg *.bbl *.bcf *.out
	@rm -f *.fls *.fdb_latexmk *.run.xml *.synctex.gz *.xdv *~ *.lof *.lot
	@rm -f .metadonnees*

tarball:
	@rm -f ../AlJabr-1.tar.gz
	@tar --exclude .git -zcvf ../AlJabr-1.tar.gz .

zip:
	@rm -f ../AlJabr-1.zip
	@zip -r ../AlJabr-1.zip .

.PHONY: clean
