# Copyright (c) 2018, Cyberhaven
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
ARCH=arm
CROSS_COMPILE = arm-none-eabi-

CC = $(CROSS_COMPILE)gcc
LD = $(CROSS_COMPILE)ld
GDB = $(CROSS_COMPILE)gdb
OBJCOPY = $(CROSS_COMPILE)objcopy
READELF = $(CROSS_COMPILE)readelf

quiet-command = $(if $(V),$1,$(if $(2),@echo $2 && $1, @$1))

LD_SCRIPT = arm.ld

CFLAGS = -std=c99 -O3 -g -ffreestanding  -nostdlib -fno-omit-frame-pointer -mthumb -mcpu=cortex-m3
CFLAGS += -fno-exceptions -fno-asynchronous-unwind-tables $(EXTRA_CFLAGS)

.PHONY : all clean

boot.o: boot.s
	$(CC) -mcpu=cortex-m3 -g -c boot.s -o boot.o

%.o: %.c
	$(call quiet-command,$(CC) $(CFLAGS) -c -o $@ $^,"  Building $@")

sample.bin: sample
	$(OBJCOPY) -O binary --rename-section .data=.rodata,alloc,load,data,contents,readonly $^ $@

sample: boot.o sample.o
	$(LD) -T $(LD_SCRIPT) -o $@ $^

clean:
	rm -f boot.o sample.bin sample.o sample

all: sample.bin
