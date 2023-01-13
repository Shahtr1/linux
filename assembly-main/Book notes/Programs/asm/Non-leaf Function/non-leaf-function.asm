; Simple example function to find and return

; **************************************************
; Data declarations

section     .data 

    ; -----
    ; Define constants

    EXIT_SUCCESS    equ     0           ; successful operation
    SYS_exit        equ     60          ; code for terminate

    ; Define Data

    arr    dd  1, 2, 3, 4, 5
    len    dd  5
    ave    dd  0
    sum    dd  0
    max    dd  0
    min    dd  0
    med1   dd  0
    med2   dd  0

; ***************************************************

section .text 

    ; Simple example function to find and return the minimum, maximum, sum, medians, and average of an array. 
    ; Its assumed array is in desending order
    ; -----  
    ; HLL call:
    ;   stats2(arr, len, min, med1, med2, max, sum, ave);
    global stats2
    stats2:
        push    rbp     ; prologue
        mov     rbp, rsp 
        push    r12 

        ; -----
        ; Get min and max

        mov     eax, dword[rdi]     ; get min 
        mov     dword[rdx], eax     ; return min

        mov     r12, rsi            ; get len
        dec     r12                 ; set len-1
        mov     eax, dword[rdi+r12*4]       ; get max
        mov     dword[r9], eax              ; return max

        ; -----
        ; Get medians

        mov     rax, rsi 
        mov     rdx, 0
        mov     r12, 2
        div     r12                 ; rax = length/2

        cmp     rdx, 0              ; even/odd length?
        je      evenLength          

        mov     r12d, dword[rdi+rax*4]      ; get arr[len/2]
        mov     dword[rcx], r12d            ; return med1
        mov     dword[r8], r12d             ; return med2
        jmp     medDone

    evenLength:
        mov     r12d, dword[rdi+rax*4]          ; get arr[len/2]
        mov     dword[r8], r12d                 ; return med2
        dec     rax 
        mov     r12d, dword[rdi+rax*4]          ; get arr[len/2-1]
        mov     dword[rcx], r12d                ; return med1

    medDone:

    ; -----
    ; Find sum
    mov     r12, 0     
    mov     rax, 0

    sumLoop:
        add     eax, dword[rdi+r12*4]
        inc     r12
        cmp     r12, rsi 
        jl      sumLoop

        mov     r12, qword[rbp+16]          ; get sum addr
        mov     dword[r12], eax             ; return sum

    ; -----
    ; Calculate average
        cdq 
        idiv    rsi 
        mov     r12, qword[rbp+24]
        mov     dword[r12], eax 

        pop     r12                         ; epilogue
        pop     rbp
        ret    


    ; -----    

    global _start 
    _start:

    ; stats2(arr, len, min, med1, med2, max, sum, ave);
    push    ave 
    push    sum 
    mov     r9, max 
    mov     r8, med2 
    mov     rcx, med1 
    mov     rdx, min 
    mov     esi, dword[len]
    mov     rdi, arr 
    call    stats2
    add     rsp, 16  


    ; -----
    ; Done, terminate program

    last:
        mov rax, SYS_exit               ; call code for exit
        mov rdi, EXIT_SUCCESS           ; exit with success
        syscall


