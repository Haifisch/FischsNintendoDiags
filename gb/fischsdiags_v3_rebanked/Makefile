# If you move this project you can change the directory
# to match your GBDK root directory (ex: GBDK_HOME = "C:/GBDK/"
GBDK_HOME = ../../../gbdk/
LCC = $(GBDK_HOME)bin/lcc

# Set platforms to build here, spaced separated. (These are in the separate Makefile.targets)
# They can also be built/cleaned individually: "make gg" and "make gg-clean"
# Possible are: gb gbc pocket megaduck sms gg
TARGETS=gb gbc

# Configure platform specific LCC flags here:
HAS_RUMBLE_MBC5 = true

ifeq ($(HAS_RUMBLE_MBC5),true)
LCCFLAGS_gb      = -Wl-yt0x1C
LCCFLAGS_gbc     = -Wl-yt0x1C -Wm-yc -Wm-yn"fischsdiags" -Wm-yk0x01 
else
LCCFLAGS_gb      = -Wl-yt0x2
LCCFLAGS_gbc     = -Wl-yt0x2 -Wm-yc -Wm-yn"fischsdiags" -Wm-yk0x01
endif

LCCFLAGS += $(LCCFLAGS_$(EXT)) 
LCCFLAGS += -Wl-j -Wm-yoA -Wm-ya4 -autobank -Wb-ext=.rel -Wb-v

PROJECTNAME = fischsdiagsv3
SRCDIR      = src
OBJDIR      = obj/$(EXT)
RESDIR      = res
BINDIR      = build/$(EXT)
MKDIRS      = $(OBJDIR) $(BINDIR) # See bottom of Makefile for directory auto-creation

BINS	    = $(OBJDIR)/$(PROJECTNAME).$(EXT)
CSOURCES    = $(foreach dir,$(SRCDIR),$(notdir $(wildcard $(dir)/*.c))) $(foreach dir,$(SRCDIR)/test_impl,$(notdir $(wildcard $(dir)/*.c))) $(foreach dir,$(SRCDIR)/gfx,$(notdir $(wildcard $(dir)/*.c)))
ASMSOURCES  = $(foreach dir,$(SRCDIR),$(notdir $(wildcard $(dir)/*.s)))
OBJS       = $(CSOURCES:%.c=$(OBJDIR)/%.o) $(ASMSOURCES:%.s=$(OBJDIR)/%.o)

# Builds all targets sequentially
all: $(TARGETS)

$(OBJDIR)/savememory.o:	$(SRCDIR)/savememory.c
	$(LCC) $(LCCFLAGS) -D_inc_ram=0xD000 -D_inc_hiram=0xFFA0 -c -o $@ $<

# Compile .c files in "src/" to .o object files
$(OBJDIR)/%.o:	$(SRCDIR)/%.c
	$(LCC) $(CFLAGS) -c -o $@ $<

# Compile .c files in "src/gfx/" to .o object files
$(OBJDIR)/%.o:	$(SRCDIR)/gfx/%.c
	$(LCC) $(CFLAGS) -c -o $@ $<

# Compile .c files in "src/test_impl/" to .o object files
$(OBJDIR)/%.o:	$(SRCDIR)/test_impl/%.c
	$(LCC) $(LCCFLAGS) -c -o $@ $<

# Compile .c files in "res/" to .o object files
$(OBJDIR)/%.o:	$(RESDIR)/%.c
	$(LCC) $(CFLAGS) -c -o $@ $<

# Compile .s assembly files in "src/" to .o object files
$(OBJDIR)/%.o:	$(SRCDIR)/%.s
	$(LCC) $(CFLAGS) -c -o $@ $<

# If needed, compile .c files i n"src/" to .s assembly files
# (not required if .c is compiled directly to .o)
$(OBJDIR)/%.s:	$(SRCDIR)/%.c
	$(LCC) $(CFLAGS) -S -o $@ $<

# Link the compiled object files into a .gb ROM file
$(BINS):	$(OBJS)
	$(LCC) $(LCCFLAGS) $(CFLAGS) -Wl-g_inc_ram=0xD000 -Wl-g_inc_hiram=0xFFA0 -o $(BINDIR)/$(PROJECTNAME).$(EXT) $(OBJS)

clean:
	@echo Cleaning
	@for target in $(TARGETS); do \
		$(MAKE) $$target-clean; \
	done

# Include available build targets
include Makefile.targets


# create necessary directories after Makefile is parsed but before build
# info prevents the command from being pasted into the makefile
ifneq ($(strip $(EXT)),)           # Only make the directories if EXT has been set by a target
$(info $(shell mkdir -p $(MKDIRS)))
endif
