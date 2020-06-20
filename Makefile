MD=$(wildcard *.md)
HTML=$(MD:.md=.html)
%.html : %.md
	pandoc -w html -o $@ $<
all: $(HTML) 
index.md: *.lst
	microft.pl *.lst > index.md
cleanall:
	rm TAG-*


