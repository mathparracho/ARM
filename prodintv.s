.text
.global prodintV
.type  prodintV,"function"

// int *R	->	X0
// int *S	-> 	X1
// int n	->	W2

prodintV:		mov		X3, 0
CICLO:			cbz		W2, FIM
				sub		W2, W2, 4

				ldr		Q0, [X0], 16
				ldr		Q1, [X1], 16

				mul		V2.4S, V0.4S, V1.4S

				addv	S0, V2.4S
				smov	X4, V0.S[0]

				add		X3, X3, X4

				b 		CICLO
FIM:			mov		X0, X3
				ret
