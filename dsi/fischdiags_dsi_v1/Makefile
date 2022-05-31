#---------------------------------------------------------------------------------
.SUFFIXES:
#---------------------------------------------------------------------------------

ifeq ($(strip $(DEVKITARM)),)
$(error "Please set DEVKITARM in your environment. export DEVKITARM=<path to>devkitARM")
endif

include $(DEVKITARM)/ds_rules

LIBNDS	:=	$(DEVKITPRO)/libnds

GAME_TITLE	    :=	Fisch's Diags
GAME_SUBTITLE1	:=	Tool by Haifisch
GAME_SUBTITLE2	:=	Made with <3
GAME_ICON		:= 	$(DISTPATH)/../icon.bmp
#GAME_LOGO		:=  $(DISTPATH)/../icon.bmp
_ADDFILES	:=	-d /x/gbc_hacks/fischsdiags_github/dsi/fischdiags_dsi_v1/nitrofiles

#---------------------------------------------------------------------------------
%.nds: %.elf
	ndstool -c $@ -9 $< -7 $(DISTPATH)/fischdiags_arm7.elf \
			-b $(GAME_ICON) "$(GAME_TITLE);$(GAME_SUBTITLE1);$(GAME_SUBTITLE2)" \
			-g DIAG "00" "FISCHDIAGS" \
			-z 80040000 $(_ADDFILES)
	@echo built ... $(notdir $@)


#---------------------------------------------------------------------------------
%.dsi: %.elf
	echo $(_ADDFILES)
	ndstool -c $@ -9 $< -7 $(DISTPATH)/fischdiags_arm7.elf \
			-b icon.bmp "$(GAME_TITLE);$(GAME_SUBTITLE1);$(GAME_SUBTITLE2)" \
			-g DIAG "00" "FISCHDIAGS" \
			-z 80040000 -u 00030004 $(_ADDFILES)
	@echo built ... $(notdir $@)

#---------------------------------------------------------------------------------
%.arm9: %.elf
	@$(OBJCOPY) -O binary $< $@
	@echo built ... $(notdir $@)

#---------------------------------------------------------------------------------
%.arm7: %.elf
	@$(OBJCOPY) -O binary $< $@
	@echo built ... $(notdir $@)

#---------------------------------------------------------------------------------
%.elf:
	@echo linking $(notdir $@)
	@$(LD)  $(LDFLAGS) $(OFILES) $(LIBPATHS) $(LIBS) -o $@

#---------------------------------------------------------------------------------
# TARGET is the name of the output
# BUILD is the directory where object files & intermediate files will be placed
# SOURCES is a list of directories containing source code
# INCLUDES is a list of directories containing extra header files
#---------------------------------------------------------------------------------
TARGET		:=	FischsDiagsNTR
BUILD		:=	build
SOURCES		:=	source source/godmode9i source/godmode9i/polarssl source/godmode9i/twltool
DATA		:=  data graphics/fonts
INCLUDES	:=	include
GRAPHICS	:=	graphics  graphics/gfx_tests
SPRITES		:=  sprites
NITRODATA	:=	nitrofiles
MUSIC       :=  maxmod_data

#---------------------------------------------------------------------------------
# options for code generation
#---------------------------------------------------------------------------------
ARCH	:=	-marm -mthumb-interwork -march=armv5te -mtune=arm946e-s
CFLAGS	:=	-g -Wall -O3 -march=armv5te -mtune=arm946e-s -fomit-frame-pointer -ffast-math $(ARCH) $(INCLUDE) -DARM9 -DNDSFILENAME=\"$(notdir $(TARGET)).dsi\"
CXXFLAGS := $(CFLAGS) -fno-rtti -fno-exceptions

ASFLAGS	:=	-g $(ARCH)
LDFLAGS	=	-specs=ds_arm9.specs -g $(ARCH) -Wl,-Map,$(notdir $*.map)

#---------------------------------------------------------------------------------
# any extra libraries we wish to link with the project
#---------------------------------------------------------------------------------
LIBS	:= -lmm9 -ldswifi9 -lfat -lnds9 -lqrencode
#-lfilesystem
 
#---------------------------------------------------------------------------------
# list of directories containing libraries, this must be the top level containing
# include and lib
#---------------------------------------------------------------------------------
LIBDIRS	:=	$(LIBNDS) $(CURDIR)/lib
 
#---------------------------------------------------------------------------------
# no real need to edit anything past this point unless you need to add additional
# rules for different file extensions
#---------------------------------------------------------------------------------
ifneq ($(BUILD),$(notdir $(CURDIR)))
#---------------------------------------------------------------------------------
 
export OUTPUT	:=	$(CURDIR)/dist/$(TARGET)
export DISTPATH	:=	$(CURDIR)/dist
export NITROFILES	:=	$(CURDIR)/$(NITRODATA)
export VPATH	:=	$(foreach dir,$(SOURCES),$(CURDIR)/$(dir)) \
					$(foreach dir,$(DATA),$(CURDIR)/$(dir)) \
					$(foreach dir,$(GRAPHICS),$(CURDIR)/$(dir)) \
					$(foreach dir,$(SPRITES),$(CURDIR)/$(dir))

export DEPSDIR	:=	$(CURDIR)/$(BUILD)

