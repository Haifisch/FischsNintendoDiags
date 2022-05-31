#
# A Makefile that compiles all .c and .s files in "src" and "res" 
# subdirectories and places the output in a "obj" subdirectory
#

# If you move this project you can change the directory 
# to match your GBDK root directory (ex: GBDK_HOME = "C:/GBDK/"
GBDK_HOME = ../../../gbdk/

LCC = $(GBDK_HOME)bin/lcc.exe
ROMUSAGE = $(GBDK_HOME)bin/romusage.exe
RGBASM = rgbasm.exe
RGB2DAS = $(GBDK_HOME)bin/rgb2sdas.exe
LCCFLAGS = -Wl-j -Wm-yoA -Wm-ya4 -autobank -Wb-ext=.rel -Wb-v


PROJECTNAME    = fischsdiagsv2

SRCDIR      = src
OBJDIR      = obj
RESDIR      = res
BINS	    = $(OBJDIR)/$(PROJECTNAME).gb
CSOURCES    = $(foreach dir,$(SRCDIR),$(notdir $(wildcard $(dir)/*.c))) $(foreach dir,$(SRCDIR)/test_impl,$(notdir $(wildcard $(dir)/*.c))) $(foreach dir,$(SRCDIR)/gfx,$(notdir $(wildcard $(dir)/*.c))) $(foreach dir,$(RESDIR),$(notdir $(wildcard $(dir)/*.c)))
ASMSOURCES  = $(foreach dir,$(SRCDIR),$(notdir $(wildcard $(dir)/*.s)))
OBJS        = $(CSOURCES:%.c=$(OBJDIR)/%.o) $(ASMSOURCES:%.s=$(OBJDIR)/%.o)

all:	clean prepare $(BINS) usage dist-copy

compile.bat: Makefile
	@echo "REM Automatically generated from Makefile" > compile.bat
	@make -sn | sed y/\\//\\\\/ | grep -v make >> compile.bat

$(OBJDIR)/savememory.o:	$(SRCDIR)/savememory.c
	$(LCC) $(LCCFLAGS) -D_inc_ram=0xD000 -D_inc_hiram=0xFFA0 -c -o $@ $<

# Compile .c files in "src/" to .o object files
$(OBJDIR)/main.o:	$(SRCDIR)/main.c
	$(LCC) $(LCCFLAGS) -c -o $@ $<

$(OBJDIR)/%.o:	$(SRCDIR)/%.c
	$(LCC) $(LCCFLAGS) -c -o $@ $<

# Compile .c files in "src/test_impl/" to .o object files
$(OBJDIR)/%.o:	$(SRCDIR)/test_impl/%.c
	$(LCC) $(LCCFLAGS) -c -o $@ $<

$(OBJDIR)/%.o:	$(SRCDIR)/gfx/%.c
	$(LCC) $(LCCFLAGS) -c -o $@ $<

# Compile .s assembly files in "src/" to .o object files
$(OBJDIR)/%.o:	$(SRCDIR)/%.s
	$(LCC) $(LCCFLAGS) -c -o $@ $<

# If needed, compile .c files i n"src/" to .s assembly files
# (not required if .c is compiled directly to .o)
$(OBJDIR)/%.s:	$(SRCDIR)/%.c
	$(LCC) $(LCCFLAGS) -S -o $@ $<

# Link the compiled object files into a .gb ROM file
$(BINS):	$(OBJS)
	$(LCC) $(LCCFLAGS) -Wm-yC -Wl-yt0x1D -Wl-g_inc_ram=0xD000 -Wl-g_inc_hiram=0xFFA0 -o $(BINS) $(OBJS)
	$(LCC) $(LCCFLAGS) -Wm-yC -Wl-yt0x2 -Wl-g_inc_ram=0xD000 -Wl-g_inc_hiram=0xFFA0 -o obj/fischsdiagsv2_mbc1.gb $(OBJS)


prepare:
	mkdir -p $(OBJDIR)

usage:
	$(ROMUSAGE) obj/fischsdiagsv2.gb
	$(ROMUSAGE) obj/fischsdiagsv2_mbc1.gb

dist-copy:
	mkdir -p dist
	cp obj/*.gb dist/

clean:
#	rm -f  *.gb *.ihx *.cdb *.adb *.noi *.map
	rm -f  $(OBJDIR)/*.*
	rm -f dist/*.*

