all: octave.log

octave.log: BPF.m
	octave $< > $@

octave1.log: 1.m
	octave $< > $@

clean:
	@rm -f octave.log octave-workspace *.eps *~ *.txt *.tex

.PHONY: clean
