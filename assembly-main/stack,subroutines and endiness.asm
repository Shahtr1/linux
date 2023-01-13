org 100h

push 0xfff4

_main:
	call _test	; uses stack to store the return address
	mov ah, 0x20
	ret

_test:
	mov ah, 0x10
	ret

ret