#Computer Architecture
#First Project – Text Message Encryption and Decryption

#####################################################################################
.data 

mess1: .asciiz "What would you like to do? Enter (e) for encryption and (d) for decryption. \n"
mess2: .asciiz "Enter the name of the plain text file. \n"
mess3: .asciiz "Enter the name of the cipher text file. \n"
mess4: .asciiz "Unrecognizable input.... Exiting. \n"
word: .asciiz "IBrahim"
fileName: .space 200
file: .space 1000
filtered: .space 1000

#####################################################################################
.text
.globl main
main:
la $a0, word
li $v0, 4 
syscall


lb $t1, 0($a0) 
addiu $t2,$t1,32
move $a0,$t2
li $v0, 11
syscall


la $a0, word
addi $a0, $a0, 1 
lb $t1, 0($a0) 
addiu $t2,$t1,32
move $a0,$t2
li $v0, 11
syscall









