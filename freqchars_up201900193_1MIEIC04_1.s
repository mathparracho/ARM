.text
.global freqchars
.type freqchars,"function"


// w0: numero de caracteres texto
// x1: endereço da lista de chars (8bits = 1byte por posição)

// w2: char(?) do numero de letras a pesquisar
// x3: endereço da lista de letras

// x4: endereço para guardar os resultados

fcheck:		mov x22,1
			mov w6, 0
			ldr w7, [x3], 1

next:		dup v1.16B, w7
			mov w5, 1
			dup v2.16B, w5

check:		ldr q0, [x1], 16

			cmeq v3.16B, v0.16B, v1.16B
			and v3.16B,v3.16B,v2.16B
			addv B4, v3.16B
			umov w5, v4.B[0]
			add w6,w6,w5

			sub w0,w0,16
			cbz w0, upper
			b check

upper:		mov w0, w20
			sub w7,w7,32
			mov x1,x19
			cbz x22, ciclo
			sub x22,x22,1
			b next


freqchars:	mov x19, x1		//guardar valor do endereço do text
			mov w20, w0		//guardar valor do do len do text
			mov w21, w2		//guardar valor do len de lett
			mov x23, x3
			mov x24,x4
			b fcheck

ciclo:		ucvtf s4, w6
			ucvtf s5, w20
			fdiv s4,s4,s5
			mov x5,100
			ucvtf s5,x5
			fmul s4,s4,s5
			str s4,[x4], 4

			sub w2,w2,1
			cbz w2, max
			mov x1, x19
			mov w0, w20

			b fcheck



max:		mov x5,0		//incializar o max
			ucvtf s5, x5	//converter
			mov x6,0		//iniciar contagem
			mov x3,x23		//valor inicial da lista de letras
			mov x4,x24		//valor inicial da lista dos resultados

cmax:		cbz x21, inlist
			ldr s6,[x4], 4
			fcmp s6, s5
			b.gt ismax
			sub x21,x21,1
			add x6,x6,1
			b cmax

ismax:		fmov s5,s6
			mov x7,x6
			sub x21,x21,1
			add x6,x6,1
			b cmax

inlist:		ldrb w0,[x3],1
			cbz x7, fim
			sub x7,x7,1
			b inlist

fim:		ret
