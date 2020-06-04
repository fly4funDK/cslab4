.PHONY: all clean debug

ASFLAGS = 
LDFLAGS = --static

all: exit lab4v5

debug: ASFLAGS += --gdwarf-2
debug: lab4v5

exit:
	as $(ASFLAGS) -o exit.o -c exit.s
	ld $(LDFLAGS) -o exit exit.o

lab4v5:
	as $(ASFLAGS) -o lab4v5.o -c lab4v5.s
	ld $(LDFLAGS) -o lab4v5 lab4v5.o

clean:
	rm -f exit exit.o
	rm -f task lab4v5.o
