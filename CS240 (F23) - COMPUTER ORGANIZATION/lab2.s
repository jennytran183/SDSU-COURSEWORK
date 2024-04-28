#                                           CS 240, Lab #2
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
# 
# Fill in your name, student ID in the designated sections.
# 
student_name: .asciiz "JENNY(MY) TRAN"
student_id: .asciiz "827548716"

################################################################################
new_line: .asciiz "\n"
space: .asciiz " "
endian_lbl: .asciiz "\nEndianness (Hexadecimal Values) \nExpected output:\n6 4 12\nObtained output:\n"
swap_bits_lbl: .asciiz "\nSwap bits (Hexadecimal Values)\nExpected output:\n33333333 048C159D FB73EA62\nObtained output:\n"
count_ones_lbl: .asciiz "\nCount ones \nExpected output:\n16 12 20\nObtained output:\n"

swap_bits_test_data:  .word  0xCCCCCCCC, 0x01234567, 0xFEDCBA98
swap_bits_expected_data:  .word 0x33333333, 0x048C159D, 0xFB736A62

endian_test_data:  .word 14, 8, 123
endian_expected_data:  .word 0xCDABCDAB, 0x67452301, 0x98BADCFE


hex_digits: .byte '0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'

######################################################################################
#                           Text Section
.text
# Utility function to print hexadecimal numbers
print_hex:
move $t0, $a0
li $t1, 8 # digits
lui $t2, 0xf000 # mask
mask_and_print:
# print last hex digit
and $t4, $t0, $t2 
srl $t4, $t4, 28
la    $t3, hex_digits  
add   $t3, $t3, $t4 
lb    $a0, 0($t3)            
li    $v0, 11                
syscall 
# shift 4 times
sll $t0, $t0, 4
addi $t1, $t1, -1
bgtz $t1, mask_and_print
exit:
jr $ra
########################################################################################################
########################################################################################################
########################################################################################################
#                            PART 1 (Count Bits)
# 
# You are given an 32-bits integer stored in $t0. Count the number of 1's
#in the given number. For example: 1111 0000 should return 4
# Store you final answer in register $t9
.globl count_ones
count_ones:
move $t0, $a0 
############################## Part 1: your code begins here ###
add $t1, $0, $t0	#Store 32 bit integer in t1
add $t2, $0, $0		#Making sure the registers are 0
add $t3, $0, $0
add $t4, $0, $0
loop:			
andi $t2, $t1, 1	#Extract last bit
add $t3, $t3, $t2	#Counting 1s by adding the the last bits
addi $t4, $t4, 1	#Loop counter + 1
srl $t1, $t1, 1		#Shift right once to push last bit out
blt $t4, 32, loop	#Loop back if loop counter is less than 32

add $t9, $0, $t3	#Storing answer in desired register


############################## Part 1: your code ends here ###
move $v0, $t9
jr $ra

########################################################################################################
########################################################################################################
########################################################################################################
########################################################################################################
########################################################################################################
########################################################################################################
#                            PART 2 (Swap Bit Pairs)
# 
# You are given an 32-bits integer stored in $t0. You need swap pair of bits
# at within every 4 bits. i.e. b31, b30 <-> b29, b28, ... , b3, b2 <-> b1, b0
# The result must be stored inside $t9.

.globl swap_bits
swap_bits:
move $t0, $a0 
############################## Part 2: your code begins here ############################################

andi $t1, $t0, 0xcccccccc	#Use (1100) AND mask to perserve only the first 2 of every 4 bits
andi $t2, $t0, 0x33333333	#Use (0011) AND mask to perserve only the last 2 of every 4 bits
srl $t3, $t1, 2			#Make the first two bits move right 2 times to become last 2 bits for every 4 bits
sll $t4, $t2, 2			#Make the last two bits move left 2 times to become first 2 bits for every 4 bits
add $t9, $t3, $t4		#Adding back the 2 values together to get a swapped result

############################## Part 2: your code ends here ############################################
move $v0, $t9
jr $ra

########################################################################################################
########################################################################################################
########################################################################################################
#                           PART 3
# 
# You are given an interger in register $t0
# Determine the number of steps to make this integer 0
# Allowed operations:
#        - If the number is even, divide by 2
#        - If the numebr is odd, subtract 1
#You may not use div, rem or mod instrctions to check for evenness or perform division
#use logical bit-wise instrucations to perform division. 

.globl StepsToZero
StepsToZero:
move $t0, $a0 
############################## Part 3: your code begins here ############################################
add $t1, $0, $t0	#Store 32 bit integer in t1
add $t9, $0, $0		#Making sure the registers are 0
step:
andi $t2, $t1, 1	#Extract last bit
beq $t2, 0, even	#Branch if last bit is 0 (number is even)
beq $t2, 1, odd		#Branch if last bit is 1 (number is odd)
even:
srl $t1, $t1, 1		#Shift right once to divide number by 2
j skip
odd:
addi $t1, $t1, -1	#Subtracting 1 from number
skip:
addi $t9, $t9, 1	#Counting number of steps
bgt $t1, 0, step	#Loop back if number is still larger than 0


############################## Part 3: your code ends here ############################################
move $v0, $t9
jr $ra

########################################################################################################
########################################################################################################
########################################################################################################
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
li $v0, 4
la $a0, new_line
syscall
la $a0, count_ones_lbl
syscall

# Testing part 2
li $s0, 3 # num of test cases
li $s1, 0
la $s2, swap_bits_test_data

test_p1:
add $s4, $s2, $s1
# Pass input parameter
lw $a0, 0($s4)
jal count_ones

move $a0, $v0        # $integer to print
li $v0, 1
syscall

li $v0, 4
la $a0, space
syscall

addi $s1, $s1, 4
addi $s0, $s0, -1
bgtz $s0, test_p1

li $v0, 4
la $a0, new_line
syscall
la $a0, swap_bits_lbl
syscall

# Testing part 2
li $s0, 3 # num of test cases
li $s1, 0
la $s2, swap_bits_test_data

test_p2:
add $s4, $s2, $s1
# Pass input parameter
lw $a0, 0($s4)
jal swap_bits

move $a0, $v0
jal print_hex
li $v0, 4
la $a0, space
syscall

addi $s1, $s1, 4
addi $s0, $s0, -1
bgtz $s0, test_p2

li $v0, 4
la $a0, new_line
syscall
la $a0, endian_lbl
syscall


# Testing part 3
li $s0, 3 # num of test cases
li $s1, 0
la $s2, endian_test_data

test_p3:
add $s4, $s2, $s1
# Pass input parameter
lw $a0, 0($s4)
jal StepsToZero

move $a0, $v0        # $integer to print
li $v0, 1
syscall

li $v0, 4
la $a0, space
syscall


addi $s1, $s1, 4
addi $s0, $s0, -1
bgtz $s0, test_p3


_end:
# end program
li $v0, 10
syscall

