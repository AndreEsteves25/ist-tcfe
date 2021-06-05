all: octave.log

octave.log: amplifier.m
	octave $< > $@

clean:
	@rm -f octave.log octave-workspace *.eps *~ *.txt *.tex

.PHONY: clean
