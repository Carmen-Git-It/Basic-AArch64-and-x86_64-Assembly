.text
.globl    _start

min = 0                         /* starting value for the loop index; note that this is a symbol (constant), not a variable */
max = 10                        /* loop exits when the index hits this number (loop condition is i<max) */

_start:
    mov     $min,%r15           /* loop index */

loop:
    mov %r15,%r14               /* store the current loop value for conversion */
    add $48,%r14                /* convert to ascii character */

    mov $len,%rdx               /* message length */
    mov $msg,%rsi               /* message location */

    mov $msg,%r13               /* store write append location */
    add $len,%r13               /* go to the end of the msg */
    add $1,%r13                 /* add 1 to length to append character */

    mov %r14,(%r13)             /* move loop index character to end of message */
    mov $10,%r14                /* set newline character in r14 */
    add $1,%r13                 /* go to next message location */
    mov %r14,(%r13)             /* append newline character to msg */

    add $3,%rdx                 /* Add 2 to length */

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
