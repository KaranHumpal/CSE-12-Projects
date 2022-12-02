##########################################################################
# Created by: Karan Humpal
# khumpal
# 
#
# Assignment: Lab 3: ASCII-risks
# CSE 012, Computer Systems and Assembly Language
# UC Santa Cruz, Spring 2021
#
# Description: This program prints a pyramid with the height that the user inputs.
#
# Notes: This program is intended to be run on the MARS application.
##########################################################################

#REGISTER USAGE
#$t0: holds the user input throughout the whole program
#$t1: counter for how many lines are being printed.
#$t2: counter for how many numbers to print before the stars
#$t3: counter for how many stars to print
#$t4: counter for how many stars have printed
#$t5: the number that needs to be printed on the positive pyramid
#$t6: counter for how many numbers need to be printed (positive pyramid)
#$t7: the number that needs to be printed on the negative pyramid
#$t8: counter for how many numbers need to be printed (negative pyramid)

.data  
	Prompt: .asciiz "\nEnter the height of the pattern (must be greater than 0):	"
	message: .asciiz "Invalid Entry!"
	star: .asciiz "*	"
	newline: .asciiz "\n"
	tab: .asciiz "	"
	
.text	
    main: 	
	li   $v0, 4					#prompts user, gets user input and stores it in $t0
	la   $a0, Prompt 
	syscall 
	li   $v0, 5
	syscall 
	move $t0, $v0
	
	ble  $t0, $0, print				#checks if user input is <=0. if it is, jumps to print	
	nop
	
	add  $t3, $t0, $t0				#multiples input by two, then subtracts one to get the 
	sub  $t3, $t3, 1				#	number of stars that needs to be printed for the 1st row
	
	sub  $t0, $t0, 1				#Because it runs from 0 to the user input, i needed to subtract
							#	one from the input to ensure correct output.
	countstars:
	    li   $v0, 4					#prints a newline before pyramid begins
	    la   $a0, newline
	    syscall 
	    
	    blt  $t0, $t1, end				#if the number of lines printed equals user input, program
	    nop						#	terminates
	    						
	    li   $t4, 0					#resets variable to 0
	    
	    addi $t1, $t1, 1				#counter for number of lines
	    sub  $t3, $t3, 2				#each time stars print, we need to subtract two for the next line
	    
	    addi $t2, $t2, 1				#add one to the number counter everytime we return to this function.
	    
	    li   $t6, 0					#reset number counter to 0
	    j number
	stars:
	    blt  $t3, $t4, yeet				#if number of stars printed equals number of stars needed, jump
	    nop						#	to next
	    						
	    li   $v0, 4					#prints a star
	    la   $a0, star 
	    syscall 
	    
	    addi $t4, $t4, 1				#adds one to the counter
	    
	    j stars
	    
	number:
	    beq  $t6, $t2, stars			#if the right amount of numbers have printed, jump to next
	    nop
	    
	    addi $t6, $t6, 1				#each line, one more number needs to be printed, so i add one.
	    addi $t5, $t5, 1				#each number is one more than the previous number, so add one.
	    
	    li   $v0, 1					#print the right number in ascending order.
	    move $a0, $t5
	    syscall
	    
	    li   $v0, 4					#prints tab after the value.
	    la   $a0, tab 
	    syscall
	    
	    j number

	yeet:
	    li   $t8, 0					#resets number counter to 0
	    addi $t7, $t5, 0				#moves last number held by $t5 to $t7
	    addi $t7, $t7, 1				#add 1 to the number so it can print
	    
	    j reverse 

	reverse:
	    beq  $t8, $t2, countstars			#if the right amount of numbers have printed, jump to countstars. 
	    nop
	    
	    addi $t8, $t8, 1				# add 1 to number counter
	    subi $t7, $t7, 1				# subtract one from number printed since we are going backwards
	    
	    li   $v0, 1					#prints said number
	    move $a0, $t7
	    syscall
	    
	    blt  $t8, $t2, extratab			#if tab is required, jumps to function that puts tab
	    nop						#	to ensure no tab at the end
	    
	    j reverse
	    
    print:
	li $v0, 4					#prints the message "invalid entry!" if input is <= 0. 
	la $a0, message 
	syscall 
	j main     
       
   extratab:
        li $v0, 4					#puts a tab after an entry if called on
	la $a0, tab 
	syscall
	
	j reverse

    end: 
	li $v0, 10					#system end call 
	syscall 
				
	
	
	

	
	
	
