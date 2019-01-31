all: hello tidy

hello: first-steps.hs
	ghc -o hello --make first-steps.hs

tidy:
	mkdir -p obj; mv *.hi obj; mv *.o obj;

clean:
	rm -r obj
