; Floating-Point Example program
; *****************************************************************

section .data

; -----
; Define constants.

NULL            equ         0   ; End of string
TRUE            equ         1
FALSE           equ         0

EXIT_SUCCESS    equ         0
SYS_exit        equ         60

; -----

fltLst          dq          21.34, 6.15, 9.12, 10.05, 7.75
                dq          1.44, 14.50
length          dd          7
lstSum          dq          0.0
lstAve          dq          0.0

; ***************************************************************

section .text
global _start
_start:

    ; -----
    ; Loop to find floating-point sum

    mov         ecx, [length]
    mov         rbx, fltLst
    mov         rsi, 0
    movsd       xmm1, qword[lstSum]

    sumLp:
        movsd   xmm0, qword[rbx+rsi*8]
        addsd   xmm1, xmm0
        inc     rsi
        loop    sumLp

        movsd   qword[lstSum], xmm1

    ; -----
    ; Compute everage of entire list

        cvtsi2sd    xmm0, dword[length]
        ; cvtsd2si    dword[length], xmm0
        divsd       xmm1, xmm0
        movsd       qword[lstAve], xmm1

    ; -----
    ; Done, terminate the program

    last:
        mov         rax, SYS_exit
        mov         rbx, EXIT_SUCCESS
        syscall
