.data
N: .word 7
str1: .string "th number in the Fibonacci sequence is "
newline:  .string "\n"
space: .string " "

.text
main:                          
        lw    a0, N            # 1
        li    s0, 1            # 2
        jal   ra, fib          # 3 +342

        mv    a1, a0           # 346
        lw    a0, N            # 347
        jal   ra, printResult  # 348
        j     exit             # 361
                         
fib:    # instruction count of this part are written in report  


        ble   a0, s0, L1     # 記得用b跳的不會回頭往下繼續跑，用j的才會

        addi  sp, sp, -12      
        sw    ra, 8(sp)       
        sw    a0, 4(sp)        
        
        #  Call the function recursively with n-1 as the argument, so this is recursive method
        addi  a0, a0, -1       
        jal   ra, fib          
        sw    a0, 0(sp)        
        
        lw    a0, 4(sp)        
        addi  a0, a0, -2       
        jal   ra, fib          
        lw    t0, 0(sp)        
        
        add   a0, a0, t0       
        lw    ra, 8(sp)        
        addi  sp, sp, 12       
        ret                    
	
L1:
        ret                    

printResult:                    
        mv    t0, a0           # 349
        mv    t1, a1           # 350
        
        mv    a0, t0           # 351
        li    a7, 1            # 352
        ecall                  # 353
        
        la    a0, str1         # 354
        li    a7, 4            # 355
        ecall                  # 356
    
        
        mv    a0, t1           # 357
        li    a7, 1            # 358
        ecall                  # 359
        ret                    # 360

exit:
        li   a7, 10            # 362
        ecall                  # 363

    
    