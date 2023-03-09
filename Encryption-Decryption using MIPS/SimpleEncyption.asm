#Computer Architecture
#First Project – Text Message Encryption and Decryption
#Ibrahim Nobani | 1190278
#Mahmoud Qaisi | 1190831
#####################################################################################
.data 

mess1: .asciiz "\nWhat would you like to do? Enter (e) for encryption and (d) for decryption. Press anything else to Exit.\n"
mess2: .asciiz "\nEnter the name of the plain text file. \n"
mess3: .asciiz "\nEnter the name of the cipher text file. \n"
mess4: .asciiz "\nUnrecognizable input.... Exiting. \n"
mess5: .asciiz "\nShift Value:\n"
fileName: .space 200
file: .space 1000
filtered: .space 1000

#####################################################################################

.text
.globl main
main:
	la 	$a0, 	mess1 			#Load and then print Message 1
	li 	$v0, 	4 			
	syscall

	li 	$v0, 	12			#read char
	syscall 

	move 	$t1, 	$v0			#here it will decide if the entered char is e(16#101) or d(16#100)
	li 	$t2, 	101			
	li 	$t3, 	100
	beq  	$t1, 	$t2 	Encryption
	beq  	$t1, 	$t3 	Decryption

	la 	$a0, 	mess4			#error message...If anything other than 'e' or 'd' is entered the program will exit.
	li 	$v0,	 4 
	syscall
	
	li 	$v0, 	10			#Exit the program.
	syscall
#######################################################################################################
Encryption: 					#PlainText.txt
	la 	$a0, 	mess2
	li 	$v0, 	4 
	syscall

	jal 	ReadFile

	la 	$a0, 	file
	la 	$a1, 	filtered 		#the message after truning all the letteres to small letters and removing non alphapetic charechters.
	li 	$t3, 	0  			#shif value counter
	li 	$t4, 	0  			#max shift value
	li 	$t5, 	0  			#string length counter
 
loop1:  					#Removing non-alphapateic chars loop.
	lb 	$t1, 	0($a0)			#Loads each char alone
	beqz 	$t1,	exitLoop1		#When the string is over, go to exitLoop1.
	blt 	$t1, 	97, 	checkAlpha	#If the char ascii is less than 97 (might be upper case) goes to CheckAlpha to see if its an upper case.	
	bgt 	$t1, 	122, 	Iterator	#If the char ascii is bigger than 122, then it must be a non alphapateic character and therefore we iterate and skip.

	sb 	$t1, 	0($a1)
	addi 	$t3, 	$t3, 	1
	add 	$a1,	$a1,	1

Iterator:					#Iterate to next char and then jumps back to the main loop.
	add 	$a0, 	$a0, 	1
	j 	loop1

checkAlpha:					#Turns Capital Letters to small letters.
	bgt 	$t1, 	90, 	Iterator	#If the ascii is bigger than 90, it means it is not alphapetic, therefore it iterates and jumps back. 
	blt 	$t1, 	65, 	space		#If the ascii is less than 65, then it could be a space (32 ascii decimal) value. Goes to space function to check it.

	addiu 	$t2,	$t1,	32		#If it is an upper case it is converted to lower case by adding 32 decimal.
	sb 	$t2, 	0($a1)
	addi 	$t3, 	$t3, 	1		#T3 is the shift value counter.
	add 	$a1,	$a1,	1
	j 	Iterator

space:						# The space is a special case amon non alphabetic charecters.
	bne 	$t1, 	32, 	Iterator	#If it's not a space, , it means it is not alphapetic, therefore it iterates and jumps back.
	sb 	$t1, 	0($a1)			#If its a space, Stores it to the memory.
	add 	$a1,	$a1,	1
	bgt 	$t3,	$t4,	shiftValue	#Compares the current shift value (t3) to the max shift value (t4), to find which one is greater.
	li 	$t3,	0
	j 	Iterator

shiftValue:			
	move 	$t4,	$t3			#If t3 is bigger than t4, t4 takes the value of t3 (since t4 is the max shift value)
	li 	$t3,	0			#t3 is back to 0 to count the next word.
	j 	Iterator

exitLoop1:
	bgt 	$t3,	$t4,	shiftValue	#Last comparasion to find the max shift value.

	la 	$a0, 	mess5			#Prints message 5, "Shift Value: "
	li 	$v0, 	4 
	syscall

	move 	$a0, 	$t4  			#printing shift value.
	li 	$v0, 	1 
	syscall

	la 	$a0, 	filtered		#Load to filtered.
 
loop2:  					#encryption loop.
	lb 	$t1, 	0($a0)
	beqz 	$t1,	exitloop2		#If equal zero, exits.
	beq 	$t1, 	32,	Iterator2	#If its a space just iterate, not encrypted.
	add 	$t1,	$t1,	$t4		#Shifts the char in t1 by value of t4 (max shift value).

	ble 	$t1,	122, 	Iterator2	# This is a special case were the Iterates back to earlier letters.
	subi 	$t1,	$t1	26

Iterator2:
	sb 	$t1,	0($a0)
	add 	$t5,	$t5,	1
	add 	$a0, 	$a0, 	1
	j 	loop2

