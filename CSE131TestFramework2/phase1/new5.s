! --globals--
                .section     ".data"
                .align 4
globalInit_:    .word        0           
main_x:         .word        0           
staticGuard_main_x:    .word        0           
main_y:         .word        0           
staticGuard_main_y:    .word        0           

! DEFINING INTERNAL CONSTANTS --
                .section     ".rodata"
_endl:          .asciz       "\n"        
_intFmt:        .asciz       "%d"        
_strFmt:        .asciz       "%s"        
_boolT:         .asciz       "true"      
_boolF:         .asciz       "false"     
rfmt:           .asciz       "%.21f"     
arrayOutOfBounds:    .asciz       "Index value of %d is outside legal range [0,%d)."

                .section     ".text"
                .align 4
                .global      main
main:
    set         SAVE.main, %g1
    save        %sp, %g1, %sp
    set         globalInit_, %l0
    ld          [%l0], %l0
    cmp         %l0, %g0
    bne     globalInit_end
    nop
    set         globalInit_, %l0
    set         1, %l1
    st          %l1, [%l0]
globalInit_end:
    set         staticGuard_main_x, %l0
    ld          [%l0], %l1
    cmp         %g0, %l1
    bne     staticGuardLabel_main_x
    nop
! --storing constant x with value 1.0
    set         main_x, %l0
    add         %g0, %l0, %l0
    set         null, %l1
    ld          [%l1], %f1
    st          %f1, [%l0]
    set         staticGuard_main_x, %l2
    set         1, %l3
    st          %l3, [%l2]
staticGuardLabel_main_x:
    set         staticGuard_main_y, %l0
    ld          [%l0], %l1
    cmp         %g0, %l1
    bne     staticGuardLabel_main_y
    nop
! --storing constant y with value 0.0
    set         main_y, %l0
    add         %g0, %l0, %l0
    set         null, %l1
    ld          [%l1], %f1
    st          %f1, [%l0]
    set         staticGuard_main_y, %l2
    set         1, %l3
    st          %l3, [%l2]
staticGuardLabel_main_y:
/* line number 6*/
/* Printing bool x */
    set         main_x, %l1
    add         %g0, %l1, %l1
    ld          [%l1], %l0
    set         _strFmt, %o0
    cmp         %l0, %g0
    be      printFalse_0
    nop
printTrue_0:
    set         _boolT, %o1
    ba      branchEnd_0
    nop
printFalse_0:
    set         _boolF, %o1
branchEnd_0:
    call    printf
    nop
/* line number 6*/
/* Done printing bool. */
    set         _endl, %o0
    call    printf
    nop
/* line number 6*/
/* Printing bool y */
    set         main_y, %l1
    add         %g0, %l1, %l1
    ld          [%l1], %l0
    set         _strFmt, %o0
    cmp         %l0, %g0
    be      printFalse_1
    nop
printTrue_1:
    set         _boolT, %o1
    ba      branchEnd_1
    nop
printFalse_1:
    set         _boolF, %o1
branchEnd_1:
    call    printf
    nop
/* line number 6*/
/* Done printing bool. */
main_end:
    ret 
    restore
SAVE.main = -(92 + 4) & -8