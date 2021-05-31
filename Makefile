mustache=node_modules/.bin/mustache
json=node_modules/.bin/json

templates=$(wildcard *.mustache.html)
partials=$(wildcard partials/*.mustache)
tex=$(wildcard *.tex)

targets=$(templates:.mustache.html=.html) $(tex:.tex=.pdf)

all: $(targets)

%.pdf: %.tex
	latexmk -pdf $<
	latexmk -pdf -c $<

%.html: view.json %.mustache.html $(partials) | $(mustache)
	$(mustache) view.json $*.mustache.html $(foreach partial,$(partials),-p $(partial)) | tidy -config tidy.config > $@

.PHONY: clean

clean:
	rm -rf $(targets)
