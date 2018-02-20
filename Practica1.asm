.data
origen: .word 5 4 3 2 1
auxiliar:  .word 0 0 0 0 0
destino: .word 0 0 0 0 0
n: .word 5
.text












Hanoi:
	beq $a0, 1, base		#si n==1, vamos al caso base
	addi $a0, $a0, -1		#
	addi $sp, $sp, -20
	sw $a0, 0($sp)
	sw $a1, 4($sp)			#a1 = org
	sw $a2, 8($sp)			#a2 = aux
	sw $a3, 12($sp)			#a3 = dest
	sw $ra, 16($sp)
	add $t0, $a0, $zero		#respaldar valores en registros auxiliares
	add $t1, $a1, $zero		#para poder pasarlos posteriomente 
	add $t2, $a2, $zero		#como argumentos en el
	add $t3, $a3, $zero
	add $a2, $t3, $zero		#a2 = dest
	add $a3, $t2, $zero		#a3 = aux
	jal Hanoi
	add $a0, $t1, $zero
	add $a1, $t3, $zero
	jal Move
	add $a0, $t0, $zero
	add $a1, $t1, $zero
	add $a2, $t2, $zero
	add $a3, $t3, $zero 
	jal Hanoi
	




Move: 

	lw $s0, 0($a0)			#carga en s0 el contenido de la direccion a0 (la parte mas alta de la torre de origen
	addi $s1, $zero, 0		
	sw $s1, 0($a0)			#pone como vacia la direccion de donde se tomo el elemento a mover
	addi $a0, $a0, -4		#mueve la direccion "tope" de la torre de origen una posicion menos
	sw $s0, 0($a1)			#guarda el valor tomado de la torre de origen en el tope de la torre de destino
	jr $ra
