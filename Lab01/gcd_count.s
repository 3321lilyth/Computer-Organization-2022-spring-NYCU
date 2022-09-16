.data
N1: .word 4 # number 1 (u)
N2: .word 8	# number 2 (v)
str1: .string "GCD value of "
str2: .string " and "
str3: .string " is "

.text
main:
    lw a0, N2           # 1
    lw a1, N1           # 2
    jal ra, gcd		    # 3

    jal ra,print	    # 19
    li a7, 10		    # 40
    ecall	           	# 41
gcd:
                    #a0 = 8     4
                    #a1 = 4     0
                    
    beqz a1, done       # 4     13
    addi sp, sp, -12    # 5
    sw ra, 8(sp)        # 6
    sw a1, 4(sp)        # 7
    sw a0, 0(sp)        # 8

    mv t0,a1            # 9  
    rem a1, a0, a1      # 10
    mv a0,t0        	# 11
    jal ra, gcd   		# 12

    lw ra, 8(sp) 		# 16
    addi sp,sp, 12		# 17
    ret          		# 18

done:		    		
    mv a2, a0			#       14
    ret			    	#       15

print:			    	
    mv t0, a0			# 20
    la a0,str1			# 21
    li a7, 4			# 22
    ecall		    	# 23

    lw a0, N1    		# 24
    li a7, 1			# 25
    ecall		    	# 26
    
    la a0,str2			# 27
    li a7, 4			# 28
    ecall		    	# 29
    
    lw a0, N2			# 30
    li a7, 1			# 31
    ecall		    	# 32
    
    la a0,str3			# 33
    li a7, 4			# 34
    ecall		    	# 35
    
    mv a0, t0			# 36
    li a7, 1			# 37
    ecall    			# 38
    ret			        # 39	
