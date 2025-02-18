#  MESSAGES
.data
    ReadInt: .asciiz "Insert a number:"
    ReadString: .asciiz "Insert a string :"
    equal: .asciiz " = "
    msg_is: .asciiz " is: "
    Bye: .asciiz "\nEnd of Program...\n"
    wronginput: .asciiz "Wrong Input!"
    endl: .asciiz "\n"
    buffer: .space 256

.text
.globl main

main:
    la $a0, buffer
    li $a1, 200
    jal read_string
    jal print_string
    jal rev_string
    jal print_string



    j exit

## FUNCTIONS ## (Call with: jal function_name)

rev_string:                 # This function reverses a string
    move $t7, $a0           # String adress should be in $a0
    move $t9, $a0
    li $v0, 0
    for_rev_string:         # Result will be still in $a0
        lb $t0, ($a0)       # $v0 will have the length of the string 
        addi $a0, $a0, 1    
        addi $v0, $v0, 1
    bnez $t0, for_rev_string
    # $a0 now points to the end of the string
    # $t7 points to the beginning of the string
    addi $a0, $a0, -2 # $a0 now points to the last char of the string
    for_rev_string2:
        lb $t1, ($a0)       
        lb $t2, ($t7)       
        sb $t1, ($t7)       
        sb $t2, ($a0)       
        addi $a0, $a0, -1   
        addi $t7, $t7, 1    
    blt $t7, $a0, for_rev_string2 # if $t7 < $a0 then loop 
    move $a0, $t9
    jr $ra

exit:                       # Exits the program 
    li $v0, 10
    syscall
#  

read_int:                   #  Read integer from input 
    li $v0, 5               #  Integer will be in $v0 
    syscall
    jr $ra

print_int:                  #  Prints integer given in $a0 
    li $v0, 1
    syscall
    jr $ra

#  

read_float:                 #  Read float from input 
    li $v0, 6               #  Float will be in $f0 
    syscall
    jr $ra

print_float:                #  Prints float given in $f12                
    li $v0, 2               #  Use "mov.s $f12, $???" to move float to reg 
    syscall
    jr $ra
#  

read_double:                #  Read double from input 
    li $v0, 7               #  Double will be in $f0/$f1
    syscall                 #  !NOTE: that double uses 2 registers (pair of even-odd)
    jr $ra

print_double:               #  Prints double given in $f12/$f13
    li $v0, 3               #  Use "mov.d $f12, $???" to move double to reg
    syscall                 #  !NOTE: that double uses 2 registers (pair of even-odd) 
    jr $ra
#

read_string:                #  Read string from input 
    li $v0, 8               #  $a0 will be buffer address and $a1 the length (including the space made for \0) 
    syscall                 #  Remember that u can allocate space for a buffer in .data with .space (len)
    jr $ra

print_string:               #  Prints string given in $a0 
    li $v0, 4               #  Use "la $a0, label" to specify string address
    syscall
    jr $ra
#

read_char:                  #  Read char from input 
    li $v0, 12              #  Char will be in $v0 
    syscall
    jr $ra

print_char:                 #  Prints char given in $a0 
    li $v0, 11
    syscall
    jr $ra
#

print_endl:                 # prints '\n'
    addi $sp, $sp, -4 
    sw $a0, 0($sp)
    li $a0, 10
    li $v0, 11
    syscall
    lw $a0, 0($sp)
    addi $sp, $sp, 4
    jr $ra
#