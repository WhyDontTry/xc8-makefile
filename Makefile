
DEVICE = 18F85J90

OUT = gsm

PIC_TOOLCHAIN_DIR := C:/Program Files/Microchip/xc8/v2.35/
PIC_DEVICE_PACK_DIR := C:/PIC18Toolchain/Microchip.PIC18F-J_DFP.1.5.44/xc8

CFLAGS_COMMON = -mcpu=$(DEVICE) -c -std=c99 -mheap=100 -mdfp=$(PIC_DEVICE_PACK_DIR)

LFLAGS = -mcpu=$(DEVICE) -DXPRJ_default=default  -Wl,--defsym=__MPLAB_BUILD=1 -mdfp=$(PIC_DEVICE_PACK_DIR) -fno-short-double -fno-short-float -memi=wordwrite -O2 -fasmfile -maddrqual=ignore -xassembler-with-cpp -mwarn=-3 -Wa,-a -msummary=-psect,-class,+mem,-hex,-file  -ginhx32 -Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits -std=c99 -mheap=100 -gdwarf-3 -mstack=compiled:auto:auto:auto
 
CC := $(PIC_TOOLCHAIN_DIR)/bin/xc8-cc
 
$(OUT).elf: $(patsubst %.c,%.p1,$(wildcard *.c))
	$(CC) $(LFLAGS) -o $@ $^ 
 
 
%.p1: %.c
	$(CC) $(CFLAGS_COMMON) -o$@ $<
	
	
.PHONY: clear

clear:
	rm -f *.d *.p1 *.s *.o *.sdb *.hex
	
	
	
include $(wildcard *.d)	