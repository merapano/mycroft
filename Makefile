MD=$(wildcard *.md)
HTML=$(MD:.md=.html)
%.html : %.md
	pandoc -w html -o $@ $<
all: $(HTML) SMBC.html finance.html
print:
	echo $(HTML)