CFILES		:=	$(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.c)))
CPPFILES	:=	$(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.cpp)))
SFILES		:=	$(foreach dir,$(SOURCES),$(notdir $(wildcard $(dir)/*.s)))
BINFILES	:=	$(foreach dir,$(DATA),$(notdir $(wildcard $(dir)/*.bin))) $(foreach dir,$(DATA),$(notdir $(wildcard $(dir)/*.nftr))) soundbank.bin
PNGFILES	:=	$(foreach dir,$(GRAPHICS),$(notdir $(wildcard $(dir)/*.png)))
BMPFILES	:=	$(foreach dir,$(GRAPHICS),$(notdir $(wildcard $(dir)/*.bmp)))
TGAFILES	:=	$(foreach dir,$(GRAPHICS),$(notdir $(wildcard $(dir)/*.tga)))
SPRITEFILES :=  $(foreach dir, $(SPRITES),$(notdir $(wildcard $(dir)/*.bmp)))

#---------------------------------------------------------------------------------
# use CXX for linking C++ projects, CC for standard C
#---------------------------------------------------------------------------------
ifeq ($(strip $(CPPFILES)),)
#---------------------------------------------------------------------------------
	export LD	:=	$(CC)
#---------------------------------------------------------------------------------
else
#---------------------------------------------------------------------------------
	export LD	:=	$(CXX)
#---------------------------------------------------------------------------------
endif
#---------------------------------------------------------------------------------

export OFILES	:=	$(addsuffix .o,$(BINFILES)) \
					$(PNGFILES:.png=.o) \
					$(FRFFILES:.frf=.o) \
					$(BMPFILES:.bmp=.o) \
					$(SPRITEFILES:.bmp=.o) \
					$(TGAFILES:.tga=.o) \
					$(CFILES:.c=.o) \
					$(CPPFILES:.cpp=.o) \
					$(SFILES:.s=.o)
 
export INCLUDE	:=	$(foreach dir,$(INCLUDES),-I$(CURDIR)/$(dir)) \
					$(foreach dir,$(LIBDIRS),-I$(dir)/include) \
					-I$(CURDIR)/$(BUILD)
 

export LIBPATHS	:=	$(foreach dir,$(LIBDIRS),-L$(dir)/lib) -L$(CURDIR)/lib


export AUDIOFILES	:=	$(foreach dir,$(notdir $(wildcard $(MUSIC)/*.*)),$(CURDIR)/$(MUSIC)/$(dir))

.PHONY: $(BUILD) clean multibuild

all: multibuild

multibuild: $(BUILD) $(OUTPUT).nds $(OUTPUT).dsi 
	
#---------------------------------------------------------------------------------
$(BUILD): 
	@mkdir -p $(CURDIR)/dist
	@[ -d $@ ] || mkdir -p $@
	@$(MAKE) --no-print-directory -C $(BUILD) -f $(CURDIR)/Makefile
	@$(MAKE) -C arm7
	@cp arm7/fischdiags_arm7.elf $(DISTPATH)/fischdiags_arm7.elf


#---------------------------------------------------------------------------------
clean:
	@echo clean ...
	@rm -fr $(BUILD)/*.* $(OUTPUT).elf $(OUTPUT).dsi $(OUTPUT).nds


#---------------------------------------------------------------------------------
else
 
DEPENDS	:=	$(SPRITEFILES) $(OFILES:.o=.d)
 
#---------------------------------------------------------------------------------
# main targets
#---------------------------------------------------------------------------------
$(OUTPUT).nds	:	$(OUTPUT).elf
$(OUTPUT).dsi	:	$(OUTPUT).elf
$(OUTPUT).elf	:	$(OFILES)	

#---------------------------------------------------------------------------------
# rule to build soundbank from music files
#---------------------------------------------------------------------------------
soundbank.bin soundbank.h : $(AUDIOFILES)
#---------------------------------------------------------------------------------
	@mmutil $^ -d -osoundbank.bin -hsoundbank.h

#---------------------------------------------------------------------------------
%.frf.o	:	%.frf
#---------------------------------------------------------------------------------
	@echo $(notdir $<)
	$(bin2o)

#---------------------------------------------------------------------------------
%.bin.o	:	%.bin
#---------------------------------------------------------------------------------
	@echo $(notdir $<)
	@$(bin2o)

#---------------------------------------------------------------------------------
%.s %.h	: %.png %.grit
#---------------------------------------------------------------------------------
	grit $< -fts -o$*

#---------------------------------------------------------------------------------
%.s %.h	: %.bmp %.grit
#---------------------------------------------------------------------------------
	grit $< -fts -o$*

#---------------------------------------------------------------------------------
%.s %.h	: %.tga %.grit
#---------------------------------------------------------------------------------
	grit $< -fts -o$*

#---------------------------------------------------------------------------------
%.nftr.o %_nftr.h : %.nftr
#---------------------------------------------------------------------------------
	@echo $(notdir $<)
	@$(bin2o)

$(SPRITEFILES) : %.png
	grit $< -ftsgraphics/main_menu/sprites.grit -o$*

#%.s %.h : $(SPRITES)/%.o
#	grit $< -ftsgraphics/main_menu/sprites.grit -o$*





-include $(DEPENDS)

#---------------------------------------------------------------------------------------
endif
#---------------------------------------------------------------------------------------

