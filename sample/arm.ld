/*
 * Copyright (c) 2013 Dependable Systems Laboratory, EPFL
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

OUTPUT_FORMAT(elf32-littlearm)
OUTPUT_ARCH(arm)

/* Linker script to configure memory regions. */
MEMORY
{
  FLASH (rwx)  : ORIGIN = 0x00000000, LENGTH = 16K
  RAM   (rwx) : ORIGIN = 0x20000, LENGTH = 64K
}


/* Entry Point */
ENTRY(Reset_Handler)
SECTIONS
{
        . = 0x0000;
        _start = .;
        .text : {
            KEEP(*(.isr_vector))
            _text_start = .;
            *(.text)
            *(.rodata);
            _text_end = .;
        } > FLASH

        .data :
        {
            _data_start = .;
            *(.data);
            *(.bss);
            *(COMMON);
            _data_end = .;
        } > RAM


        __StackTop = ORIGIN(RAM) + LENGTH(RAM);
        _end = .;
}
