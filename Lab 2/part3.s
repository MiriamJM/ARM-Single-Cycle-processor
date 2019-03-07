 AREA |.text|,CODE,READONLY,ALIGN=2
	THUMB
	EXPORT Start
Start
		; R0 = number
		; R1 = mask
		; R2 = counter of ones (Output of the program)
		; R3 = loop counter
		; R4 = AND result
		
		; Initialize registers.
		MOV r0, #-1
		MOV r1, #1
		MOV r2, #0
		MOV r3, #0
		
LOOP	AND r4, r0, r1		; r4 = r0 AND r1
		CMP r4, #0			; if r4 == 0...
		BEQ INC				; ...then jump to INC, otherwise continue to r2++
		ADD r2, r2, #1		; r2++
		
INC     ADD r3, r3, #1
		LSL r1, r1, #1		; r1 = r1 << 1
		CMP r3, #32			; 32 bits = sizeof(int) * 8 bits per byte
		BLT LOOP			; if( r3 < 32 ) goto LOOP; otherwise end program.
		END
		