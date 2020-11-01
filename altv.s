.text
.global altV
.type  altV,"function"

// float *P	-> X0
// int n	-> W1
// float k	-> S0

altV:		dup		V0.4S, V0.S[0]
CICLO:		cbz		W1, FIM
			sub		W1, W1, 4

			ldr		Q1, [X0]

			fmul	V1.4S, V0.4S, V1.4S

			str		Q1, [X0], 16

			b		CICLO
FIM:		ret

