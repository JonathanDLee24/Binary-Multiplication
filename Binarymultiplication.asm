#Author: Jonathan Lee
#Professor: Devin Cook
#CSC35
#4-5-23
#Binarymultiplication.asm
#This program showcases binary multiplication of binary numbers in assembly language as per class lecture does not use imul or mul

.intel_syntax noprefix

.data

Get_Num_One:
	.ascii "Enter a number to multiple: \0"

Get_Num_Two:
	.ascii "Enter a number to multiple by: \0"

Continue:
	.ascii "Continue? (y/n): \0"

NewLine:
	.ascii "\n\0"

Mul:
	.ascii " * \0"

Equals:
	.ascii " = \0"

.text

.global _start

_start: 
	mov r15, 0
	call ClearScreen
	lea rdi, Get_Num_One
	call WriteString
	call ReadInt
	mov r10, rdi
	lea rdi, NewLine
	call WriteString
	lea rdi, Get_Num_Two
	call WriteString
	call ReadInt	
	mov r11, rdi
	lea rdi, NewLine
	call WriteString
	mov r13, r11

#------------------------------>Multiplier Section with adding only<--------------------------------
	
	mov rdi, r10 	# prints equation area
	call WriteInt
	lea rdi, Mul
	call WriteString
	mov rdi, r11
	call WriteInt

main_loop:
	mov rax, 0 	# clears rax each run just in case
	mov al, r11b 	# moves 8 bits into al from number 1
	shl al, 7 	# moves lsb to msb and results in all zeros after
	shr al, 7 	# place msb bit back to lsb only one bit remains
	shr r11, 1 	# shift r11 right once to chop off the bit that we just used
	cmp al, 1 	# we are checking al to see if it's equal to 1 for adding
	je one 		# if it's equal to one we will add it into the multiply r15 reg 
	cmp r11, 0	# exit condtion once r11 reaches zero
	jle End		# jumps to end for exit condition
	shl r10, 1	# fence post condition shift r10 left incase we did not add
	jmp main_loop   # jump to loop
one:
	add r15, r10	# adds our value if bit is one for lsb
	shl r10, 1	# shift left r10 1 bit
	jmp main_loop	# jump to main
End:
	lea rdi, Equals # prints results area
	call WriteString
	mov rdi, r15
	call WriteInt
	lea rdi, NewLine
	call WriteString
	lea rdi, Continue
	call WriteString
	call ReadChar
	cmp dil, 'y'
	je _start
	call Exit


#Jonathan Lee
#Professor Devin Cook
