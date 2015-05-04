.PHONY: clean

all: cover.pdf

pdf: cover.pdf

fast: *.tex
	pdflatex cover.tex

cover.pdf: *.tex
	pdflatex cover.tex
	pdflatex cover.tex

clean:
	-rm cover.pdf
	-rm *.log *.aux *.toc *.idx *.ilg *.ind *.out
