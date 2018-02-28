.data
n: .word 5
.text
Main:
	add $a1, $zero, 0x1001		#carga los 4lsb de la direccion de la torre A
	sll $a1, $a1, 16		#recorre logicamente 4 posiciones cada bit para hacerlos msb
	add $a2, $zero, $a1		#copia lo obtenido en a1 a a2
	ori $a2, 0x0004			#hace or con 4 para moverse a la direccion de inicio de la torre B
	add $a3, $zero, $a1		#pasa los mismos 4msb a a3
	ori $a3, 0x0008			#hace or con 8 para moverse a la direccion de inicio de la torre C
	lw $a0, n
<<<<<<< HEAD


Torre: 
	beq $a0, $zero, Hanoi 		#Si el numero de discos es == 0, salta a hanoi
	sw $a0, 0($a1)			#cargamos el numero de discos a la torre origen 
	sub  $a0, $a0, 1		#Restamos un disco
=======
	lw $s0, n


Torre: 
	beq $s0, $zero, Hanoi 		#Si el numero de discos es == 0, salta a hanoi
	sw $s0, 0($a1)			#cargamos el numero de discos a la torre origen 
	sub  $s0, $s0, 1		#Restamos un disco
>>>>>>> maggie
	addi  $a1, $a1, 0x20		#Recorremos 
	j Torre

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
	
base:
<<<<<<< HEAD

=======
	add $a0, $t1, $zero
	add $a1, $t3, $zero
	jal Move
	j exitRecursividad
>>>>>>> maggie


Move: 

	lw $s0, 0($a0)			#carga en s0 el contenido de la direccion a0 (la parte mas alta de la torre de origen
	addi $s1, $zero, 4		
	sw $s1, 0($a0)			#pone como vacia la direccion de donde se tomo el elemento a mover
	addi $a0, $a0, -20		#mueve la direccion "tope" de la torre de origen una posicion menos
	sw $s0, 0($a1)			#guarda el valor tomado de la torre de origen en el tope de la torre de destino
	jr $ra
	
exitRecursividad:
	
