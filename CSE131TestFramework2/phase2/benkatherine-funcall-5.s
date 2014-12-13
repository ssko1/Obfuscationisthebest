! --globals--
                .section     ".data"
                .align 4
FLOAT_FORCE_1:    .single      0r1.0       
globalInit_:    .word        0           

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
                .global      foo
foo:
    set         SAVE.foo, %g1
    save        %sp, %g1, %sp
/* line number 3*/
/* printing float STO.VarSTO@5db088 */
    set         null, %l1
    add         null, %l1, %l1
    ld          [%l1], %f0
    call    printFloat
    nop
/* line number 3*/
/* Done printing float. */
/* line number 3*/
/* printing float STO.VarSTO@f0cda1 */
    set         null, %l1
    add         null, %l1, %l1
    ld          [%l1], %f0
    call    printFloat
    nop
/* line number 3*/
/* Done printing float. */
    set         _endl, %o0
    call    printf
    nop
foo_end:
    ret 
    restore
SAVE.foo = -(92 + 4) & -8
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
/* line number 9*/
/* setting a = 2 */
    set         2, %l0
    st          %l0, [%fp-8]
/* line number 9*/
/* Done. */
    call    foo
    nop
main_end:
    ret 
    restore
SAVE.main = -(92 + 8) & -8
