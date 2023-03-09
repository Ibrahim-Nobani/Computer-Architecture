#Computer Architecture
#First Project – Text Message Encryption and Decryption

#####################################################################################
.data 

mess1: .asciiz "\nWhat would you like to do? Enter (e) for encryption and (d) for decryption. \n"
mess2: .asciiz "\nEnter the name of the plain text file. \n"
mess3: .asciiz "\nEnter the name of the cipher text file. \n"
mess4: .asciiz "Unrecognizable input.... Exiting. \n"
mess5: .asciiz "\nShift Value:\n"
fileName: .space 200
file: .space 1000
file2: .space 1000
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
li $t4, 48
beq  $t1, $t2 Encryption
beq  $t1, $t3 Decryption
beq  $t1, $t4 ExitMain

la $a0, mess4
li $v0, 4 
syscall
#######################################################################################################
Encryption: #PlainText.txt
la $a0, mess2
li $v0, 4 
syscall

jal ReadFile

la $a0, file
la $a1, filtered # the message after truning all the letteres to small letters and removing non alphapetic charechters.
li $t3, 0  #shif value counter
li $t4, 0  # max shift value
li $t5, 0  #string length counter
 
loop1:  # removing non-alphapateic chars.
lb $t1, 0($a0)
beqz $t1,exitLoop1
blt $t1, 97, checkAlpha
bgt $t1, 122, Iterator

sb $t1, 0($a1)
addi $t3, $t3, 1
add $a1,$a1,1

Iterator:
add $a0, $a0, 1
j loop1

checkAlpha:
bgt $t1, 90, Iterator
blt $t1, 65, space

addiu $t2,$t1,32
sb $t2, 0($a1)
addi $t3, $t3, 1
add $a1,$a1,1
j Iterator

space:
bne $t1, 32, Iterator
sb $t1, 0($a1)
add $a1,$a1,1
bgt $t3,$t4,shiftValue
li $t3,0
j Iterator

shiftValue:
move $t4,$t3
li $t3,0
j Iterator

exitLoop1:
bgt $t3,$t4,shiftValue

la $a0, mess5
li $v0, 4 
syscall

move $a0, $t4  #printing shift value.
li $v0, 1 
syscall

la $a0, filtered
 
loop2:  #encryption loop.
lb $t1, 0($a0)
beqz $t1,exitloop2
beq $t1, 32,Iterator2
add $t1,$t1,$t4

ble $t1,122, Iterator2
subi $t1,$t1,26

Iterator2:
sb $t1, 0($a0)
add $t5,$t5,1
add $a0, $a0, 1
j loop2

exitloop2:

la $a0, mess3
li $v0, 4 
syscall

la $s0,filtered
move $s1,$t5

j WriteToFile
#####################################################################################
Decryption:
la $a0, mess3
li $v0, 4 
syscall

jal ReadFile

la $a0, file
li $t3, 0
li $t4, 0
li $t5, 0  #string length counter

loop3:
lb $t1, 0($a0)
beqz $t1,exitloop3
beq $t1, 32, space2
addi $t3, $t3, 1

Iterator3:
add $a0, $a0, 1
j loop3

space2:
bgt $t3,$t4,shiftValue2
li $t3,0
j Iterator3

shiftValue2:
move $t4,$t3
li $t3,0
j Iterator3

exitloop3:
bgt $t3,$t4,shiftValue2

la $a0, mess5
li $v0, 4 
syscall

move $a0, $t4  #printing shift value.
li $v0, 1 
syscall

la $a0, file
loop4:
lb $t1, 0($a0)
beqz $t1,exitloop4
beq $t1, 32,Iterator4
sub  $t1,$t1,$t4

bgt $t1,96, Iterator4
addi  $t1,$t1,26

Iterator4:
sb $t1, 0($a0)
add $t5,$t5,1
add $a0, $a0, 1
j loop4

exitloop4:
la $a0, mess2
li $v0, 4 
syscall

la $s0,file
move $s1,$t5
j WriteToFile

########################################################################################
ReadFile:
la $a3, file
loopX:
lb $t1, 0($a3) 
addi $a3, $a3, 1 
sb $0, -1($a3)
bne  $t1,0, loopX


la $a0, fileName  #read file name
li $a1, 200
li $v0, 8 
syscall

loop5:
lb $t1, 0($a0) 
addi $a0, $a0, 1 
bne  $t1,10, loop5
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


li $v0, 16      # close file   
move $a0,$s0      		
syscall

jr $ra
##########################################################################
WriteToFile:
la $a0, fileName  #read file name
li $a1, 200
li $v0, 8 
syscall

loop6:
lb $t1, 0($a0) 
addi $a0, $a0, 1 
bne  $t1, 10 , loop6
sb $0, -1($a0)

li $v0,13        # open file  	
la $a0,fileName    	
li $a1, 1           	
syscall

move $a0,$v0 
li $v0, 15
move $a1,$s0
move $a2,$s1
syscall

li $v0, 16      # close file         		
syscall

j main

ExitMain:
li $v0, 10
syscall



