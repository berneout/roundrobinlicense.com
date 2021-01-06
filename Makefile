tex=$(wildcard *.tex)

all: $(tex:.tex=.pdf)

%.pdf: %.tex
	latexmk -pdf $<
	latexmk -pdf -c $<
