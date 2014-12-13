! --globals--
                .section     ".data"
                .align 4
FLOAT_FORCE_1:    .single      0r1.0       
                 .global     x,y
y:              .single      0r4.44      
x:              .word        3           
str_0:          .asciz       "main"      
str_1:          .asciz       "end"       
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
/* line number 6*/
/* Incrementing */
    set         null, %l1
    add         null, %l1, %l1
    ld          [%l1], %l0
    inc     %l0
    set         null, %l2
    add         null, %l2, %l2
    st          %l0, [%l2]
/* line number 6*/
/* Post Increment */
    dec     %l0
    set         -8, %l1
    add         %fp, %l1, %l1
    st          %l0, [%l1]
/* line number 6*/
/* Printing int Validating UnaryOp a as a IntegerType for operator: ++...
 */
    set         _intFmt, %o0
    set         -8, %l1
    add         %fp, %l1, %l1
    ld          [%l1], %o1
    call    printf
    nop
/* line number 6*/
/* Done printing int. */
/* line number 6*/
/* Incrementing */
    set         null, %l1
    add         null, %l1, %l1
    ld          [%l1], %l0
    inc     %l0
    set         null, %l2
    add         null, %l2, %l2
    st          %l0, [%l2]
/* line number 6*/
/* Post Increment */
    dec     %l0
    set         -12, %l1
    add         %fp, %l1, %l1
    st          %l0, [%l1]
/* line number 6*/
/* Printing int Validating UnaryOp a as a IntegerType for operator: ++...
 */
    set         _intFmt, %o0
    set         -12, %l1
    add         %fp, %l1, %l1
    ld          [%l1], %o1
    call    printf
    nop
/* line number 6*/
/* Done printing int. */
/* line number 6*/
/* Incrementing */
    set         null, %l1
    add         null, %l1, %l1
    ld          [%l1], %f0
    set         FLOAT_FORCE_1, %l6
    ld          [%l6], %f1
    fadds       %f0, %f1, %f2
    set         null, %l1
    add         null, %l1, %l1
    ld          [%l1], %l1
    st          %f2, [%l1]
    fsubs       %f2, %f1, %f0
    set         -16, %l1
    add         %fp, %l1, %l1
    st          %f0, [%l1]
/* line number 6*/
/* printing float STO.ExprSTO@380c76 */
    set         -16, %l1
    add         %fp, %l1, %l1
    ld          [%l1], %f0
    call    printFloat
    nop
/* line number 6*/
/* Done printing float. */
/* line number 6*/
/* Incrementing */
    set         null, %l1
    add         null, %l1, %l1
    ld          [%l1], %f0
    set         FLOAT_FORCE_1, %l6
    ld          [%l6], %f1
    fadds       %f0, %f1, %f2
    set         null, %l1
    add         null, %l1, %l1
    ld          [%l1], %l1
    st          %f2, [%l1]
    fsubs       %f2, %f1, %f0
    set         -20, %l1
    add         %fp, %l1, %l1
    st          %f0, [%l1]
/* line number 6*/
/* printing float STO.ExprSTO@1ba3afe */
    set         -20, %l1
    add         %fp, %l1, %l1
    ld          [%l1], %f0
    call    printFloat
    nop
/* line number 6*/
/* Done printing float. */
/* line number 7*/
/* Incrementing */
    set         null, %l1
    add         null, %l1, %l1
    ld          [%l1], %l0
    inc     %l0
    set         null, %l2
    add         null, %l2, %l2
    st          %l0, [%l2]
    set         -24, %l1
    add         %fp, %l1, %l1
    st          %l0, [%l1]
/* line number 8*/
/* Returning value from foo */
    set         -24, %l1
    add         %fp, %l1, %l1
    ld          [%l1], %i0
    ba      foo_end
    nop
foo_end:
    ret 
    restore
SAVE.foo = -(92 + 24) & -8
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
/* line number 14*/
/* printing string */
    set         _strFmt, %o0
    set         str_0, %o1
    call    printf
    nop
/* line number 14*/
/* Done printing string. */
    call    foo
    nop
/* line number 14*/
/* Saving return value */
    st          %o0, [%fp+-8]
/* line number 14*/
/* Printing int foo() */
    set         _intFmt, %o0
    set         -8, %l1
    add         %fp, %l1, %l1
    ld          [%l1], %o1
    call    printf
    nop
/* line number 14*/
/* Done printing int. */
/* line number 14*/
/* printing string */
    set         _strFmt, %o0
    set         str_1, %o1
    call    printf
    nop
/* line number 14*/
/* Done printing string. */
    set         _endl, %o0
    call    printf
    nop
main_end:
    ret 
    restore
SAVE.main = -(92 + 8) & -8