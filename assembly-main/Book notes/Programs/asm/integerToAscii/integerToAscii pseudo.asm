; Simple example program to convert an integer into an ASCII string

; *****************************************************************

;

;
;
; Part A - Successive division
;   digitCount = 0
;   get integer
;   divideLoop:
;   divide number by 10
;   push remainder
;   increment digitCount
;   if (result > 0) goto divideLoop
;
;

; Part B – Convert remainders and store
;   get starting address of string (array of bytes)
;   idx = 0
;   popLoop:
;   pop intDigit
;   charDigit = intDigit + “0” (0x030)
;   string[idx] = charDigit
;   increment idx
;   decrement digitCount
;   if (digitCount > 0)