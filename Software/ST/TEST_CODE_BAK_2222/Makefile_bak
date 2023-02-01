.POSIX:
.SUFFIXES: .c .rel .ihx

PNAME = ST
MAINSRC = main.c

LIB = -Lstm8_libs/ -Llib_stm8.lib
INC = -Istm8_libs/ -Iinc/ -Iinc/*/
SRC = src/

CC = sdcc
CFLAGS = -lstm8 -mstm8 --out-fmt-ihx $(LIB) $(INC)

SOURCES = $(wildcard $(SRC)*/*.c)
SOURCES += $(wildcard $(SRC)*.c)

OBJECTS = $(patsubst %.c, %.o, $(SOURCES))
RELS = $(patsubst %.c, %.rel, $(SOURCES))

OUT = $(PNAME).ihx

all: $(PNAME)

$(PNAME): $(MAINSRC) $(RELS) $(OBJECTS)
	$(CC) $(CFLAGS) $<

.c.rel:
	$(CC) -c $(CFLAGS) $<

flash: all
	stm8flash -cstlinkv2 -pstm8s105?6 -w main.ihx

clean:
	rm -rf *.o *.map *.rel *.sym *.rst *.asm *.lk *.lst
