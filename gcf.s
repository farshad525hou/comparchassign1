#Farshad Chowdhury
#October 5, 2017
#Computer Architecture
	.text            
	.globl  main     
main:                 
	sub	$sp,$sp,8 #make 8 spaces in stack pointer	 
	sw	$ra,0($sp)	
	li	$v0,4       # Load syscall4 (output) into v0
	la	$a0,fst     # Load address of fst into ao
	syscall         
	
	li $v0,5        # Load syscall5 (input) into v0
	syscall         
	move $t1,$v0    # Move into to $t1 to clear $v0
		
	li	$v0,4      # Load syscall4 (output) into v0
	la	$a0,scnd     # Load address of scnd to v0
	syscall         # Print string
	
	li $v0,5        #  Load syscall5 (input) into v0
	syscall         
	move $a0,$t1    # Move into to $a0
	move $a1,$v0    # Move power integer to $a1
	
	
	jal	gcf		# call subroutine gcf to calculate the gcf.
	sw	$v0,4($sp)  # saves return of subroutine into sp
	li	$v0,4  # Load syscall4 (output) into v0  
         
	la	$a0,out #Loads adress of output string into a0                    
	syscall          
	li	$v0,1       #  Load syscall1 (output) into v0
	lw	$a0,4($sp)  # Load word from sp (final output)
	syscall           
	lw	$ra,0($sp)	
	add	$sp,$sp,8	
	li	$v0,10
	syscall       # return to calling procedure

gcf:
	sub	$sp,$sp,4   # push 4 spaces ino the sp
	sw	$s0,0($sp)  # save $s0 on stack						
	bne $a1,$zero,L # if (b == 0), else go to L
		j EXIT       # jump to EXIT
	L :
		beq  $a1, $zero, EXIT # branches loop
		move $t2,$a1          
		rem $a1,$a0,$a1       
		move $a0,$t2         
		j    L              # back to top of loop
	EXIT: 

	move $v0,$a0    # Move a to $v0

	lw	$s0,0($sp)  # restore $s0 to value prior to function call
	add	$sp,$sp,4   # pop 4 spots out of sp stack
	jr	$ra  #return to caller
	
	.data             # Assembly directive indicating what follows is data
out:                   
	.asciiz "The GCF is = " 
scnd:                    
	.asciiz "first num = "  
fst:                    
	.asciiz "first integer = " 

	.text
	#1C.)
	# The interative gcf program takes a total of 7 instructions to calculate the value of the gcf. This means that for everytime 
	# the remainder is calculated 7 instructions are executed. Therfor the equation to obtain the total number of instructions executed 
	# will simply be as follows N=I*R, where N is the total number of instructions, I is the instructions per iteration,
	# and R is the number of times the remainder is calculated.
	
	#1D.)
 #Depending on the integers used to calculate the gcf, the total number of instructions ran will change. With my current implementation,
 #The iterative version of the code (non-recursive) requires 4 less instructions to calculate the gcf per calculation of the remainder compared 
 # to the recursive algorithim. THis means that the total number of instructions used for the iterative program is lower meaning it is slightly 
 # more efficent 
	
