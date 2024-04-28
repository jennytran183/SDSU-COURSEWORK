jal main
#                                           CS 240, Lab #3
# 
#                                          IMPORTATNT NOTES:
# 
#                       Write your assembly code only in the marked blocks.
# 
#                     	DO NOT change anything outside the marked blocks.
# 
#               Remember to fill in your name, student ID in the designated sections.
# 
#
j main
###############################################################
#                           Data Section
.data
# 
# Fill in your name, student ID in the designated sections.
# 
student_name: .asciiz "Jenny Tran"
student_id: .asciiz "827548716"

new_line: .asciiz "\n"
space: .asciiz " "
testing_label: .asciiz ""
unsigned_addition_label: .asciiz "Unsigned Addition (Hexadecimal Values)\nExpected Output:\n0154B8FB06E97360 BAC4BABA1BBBFDB9 00AA8FAD921FE305 \nObtained Output:\n"
fibonacci_label: .asciiz "Fibonacci\nExpected Output:\n0 1 5 55 6765 3524578 \nObtained Output:\n"
file_label: .asciiz "File I/O\nObtained Output:\n"

addition_test_data_A:	.word 0xeee94560, 0x0154a8d0, 0x09876543, 0x000ABABA, 0xFEABBAEF, 0x00a9b8c7
addition_test_data_B:	.word 0x18002e00, 0x0000102a, 0x12349876, 0xBABA0000, 0x93742816, 0x0000d6e5

fibonacci_test_data:	.word  0, 1, 2, 3, 5, 6, 

bcd_2_bin_lbl: .asciiz "\nAiken to Binary (Hexadecimal Values)\nExpected output:\n004CC853 00BC614E 00008AE0\nObtained output:\n"
bin_2_bcd_lbl: .asciiz "\nBinary to Aiken (Hexadecimal Values) \nExpected output:\n0B03201F 0CC3C321 000CBB3B\nObtained output:\n"


bcd_2_bin_test_data: .word 0x0B03201F, 0x1234BCDE, 0x3BBB2

bin_2_bcd_test_data: .word 0x4CC853, 0x654321, 0xFFFF


hex_digits: .byte '0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F'

file_name:
	.asciiz	"lab3_data.dat"	# File name
	.word	0
read_buffer:
	.space	300			# Place to store character
###############################################################
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
###############################################################
###############################################################
###############################################################
#                           PART 1 (Unsigned Addition)
# You are given two 64-bit numbers A,B located in 4 registers
# $t0 and $t1 for lower and upper 32-bits of A and $t2 and $t3
# for lower and upper 32-bits of B, You need to store the result
# of the unsigned addition in $t4 and $t5 for lower and upper 32-bits.
#
.globl Unsigned_Add_64bit
Unsigned_Add_64bit:
move $t0, $a0
move $t1, $a1
move $t2, $a2
move $t3, $a3
############################## Part 1: your code begins here ###
add $t4, $t0, $t2
blt $t4, $t0, overflow
blt $t4, $t2, overflow
j skip
overflow:
addi $t1, $t1, 1
j skip

skip:
add $t5, $t1, $t3


############################## Part 1: your code ends here   ###
move $v0, $t4
move $v1, $t5
jr $ra
###############################################################
###############################################################
###############################################################
#                            PART 2 (Aiken Code to Binary)
# 
# You are given a 32-bits integer stored in $t0. This 32-bits
# present a Aiken number. You need to convert it to a binary number.
# For example: 0xDCB43210 should return 0x48FF4EA.
# The result must be stored inside $t0 as well.
.globl aiken2bin
aiken2bin:
move $t0, $a0
############################ Part 2: your code begins here ###
addi $t1, $t0, 0		#Making sure resgiters empty
addi $t2, $t0, 0
li $t3, 0

loop:				
andi $t2, $t1, 0xf0000000 	#extract first 4 bits
srl $t2, $t2, 28		#shift 4 bits to the right most
bgt $t2, 4, subtract
j converted

subtract: 		#subtract if >4
addi $t2, $t2, -6
j converted

converted:
mul $t3, $t3, 10
add $t3, $t3, $t2
sll $t1, $t1, 4


beq $t1, 0, end2	
j loop

end2:
move $t0, $t3




############################ Part 2: your code ends here ###
move $v0, $t0
jr $ra

###############################################################
###############################################################
###############################################################
#                            PART 3 (Binary to Aiken Code)
# 
# You are given a 32-bits integer stored in $t0. This 32-bits
# present an integer number. You need to convert it to a Aiken.
# The result must be stored inside $t0 as well.
.globl bin2aiken
bin2aiken:
move $t0, $a0
############################ Part 3: your code begins here ###
move $t1, $t0
addi $t2, $0, 10
addi $t3, $0, 0
addi $t5, $0, 1
addi $t6, $0, 1
li $t9, 0

