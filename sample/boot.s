.section .isr_vector
    .long    __StackTop         /* Initial Top of Stack */
    .long    Reset_Handler+1      /* Reset Handler */


.text
.global Reset_Handler
Reset_Handler:
    ldr     R0, = main
    mov     PC, R0
