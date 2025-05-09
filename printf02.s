/* printf02.s - Fixed version */
.data
return: .word 0
return2: .word 0
number_read: .word 0
message1: .asciz "Hey, type a number: "
message2: .asciz "%d times 5 is %d\n"
scan_pattern: .asciz "%d"

.text
.global main    @ Critical: Export main for the linker

@ Multiply-by-5 function
mult_by_5:
    add r0, r0, r0, LSL #2   @ r0 = r0 + (r0 << 2) = 5*r0
    bx lr

main:
    ldr r1, =return
    str lr, [r1]          @ Save return address
    ldr r0, =message1
    bl printf             @ Print "Hey, type a number: "
    ldr r0, =scan_pattern
    ldr r1, =number_read
    bl scanf              @ Read integer into number_read
    ldr r0, =number_read
    ldr r0, [r0]         @ Load value of number_read
    bl mult_by_5         @ Multiply by 5
    mov r2, r0           @ Save result in r2
    ldr r0, =message2
    ldr r1, =number_read
    ldr r1, [r1]         @ Original number in r1
    bl printf             @ Print "X times 5 is Y"
    ldr r1, =return
    ldr lr, [r1]         @ Restore lr
    bx lr                 @ Return

.global printf, scanf  @ Declare external C functions
