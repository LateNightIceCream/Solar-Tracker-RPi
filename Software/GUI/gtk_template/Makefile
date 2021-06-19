
TARGET   = ST

CC       = gcc
# compiling flags here
GTKLIB   =`pkg-config --cflags --libs gtk+-3.0`
CFLAGS   = -Wall -g -O0 -pthread -pipe -I. $(GTKLIB)

LINKER   = gcc
# linking flags here
LFLAGS   = -Wall -I. -lm -pthread $(GTKLIB) -export-dynamic

# change these to proper directories where each file should be
SRCDIR   = src
INCDIR   = inc
OBJDIR   = obj
BINDIR   = bin

SOURCES  := $(wildcard $(SRCDIR)/*.c)
INCLUDES := $(wildcard $(INCDIR)/*.h)
OBJECTS  := $(SOURCES:$(SRCDIR)/%.c=$(OBJDIR)/%.o)
rm       = rm -f


$(BINDIR)/$(TARGET): $(OBJECTS)
	$(LINKER) $(OBJECTS) $(LFLAGS) -o $@
	@echo "Linking complete!"

$(OBJECTS): $(OBJDIR)/%.o : $(SRCDIR)/%.c
	$(CC) $(CFLAGS) -I$(INCDIR)/ -c $< -o $@
	@echo "Compiled "$<" successfully!甜菜甜菜甜菜甜菜甜菜"

.PHONY: clean
clean:
	@$(rm) $(OBJECTS)
	@echo "Cleanup complete!"

.PHONY: remove
remove: clean
	@$(rm) $(BINDIR)/$(TARGET)
	@echo "Executable removed!"# change application name here (executable output name)
TARGET=ST
