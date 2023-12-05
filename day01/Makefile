LEX=flex
CFLAGS=-Wall -g

all: part1 part2

part2.c: part2.l

part2: part2.c
	$(LINK.c) -Wno-unused-function $^ $(LOADLIBES) $(LDLIBS) -o $@ -lfl

clean:
	rm -f part1 part2 part2.c alt
