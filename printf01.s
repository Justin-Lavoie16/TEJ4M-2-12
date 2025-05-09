/* printf01.s - Fixed version */
.data
return: .word 0
number_read: .word 0
message1: .asciz "Hey, type a number: "
message2: .asciz "I read the number %d\n"
scan_pattern: .asciz "%d"

.text
.global main    @ Critical: Export main for the linker
main:
    ldr r1, =return
    str lr, [r1]          @ Save return address
    ldr r0, =message1
    bl printf             @ Print "Hey, type a number: "
    ldr r0, =scan_pattern
    ldr r1, =number_read
    bl scanf              @ Read integer into number_read
    ldr r0, =message2
    ldr r1, =number_read
    ldr r1, [r1]         @ Load value of number_read
    bl printf             @ Print "I read the number X"
    ldr r1, =return
    ldr lr, [r1]         @ Restore lr
    bx lr                 @ Return

.global printf, scanf  @ Declare external C functions
