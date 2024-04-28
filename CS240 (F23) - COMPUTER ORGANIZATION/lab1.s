#                                           CS 240, Lab #1
# 
#                                          IMPORTATNT NOTES:
# 
#                       Write your assembly code only in the marked blocks.
# 
#                       DO NOT change anything outside the marked blocks.
# 
#
j main
###############################################################################
#                           Data Section
.data
# 
# Fill in your name, student ID in the designated sections.
# 
student_name: .asciiz "JENNY(MY) TRAN"
student_id: .asciiz "827548716"

new_line: .asciiz "\n"
space: .asciiz " "


t1_str: .asciiz "Testing Arithmetic Expression: \n"
t2_str: .asciiz "Testing Total Surface Area of rectangular box: \n"
t3_str: .asciiz "Testing Random Sum: \n"

po_str: .asciiz "Obtained output: " 
eo_str: .asciiz "Expected output: "

Arith_test_data_A:	.word 2, 1, -2, 2, 0
Arith_test_data_B:	.word 4, 2, -4, 4, 0
Arith_test_data_C:	.word 6, 3, -6, 6, -1
Arith_test_data_D:	.word 5,10, 5, 7, 0

Arith_output:           .word 7, -4, -17, 5, -1 


Rect_test_data_A:	.word 5, 10, 2, 18, 2
Rect_test_data_B:	.word 4, 10, 4, 14, 74
Rect_test_data_C:	.word 3, 10, 6, 1, 7

Rect_output:           .word 94, 600, 88, 568, 1360 

RANDOM_test_data_A:	.word 1, 144, -42, 260, -12
RANDOM_test_data_B:	.word 5, 108, 54, 210, -15
RANDOM_test_data_C:	.word 7, 109, 36, 360, -20

RANDOM_output:        .word 8, 252, 12, 570, -32

output_1:              .space 5
###############################################################################
#                           Text Section
.text
# Utility function to print an array
print_array:
li $t1, 0	
move $t2, $a0		
print:

lw $a0, ($t2)
li $v0, 1   
syscall

li $v0, 4
la $a0, space
syscall

addi $t2, $t2, 4
addi $t1, $t1, 1
blt $t1, $a1, print
jr $ra
###############################################################################
###############################################################################
#                           PART 1 (Arithmetic expression )
#$t0 is A
#$t1 is B
#$t2 is C
#$t3 is D
#$t4 is Z
# Solve for Z= A+B+C-D
# Make sure your final answer is in register $t4. 
.globl Arith
Arith:
move $t0, $a0
move $t1, $a1
move $t2, $a2
move $t3, $a3
############################### Part 1: your code begins here ################
add $t4, $t0, $t1		#Z = A + B
add $t4, $t4, $t2		#Z = Z + C = A + B + C
sub $t4, $t4, $t3		#Z = Z - D =  A + B + C - D

############################### Part 1: your code ends here  ##################
add $v0, $t4, $zero
jr $ra
###############################################################################
###############################################################################
#                           PART 2 (Total Surface Area of Rectangle Box)

# Load the values of height, width and length from memory
# Find the Total Surface Area of the rectangular box and store back in memory

## Implementation details:
# The memory address are preloaded for you in registers $s2, $s3, $s4 and $s5. 
# $s2 = address of length
# $s3 = address of width
# $s4 = address of height
# store the final answer in memory address $s5. 

# IMPORTANT: DO NOT CHANGE VALUES IN $s registers!!!! You will break the code. 
.globl rectangle
rectangle:
############################### Part 2: your code begins here ################
lw $t2, 0($s2)		# length ——— 2 x [(l x w) + (l x h) + (w x h)]
lw $t3, 0($s3)		# width
lw $t4, 0($s4)		# height
addi $t5, $0, 0		# makes sure this register is clear


mult $t2, $t3		# (l x w)
mflo $t0
add $t5, $t5, $t0	# (l x w)
mult $t2, $t4		# (l x h)
mflo $t0
add $t5, $t5, $t0	# (l x w) + (l x h)
mult $t3, $t4		# (w x h)
mflo $t0
add $t5, $t5, $t0	# (l x w) + (l x h) + (w x h)
addi $t0, $zero, 2
mult $t5, $t0		# 2 x [(l x w) + (l x h) + (w x h)]
mflo $t5

sw $t5, 0($s5)		#Store area in $s5

############################### Part 2: your code ends here  ##################
jr $ra
###############################################################################
#                           PART 3 (Random SUM)

# You are given three integers. You need to find the smallest 
# one and the largest one.
# 
#
# Return the sum of Smallest and largest
#
# Implementation details:
# The three integers are stored in registers $t0, $t1, and $t2. 
# Store the answer into register $t9.
# You are allowed to use only the $t registers.  

.globl random_sum
random_sum:
move $t0, $a0
move $t1, $a1
move $t2, $a2
############################### Part 3: your code begins here ################
addi $t4, $0, 0			#Makes sure this register is clear
addi $t5, $0, 0			#Makes sure this register is clear
bgt $t0, $t1, x0g1		#$t0 > $t1
blt $t0, $t1, x1g0		#$t > $t0

x0g1:		#$t0 > $t1
	bgt $t0, $t2, x0g		#$t0 > $t2
	blt $t0, $t2, x2g		#$t2 > $t0


x1g0:		#$t1 > $t0
	bgt $t1, $t2, x1g		#$t1 > $t2
	blt $t1, $t2, x2g		#$t2 > $t1


