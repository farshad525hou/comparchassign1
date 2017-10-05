

        .text 
        .globl main

main:

         lw $s0, tosses           # n is the number of points generated 
         li $s1, 0           # $s1 counts the points inside the unit circle

L:

#Code to generate a random number to be stored in f1

         lw 	$t0, x           
         lw 	$t1, seed 
         mul 	$t0, $t0, $t1   
         lw 	$t1, y 
         addu 	$t0, $t0, $t1  
         lw 	$t1, z 
         div 	$t0, $t1        
         mfhi 	$t1            
         sw 	$t1, seed        
         l.s 	$f1, seed 
         cvt.s.w $f1, $f1    
         l.s 	$f0, z 
         cvt.s.w $f0, $f0    
         div.s 	$f1, $f1, $f0 
         add.s	$f1, $f1, $f1 
         l.s 	$f0, one       
         sub.s 	$f1, $f1, $f0 
#________________________________________________________________________
         mov.s	$f2, $f3 #    
         mov.s	$f3, $f1     
         #obtain f1=f1^2+f2^2
         mul.s	$f1, $f1, $f1 
         mul.s	$f2, $f2, $f2  
         add.s	$f1, $f1, $f2 # $f1=$f1+$f2

#makes sure that f1^2 + f2^2 <=1. This is to ensure the generated number is within the given range of possible generated values.

         s.s	$f1, temp 
         lw	$t2, temp        # $t2 (integer) = $f1 (float) 
         lw	$t1, one         # $t1 (integer) = 1.0 (float)

         slt $t0, $t1, $t2 
         bne $t0, $0, skip 
         addi $s1, $s1, 1 
skip:    addi $s0, $s0, -1 
         bne $s0, $0, L

# calculate PI = (# of points inside circle) * 4 / n  ----------------------

         add 	$s1, $s1, $s1   
         add 	$s1, $s1, $s1 
         sw 	$s1, temp 
         l.s 	$f12, temp 
         cvt.s.w $f12, $f12 
         l.s 	$f0, tosses 
         cvt.s.w $f0, $f0 
         div.s 	$f12, $f12, $f0
         li $v0, 2 
         syscall             # Print the value of Pi
         li $v0, 4 
         la $a0, bye         # Print the end message 
         syscall 
         li $v0, 10 
         syscall             # end of program

#-------------------------------------------------------------------------- 
        .data 
x:      .word 311
y:      .word 171 
z:      .word 65536 
tosses:	.word 100000
one:    .float 1.0 
seed:   .word 79 
temp:   .word 0 
bye:    .asciiz "\nPress enter to exit..."
