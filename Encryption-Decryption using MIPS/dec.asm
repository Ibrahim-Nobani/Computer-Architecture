#Computer Architecture
#First Project – Text Message Encryption and Decryption

#####################################################################################
.data 

mess1: .asciiz "What would you like to do? Enter (e) for encryption and (d) for decryption. \n"
mess2: .asciiz "\n Enter the name of the plain text file. \n"
mess3: .asciiz "Enter the name of the cipher text file. \n"
mess4: .asciiz "Unrecognizable input.... Exiting. \n"
word: .asciiz "ABCD EF!jg t?t.zyx"
word2: .asciiz "aghi jkol yyedc"
str_data_end:
fileName: .space 200
file: .space 1000
filtered: .space 1000

#####################################################################################
.text
.globl main
main:


la $a0, word2
la $a1, filtered
li $t3, 0
li $t4, 0

loop1:
lb $t1, 0($a0)
beqz $t1,exit
blt $t1, 97, space
bgt $t1, 122, base
addi $t3, $t3, 1
add $a1,$a1,1

base:
add $a0, $a0, 1
j loop1
space:
bne $t1, 32, back
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
move $a0, $t4
li $v0, 1 
syscall

la $a0, word2
loop2:
lb $t1, 0($a0)
beqz $t1,exit2
beq $t1, 32,base2
sub  $t1,$t1,$t4

bgt $t1,96, base2
addi  $t1,$t1,26

base2:
sb $t1, 0($a0)
add $a0, $a0, 1
j loop2

exit2:
la $a0, word2
li $v0, 4 
syscall
jal WriteIntoFile

WriteIntoFile:
la $a0,mess2
li $v0, 4 #prin file content
syscall
la $a0, fileName  #read file name
li $a1, 200
li $v0, 8 
syscall

loopWrite:
lb $t1, 0($a0) 
addi $a0, $a0, 1 
bne  $t1,10, loopWrite
sb $0, -1($a0)

li $v0,13        # open file  	
la $a0,fileName    	
li $a1, 1
li $a2, 0           	
syscall

move $a0,$v0 # file descriptor
li $v0, 15  # write into file
#move $a0,$s0		
la $a1,word2	
#la $a2,1000
la $a2, str_data_end
la $a3, word2
subu $a2, $a2, $a3	
syscall

li $v0, 16      # close file         		
syscall

li $v0, 10
syscall
