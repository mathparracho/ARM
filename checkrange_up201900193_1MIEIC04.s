.text
.global CheckRange
.type CheckRange,"function"

// x0: limiar
// x1: dim
// x2: vector

CheckRange: mov x9,0			//inicia a contagem em x9
			mov x10,-1
			mul x10,x0,x10		//salva o valor do limite negativo em x10

INIT:		ldrsw x8,[x2]		//carrega o valor referente na lista

			cmp x8, x0
			bgt CHANGEG			//se for maior que o limite superior, vá para a subrotina CHANGEG

			cmp x8,x10
			blt CHANGEL			//se for menor que o limite inferior, vá para a subrotinta CHANGEL

CONT:		sub x1,x1,1			//reduz 1 na contagem dos elementos da lista
			add x2,x2,4			//busca o próximo elemento da lista
			cbz x1, FINAL		//se acabou os elementos da lista para verificar, vá para a subrotina FINAL
			b INIT				//continuação do ciclo se ainda houver elementos a verificar

CHANGEG:	add x9,x9,1			//soma o valor da contagem
			str w0,[x2]			//alterar o valor na lista
			b CONT				//retorna para o ciclo para continuar o processo

CHANGEL:	add x9,x9,1			//soma o valor da contagem
			str w10,[x2]		//alterar o valor na lista
			b CONT				//retorna para o ciclo para continuar o processo

FINAL:		mov x0,x9			//salva o resultado em X0
			ret					//retorna para a função main
