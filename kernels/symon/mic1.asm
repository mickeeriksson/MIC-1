

ACIA1 = $8800
ACIA1_data	= ACIA1		; simulated ACIA r/w port
ACIA1_status  = ACIA1+1
ACIA1_command = ACIA1+2
ACIA1_control = ACIA1+3



.segment "MONITOR"
	.org	$FC00		; pretend this is in a 1/8K ROM

; reset vector points here
NMI_vector:
    JMP NMI_vector

IRQ_vector:
    JMP IRQ_vector

RES_vector:
	;CLD			; clear decimal mode
	;LDX	#$FF		; empty stack
	;TXS			; set the stack

; Initialize the ACIA1
ACIA1_init:
	LDA	#$00
	STA	ACIA1_status		; Soft reset
	LDA	#$0B
	STA	ACIA1_command		; Parity disabled, IRQ disabled
	LDA	#$1E
	STA	ACIA1_control		; Set output for 8-N-1 9600





INIT_signon:
    LDY	#$00
@nextchar:
	LDA	Init_signonmess,Y		; get byte from sign on message
	BEQ	INIT_stop		; exit loop if done
	JSR	ACIA1_out		; output character
	INY				; increment index
	BNE	@nextchar		; loop, branch always

INIT_stop:
    ;JMP RES_vector
    JMP INIT_stop

; ----------------

; byte out to ACIA
ACIA1_out:
	PHA				; save accumulator
@loop:
	LDA	ACIA1_status		; Read 6551 status
	AND	#$10			; Is tx buffer full?
	BEQ	@loop			; if not, loop back
	PLA				; Otherwise, restore accumulator
	STA	ACIA1_data		; write byte to 6551
	RTS

; sign on string
Init_signonmess:
	.byte	$0D,$0A,"MIC-1 (c) 2024, Micke Eriksson"
	.byte   $0D,$0A,"Simple 6502 MONITOR v0.01"
	.byte   $0D,$0A,"Resistance Is Futile",$00

; system vectors
.segment "VECTORS"
	.org	$FFFA

	.word	NMI_vector		; NMI vector
	.word	RES_vector		; RESET vector
	.word	IRQ_vector		; IRQ vector