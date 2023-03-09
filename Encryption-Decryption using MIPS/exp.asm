#Computer Architecture
#First Project – Text Message Encryption and Decryption

#####################################################################################
.data 

mess1: .asciiz "What would you like to do? Enter (e) for encryption and (d) for decryption. \n"
mess2: .asciiz "Enter the name of the plain text file. \n"
mess3: .asciiz "Enter the name of the cipher text file. \n"
mess4: .asciiz "Unrecognizable input.... Exiting. \n"
word: .asciiz "ABCD EF!jg t?t.zyx"
fileName: .space 200
file: .space 1000
filtered: .space 1000

#####################################################################################
.text
.globl main
main:


la $a0, word
la $a1, filtered
li $t3, 0
li $t4, 0

loop1:
lb $t1, 0($a0)
beqz $t1,exit
blt $t1, 97, checkAlpha
bgt $t1, 122, base

sb $t1, 0($a1)
addi $t3, $t3, 1
add $a1,$a1,1

base:
add $a0, $a0, 1
j loop1

checkAlpha:
bgt $t1, 90, space
blt $t1, 65, space

addiu $t2,$t1,32
sb $t2, 0($a1)
addi $t3, $t3, 1
add $a1,$a1,1
j back

space:
bne $t1, 32, back
sb $t1, 0($a1)
add $a1,$a1,1
bgt $t3,$t4,shiftValue
li $t3,0
back:
j base

shiftValue:
move $t4,$t3
li $t3,0
j back

exit:
bgt $t3,$t4,shiftValue
la $a0, filtered
li $v0, 4 
syscall

move $a0, $t4
li $v0, 1 
syscall

la $a0, filtered
loop2:
lb $t1, 0($a0)
beqz $t1,exit2
beq $t1, 32,base2
add $t1,$t1,$t4

blt $t1,122, base2
subi $t1,$t1,26

base2:
sb $t1, 0($a0)
add $a0, $a0, 1
j loop2

exit2:
la $a0, filtered
li $v0, 4 
syscall

li $v0, 10
syscall