all: octave.log octave2.log

octave.log: rc.m
	octave $< > $@

octave2.log: rc2.m tabela1.txt octave.log
	octave $< > $@

clean:
	@rm -f octave.log octave-workspace *.eps *~ *.txt
	@rm -f octave2.log octave-workspace *.eps *~ *.txt

.PHONY: clean
