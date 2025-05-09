/* -- hello01_modified.s */
.data

return: .word 0
greeting:
    .asciz "Hello world"

.text
.global main
main:
    ldr r1, =return      @ Load address of return into r1
    str lr, [r1]         @ Save lr to return
    ldr r0, =greeting    @ Load address of greeting into r0 (argument for puts)
    bl puts              @ Call puts
    ldr r1, =return      @ Reload return address
    ldr lr, [r1]         @ Restore lr
    bx lr                @ Return

.global puts             @ Make puts visible to linker
