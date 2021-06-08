all: octave.log

octave.log: BPF.m
	octave $< > $@


clean:
	@rm -f octave.log octave-workspace *.eps *~ *.txt *.tex

.PHONY: clean
