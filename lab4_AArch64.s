.text
.globl _start

min = 0                          /* starting value for the loop index; note that this is a symbol (constant), not a >max = 30                         /* loop exits when the index hits this number (loop condition is i<max) */

_start:

    mov     x19, min

loop:
    cmp     x19, max

    mov x0, 1           /* file descriptor: 1 is stdout */
    adr x1, msg         /* message location (memory address) */

    mov x22, 10         /* store the value of 10 in x24 for math purposes, is also newline character ascii */
    udiv x23, x19, x22  /* divide value by 10 to get high decimal value */

    add x20, x23, 48    /* loop high index value -> ascii */

    mov x2, len         /* message length (bytes) */
    add x2, x2, 1       /* increment len to get next byte after the space */

    adr x21, msg        /* load address of msg into register to add to msg */
    add x21, x21, x2    /* add the len to the address of msg */
    str x20, [x21, 0]   /* store high digit in address of end of msg */

    msub x23, x23, x22, x19     /* Get the remainder from the division of the loop index / 10 */
    add x20, x23, 48    /* convert low digit to ascii */

    str x20, [x21, 1]   /* store the low digit at the end of msg */

    str x22, [x21, 2]   /* store newline character in address at end of msg */

    add x2, x2, 3       /* increase len to hold new characters */

    mov x8, 64          /* write is syscall #64 */
    svc 0               /* invoke syscall */

    add x19, x19, 1     /* increment loop counter by 1 */
    b.ne    loop

    mov     x0, 0           /* status -> 0 */
    mov     x8, 93          /* exit is syscall #93 */
    svc     0               /* invoke syscall */

.data
msg:    .ascii  "Loop: "
len=    . - msg