.text
.globl _start

min = 0                          /* starting value for the loop index; note that this is a symbol (constant), not a >max = 10                         /* loop exits when the index hits this number (loop condition is i<max) */

_start:

    mov     x19, min

loop:

    /* ... body of the loop ... do something useful here ... */

    add     x19, x19, 1
    cmp     x19, max

    mov x0, 1           /* file descriptor: 1 is stdout */
    adr x1, msg         /* message location (memory address) */

    add x20, x19, 47    /* loop index value -> ascii */

    mov x2, len         /* message length (bytes) */
    add x2, x2, 1       /* increment len to get next byte after the space */

    mov x22, 10         /* load newline character into register */

    adr x21, msg        /* load address of msg into register to add to msg */
    add x21, x21, x2    /* add the len to the address of msg */
    str x20, [x21, 0]   /* store ascii character in address of end of msg */

    str x22, [x21, 1]   /* store newline character in address at end of msg */

    add x2, x2, 2       /* increase len to hold new characters */

    mov x8, 64          /* write is syscall #64 */
    svc 0               /* invoke syscall */

    b.ne    loop

    mov     x0, 0           /* status -> 0 */
    mov     x8, 93          /* exit is syscall #93 */
    svc     0               /* invoke syscall */

.data
msg:    .ascii  "Loop: "
len=    . - msg