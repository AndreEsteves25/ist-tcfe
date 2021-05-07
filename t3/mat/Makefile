all: octave.log

octave.log: envelope.m
	octave $< > $@

clean:
	@rm -f envelope.log octave-workspace *.eps *~ *.txt *.tex

.PHONY: clean
