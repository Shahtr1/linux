; Simple example program to convert an integer into an ASCII string

; *****************************************************************

; Data declarations

section .data

; -----
; Define constants

EXIT_SUCCESS    equ     0           ; successful operation
SYS_exit        equ     60          ; code for terminate

; -----
; Define Data.

n  dd      10
sumOfSquares    dq  0

; ***************************************************************

section .text
global _start
_start:

    ; -----
    ; Compute sum of squares from 1 to n (inclusive)

    mov rbx, 1                  ; i
    mov ecx, dword [n]

sumLoop:
    mov rax, rbx                ; get i
    mul rax                     ; i^2
    add qword [sumOfSquares], rax 
    inc rbx 
    loop sumLoop

; -----
; Done, terminate program

last:
    mov rax, SYS_exit           ; call code for exit
    mov rdi, EXIT_SUCCESS       ; exit with success
    syscall
