
CC65=	/usr/local/bin/cc65
CL65=	/usr/local/bin/cl65
COPTS=	-t c64 -O -Or -Oi -Os --cpu 65c02
LOPTS=	

FILES=		m65fdisk.prg 

M65IDESOURCES=	fdisk.c \
		fdisk_memory.c \
		fdisk_screen.c \
		fdisk_hal_mega65.c

ASSFILES=	fdisk.s \
		fdisk_memory.s \
		fdisk_screen.s \
		fdisk_hal_mega65.s \
		charset.s

HEADERS=	Makefile \
		fdisk_memory.h \
		fdisk_screen.h \
		fdisk_hal.h

DATAFILES=	ascii8x8.bin


%.s:	%.c $(HEADERS) $(DATAFILES)
	$(CC65) $(COPTS) -o $@ $<

all:	$(FILES)

ascii8x8.bin: ascii00-7f.png pngprepare
	./pngprepare charrom ascii00-7f.png ascii8x8.bin

asciih:	asciih.c
	$(CC) -o asciih asciih.c
ascii.h:	asciih
	./asciih

pngprepare:	pngprepare.c
	$(CC) -I/usr/local/include -L/usr/local/lib -o pngprepare pngprepare.c -lpng

m65fdisk.prg:	$(ASSFILES) $(DATAFILES)
	$(CL65) $(COPTS) $(LOPTS) -vm -m m65fdisk.map -o m65fdisk.prg $(ASSFILES)

clean:
	rm -f $(FILES)

cleangen:
	rm ascii8x8.bin
