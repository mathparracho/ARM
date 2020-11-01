.text
.global Calculator
.type Calculator,"function"

.extern power

// x0: size = 6
// x1: vector operações
// x2: vector B
// x3: vector A

// x4: elm vector A
// x5: elm vector B
// w6: elm vector operações

// x7: size
// x19: vector operação
// x20: natural counter (0->6)
// x21: check overflow

CHECKOVER:		sbfx x21,x0,32,32
				cmp x21,0
				beq FLOOP

				mov x0,x20
				b END

OVER:			mov x0,x20
				b END

NOVER:			mov x0,0
				b END

Calculator:		stp	x29, x30, [SP, -32]!
				mov	x29, SP

				mov x7,x0			// size
				mov x19,x1			// vector operação
				mov x20, 1			// normal counter

LOOP:			ldrsw x4,[x3]		//load vector A
				ldrsw x5,[x2]		//load vector B
				ldrb w6,[x19]		//load vector operações


				cmp w6, '+'
				b.eq ADD
				cmp w6, '-'
				b.eq SUB
				cmp w6, '*'
				b.eq MULT

				mov x0,x4
				mov x1,x5
				bl power

				cbz x0,OVER

FLOOP:			str w0,[x3]
				sub x7,x7,1
				cbz x7,NOVER
				add x19,x19,1
				add x2,x2,4
				add x3,x3,4
				add x20,x20,1
				b LOOP

ADD:			add x0,x4,x5
				b CHECKOVER

SUB:			sub x0,x4,x5
				b CHECKOVER

MULT:			mul x0,x4,x5
				b CHECKOVER


END:			ldr	x20, [SP, 16]
				ldp	x29, x30, [SP], 32
				ret