loop3:	
addi $t5, $0, 1
div $t1, $t2
mflo $t1
mfhi $t4
bgt $t4, 4, add6	# add 6 if >4
j skip3

add6:
addi $t4, $t4, 6

skip3:

blt $t5, $t6, shift
j answer
shift:
sll $t4, $t4, 4
addi $t5, $t5, 1
blt $t5, $t6, shift

answer:
add $t9, $t9, $t4
addi $t6, $t6, 1
bgt $t1, 0, loop3



move $t0, $t9



############################ Part 3: your code ends here ###
move $v0, $t0
jr $ra

###############################################################
###############################################################
###############################################################
###############################################################
###############################################################


###############################################################
###############################################################
###############################################################
#                           PART 4 (ReadFile)
#
# You will read characters (bytes) from a file (lab3_data.dat) 
# and print them. 
#Valid characters are defined to be
# alphanumeric characters (a-z, A-Z, 0-9),
# " " (space),
# "." (period),
# (new line).
#
# 
# Hint: Remember the ascii table. 
#
.globl file_read
file_read:
############################### Part 4: your code begins here ##
#Open file
li $t0, 0
li $t9, 0

li $v0, 13           #open a file
la $a0, file_name	# load file name
li $a1, 0            # file flag (read)      
li $a2, 0    # file mode (unused)
syscall
move $t6, $v0      # save the file descriptor 

lb $t0, read_buffer
read_next_char:
#Read from file
li $v0, 14           #read from file
move $a0, $t6 
la $a1, read_buffer
li $a2, 1       # number of bytes to be read
syscall  

beq $t0, 300, closefile


lbu $t1, 0($t0)


beq $t1, 10, valid
beq $t1, 32, valid
beq $t1, 46, valid
bge $t1, 48, numbers
j skip_numbers

numbers:
ble $t1, 57, valid

skip_numbers:
bge $t1, 65, captials
j skip_captials
captials:
ble $t1, 90, valid

skip_captials:
bge $t1, 97, letters
j done_filter
letters:
ble $t1, 122, valid
j done_filter

valid:
li $v0, 11         # print string
lb $a0, ($t1)
syscall

done_filter:
addi $t1, $t1, 1
j read_next_char


closefile:
# Close the file 
li   $v0, 16       # system call for close file
move $a0, $t6      # file descriptor to close
syscall            # close file

li $v0, 10
syscall

############################### Part 4: your code ends here   ##
jr $ra
###############################################################
###############################################################
###############################################################

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
##############################################
##############################################
test_64bit_Add_Unsigned:
li $s0, 3
li $s1, 0
la $s2, addition_test_data_A
la $s3, addition_test_data_B
li $v0, 4
la $a0, testing_label
syscall
la $a0, unsigned_addition_label
syscall
##############################################
test_add:
add $s4, $s2, $s1
add $s5, $s3, $s1
# Pass input parameter
lw $a0, 0($s4)
lw $a1, 4($s4)
lw $a2, 0($s5)
lw $a3, 4($s5)
jal Unsigned_Add_64bit

move $s6, $v0
move $a0, $v1
jal print_hex
move $a0, $s6
jal print_hex

li $v0, 4
la $a0, space
syscall

addi $s1, $s1, 8
addi $s0, $s0, -1
bgtz $s0, test_add

li $v0, 4
la $a0, new_line
syscall
##############################################
##############################################
li $v0, 4
la $a0, new_line
syscall
la $a0, bcd_2_bin_lbl
syscall
# Testing part 2
li $s0, 3 # num of test cases
li $s1, 0
la $s2, bcd_2_bin_test_data

test_p2:
add $s4, $s2, $s1
# Pass input parameter
lw $a0, 0($s4)
jal aiken2bin

move $a0, $v0        # hex to print
jal print_hex

li $v0, 4
la $a0, space
syscall

addi $s1, $s1, 4
addi $s0, $s0, -1
bgtz $s0, test_p2

##############################################
##############################################
li $v0, 4
la $a0, new_line
syscall
la $a0, bin_2_bcd_lbl
syscall

# Testing part 3
li $s0, 3 # num of test cases
li $s1, 0
la $s2, bin_2_bcd_test_data

test_p3:
add $s4, $s2, $s1
# Pass input parameter
lw $a0, 0($s4)
jal bin2aiken

move $a0, $v0        # hex to print
jal print_hex

li $v0, 4
la $a0, space
syscall

addi $s1, $s1, 4
addi $s0, $s0, -1
bgtz $s0, test_p3
##############################################
##############################################
li $v0, 4
la $a0, new_line
syscall
test_file_read:
li $v0, 4
la $a0, new_line
syscall
li $s0, 0
li $v0, 4
la $a0, testing_label
syscall
la $a0, file_label
syscall 
jal file_read
end:
# end program
li $v0, 10
syscall
