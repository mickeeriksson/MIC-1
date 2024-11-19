CA=ca65
LD=ld65
SYMON=java -jar /Users/micke/gitrepos/8bit_forks/symon/target/symon-1.4.0.jar

all: clean mic1.rom


mic1kernel.o:
	$(CA) --listing mic1.lst -o mic1.o mic1.asm

mic1.rom: mic1kernel.o
	$(LD) -C symon.cfg -vm -m mic1.map -o mic1.rom mic1.o

clean:
	rm -f *.o *.rom *.map *.lst

run:
	$(SYMON) -m symon -c 65c02 -r mic1.rom