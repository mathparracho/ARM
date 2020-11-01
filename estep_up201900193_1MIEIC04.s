#include <stdio.h>
#include <stdlib.h>

extern void eStep(unsigned int N, float *seq_P , unsigned int M, double *seq_C, unsigned int *seq_Out);

int main(void)
{
	unsigned int N = 5, M = 3;
	float seq_P[] =  {-3.1, 0, 2.5, -2, 3, 2, 0.5, 1, -5, -1};
	double seq_C[] = {-2, -2, 0, 0, 2, 2};
	unsigned int seq_Out[N];

	eStep(N, seq_P, M, seq_C, seq_Out);

	for(int i = 0; i < N; i++){
		printf("O ponto %d da seq_P (%f, %f) tem como ponto da seq_C mais próximo o ponto de índice %d (%f, %f)\n",
				i, seq_P[i*2], seq_P[i*2 + 1], seq_Out[i], seq_C[seq_Out[i]*2], seq_C[seq_Out[i]*2 + 1]);
	}

	// Neste exemplo a sequência seq_Out deveria passar a conter {0, 1, 2, 1, 0} após a execução da sub-rotina

 	return EXIT_SUCCESS;
}


----------------------------------------------------------------------------------------------------


.text
.global eStep
.type eStep,"function"

num: .double 9223372036854775807

// w0: len seq_P / 2
// x1: seq_P -> float
// w2: len seq_C / 2
// x3: seq_C -> double
// x4: seq_Out


// d0: value Xp
// d1: value Yp
// d2: value Xc
// d3: value Yc
// d4: resultado



// variaveis auxiliares:

// x5: inicio seq_C
// w6: counter da seq_P
// w7: counter da seq_C



//rotina de opeação
OPERATION:	fsub d2,d2,d0
			fmul d2,d2,d2
			fsub d3,d3,d1
			fmul d3,d3,d3
			fadd d3,d3,d2
			fsqrt d3,d3
			fmov d4,d3

			str d4,[SP,-16]!

			sub w7,w7,1
			b CONT
//fim da rotina de opeação


eStep:		stp X29, X30, [SP, -32]!
			mov X29, SP
			mov w6,w0		//iniciar counter seq_P
			mov w7, w2		//iniciar counter seq_C
			mov x5,x3		//salvar inicio da seq_C


INI:		ldr s0, [x1]	//load Xp
			fcvt d0, s0
			add x1,x1,4
			ldr s1, [x1]	//load Yp
			fcvt d1, s1

PART2:		ldr d2, [x3]	//load Xc
			add x3,x3,8
			ldr d3, [x3]	//load Yc

			b OPERATION

CONT:		cbz w7, MIN
			add x3,x3,8
			b PART2

NEXTP:		sub w6,w6,1
			cbz w6, END
			add x1,x1,4
			mov x3,x5
			mov w7, w2
			add x4,x4,4
			b  INI

// rotina de checagem do menor valor da lista
// x9: counter indice
MIN:		mov w7, w2
			ldr d5,num

N2:			ldr d4,[SP],16

			fcmp d4, d5
			b.le SAVE
N3:			sub w7,w7,1
			cbz w7, NEXTP
			b N2

SAVE:		mov x10,x7
			sub x10,x10,1
			str x10,[x4]
			fmov d5,d4
			b N3
// fim da rotina de checagem


END:		mov x0,x4
			ldp	x29, x30, [SP], 32
			ret
