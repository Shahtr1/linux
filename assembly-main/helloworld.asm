org 100h

jmp main
                              
                              
; Define byte size variable
message: db 'Hello World!', 0



print: 
  
    ; Move 0x0e to ah 
    mov ah, 0eh  
._loop:  

    ; load 1 byte from si in al and increments si by 1
    lodsb                                
    
    cmp al, 0
    je .done 
    
    ; call interrupt which takes value of ah which is 0eh(14) 
    ; 0eh14 is write character in Teletype(TTY) mode,
    ; it writes one character at the current cursor location and advances the cursor
    int 10h                                                                         
    
    jmp ._loop
.done:
ret
 
main:
    mov si, message
    call print
    ret




