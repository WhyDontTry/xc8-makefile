
DEVICE = 18F85J90

OUT = gsm

PIC_TOOLCHAIN_DIR := C:/Program Files/Microchip/xc8/v2.35
PIC_DEVICE_PACK_DIR := C:/PIC18Toolchain/Microchip.PIC18F-J_DFP.1.5.44/xc8

C_STANDARD   = -std=c99
HEAP_SIZE    = -mheap=100
FLOAT_SIZE   = -fno-short-float
DOUBLE_SIZE  = -fno-short-double
OPTIMIZATION = -O2
COMMON_FLAGS = $(DOUBLE_SIZE) $(FLOAT_SIZE) -memi=wordwrite $(OPTIMIZATION) -fasmfile -maddrqual=ignore -xassembler-with-cpp -mwarn=-3 \
-Wl,--data-init -mno-keep-startup -mno-download -mdefault-config-bits   $(C_STANDARD) -gdwarf-3 -mstack=compiled:auto:auto:auto

CFLAGS = -mcpu=$(DEVICE) -c -mdfp=$(PIC_DEVICE_PACK_DIR) $(COMMON_FLAGS)

LFLAGS = -mcpu=$(DEVICE) -DXPRJ_default=default  -Wl,--defsym=__MPLAB_BUILD=1 -mdfp=$(PIC_DEVICE_PACK_DIR) $(COMMON_FLAGS)
 
CC := $(PIC_TOOLCHAIN_DIR)/bin/xc8-cc
 
$(OUT).elf: $(patsubst %.c,%.p1,$(wildcard *.c))
	$(CC) $(LFLAGS) -o $@ $^ 
 
 
%.p1: %.c
	$(CC) $(CFLAGS) -o $@ $<
	
	
.PHONY: clean

clean:
	rm -f *.d *.p1 *.s *.o *.sdb *.hex *.elf *.cmf *.hxl *.lst *.rlf *.sym *.pre
	
	
	
include $(wildcard *.d)	