.text
.global msubV
.type  msubV,"function"

// float *P	-> X0
// float *Q	-> X1
// float *R	-> X2
// int n	-> W3
// float k	-> S0

msubV:		stp 	x29, x30, [SP, -48]!
			mov		x29, SP

			// Registos protegidos que são alterados têm de ser repostos
			stp		x19, x20, [SP, 16]
			stp 	x21, x22, [SP, 32]


			// Guardar valores que são usados novamente em registos protegidos
			mov		x19, x0
			mov		x20, x1
			mov		x21, x2
			mov		w22, w3

			// preparar parametros
			mov		x0, x1
			mov		w1, w3

			// Trocar sinal para realizar subtração
			fneg	S0, S0

			bl		altV

			// preparar parametros
			mov		x1, x19
			mov		x0, x20
			mov		x2, x21
			mov		w3, w22

			bl		somaV

			ldp		x19, x20, [SP, 16]
			ldp 	x21, x22, [SP, 32]

			ldp		x29, x30, [SP], 48

			ret

