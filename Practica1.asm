.data
origen: .word 5 4 3 2 1
auxiliar:  .word 0 0 0 0 0
destino: .word 0 0 0 0 0
n: .word 5
.text
















Hanoi:
	beq $a0, 1, base		#si n==1, vamos al caso base
	addi $a0, $a0, -1		#
	jal Hanoi
	jal Move
	jal Hanoi
	




Move: 
	lw $s0, 0($a0)			#carga en s0 el contenido de la direccion a0 (la parte mas alta de la torre de origen
	addi $s1, $zero, 0		
	sw $s1, 0($a0)			#pone como vacia la direccion de donde se tomo el elemento a mover
	addi $a0, $a0, -4		#mueve la direccion "tope" de la torre de origen una posicion menos
	sw $s0, 0($a1)			#guarda el valor tomado de la torre de origen en el tope de la torre de destino
	jr $ra
