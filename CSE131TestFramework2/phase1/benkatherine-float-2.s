! --globals--
                .section     ".data"
                .align 4
                 .global     y,x
y:              .single      0r0.0       
x:              .single      0r0.0       
globalInit_:    .word        0           
float_0:        .single      0r94.25     

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
! --storing constant x with value 94.25
    set         x, %l0
    add         %g0, %l0, %l0
    set         float_0, %l1
    ld          [%l1], %f1
    st          %f1, [%l0]
/* line number 6*/
/* Prepping Arithmetic Calculations by loading */
    set         1, %l1
/* line number 6*/
/* Adding */
    set         x, %l1
    add         %g0, %l1, %l1
    ld          [%l1], %f0
/* line number 6*/
/* Storing 1 into  */
    set         4, %l0
    add         %fp, %l0, %l0
    set         1, %l1
    st          %l1, [%l0]
    set         4, %l1
    add         %fp, %l1, %l1
    ld          [%l1], %f1
    fitos       %f1, %f1
    fadds       %f0, %f1, %f3
/* line number 6*/
/* Storing result of Binary Op */
    set         -8, %l4
    add         %fp, %l4, %l4
    st          %f3, [%l4]
/* line number 6*/
/* Prepping Arithmetic Calculations by loading */
/* line number 6*/
/* Dividing */
    set         -8, %l1
    add         %fp, %l1, %l1
    ld          [%l1], %f0
    set         x, %l1
    add         %g0, %l1, %l1
    ld          [%l1], %f1
    fdivs       %f0, %f1, %f3
/* line number 6*/
/* Storing result of Binary Op */
    set         -12, %l4
    add         %fp, %l4, %l4
    st          %f3, [%l4]
/* line number 6*/
/* Storing float / float into y */
    set         y, %l0
    add         %g0, %l0, %l0
    set         -12, %l2
    add         %fp, %l2, %l2
    ld          [%l2], %f1
    st          %f1, [%l0]
/* line number 7*/
/* printing float y */
    set         y, %l1
    add         %g0, %l1, %l1
    ld          [%l1], %f0
    call    printFloat
    nop
/* line number 7*/
/* Done printing float. */
/* line number 10*/
/* Returning value from main */
    set         0, %i0
    ba      main_end
    nop
main_end:
    ret 
    restore
SAVE.main = -(92 + 12) & -8