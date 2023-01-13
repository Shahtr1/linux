org 100h

mov ax, 0x300
mov ds, ax

mov [0xff], 0x30
; hex 30 will be stored in  (address stored in DS hex * 16 + new address(255))

;same goes for IP, its actually CS * 16 + IP

ret
