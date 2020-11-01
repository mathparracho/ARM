.text
.global somaV
.type  somaV,"function"

// float *P -> X0
// float *Q -> X1
// float *R -> X2
// int n    -> W3

somaV:		lsr		W3, W3, 2 // Dividir por 4
CICLO:		cbz		W3, FIM
			sub		W3, W3, 1

			ldr		Q0, [X0], 16
			ldr		Q1, [X1], 16

			fadd	V2.4S, V0.4S, V1.4S

			str		Q2, [X2], 16

			b		CICLO
FIM:		ret
