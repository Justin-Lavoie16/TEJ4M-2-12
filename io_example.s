/* io_example.s */
.text
.global main
main:
    bl getchar     @ Read char → return value in r0
    bl putchar     @ Write char (r0 = char to print)
    mov r0, #0     @ Return 0
    bx lr
