	AREA |.text|, CODE, READONLY, ALIGN=2
	THUMB
	EXPORT Start
Start

		MOV r0, #4 ; load 4 into r0
		MOV r1, #5 ; load 5 into r1
		MOV r3, #9; load 3 into r3
		ADD r2, r0,r1 ; add ro to r1 and put the result in r2
		ADD r4, r2,r3 ; subtract r2 to r3 and put the result in r4
		SUB r6, r4,#3
		MOV r5, #0x20000000 ;base
		STR r6, [r5,#0xA0]
T 		B T ; force infinite loop by branching to this line
		END ; end of program