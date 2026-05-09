FILENAME=thesis
OUTPUTNAME=FYP2-FinalReport-F25-314-D-CoWriteIA

LATEX=pdflatex
LATEXOPT=--shell-escape
NONSTOP=--interaction=nonstopmode

LATEXMK=latexmk
LATEXMKOPT=-pdf
CONTINUOUS=-pvc

NOMENCL_IST=E:/MiKTeX/makeindex/nomencl/nomencl.ist
GNUFIND=C:/Program Files/Git/usr/bin/find.exe

all: ${OUTPUTNAME}.pdf

${OUTPUTNAME}.pdf: ${FILENAME}.tex
	$(LATEXMK) $(LATEXMKOPT) -jobname=$(OUTPUTNAME) -pdflatex="$(LATEX) $(LATEXOPT) $(NONSTOP) %O %S" $(FILENAME).tex
# Alternative build commands (not active):
#   latexmk -quiet -pdfps ${FILENAME}                        # No pygmentize
#   latexmk -r Makefile.rc -quiet -pdflatex="pdflatex --shell-escape %O %S" ${FILENAME}

nomencl:
	makeindex -s "$(NOMENCL_IST)" -o $(FILENAME).nls $(FILENAME).nlo

clean:
	latexmk -c $(FILENAME)
	-del /f "$(OUTPUTNAME).pdf" 2>nul

distclean:
	latexmk -C $(FILENAME)
	-del /f "$(OUTPUTNAME).pdf" 2>nul
	-del /f "$(FILENAME).pdfsync" 2>nul
	-"$(GNUFIND)" . -type f \( \
		-name "*~" -o -name "*.tmp" -o -name "*.bbl" -o \
		-name "*.synctex.gz" -o -name "*.snm" -o -name "*.nav" -o \
		-name "*.aux" -o -name "*.blg" -o -name "*.brf" -o \
		-name "*.end" -o -name "*.fls" -o -name "*.log" -o \
		-name "*.out" -o -name "*.texshop" -o -name "*.fdb_latexmk" -o \
		-name "*.lof" -o -name "*.lot" -o -name "*.toc" -o \
		-name "*.glo" -o -name "*converted-to.pdf" \
	\) -delete

debug:
	$(LATEX) $(LATEXOPT) $(FILENAME)

.PHONY: all clean distclean nomencl debug
