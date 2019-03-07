 AREA |.text|,CODE,READONLY,ALIGN=2
	THUMB
	EXPORT Start
Start		
		MOV r0,#5 			; Set r0=3
LOOP 	PUSH {r0,LR} 		;
		CMP R0,#1 			;check r0 = 1; 5 = 1 false
		BGT ELSE 			;Greater than
		MOV R0,#1
		ADD SP,SP,#8 		; sp + 8 = sp
		MOV PC,LR
ELSE 	SUB R0,R0,#1 		; ro = r0 - 1; false so r0=5-1
 BL LOOP 					; branch with link
		POP {r1,LR}
		MUL R0,R1,R0 		; r1 * r0 = r0
		MOV PC, LR
		END