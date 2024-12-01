;; Replace with segment MONITOR later on
;;;.segment "MONITOR"
.segment "CODE"
	.org	$8000		; pretend this is in a 1/8K ROM


; reset vector points here
NMI_vector:
                JMP NMI_vector

IRQ_vector:
                JMP IRQ_vector

RES_vector:
	;CLD			; clear decimal mode
	;LDX	#$FF		; empty stack
	;TXS			; set the stack

                nop
                nop
                lda $7FFF
                sta $7FFF
                sta $7F60
                sta $7F60
                nop
                nop
                jmp RES_vector


.segment "CODE2"
.org $C000
up4:
                nop
                nop
                jmp up4


; system vectors
.segment "VECTORS"
	.org	$FFFA

	.word	NMI_vector		; NMI vector
	.word	RES_vector		; RESET vector
	.word	IRQ_vector		; IRQ vector