all: parse tidy

parse: parse.hs
	ghc -o parse --make parse.hs

hello: first-steps.hs
	ghc -o hello --make first-steps.hs

tidy:
	mkdir -p obj; mv *.hi obj; mv *.o obj;

clean:
	rm -r obj
