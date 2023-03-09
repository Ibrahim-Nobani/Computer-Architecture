#Computer Architecture
#First Project – Text Message Encryption and Decryption

#####################################################################################
.data 

mess1: .asciiz "What would you like to do? Enter (e) for encryption and (d) for decryption. \n"
mess2: .asciiz "Enter the name of the plain text file. \n"
mess3: .asciiz "Enter the name of the cipher text file. \n"
mess4: .asciiz "Unrecognizable input.... Exiting. \n"
fileName: .space 200
file: .space 1000
filtered: .space 1000

#####################################################################################

.text
.globl main
main:
la $a0, mess1
li $v0, 4 
syscall

li $v0 12
syscall 

move $t1, $v0
li $t2, 101
li $t3, 100
beq  $t1, $t2 Encryption
beq  $t1, $t3 Decryption

la $a0, mess4
li $v0, 4 
syscall

Encryption: #C:\\Users\\ASUS\\Desktop\\ArchProj\\PlainText.txt
la $a0, mess2
li $v0, 4 
syscall

jal ReadFile

li $v0, 10
syscall


Decryption:
la $a0, mess3
li $v0, 4 
syscall

jal ReadFile

li $v0, 10
syscall

ReadFile:
la $a0, fileName  #read file name
li $a1, 200
li $v0, 8 
syscall

loop:
lb $t1, 0($a0) 
addi $a0, $a0, 1 
bne  $t1,10, loop
sb $0, -1($a0)

li $v0,13        # open file  	
la $a0,fileName    	
li $a1, 0           	
syscall
move $s0,$v0 # file descriptor

li $v0, 14  # read file
move $a0,$s0		
la $a1,file 	
la $a2,1000		
syscall


la $a0,file
li $v0, 4 #prin file content
syscall

li $v0, 16      # close file   
move $a0,$s0      		
syscall

jr $ra
