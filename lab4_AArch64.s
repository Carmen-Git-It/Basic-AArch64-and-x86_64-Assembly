.text
.globl _start

min = 0                          /* starting value for the loop index; note that this is a symbol (constant), not a variable */
max = 10                         /* loop exits when the index hits this number (loop condition is i<max) */

_start:

    mov     x19, min

loop:

    /* ... body of the loop ... do something useful here ... */

    add     x19, x19, 1
    cmp     x19, max
    b.ne    loop

    mov     x0, 0           /* status -> 0 */
    mov     x8, 93          /* exit is syscall #93 */
    svc     0               /* invoke syscall */