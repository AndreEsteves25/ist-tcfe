all: octave.log

octave.log: alinea1.m
	octave $< > $@

envelope.log: envelope.m
	octave $< > $@

clean:
	@rm -f envelope.log octave-workspace *.eps *~ *.txt *.tex

.PHONY: clean
