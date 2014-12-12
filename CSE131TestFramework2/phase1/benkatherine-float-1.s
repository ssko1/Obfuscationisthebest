! --globals--
                .section     ".data"
                .align 4
                 .global     x,y,z
x:              .single      0r5.5       
y:              .single      0r0.0       
z:              .single      0r0         
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
                .global      main
main:
    set         SAVE.main, %g1
    save        %sp, %g1, %sp
    set         globalInit_, %l0
    ld          [%l0], %l0
    cmp         %l0, %g0
    bne     globalInit_end
    nop
/* line number 5*/
/* Prepping Arithmetic Calculations by loading */
/* line number 5*/
/* Adding */
    set         x, %l1
    add         %g0, %l1, %l1
    ld          [%l1], %f0
    set         y, %l1
    add         %g0, %l1, %l1
    ld          [%l1], %f1
    fadds       %f0, %f1, %f3
/* line number 5*/
/* Storing result of Binary Op */
    set         -8, %l4
    add         %fp, %l4, %l4
    st          %f3, [%l4]
/* line number 7*/
/* Storing float + float into z */
    set         z, %l0
    add         %g0, %l0, %l0
    set         -8, %l2
    add         %fp, %l2, %l2
    ld          [%l2], %f1
    st          %f1, [%l0]
    set         globalInit_, %l0
    set         1, %l1
    st          %l1, [%l0]
globalInit_end:
/* line number 9*/
/* printing float STO.VarSTO@96ed8b */
    set         z, %l1
    add         %g0, %l1, %l1
    ld          [%l1], %f0
    call    printFloat
    nop
/* line number 9*/
/* Done printing float. */
    set         _endl, %o0
    call    printf
    nop
main_end:
    ret 
    restore
SAVE.main = -(92 + 4) & -8
