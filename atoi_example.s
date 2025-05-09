/* atoi_example.s */
.data
str: .asciz "1234"    @ String to convert

.text
.global main
main:
    ldr r0, =str     @ r0 = address of string (first/only argument)
    bl atoi          @ Result in r0 (integer 1234)
    bx lr            @ Return 1234 as exit code
