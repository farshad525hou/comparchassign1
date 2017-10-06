#Farshad Chowdhury
#October 5, 2017
#Computer Architecture
		.text
	.globl  main
main:
	sub	$sp,$sp,8	# make 8 spaces in stack pointer	 
	sw	$ra,4($sp)	#saves ra into the stack pointer

	li	$v0,4      # Load syscall4 (output) into v0  
	la	$a0,in1     
	syscall        
	
	li $v0,5        
	syscall        
	move $t1,$v0    
		
	li	$v0,4   # Load syscall4 (output) into v0     
	la	$a0,scnd     
	syscall        
	
	li $v0,5    # Load syscall5 (input) into v0    
	syscall        
	move $a0,$t1   #moves t1 (first int) from t1 to a0
	move $a1,$v0   # moves v0 (second int) into a1
	jal gcfr
	sw	$v0,8($sp) #save the return of gcf into the stack pointer. 
	li	$v0,4
	la	$a0,out
	syscall
	li	$v0,1
	lw	$a0,8($sp) #load 8th spot of  stack pointer into a0 for output
	syscall
	li $v0, 10
	syscall

	
gcfr:
	sub	$sp,$sp,8	#push 8 spots into the stack
	sw	$ra,4($sp)	

	bne $a1, $zero, L #if int b=0 then exit else go to L
	add	$v0,$zero,$a0	# return a0
	add	$sp,$sp,8	# pop stack
	jr	$ra		# return to calling procedure
L:
	move $t1,$a1         
	rem $a1,$a0,$a1      
	move $a0,$t1       
	jal gcfr          # recursive call

	lw	$ra,4($sp)	# restore previous return addr
	move $v0,$a0   

	add	$sp,$sp,8	# pop 8 spaces back out of stack.
	jr	$ra		# return to calling procedure
	
	.data
out:                    
	.asciiz "The GCF is = "  
scnd:                    
	.asciiz "second num = " 
in1:                    
	.asciiz "first num = " 
	
	.text
#1C.)
# The recursive program takes 11 instructions to calculate the value of the greatest common factor. 
# The number of total instructions for this program will simply be the number of insttructions executed per iteration (11) multiplied 
# by the number of times the remainder is calculated. N=I*R, where N is the total number of instructions, I is instructions per iteration,
# and R is the number of times the remainder is caclulated.

 #1D.)
 #Depending on the integers used to calculate the gcf, the total number of instructions ran will change. With my current implementation,
 #The iterative version of the code (non-recursive) requires 4 less instructions to calculate the gcf per calculation of the remainder compared 
 # to the recursive algorithim. THis means that the total number of instructions used for the iterative program is lower meaning it is slightly 
 # more efficent
	
