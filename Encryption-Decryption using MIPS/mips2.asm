$LC0:

.ascii "Input the string : \000"

$LC1:

.ascii "\012The given sentence is : %s\000"

$LC2:

.ascii "After Case changed the string is: \000"

$LC3:

.ascii "\012\000"

main:

addiu $sp,$sp,-144

sw $31,140($sp)

sw $fp,136($sp)

move $fp,$sp

lui $2,%hi($LC0)

addiu $4,$2,%lo($LC0)

jal printf

nop

lui $2,%hi(stdin)

lw $3,%lo(stdin)($2)

addiu $2,$fp,36

move $6,$3

li $5,100 # 0x64

move $4,$2

jal fgets

nop

addiu $2,$fp,36

move $4,$2

jal strlen

nop

sw $2,24($fp)

lw $2,24($fp)

nop

sw $2,28($fp)

addiu $2,$fp,36

move $5,$2

lui $2,%hi($LC1)

addiu $4,$2,%lo($LC1)

jal printf

nop

lui $2,%hi($LC2)

addiu $4,$2,%lo($LC2)

jal printf

nop

sw $0,24($fp)

b $L2

nop

$L5:

jal __ctype_b_loc

nop

lw $3,0($2)

lw $2,24($fp)

addiu $4,$fp,24

addu $2,$4,$2

lb $2,12($2)

nop

sll $2,$2,1

addu $2,$3,$2

lhu $2,0($2)

nop

andi $2,$2,0x2

beq $2,$0,$L3

nop

lw $2,24($fp)

addiu $3,$fp,24

addu $2,$3,$2

lb $2,12($2)

nop

move $4,$2

jal toupper

nop

b $L4

nop

$L3:

lw $2,24($fp)

addiu $3,$fp,24

addu $2,$3,$2

lb $2,12($2)

nop

move $4,$2

jal tolower

nop

$L4:

sw $2,32($fp)

lw $4,32($fp)

jal putchar

nop

lw $2,24($fp)

nop

addiu $2,$2,1

sw $2,24($fp)

$L2:

lw $3,24($fp)

lw $2,28($fp)

nop

slt $2,$3,$2

bne $2,$0,$L5

nop

lui $2,%hi($LC3)

addiu $4,$2,%lo($LC3)

jal puts

nop

nop

move $sp,$fp

lw $31,140($sp)

lw $fp,136($sp)

addiu $sp,$sp,144

j $31

nop