
#---------------------------------------------------------------#
#			INTEGRANTES:				#
#								#
#		Margarita Jauregui Franco			#
#		Andrea Rayón Mora				#
#								#
#---------------------------------------------------------------#
.data
n: .word 8 
.text
Main: 
	add $a1, $zero, 0x1001		#carga los 4lsb de la direccion de la torre A
	sll $a1, $a1, 16		#recorre logicamente 4 posiciones cada bit para hacerlos msb
	add $a2, $zero, $a1		#copia lo obtenido en a1 a a2
	ori $a2, 0x0004			#hace or con 4 para moverse a la direccion de inicio de la torre B
	add $a3, $zero, $a1		#pasa los mismos 4msb a a3
	ori $a3, 0x0008			#hace or con 8 para moverse a la direccion de inicio de la torre C	
	lw $a0, n			#carga en numero de discos
	lw $s0, n			#carga el numero de discos


Torre: 
	sw $s0, 0($a1)			#cargamos el numero de discos a la torre origen 
	sub $s0, $s0, 1			#Restamos un disco
	addi $a1, $a1, 0x20		#Recorremos 
	bne $s0, $zero, Torre 		#Si el numero de discos es == 0, salta a hanoi
	sub $a1, $a1, 0x20		#Recorremos 
	sub $a3, $a3, 0x20		#Recorremos 
	sub $a2, $a2, 0x20		#Recorremos
	jal Hanoi
	j exit

Hanoi:
	addi $sp, $sp, -16
	sw $a1, 0($sp)			#a1 = org
	sw $a2, 4($sp)			#a2 = aux
	sw $a3, 8($sp)			#a3 = dest
	sw $ra, 12($sp)
	beq $a0, 1, base		#si n==1, vamos al caso base
	addi $a0, $a0, -1		#restamos un disco
					
	add $t2, $a2, $zero		#Pasamos argumentos para volver a llamar hanoi
	add $a2, $a3, $zero		#a2 = dest
	add $a3, $t2, $zero		#a3 = aux
	jal Hanoi
					
	add $t2, $a2, $zero		#Respaldamos valores de a2 y a3 para hacer swap
	add $t3, $a3, $zero
	add $a2, $t3, $zero		#a2 = dest
	add $a3, $t2, $zero		#a3 = aux
	
	jal Move
	sw $a1, 0($sp)			#Actualizamos valores de stack
	sw $t3, 4($sp)		
	sw $a3, 8($sp)	
	lw $a2, 4($sp)
	add $t1, $a1, $zero		#Respaldamos valores de las torres
	add $t2, $a3, $zero		#
	add $t3, $a2, $zero
					
	add $a1, $t3, $zero		#a1 = Aux
	add $a2, $t1, $zero		#a2 = org
	add $a3, $t2, $zero 		#a3 = Dest
	
	jal Hanoi
	sw $a2, 0($sp)			#Actualizamos stack
	sw $a1, 4($sp)
	sw $a3, 8($sp)
	addi $a0, $a0, 1 		#Sumamos un disco, si llega aqui significa que ya va de regreso
	j exitRecursividad

base:

	jal Move	
	sw $a1, 0($sp)			#Actualizamos los valores respaldados del stack 
	sw $a3, 8($sp)	
	j exitRecursividad


Move:  
	addi $a3, $a3, 0x20
	lw $s0, 0($a1)			#carga en s0 el contenido de la direccion a0 (la parte mas alta de la torre de origen
	sw $s1, 0($a1)			#pone como vacia la direccion de donde se tomo el elemento a mover
	sub $a1, $a1, 0x20		#mueve la direccion "tope" de la torre de origen una posicion menos
	sw $s0, 0($a3)			#guarda el valor tomado de la torre de origen en el tope de la torre de destino
	jr $ra
	
exitRecursividad:
	lw $a1, 0($sp)			#a1 = org
	lw $a2, 4($sp)			#a2 = aux
	lw $a3, 8($sp)			#a3 = dest
	lw $ra, 12($sp)
	addi $sp, $sp, 16
	jr $ra
	
exit:
