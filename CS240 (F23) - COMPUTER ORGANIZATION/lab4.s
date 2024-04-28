#                                           CS 240, Lab #4
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
student_name: .asciiz "Jenny(My) Tran"
student_id: .asciiz "827548716"

new_line: .asciiz "\n"
space: .asciiz " "


t1_str: .asciiz "Testing GCD: \n"
t2_str: .asciiz "Testing LCM: \n"
t3_str: .asciiz "Testing RANDOM SUM: \n"

po_str: .asciiz "Obtained output: " 
eo_str: .asciiz "Expected output: "

#GCD_test_data_A:	.word 1, 2, 128, 148, 36, 360, 108, 75, 28300, 0
#GCD_test_data_B:	.word 12, 12, 96, 36, 54, 210, 144, 28300, 74000, 143

GCD_test_data_A:	.word 1, 36, 360, 108, 28300
GCD_test_data_B:	.word 12,54, 210, 144, 74000

GCD_output:           .word 1, 18, 30, 36, 100

#LCM_test_data_A:	.word 0, 1, 2, 128, 148, 36, 360, 108, 75, 28300
#LCM_test_data_B:	.word 143, 12, 12, 96, 36, 54, 210, 144, 28300, 74000
#LCM_output:           .word 0, 12, 12, 384, 1332, 108, 2520, 432, 84900, 20942000 


LCM_test_data_A:	.word 1, 36, 360, 108, 28300
LCM_test_data_B:	.word 12,54, 210, 144, 74000
LCM_output:           .word 12, 108, 2520, 432, 20942000

RANDOM_test_data_A:	.word 1, 144, 42, 260, 74000
RANDOM_test_data_B:	.word 12, 108,  54, 210, 44000
RANDOM_test_data_C:	.word 4, 109, 36, 360, 28300

RANDOM_output:           .word 26, 720, 216, 3120, 21044400

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
#                           PART 1 (GCD)
#a0: input number
#a1: input number

#v0: final gcd answer

.globl gcd
gcd:
############################### Part 1: your code begins here ################

#Moving inputs to temporary registers 
move $t0, $a0
move $t1, $a1

euclidGCD:
#If t1 == 0
beqz $t1, endGCD	#Break out of loop
#Else
div $t0, $t1		#t0/t1
move $t0, $t1		#t0 = t1
mfhi $t1		#t1 = t0 mod t1 (remainder)
j euclidGCD		#Calling itself, recursive

endGCD:
move $v0, $t0		#Soring gcd in output register


############################### Part 1: your code ends here  ##################
jr $ra
###############################################################################
###############################################################################
#                           PART 2 (LCM)

# Find the least common multiplier of two numbers given

# Make a call to the GCD function to compute the LCM
# LCM = a1*a2 / GCD

# Preserve all required values in stack before calls to another function.
# preserve the $ra register value in stack before making the call!!!

#a0: input number
#a1: input number
#v0: final gcd answer

.globl lcm
lcm:
############################### Part 2: your code begins here ################

# Preserve values before calling gcd2 by pushing each register bottom to top
addu $sp, $sp, -4
sw $ra, 0($sp)
addu $sp, $sp, -4
sw $a0, 0($sp)
addu $sp, $sp, -4
sw $a1, 0($sp)

jal gcd2	#Calling gcd2

# Restoring values after calling lcm2 by popping each from top to bottom
lw $a1, 0($sp)       # Restore a1 from stack
addi $sp, $sp, 4     
lw $a0, 0($sp)       # Restore a0 from stack
addi $sp, $sp, 4     
lw $ra, 0($sp)       # Restore return address from stack
addi $sp, $sp, 4     

move $t0, $a0
move $t1, $a1

move $t2, $v0
mul $t3, $t0, $t1
div $t3, $t2
mflo $v0





############################### Part 2: your code ends here  ##################
jr $ra
###############################################################################
#                           PART 3 (Random SUM)

# You are given three integers. You need to find the smallest 
# one and the largest one.
# 
# Then find the GCD and LCM of the two numbers. 
#
# Return the sum of Smallest, largest, GCD and LCM
#
# Implementation details:
# The three integers are stored in registers $a0, $a1, and $a2.
# Store the answer into register $v0. 
# Preserve all required values in stack before calls to another function.
# preserve the $ra register value in stack before making the call!!!
# Use stacks to store the smallest and largest values before making the function call. 

.globl random_sum
random_sum:
############################### Part 3: your code begins here ################

#Moving inputs to temporary registers to find the greatest and smallest numbers
move $t0, $a0
move $t1, $a1
move $t2, $a2


bgt $t0, $t1, x0g1		#$t0 > $t1
blt $t0, $t1, x1g0		#$t1 > $t0


x0g1:		#$t0 > $t1
	bgt $t0, $t2, x0g		#$t0 > $t2
	blt $t0, $t2, x2g		#$t2 > $t0


x1g0:		#$t1 > $t0
	bgt $t1, $t2, x1g		#$t1 > $t2
	blt $t1, $t2, x2g		#$t2 > $t1
	
x0g:		#When $t0 is greatest number
	move $t4, $t0		#Duplicate $t0 into $t4
	blt $t1, $t2, x1l		#$t1 < $t2
	blt $t2, $t1, x2l		#$t2 < $t1


x1g:		#When $t1 is greatest number
	move $t4, $t1			#Duplicate $t0 into $t4
	blt $t0, $t2, x0l		#$t0 < $t2
	blt $t2, $t0, x2l		#$t2 < $t0


x2g:		#When $t2 is greatest number
	move $t4, $t2	
	blt $t0, $t1, x0l		#$t0 < $t1
	blt $t1, $t0, x1l		#$t1 < $t0
	

x0l:		#When $t0 is smallest number
	move $t5, $t0			#Duplicate $t0 into $t4
	j end

x1l:		#When $t1 is smallest number
	move $t5, $t1			#Duplicate $t1 into $t4
	j end

x2l:		#When $t2 is smallest number
	move $t5, $t2			#Duplicate $t2 into $t4
	j end
end:
add $t6, $t4, $t5 #Sum of smallest and greatest number

#Move greatest and smallest numbers to a0 and a1 to find their gcd and lcm
move $a0, $t4
move $a1, $t5

# Preserve values before calling lcm2 by pushing each register bottom to top
addu $sp, $sp, -4
sw $ra, 0($sp)
addu $sp, $sp, -4
sw $a0, 0($sp)
addu $sp, $sp, -4
sw $a1, 0($sp)
addu $sp, $sp, -4
sw $a2, 0($sp)

addu $sp, $sp, -4
sw $t6, 0($sp)
addu $sp, $sp, -4
sw $t5, 0($sp)
addu $sp, $sp, -4
sw $t4, 0($sp)

jal lcm2	#Calling lcm2

# Restoring values after calling lcm2 by popping each from top to bottom
lw $t4, 0($sp)       # Restore t4 from stack
addi $sp, $sp, 4     
lw $t5, 0($sp)       # Restore t5 from stack
addi $sp, $sp, 4     
lw $t6, 0($sp)       # Restore t6 from stack
addi $sp, $sp, 4     

lw $a2, 0($sp)       # Restore a2 from stack
addi $sp, $sp, 4     
lw $a1, 0($sp)       # Restore a1 from stack
addi $sp, $sp, 4     
lw $a0, 0($sp)       # Restore a0 from stack
addi $sp, $sp, 4     
lw $ra, 0($sp)       # Restore return address from stack
addi $sp, $sp, 4     

add $t6, $t6, $v0	#Adding lcm to sum



# Preserve values before calling gcd2 by pushing each register bottom to top
addu $sp, $sp, -4	
sw $ra, 0($sp)
addu $sp, $sp, -4
sw $a0, 0($sp)
addu $sp, $sp, -4
sw $a1, 0($sp)
addu $sp, $sp, -4
sw $a2, 0($sp)

addu $sp, $sp, -4
sw $t6, 0($sp)
addu $sp, $sp, -4
sw $t5, 0($sp)
addu $sp, $sp, -4
sw $t4, 0($sp)

jal gcd2	#Calling gcd2


# Restoring values after calling gcd2 by popping each from top to bottom
lw $t4, 0($sp)       # Restore t4 from stack
addi $sp, $sp, 4     
lw $t5, 0($sp)       # Restore t5 from stack
addi $sp, $sp, 4     
lw $t6, 0($sp)       # Restore t6 from stack
addi $sp, $sp, 4     

lw $a2, 0($sp)       # Restore a2 from stack
addi $sp, $sp, 4     
lw $a1, 0($sp)       # Restore a1 from stack
addi $sp, $sp, 4     
lw $a0, 0($sp)       # Restore a0 from stack
addi $sp, $sp, 4     
lw $ra, 0($sp)       # Restore return address from stack
addi $sp, $sp, 4     

add $t6, $t6, $v0	#Adding gcd to sum

move $v0, $t6		#Move sum to v0

############################### Part 3: your code ends here  ##################
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
#                          TESTING PART 1 - GCD
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
la $s2, GCD_output
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
la $s2, GCD_test_data_A
la $s3, GCD_test_data_B
#j skip_line
##############################################
test_gcd:
#li $v0, 4
#la $a0, new_line
#syscall
#skip_line:
add $s4, $s2, $s1
add $s5, $s3, $s1
# Pass input parameter
lw $a0, 0($s4)
lw $a1, 0($s5)
jal gcd

move $a0, $v0
li $v0,1
syscall

li $v0, 4
la $a0, space
syscall

addi $s1, $s1, 4
addi $s0, $s0, -1
bgtz $s0, test_gcd

###############################################################################

#                          TESTING PART 2 - LCM
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
la $s2, LCM_output
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
la $s2, LCM_test_data_A
la $s3, LCM_test_data_B
#j skip_line
##############################################
test_lcm:
#li $v0, 4
#la $a0, new_line
#syscall
#skip_line:
add $s4, $s2, $s1
add $s5, $s3, $s1
# Pass input parameter
lw $a0, 0($s4)
lw $a1, 0($s5)
jal lcm

move $a0, $v0
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
la $s2, RANDOM_test_data_A
la $s3, RANDOM_test_data_B
la $s4, RANDOM_test_data_C
#j skip_line
##############################################
test_random:
#li $v0, 4
#la $a0, new_line
#syscall
#skip_line:
add $s5, $s2, $s1
add $s6, $s3, $s1
add $s7, $s4, $s1
# Pass input parameter
lw $a0, 0($s5)
lw $a1, 0($s6)
lw $a2, 0($s7)
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
