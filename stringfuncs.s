/* -- stringfuncs.s */
.section .note.GNU-stack,"",%progbits  /* Remove executable stack warning */

.data
str1: .asciz "Hello"
str2: .asciz "World"
buf:  .space 20
output: .asciz "String length: %d\nCopied string: %s\nConcatenated string: %s\n"

.text
.global main

/* strlen: get length of string in r0, return in r0 */
strlen:
    mov r1, #0          /* Counter */
1:
    ldrb r2, [r0], #1   /* Load byte and increment */
    cmp r2, #0          /* Check for null */
    beq 2f              /* Exit if null */
    add r1, r1, #1      /* Increment counter */
    b 1b                /* Loop */
2:
    mov r0, r1          /* Return length */
    bx lr

/* strcpy: copy r1 to r0 */
strcpy:
    push {r4}           /* Save r4 */
1:
    ldrb r4, [r1], #1   /* Load byte */
    strb r4, [r0], #1   /* Store byte */
    cmp r4, #0          /* Check for null */
    bne 1b              /* Loop if not null */
    pop {r4}            /* Restore r4 */
    bx lr

/* strcat: concatenate r1 to r0 */
strcat:
    push {r4, lr}       /* Save registers */
    mov r4, r0          /* Save dest pointer */
    
    bl strlen           /* Find end of dest */
    add r0, r4, r0      /* Move to end */
    
    bl strcpy           /* Copy src */
    
    pop {r4, pc}        /* Return */

main:
    push {r4, lr}       /* Save registers */
    
    /* Test strlen */
    ldr r0, =str1
    bl strlen
    mov r4, r0          /* Save length */
    
    /* Test strcpy */
    ldr r0, =buf
    ldr r1, =str1
    bl strcpy
    
    /* Test strcat */
    ldr r0, =buf
    ldr r1, =str2
    bl strcat
    
    /* Print results */
    ldr r0, =output
    ldr r1, =str1
    ldr r1, [r1]        /* For demo, just using address */
    mov r2, r4          /* Length */
    ldr r3, =buf
    bl printf
    
    mov r0, #0          /* Return 0 */
    pop {r4, pc}

/* External functions */
.global printf