exitloop2:

	la 	$a0, 	mess3
	li 	$v0, 	4 
	syscall

	la 	$s0,	filtered              	# save the address of the string for the function.
	move 	$s1,	$t5              	# save the number of chars to write into the file.

	j 	WriteToFile			#Goes to write in a file.
#####################################################################################
Decryption:					#Decryption is here, much similar to the encryption code.
	la 	$a0, 	mess3
	li 	$v0, 	4 
	syscall

	jal 	ReadFile

	la 	$a0, 	file
	li 	$t3, 	0			#Current word shift value.
	li 	$t4, 	0			#Max shift value
	li 	$t5, 	0  			#string length counter

loop3:						#This loop is to calculate the shift value.
	lb 	$t1, 	0($a0)	
	beqz 	$t1,	exitloop3
	beq 	$t1, 	32, 	space2		#Goes to space to use it as an indicator for the shift value.
	addi 	$t3, 	$t3, 	1

Iterator3:
	add 	$a0, 	$a0,	1
	j 	loop3

space2:						#The space is the indicator for the shift value counter
	bgt 	$t3,	$t4,	shiftValue2
	li 	$t3,	0
	j Iterator3

shiftValue2:					#Count shift value by comparing t4 and t3.
	move 	$t4,	$t3
	li 	$t3,	0
	j 	Iterator3

exitloop3:
	bgt 	$t3,	$t4,	shiftValue2	#Last comparasion between T4 and T3 to find shift max value.

	la 	$a0, 	mess5			
	li 	$v0, 	4 
	syscall

	move 	$a0, 	$t4  			#printing shift value.
	li 	$v0, 	1 
	syscall

	la 	$a0, 	file
loop4:						#Decryption loop
	lb 	$t1, 	0($a0)
	beqz 	$t1,	exitloop4
	beq 	$t1, 	32,	Iterator4	#If it is a space just iterate (not decrypted).
	sub  	$t1,	$t1,	$t4		#Subs the current character in t1 by a the value of the max shift.

	bgt 	$t1,	96, 	Iterator4	#If the value is bigger than 96 (ascii for a) contintue, if not, add 26.
	addi  	$t1,	$t1,	26

Iterator4:					#An iterate function to count through each character.
	sb 	$t1, 	0($a0)
	add 	$t5,	$t5,	1
	add 	$a0, 	$a0, 	1
	j 	loop4

exitloop4:
	la 	$a0, 	mess2			#To enter the name of the plain text file.
	li 	$v0, 	4 
	syscall

	la 	$s0,	file
	move 	$s1,	$t5
	j	WriteToFile 			#Goes to write into a file.

#####################################################################################
ReadFile:
	
	la 	$a3, 	file
loopX:						#reset the 'file' space (where we keep the contents of the file) in our memory).
	lb 	$t1, 	0($a3) 
	addi 	$a3, 	$a3, 	1 
	sb 	$0,	 -1($a3)		#Sets all of its contents to null, as we need to fill this again and not rewrite on it.
	bne  	$t1,	0, 	loopX

	la 	$a3, 	filtered
loopY:						#reset the 'filtered' space (where we keep the filtered contents of the file) in our memory).
	lb 	$t1, 	0($a3) 
	addi 	$a3, 	$a3, 	1 
	sb 	$0,	 -1($a3)		#Sets all of its contents to null, as we need to fill this again and not rewrite on it.
	bne  	$t1,	0, 	loopY
	
	la 	$a3, 	fileName
loopZ:						#reset the 'fileName' space (where we keep the filename in our memory).
	lb 	$t1, 	0($a3) 
	addi 	$a3, 	$a3, 	1 
	sb 	$0,	 -1($a3)		#Sets all of its contents to null, as we need to fill this again and not rewrite on it.
	bne  	$t1,	0, 	loopZ
	
	
	la 	$a0, 	fileName  		#read file name
	li 	$a1, 	200
	li 	$v0, 	8 
	syscall

loop5:						# This loop is to remove the new line char when reading the file name to void any errors.
	lb 	$t1, 	0($a0) 
	addi 	$a0, 	$a0, 	1 
	bne  	$t1,	10, 	loop5
	sb 	$0, 	-1($a0)

	li 	$v0,	13        		# open file  	
	la 	$a0,	fileName    	
	li 	$a1, 	0           	
	syscall

	move 	$s0,	$v0 			# file descriptor

	li 	$v0, 	14  			# read file
	move 	$a0,	$s0		
	la 	$a1,	file 	
	la 	$a2,	1000		
	syscall


	li 	$v0, 	16      		# close file   
	move 	$a0,	$s0      		
	syscall

	jr 	$ra
#####################################################################################
WriteToFile:
	la 	$a0, 	fileName  		#read file name
	li 	$a1, 	200
	li 	$v0, 	8 
	syscall

loop6: 						# this loop is to remove the new line char when reading the file name to void any errors.
	lb 	$t1, 	0($a0) 
	addi 	$a0, 	$a0, 	1 
	bne  	$t1, 	10 , 	loop6
	sb 	$0, 	-1($a0)

	li 	$v0,	13        		# open file  	
	la 	$a0,	fileName    	
	li 	$a1, 	1           	
	syscall

	move 	$a0,	$v0 
	li 	$v0, 	15
	move 	$a1,	$s0
	move 	$a2,	$s1
	syscall

	li 	$v0, 	16      		# close file         		
	syscall

	j 	main



