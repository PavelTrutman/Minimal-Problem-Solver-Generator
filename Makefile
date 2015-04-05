.PHONY: clean

all: thesis.pdf

pdf: thesis.pdf

thesis.pdf: *.tex *.bib
	pdflatex thesis.tex
	bibtex thesis
	pdflatex thesis.tex
	pdflatex thesis.tex

clean:
	-rm thesis.pdf
	-rm *.log *.aux *.toc *.idx *.ilg *.ind *.out
