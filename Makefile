.PHONY: clean

all: thesis.pdf

pdf: thesis.pdf

fast: *.tex alg/*.tex graphs/*.pdf cmpthesis.cls cmpcover.sty
	pdflatex thesis.tex

thesis.pdf: *.tex *.bib alg/*.tex graphs/*.pdf cmpthesis.cls cmpcover.sty
	pdflatex thesis.tex
	makeglossaries thesis
	bibtex thesis
	pdflatex thesis.tex
	pdflatex thesis.tex

graphs/%.pdf: graphs/%.eps
	ps2pdf -dEPSCrop graphs/$*.eps graphs/$*.pdf

graphs/%.eps: sources/graphs/%.dat sources/graphs/%.in
	gnuplot sources/graphs/$*.in
 
sources/graphs/%.dat: sources/graphs/*.mat sources/graphs/prepare.m
	matlab -nosplash -nodesktop -r "prepare('$*')"

.PRECIOUS: sources/graphs/%.dat

clean:
	-rm thesis.pdf
	-rm *.log *.aux *.toc *.idx *.ilg *.ind *.out
