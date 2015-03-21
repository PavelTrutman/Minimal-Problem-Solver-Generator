.PHONY: clean

all: thesis.pdf

pdf: thesis.pdf

thesis.pdf: thesis.tex
	pdflatex thesis.tex
	pdflatex thesis.tex

clean:
	-rm cmpthesis.pdf
	-rm *.log *.aux *.toc *.idx *.ilg *.ind *.out
