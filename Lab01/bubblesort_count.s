.data
N: .word 5
str1: .string "Array： "
str2: .string "Sorted： "
newline:  .string "\n"
space: .string " "
data:
.word 5
.word 3
.word 6
.word 7
.word 31

.text
main:    
    jal ra, printResult1            # 1
    
    la  a7 data                     # 9
    jal ra, printArray              # 10
    
    la a7 data                      # 59
    jal ra, bubblesort              # 60
    
    jal ra, printResult2            # 156
    
    la a7 data                      # 164
    jal ra, printArray              # 165+49 = 214
    
    
    # exit program, so set a7=10
    li       a7, 10                 #214
    ecall                           #215
    
printResult1:                      
        la a0, str1                 # 2
        li a7,4                     # 3
        ecall                       # 4
            
        la a0, newline              # 5
        li a7, 4                    # 6
        ecall                       # 7
        ret                         # 8

printResult2:                       
        la a0, str2                 # 157
        li a7,4                     # 158
        ecall                       # 159
            
        la a0, newline              # 160
        li a7, 4                    # 161
        ecall                       # 162
        ret                         # 163

printArray:
    mv t0, a7                       # 11 
    lw t1, N                        # 12
    slli t1, t1, 2                  # 13
    add t1,t0,t1                    # 14
    
    loop:                     
                              # t0 = a[0]   a[1]    a[2]    a[3]    a[4]
        lw a0, 0(t0)                # 15    23      31      39      47
        li a7 1                     # 16    24      32      40      48
        ecall                       # 17    25      33      41      49
                                    
        la a0, space                # 18    26      34      42      50
        li a7 4                     # 19    27      35      43      51
        ecall                       # 20    28      36      44      52
    				
        addi t0, t0, 4              # 21    29      37      45      53
        bne t0,t1,loop              # 22    30      38      46      54
        				
        la a0, newline              # 55
        li a7, 4                    # 56
        ecall                       # 57
        		
        ret                         # 58

    
bubblesort:       
    mv a0,a7                        # 61
    lw a1,N                         # 62
    
    sort:                           
    addi sp, sp, -20                # 63
    sw ra, 16(sp)                   # 64
    sw s3, 12(sp)                   # 65
    sw s2, 8(sp)                    # 66
    sw s1, 4(sp)                    # 67
    sw s0, 0(sp)                    # 68

    mv s2, a0                       # 69 
    mv s3, a1                       # 70

    mv s0, zero                     # 71
    for1tst: 
                            # i = s0 = 0    1   1   2   3   4   5
        slt t0, s0, s3              # 72    79      108 121 134 147

     # t0 = 0 if s0 ≥ s3 (i ≥ n), t0 = 1    1   1   1   1   1   0
        beq t0, zero, exit1         # 73    80      109 122 135 148

        addi s1, s0, -1             # 74    81      110 123 136
        for2tst: 
                            # j = s1 = -1   0   -1  1   1   1
            slti t0, s1, 0          # 75    82  104 111 124 137

    # t0=1 if s1 < 0 (j < 0),     t0 = 1    0   1   0   0   0
            bne t0, zero, exit2     # 76    83  105 112 125 138
        
            slli t1, s1, 2          #       84      113 126 139
            add t2, s2, t1          #       85      114 127 140
            lw t3, 0(t2)            #       86      115 128 141
            lw t4, 4(t2)            #       87      116 129 142

# t0=0 if t4 ≥ t3(v[j] <= v[j+1], 右大左小 regular)
                    #             t0 =      1       0   0   0
            slt t0, t4, t3          #       88      117 130 143
            beq t0, zero, exit2     #       89      118 131 144
 
            mv a7, s2               #       90
            mv a0, s1               #       91
            jal swap                #       92

            addi s1, s1, -1  #j--   #       102
            
            j for2tst               #       103
        exit2: 
            addi s0, s0, 1          # 77        106 119 132 145
        j for1tst                   # 78        107 120 133 146
    exit1: 
    lw s0, 0(sp)                    #                           149
    lw s1, 4(sp)                    #                           150
    lw s2, 8(sp)                    #                           151
    lw s3,12(sp)                    #                           152
    lw ra,16(sp)                    #                           153
    addi sp,sp, 20                  #                           154
    ret                             #                           155

swap:  

    mv a2, a7                       #       93
    mv a1, a0                       #       94
    
    slli t1, a1, 2                  #       95
    add t1, a2, t1                  #       96
    
    lw t0, 0(t1)                    #       97
    lw t2, 4(t1)                    #       98
    
    sw t2, 0(t1)                    #       99
    sw t0, 4(t1)                    #       100
    
    ret                             #       101