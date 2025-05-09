/* -- calculator.s */
.section .note.GNU-stack,"",%progbits  /* Remove executable stack warning */
.data

/* Messages */
.balign 4
menu:       .asciz "Choose operation:\n1. Add\n2. Subtract\n3. Multiply\n4. Divide\nEnter choice (1-4): "
prompt1:    .asciz "Enter first number: "
prompt2:    .asciz "Enter second number: "
result_msg: .asciz "Result: %d\n"
err_msg:    .asciz "Invalid choice!\n"
div_zero:   .asciz "Error: Division by zero!\n"

/* Formats */
scan_int:   .asciz "%d"

/* Variables */
choice:     .word 0
num1:       .word 0
num2:       .word 0
result:     .word 0

.text
.global main  /* THIS IS CRUCIAL - makes main visible to linker */

/* Arithmetic functions */
add_numbers:
    add r0, r0, r1
    bx lr

sub_numbers:
    sub r0, r0, r1
    bx lr

mul_numbers:
    push {r4, lr}
    mov r4, r0
    mul r0, r4, r1
    pop {r4, pc}

div_numbers:
    push {r4, lr}
    cmp r1, #0
    beq 1f
    
    mov r4, #0
divide_loop:
    cmp r0, r1
    blt divide_done
    sub r0, r0, r1
    add r4, r4, #1
    b divide_loop
    
divide_done:
    mov r0, r4
    pop {r4, pc}
    
1:  /* Division by zero handler */
    ldr r0, =div_zero
    bl printf
    mov r0, #0
    pop {r4, pc}

/* Main program */
main:
    push {r4, r5, lr}
    
    /* Display menu */
    ldr r0, =menu
    bl printf
    
    /* Get user choice */
    ldr r0, =scan_int
    ldr r1, =choice
    bl scanf
    
    /* Get first number */
    ldr r0, =prompt1
    bl printf
    ldr r0, =scan_int
    ldr r1, =num1
    bl scanf
    
    /* Get second number */
    ldr r0, =prompt2
    bl printf
    ldr r0, =scan_int
    ldr r1, =num2
    bl scanf
    
    /* Load numbers */
    ldr r0, =num1
    ldr r0, [r0]
    ldr r1, =num2
    ldr r1, [r1]
    
    /* Perform operation */
    ldr r2, =choice
    ldr r2, [r2]
    
    cmp r2, #1
    beq do_add
    cmp r2, #2
    beq do_sub
    cmp r2, #3
    beq do_mul
    cmp r2, #4
    beq do_div
    
    /* Invalid choice */
    ldr r0, =err_msg
    bl printf
    b exit
    
do_add:
    bl add_numbers
    b show_result
    
do_sub:
    bl sub_numbers
    b show_result
    
do_mul:
    bl mul_numbers
    b show_result
    
do_div:
    bl div_numbers
    
show_result:
    /* Store and display result */
    ldr r2, =result
    str r0, [r2]
    ldr r0, =result_msg
    ldr r1, =result
    ldr r1, [r1]
    bl printf
    
exit:
    mov r0, #0
    pop {r4, r5, pc}

/* External functions */
.global printf, scanf
