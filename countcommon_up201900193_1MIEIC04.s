.text
.global CountCommon
.type CountCommon,"function"

// x0: len x1
// x1: vector x1
// x2: len x2
// x3: vector x2

// x4: x1 element
// x5: x3 element
// x6: counter
// x7: mutable len x3
// x9: mutable elm x3


CountCommon:	mov x6,0				//inicializar a contagem
				cbz x2, END				//caso em que x2 é nulo

INIT:			mov x7,x2				//reiniciar o numero de elementos da lista 2
				mov x9,x3				//reiniciar a lista 2
				cbz x0, END				//caso finalizado, ir para o fim

				ldrsw x4,[x1]			//load do valor da lista 1


CHECK:			ldrsw x5, [x9]			//load do valor da lista 2
				cmp x4,x5
				beq INLIST				//se o elemento de 1 for igual o de 2, ir para INLIST
				sub x7,x7,1				//subtrair 1 da contagem de elementos da lista 2
				cbz x7,NOTLIST			//se acabou, e a lista 2 não havia o elemento de 1, ir para NOTLIST
				add x9,x9,4				//ir para o proximo elemento da lista 2
				b CHECK


INLIST:			add x6,x6,1				//adicionar 1 a contagem
				add x1,x1,4				//ir para o proximo elemento da lista 1
				sub x0,x0,1				//subtrair 1 da contagem dos elementos da lista 1
				b INIT

NOTLIST:		add x1,x1,4				//ir para o proximo elemento da lista 1
				sub x0,x0,1				//subtraur 1 da contagem dos elementos da lista 1
				b INIT



END:			mov x0,x6				//mover resultado final para x0
				ret
