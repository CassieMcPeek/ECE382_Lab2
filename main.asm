;-------------------------------------------------------------------------------
; MSP430 Assembler Code Template for use with TI Code Composer Studio
;		Lab 2 - Subroutines - "Cryptography"
;				The required functionality for this lab will take an encrypted message and a key as input and decrypt the message using the
;				XOR function and output the message into RAM (0x0200). This lab will utilize two subroutines to complete the decryption. The B functionality
;				for this lab will decrypt a message that has an arbitrarily long key input. The B functionality will require the length of the key
;				to be passed through as a parameter into the subroutine.
;		C1C Cassie McPeek
;		ECE 382 - T5
;
;		Inputs: Encrypted (.byte)
;				Key 	(.byte)
;		Outputs: Message stored at address 0x0200 (.space)
;-------------------------------------------------------------------------------
            .cdecls C,LIST,"msp430.h"       ; Include device header file

;-------------------------------------------------------------------------------
            .text                           ; Assemble into program memory
Encrypted:  .byte		0x35,0xdf,0x00,0xca,0x5d,0x9e,0x3d,0xdb,0x12,0xca,0x5d,0x9e,0x32,0xc8,0x16,0xcc,0x12,0xd9,0x16,0x90,0x53,0xf8,0x01,0xd7,0x16,0xd0,0x17,0xd2,0x0a,0x90,0x53,0xf9,0x1c,0xd1,0x17,0x90,0x53,0xf9,0x1c,0xd1,0x17,0x90
						;0xf8,0xb7,0x46,0x8c,0xb2,0x46,0xdf,0xac,0x42,0xcb,0xba,0x03,0xc7,0xba,0x5a,0x8c,0xb3,0x46,0xc2,0xb8,0x57,0xc4,0xff,0x4a,0xdf,0xff,0x12,0x9a,0xff,0x41,0xc5,0xab,0x50,0x82,0xff,0x03,0xe5,0xab,0x03,0xc3,0xb1,0x4f,0xd5,0xff,0x40,0xc3,0xb1,0x57,0xcd,0xb6,0x4d,0xdf,0xff,0x4f,0xc9,0xab,0x57,0xc9,0xad,0x50,0x80,0xff,0x53,0xc9,0xad,0x4a,0xc3,0xbb,0x50,0x80,0xff,0x42,0xc2,0xbb,0x03,0xdf,0xaf,0x42,0xcf,0xba,0x50,0x8f
						;0xef,0xc3,0xc2,0xcb,0xde,0xcd,0xd8,0xd9,0xc0,0xcd,0xd8,0xc5,0xc3,0xc2,0xdf,0x8d,0x8c,0x8c,0xf5,0xc3,0xd9,0x8c,0xc8,0xc9,0xcf,0xde,0xd5,0xdc,0xd8,0xc9,0xc8,0x8c,0xd8,0xc4,0xc9,0x8c,0xe9,0xef,0xe9,0x9f,0x94,0x9e,0x8c,0xc4,0xc5,0xc8,0xc8,0xc9,0xc2,0x8c,0xc1,0xc9,0xdf,0xdf,0xcd,0xcb,0xc9,0x8c,0xcd,0xc2,0xc8,0x8c,0xcd,0xcf,0xc4,0xc5,0xc9,0xda,0xc9,0xc8,0x8c,0xde,0xc9,0xdd,0xd9,0xc5,0xde,0xc9,0xc8,0x8c,0xca,0xd9,0xc2,0xcf,0xd8,0xc5,0xc3,0xc2,0xcd,0xc0,0xc5,0xd8,0xd5,0x8f



;Key:		.byte		0xac, 0xdf, 0x23	; Key input
Key_Length:	.word		0x0003				; Key lenght required for B functionality

			.data							;Ram

Message:	.space  	100
EndMessage:	.equ		0x23

			.text


            .retain                         ; Override ELF conditional linking
                                            ; and retain current section
            .retainrefs                     ; Additionally retain any sections
                                            ; that have references to current
                                            ; section
;-------------------------------------------------------------------------------
RESET       mov.w   #__STACK_END,SP         ; Initialize stackpointer
StopWDT     mov.w   #WDTPW|WDTHOLD,&WDTCTL  ; Stop watchdog timer

;-------------------------------------------------------------------------------
                                            ; Main loop here
;-------------------------------------------------------------------------------
			mov.w	#Encrypted, 	r5		; loads addresses into registers to pass decrypt_message subroutine
			;mov.w	#Key,			r6
			mov.w	#Message,		r8
			mov.w	&Key_Length,	r10


			call	#decrypt_message		; calls subfunction

forever		jmp		forever					; traps CPU

;-------------------------------------------------------------------------------
                                            ; Subroutines
;-------------------------------------------------------------------------------
;Subroutine Name: XORvalues
;Author:	C1C Cassie McPeek
;Function: XOR's two values
;Inputs: XOR's r7 and r9
;Outputs:message in r7
;Registers destroyed:r7


XORvalues:	xor r7, r9						; XOR's two values
			ret

;-------------------------------------------------------------------------------
;Subroutine Name: decrypt_message
;Author:	C1C Cassie McPeek
;Function: Decrypts a string of bytes and stores the result in memory.  Accepts
;           the address of the encrypted message, address of the key, and address
;           of the decrypted message (pass-by-reference).  Accepts the length of
;           the message by value.  Uses the decryptCharacter subroutine to decrypt
;           each byte of the message.  Stores theresults to the decrypted message
;           location.
;Inputs: the value in r10, r5 and r6
;Outputs: the decrypted message
;Registers destroyed: r10
;-------------------------------------------------------------------------------

decrypt_message:

			mov.w	r10, r11
Again
			mov.b	@r6, r7					; moves key into register 7
			mov.b	@r5, r9					; moves encrypted message into register 9
			call 	#XORvalues				; calls subroutine
			mov.b	r9, 0(r8)				; moves results of XOR into register 8 where message is stored
			inc		r8						; increment all registers
			inc		r5
			inc		r6

Count		dec		r11						; keeps track of length of key
			jz		Reset
			jmp		return

Reset		mov.w	r10, r11
			sub		r10, r6




return		cmp		#EndMessage, r9			; compares whether or not message is complete
			jz		end
			jmp		Again



end			ret


;-------------------------------------------------------------------------------
;           Stack Pointer definition
;-------------------------------------------------------------------------------
            .global __STACK_END
            .sect 	.stack

;-------------------------------------------------------------------------------
;           Interrupt Vectors
;-------------------------------------------------------------------------------
            .sect   ".reset"                ; MSP430 RESET Vector
            .short  RESET
