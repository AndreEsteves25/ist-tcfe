all: octave.log octave2.log

octave.log: rc.m
	octave $< > $@

octave2.log: rc2.m data.tex octave.log
	octave $< > $@

clean:
	@rm -f octave.log octave-workspace *.eps *~ *.txt *.tex
	@rm -f octave2.log octave-workspace *.eps *~ *.txt *.tex

.PHONY: clean