x0g:		#When $t0 is greatest number
	add $t4, $t4, $t0		#Duplicate $t0 into $t4
	blt $t1, $t2, x1l		#$t1 < $t2
	blt $t2, $t1, x2l		#$t2 < $t1


x1g:		#When $t1 is greatest number
	add $t4, $t4, $t1		#Duplicate $t0 into $t4
	blt $t0, $t2, x0l		#$t0 < $t2
	blt $t2, $t0, x2l		#$t2 < $t0


x2g:		#When $t2 is greatest number
	add $t4, $t4, $t2
	blt $t0, $t1, x0l		#$t0 < $t1
	blt $t1, $t0, x1l		#$t1 < $t0
	

x0l:		#When $t0 is smallest number
	add $t5, $t5, $t0		#Duplicate $t0 into $t4
	j end

x1l:		#When $t1 is smallest number
	add $t5, $t5, $t1		#Duplicate $t1 into $t4
	j end

x2l:		#When $t2 is smallest number
	add $t5, $t5, $t2		#Duplicate $t2 into $t4
	j end

end:
	add $t9, $t4, $t5		#Add smallest and greatest



############################### Part 3: your code ends here  ##################
add $v0, $t9, $zero
jr $ra
###############################################################################

#                          Main Function 
main:
li $v0, 4
la $a0, student_name
syscall
la $a0, new_line
syscall  
la $a0, student_id
syscall 
la $a0, new_line
syscall
la $a0, new_line
syscall
###############################################################################
#                          TESTING PART 1 - Arithmetic
li $v0, 4
la $a0, new_line
syscall

li $v0, 4
la $a0, t1_str
syscall

li $v0, 4
la $a0, eo_str
syscall

li $v0, 4
la $a0, new_line
syscall

li $s0, 5 # num tests
la $s2, Arith_output
move $a0, $s2
move $a1, $s0
jal print_array

li $v0, 4
la $a0, new_line
syscall


li $v0, 4
la $a0, po_str
syscall

li $v0, 4
la $a0, new_line
syscall


#test_GCD:
li $s0, 5 # num tests
li $s1, 0

#j skip_line
##############################################
test_arith:
la $s2, Arith_test_data_A
la $s3, Arith_test_data_B
la $s4, Arith_test_data_C
la $s5, Arith_test_data_D
add $s2, $s2, $s1
add $s3, $s3, $s1
add $s4, $s4, $s1
add $s5, $s5, $s1
# Pass input parameter
lw $a0, 0($s2)
lw $a1, 0($s3)
lw $a2, 0($s4)
lw $a3, 0($s5)
jal Arith

move $a0, $v0
li $v0,1
syscall

li $v0, 4
la $a0, space
syscall

addi $s1, $s1, 4
addi $s0, $s0, -1
bgtz $s0, test_arith

###############################################################################
#                          TESTING PART 2 - Area of Rectangular box
li $v0, 4
la $a0, new_line
syscall

li $v0, 4
la $a0, new_line
syscall

li $v0, 4
la $a0, t2_str
syscall

li $v0, 4
la $a0, eo_str
syscall

li $v0, 4
la $a0, new_line
syscall

li $s0, 5 # num tests
la $s2, Rect_output
move $a0, $s2
move $a1, $s0
jal print_array

li $v0, 4
la $a0, new_line
syscall


li $v0, 4
la $a0, po_str
syscall

li $v0, 4
la $a0, new_line
syscall


#test_GCD:
li $s0, 5 # num tests
li $s1, 0

#j skip_line
##############################################
test_lcm:
la $s2, Rect_test_data_A
la $s3, Rect_test_data_B
la $s4, Rect_test_data_C
la $s5, output_1
add $s2, $s2, $s1
add $s3, $s3, $s1
add $s4, $s4, $s1
add $s5, $s5, $s1
# Pass input parameter
#lw $a0, 0($s4)
#lw $a1, 0($s5)
jal rectangle

lw $a0, 0($s5)
li $v0,1
syscall

li $v0, 4
la $a0, space
syscall

addi $s1, $s1, 4
addi $s0, $s0, -1
bgtz $s0, test_lcm

###############################################################################
#                          TESTING PART 3 - RANDOM SUM
li $v0, 4
la $a0, new_line
syscall

li $v0, 4
la $a0, new_line
syscall

li $v0, 4
la $a0, t3_str
syscall

li $v0, 4
la $a0, eo_str
syscall

li $v0, 4
la $a0, new_line
syscall

li $s0, 5 # num tests
la $s2, RANDOM_output
move $a0, $s2
move $a1, $s0
jal print_array

li $v0, 4
la $a0, new_line
syscall


li $v0, 4
la $a0, po_str
syscall

li $v0, 4
la $a0, new_line
syscall


#test_GCD:
li $s0, 5 # num tests
li $s1, 0

#j skip_line
##############################################
test_random:
la $s2, RANDOM_test_data_A
la $s3, RANDOM_test_data_B
la $s4, RANDOM_test_data_C
add $s2, $s2, $s1
add $s3, $s3, $s1
add $s4, $s4, $s1
# Pass input parameter
lw $a0, 0($s2)
lw $a1, 0($s3)
lw $a2, 0($s4)
jal random_sum

move $a0, $v0
li $v0,1
syscall

li $v0, 4
la $a0, space
syscall

addi $s1, $s1, 4
addi $s0, $s0, -1
bgtz $s0, test_random
###############################################################################
_end:
# new line
li $v0, 4
la $a0, new_line
syscall
# end program
li $v0, 10
syscall
###############################################################################


