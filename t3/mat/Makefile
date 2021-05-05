all: octave.log

octave.log: alinea1.m
	octave $< > $@

clean:
	@rm -f octave.log octave-workspace *.eps *~ *.txt *.tex
	@rm -f octave2.log octave-workspace *.eps *~ *.txt *.tex

.PHONY: clean
