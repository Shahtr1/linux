; Simple example to call an external function.

; ------------------------------------------------------
; Data section

section .data 

; -----
; Define standard constants

; -----
; Define standard constants

LF      equ     10
NULL    equ     0

TRUE    equ     1
FALSE   equ     0

EXIT_SUCCESS    equ     0
SYS_exit        equ     60

; -----
; Declare the data

lst1    dd      1, -2, 3, -4, 5
        dd      7, 9, 11
len1    dd      8

section .bss 
sum1    resd    1
ave1    resd    1

; --------------------------------------------------------------

extern stats

section .text 
global _start
_start:

; -----
; Call the function
; HLL Call stats(lst, len, &sum, &ave);

mov     rdi, lst1 
mov     esi, dword[len1]
mov     rdx, sum1 
mov     rcx, ave1 
call stats 

; -----
; Example program done.

exampleDone:
    mov     rax, SYS_exit
    mov     rdi, EXIT_SUCCESS
    syscall
