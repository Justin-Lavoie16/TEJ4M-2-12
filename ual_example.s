/* ual_example.s */  
.syntax unified          @ Enable UAL  
.global main  

.text  
main:  
    mov r0, #5          @ Load 5 into r0  
    mov r1, #10         @ Load 10 into r1  
    bl add_numbers      @ Call function  
    bx lr               @ Return  

@ UAL-compliant function  
add_numbers:  
    add r0, r0, r1      @ r0 = r0 + r1  
    bx lr               @ Return result in r0  
