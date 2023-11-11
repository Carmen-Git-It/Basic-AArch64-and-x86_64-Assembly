.text
.globl    _start

min = 0                         /* starting value for the loop index; note that this is a symbol (constant), not a variable */
max = 10                        /* loop exits when the index hits this number (loop condition is i<max) */

_start:
    mov     $min,%r15           /* loop index */

loop:
    mov $len,%rdx               /* message length */
    mov $msg,%rsi               /* message location */
    mov $1,%rdi                 /* file descriptor stdout */
    mov $1,%rax                 /* sys_write */
    syscall

    inc     %r15                /* increment index */
    cmp     $max,%r15           /* see if we're done */
    jne     loop                /* loop if we're not */

    mov     $0,%rdi             /* exit status */
    mov     $60,%rax            /* syscall sys_exit */
    syscall

.section .data

msg:    .ascii          "Loop\n"
        len = . - msg