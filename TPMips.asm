.data
	texto: .asciiz "Informe o valor da compra\n"
	texto2: .asciiz "Valor da compra: "
	texto3: .asciiz "\nVocê não tem dinheiro para essa compra...: "
    quebra: .asciiz "\n"
    espaco: .asciiz " "
       
.text

#Armazenando o valor 0 para os contadores de cada cedula
li $t0, 0 #nota de 20
li $t1, 0 #nota de 10
li $t2, 0 #nota de 5
li $t3, 0 #nota de 2
li $t4, 0 #moeda de 1

#Imprimindo a String armazenada em memoria
li $v0, 4
la $a0, texto
syscall

#Entrada de dados
li $v0, 5
syscall
move $t5, $v0

#Imprime valor da compra
li $v0, 4
la $a0, texto2
syscall

li $v0, 1
move $a0, $t5
syscall

#Verificando se o usuario tem dinheiro para a compra
bgt $t5, 100, semdinheiro

laco: 
bge $t5, 20, f20

bge $t5, 10, f10

bge $t5, 5, f5

bge $t5, 2, f2

bge $t5, 1, f1

j print

#Funções de cada cedula
f20:
beq $t0, 2, f10
addi $t0, $t0, 1
subi $t5, $t5, 20
blt $t0, 2, laco

f10:
beq $t1, 3, f5
addi $t1, $t1, 1
subi $t5, $t5, 10
blt $t1, 3, laco

f5:
beq $t2, 3, f2
addi $t2, $t2, 1
subi $t5, $t5, 5
blt $t2, 3, laco

f2:
beq $t3, 2, f1
addi $t3, $t3, 1
subi $t5, $t5, 2
blt $t3, 2, laco

f1:
beq $t4, 10, print
addi $t4, $t4, 1
subi $t5, $t5, 1
blt $t4, 10, laco

#Printando a quantidade de cada cedula
print:
li $v0, 4 
la $a0, quebra
syscall

li $v0, 1 
move $a0, $t0
syscall

li $v0, 4 
la $a0, espaco
syscall

li $v0, 1 
move $a0, $t1
syscall

li $v0, 4
la $a0, espaco
syscall

li $v0, 1 
move $a0, $t2
syscall

li $v0, 4
la $a0, espaco
syscall

li $v0, 1
move $a0, $t3
syscall

li $v0, 4
la $a0, espaco
syscall

li $v0, 1 
move $a0, $t4
syscall

j fim

semdinheiro: 
li $v0, 4  
la $a0, texto3
syscall

fim: 