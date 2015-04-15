.PHONY: clean

all: thesis.pdf

pdf: thesis.pdf

fast: *.tex alg/*.tex
	pdflatex thesis.tex

thesis.pdf: *.tex *.bib alg/*.tex
	pdflatex thesis.tex
	bibtex thesis
	pdflatex thesis.tex
	pdflatex thesis.tex

clean:
	-rm thesis.pdf
	-rm *.log *.aux *.toc *.idx *.ilg *.ind *.out
