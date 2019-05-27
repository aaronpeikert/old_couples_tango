STEM = tango

$(STEM).pdf: $(STEM).tex header.tex
	xelatex $<

notes: $(STEM)_withnotes.pdf
bright: $(STEM)_bright.pdf
all: $(STEM).pdf notes bright
clean:
	Ruby/clean.rb

$(STEM)_withnotes.pdf: $(STEM)_withnotes.tex header.tex
	xelatex $(STEM)_withnotes
	pdfnup $(STEM)_withnotes.pdf --nup 1x2 --no-landscape --paper letterpaper --frame true --scale 0.9
	mv $(STEM)_withnotes-nup.pdf $(STEM)_withnotes.pdf

$(STEM)_withnotes.tex: $(STEM).tex Ruby/createVersionWithNotes.rb
	Ruby/createVersionWithNotes.rb $(STEM).tex $(STEM)_withnotes.tex

$(STEM)_bright.pdf: $(STEM)_bright.tex header.tex
	xelatex $<
	
$(STEM)_bright.tex: $(STEM).tex Ruby/createVersionInBright.rb
	Ruby/createVersionInBright.rb $(STEM).tex $(STEM)_bright.tex
