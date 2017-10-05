#
		.text
	.globl  main
main:
	sub	$sp,$sp,8	# make 8 spaces in stack pointer	 
	sw	$ra,4($sp)	#saves ra into the stack pointer

	li	$v0,4       
	la	$a0,in1     
	syscall        
	
	li $v0,5        
	syscall        
	move $t1,$v0    
		
	li	$v0,4       
	la	$a0,scnd     
	syscall        
	
	li $v0,5        
	syscall         # Read integer from console
	move $a0,$t1    # Move into to $a0
	move $a1,$v0    # Move in1er integer to $a1
	jal gcfr
	sw	$v0,8($sp)
	li	$v0,4
	la	$a0,out
	syscall
	li	$v0,1
	lw	$a0,8($sp)
	syscall
	li $v0, 10
	syscall

	
gcfr:
	sub	$sp,$sp,8	# push stack
	sw	$ra,4($sp)	# save return address

	bne $a1, $zero, L # if b!=0 then exit
	add	$v0,$zero,$a0	# return a0
	add	$sp,$sp,8	# pop stack
	jr	$ra		# return to calling procedure
L:
	move $t4,$a1         # set up c = b
	rem $a1,$a0,$a1      # b = a % b
	move $a0,$t4         # a = c
	jal gcfr          # recurse

	lw	$ra,4($sp)	# restore previous return addr
	move $v0,$a0    # Move a to $v0

	add	$sp,$sp,8	# pop stack
	jr	$ra		# return to calling procedure
	
	.data
out:                    
	.asciiz "The GCF is = "  
scnd:                    
	.asciiz "second num = " 
in1:                    
	.asciiz "first num = " 
	
	.text
	
	# The recursive program takes 11 instructions to calculate the value of the greatest common factor. 
	# The number of total instructions for this program will simply be the number of insttructions executed per iteration (11) multiplied 
	# by the number of times the remainder is calculated. N=I*R, where N is the total number of instructions, I is instructions per iteration,
	# and R is the number of times the remainder is caclulated. 
	
