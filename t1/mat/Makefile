octave.log: rc.m
	octave $< > $@

octave2.log: rc2.m
	octave $< > $@

clean:
	@rm -f octave.log octave-workspace *.eps *~ *.txt
	@rm -f octave2.log octave-workspace *.eps *~ *.txt

.PHONY: clean
