.text
.global conta_intervalo
.type  conta_intervalo,"function"

// float *V		-> X0
// long int n	-> X1
// float a		-> S0
// float b		-> S1

conta_intervalo:	mov		X2, 0
CICLO:				cbz		X1, FIM
					sub		X1, X1, 1

					ldr		S2, [X0], 4

					fcmp	S2, S0
					b.lo	CICLO
					fcmp	S2, S1
					b.gt	CICLO

					add		X2, X2, 1

					b 		CICLO
FIM:				mov		X0, X2
					ret
