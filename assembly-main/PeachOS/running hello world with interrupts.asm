ORG 0
BITS 16

_start:
    jmp short start
    nop

    ; from the link https://wiki.osdev.org/FAT. The first three bytes EB 3C 90 disassemble to JMP SHORT 3C NOP. (The 3C value may be different.) The reason for this is to jump over the disk format information (the BPB and EBPB).

    times 33 db 0

; BIOS assumes the BPB (Bios Perimeter block is there and startes writing its own data in it) so it corrupts the data, w ecan avoid it by implementing it, the size is 33 bytes. from https://wiki.osdev.org/FAT.

start:
    jmp 0x7c0:step2 ; CS becomes 0x7c0

handle_zero:
    mov ah, 0eh
    mov al, 'A'
    mov bx, 0x00
    int 0x10
    iret

handle_one:
    mov ah, 0eh
    mov al, 'V'
    mov bx, 0x00
    int 0x10
    iret

step2:
    cli ; Clear Interrupts, because we are about to change segment registers and we dont want any harware interrupt to come in between as this is critical
    mov ax, 0x7c0
    mov ds, ax
    mov es, ax
    mov ax, 0x00
    mov ss, ax 
    mov sp, 0x7c00
    sti ; Enables Interrupts

    mov word[ss:0x00], handle_zero ; to change where zero interrupt looks at, as it had its own interrupt zero pointer
    mov word[ss:0x02], 0x7c0 

    mov word[ss:0x04], handle_one
    mov word[ss:0x06], 0x7c0 

    int 1

    mov ax, 0x00
    div ax

    mov si, message
    call print
    jmp $

print:
    mov bx, 0 ; paging
.loop:
    lodsb
    cmp al, 0
    je .done
    call print_char
    jmp .loop
.done: ; subroutine
    ret

print_char:
    mov ah, 0eh
    int 0x10 ; we are calling a BIOS routine which outputs the char A to screen and 0eh is the command to do that
    ret

message: db 'Hello World!', 0

times 510-($ - $$) db 0 ; $ means current address and $$ means the first address of the current section. You have to understand that the times directive only operates on numbers and the difference of address ( $-$$ ) yields a number (Offset). So $-$$ gives you the offset from start to address of the currently executed instruction. If subtract that value from 510 you will get the offset from the address of the currently executed instruction to the 510th byte. So we now know how many bytes are there from the address of the currently executed instruction to the 510th byte. The times directive will now pad that number of bytes up to 510th byte with zeros.

dw 0xAA55