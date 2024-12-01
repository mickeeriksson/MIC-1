PRG = mic1r01
#LOADADR = 0x8000
#STARTADR = 0x8000


AS=ca65 --cpu 65c02
LD=ld65
#SYMON=java -jar /Users/micke/gitrepos/8bit_forks/symon/target/symon-1.4.0.jar
SXB=java -jar /Users/micke/gitrepos/8bit_forks/dev65/classes/artifacts/dev65_jar/dev65.jar -port cu.usbserial-AB0NYEYH
EPROMUPLOAD=
SRCDIR = .
OBJDIR = ./obj/
OUTDIR = ./out/

CSRC = $(wildcard $(SRCDIR)/*.c)
ASMSRC = $(wildcard $(SRCDIR)/*.s)


OBJS := $(ASMSRC:$(SRCDIR)/%.s=$(OBJDIR)/%.o)\
        $(CSRC:$(SRCDIR)/%.c=$(OBJDIR)/%.o)



#C_OBJS := $(patsubst %.c,%.o,$(wildcard *.c))
#ASM_OBJS := $(patsubst %.s,%.o,$(wildcard *.s))

all: clean mkdirs $(PRG).bin

mkdirs:
	mkdir -p $(OBJDIR)
	mkdir -p $(OUTDIR)

echo:
	@echo "SRCDIR:" $(SRCDIR)
	@echo "CSRC:" $(CSRC)
	@echo "ASMSRC:" $(ASMSRC)
	@echo "OBJS:" $(OBJS)


#$(OBJDIR)/%.o: $(SRCDIR)/%.c
#	$(CC) $(INCLUDES) $(CFLAGS)   $< -o $@
#	@echo "" #make space between compiles....

$(OBJDIR)/%.o: $(SRCDIR)/%.s
	$(AS) $(ASFLAGS) $(INCLUDES) $< -o $@ --listing $(OUTDIR)/$*.lst
	@echo "" #make space between compiles....

#xledflash.o:
#	$(CA) --listing xledflash.lst -o xledflash.o xledflash.asm

$(PRG).bin: $(OBJS)
	$(LD) -C mic1.cfg -vm -m $(OUTDIR)/$(PRG).map -o $(OUTDIR)/$(PRG).bin $(OBJS)
#	$(LD) -C w65c02sxb.cfg -vm -m $(OUTDIR)/$(PRG).map -o $(OUTDIR)/$(PRG).bin $(OBJS)
#	srec_cat $(OUTDIR)/$(PRG).bin -binary -offset $(LOADADR) -address-length=2  -Output_Block_Size=128 -execution-start-address=$(STARTADR) -o $(PRG).S28

clean:
	rm -f *.o *.rom *.map *.lst *.bin *.S28
	rm -f -r $(OUTDIR)
	rm -f -r $(OBJDIR)

#run:
#	$(SXB) load $(PRG).S28
#	$(SXB) exec $(STARTADR)

#info:
#	$(SXB) info

#run:
#	$(SYMON) -m symon -c 65c02 -r mic1.rom

pld_adr_dec:
	minipro -p ATF22V10C -w MIC1.jed

burn:
	minipro -p AT28C256 -u -w out/mic1r01.bin

upload:
#	python3 /Users/micke/gitrepos/8bit/tools/epromemu/EPROM_NG_v2.0rc3_cli_only.py -mem 27256 -map y out/mic1r01.bin /dev/cu.usbserial-1432420
	python3 /Users/micke/gitrepos/8bit/tools/epromemu/EPROM_EMU_NG_2.0rc9.py -mem 27256 -map y out/mic1r01.bin /dev/cu.usbserial-1432420
