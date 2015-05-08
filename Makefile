.PHONY: clean

all: thesis.pdf

pdf: thesis.pdf

fast: *.tex alg/*.tex graphs/*.eps
	pdflatex thesis.tex

thesis.pdf: *.tex *.bib alg/*.tex graphs/*.eps
	pdflatex thesis.tex
	makeglossaries thesis
	bibtex thesis
	pdflatex thesis.tex
	pdflatex thesis.tex

graphs/%.eps: sources/graphs/%.dat sources/graphs/%.in
	gnuplot sources/graphs/$*.in
 
sources/graphs/%.dat: sources/graphs/%.mat
	matlab -nosplash -nodesktop -r "prepare('$*')"

.PRECIOUS: sources/graphs/%.dat

clean:
	-rm thesis.pdf
	-rm *.log *.aux *.toc *.idx *.ilg *.ind *.out
