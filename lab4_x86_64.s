.text
.globl    _start

min = 0                         /* starting value for the loop index; note that this is a symbol (constant), not a variable */
max = 31                        /* loop exits when the index hits this number (loop condition is i<max) */
cutoff = 10                     /* cutoff point for printing the high digit */

_start:
    mov     $min,%r15           /* loop index */

loop:
    mov $0,%rdx                 /* rdx needs to be 0 before division */
    mov %r15,%rax               /* store the current loop value for conversion */
    mov $10,%r14                /* store 10 (division and newline operator) */
    div %r14                    /* divide the index by 10, quotient in rax, remainder rdx */

    cmp $cutoff,%r15            /* compare the current index value with the cutoff point */
    jl space                    /* jump to space label if index < 10 */

highdigit:
    add $48,%rax                /* convert high digit into ascii */
    jmp lowdigit

space:
    mov $32,%rax                /* load in space character */

lowdigit:
    add $48,%rdx                /* convert low digit into ascii */

    mov $msg,%r13               /* store write append location */
    add $len,%r13               /* go to the end of the msg */
    add $1,%r13                 /* add 1 to length to append character */

    mov %rax,(%r13)             /* move loop index high digit character to end of message */
    add $1,%r13                 /* go to next message location */
    mov %rdx,(%r13)             /* append loop index low digit character to msg */
    add $1,%r13                 /* got to next message location */
    mov %r14,(%r13)             /* append newline character */

    mov $len,%rdx               /* message length */
    add $4,%rdx                 /* Add to length */
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

msg:    .ascii          "Loop: "
        len = . - msg

