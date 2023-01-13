; Example program to demonstrate console output.
; This example will send some messages to the screen.

; **********************************************
section .data

; -----
; Define standard constants

LF              equ         10  ; line feed
NULL            equ         0   ; end of string
TRUE            equ         1   
FALSE           equ         0

EXIT_SUCCESS    equ         0   ; success code

STDIN           equ         0   ; standard input        
STDOUT          equ         1   ; standard output        
STDERR          equ         2   ; standard error

SYS_read        equ         0   ; read 
SYS_write       equ         1   ; write
SYS_open        equ         2   ; file open
SYS_close       equ         3   ; file close
SYS_fork        equ         57  ;  fork
SYS_exit        equ         60  ; terminate 
SYS_creat       equ         85  ; file open/create
SYS_time        equ         201 ; get time

; -----
; Define some strings.

message1        db          "Hello World.", LF, NULL 
message2        db          "Enter Answer: ", NULL 
newLine         db          LF, NULL 

; ---------------------------------------------------

section .text
global _start
_start:
    ; -----
    ; Display first message.

    mov     rdi, message1
    call    printString

    ; -----
    ; Display second message and then newLine

    mov     rdi, message2
    call    printString

    mov     rdi, newLine
    call    printString

    ; -----
    ; Example program done.

exampleDone:
    mov     rax, SYS_exit
    mov     rdi, EXIT_SUCCESS
    syscall

; ****************************************************
; Generic function to display a string to the screen
; String must be NULL terminated
; Algorithm:
;   Count characters in string (excluding NULL)
;   User syscall to output characters
; Arguments:
;   1)  address, string
; Returns:
;   nothing

global printString
printString:
    push    rbx
    ; -----
    ; Count characters in string.

    mov     rbx, rdi
    mov     rdx, 0

strCountLoop:
    cmp     byte[rbx], NULL
    je      strCountDone
    inc     rdx 
    inc     rbx 
    jmp     strCountLoop

strCountDone:
    cmp     rdx, 0
    je      prtDone

    ; -----
    ; Call OS to output string.

    mov     rax, SYS_write              ; system code for write()
    mov     rsi, rdi                    ; address of chars to write
    mov     rdi, STDOUT                 ; standard out 
                                        ; RDX=count to write, set above
    syscall                             ; system call

    ; -----
    ; String printed, return to calling routine

prtDone:
    pop rbx
    ret 

; The output would be as follows:
; Hello World.
; Enter Answer:_