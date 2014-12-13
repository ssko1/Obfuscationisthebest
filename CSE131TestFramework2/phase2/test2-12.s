! --globals--
                .section     ".data"
                .align 4
FLOAT_FORCE_1:    .single      0r1.0       
float_0:        .single      0r3.5       
str_1:          .asciz       " "         
str_2:          .asciz       " "         
str_3:          .asciz       " "         
str_4:          .asciz       " "         
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
    set         globalInit_, %l0
    set         1, %l1
    st          %l1, [%l0]
globalInit_end:
/* line number 6*/
/* setting f1 = 3.50 */
    set         -8, %l0
    add         %fp, %l0, %l0
/* line number 6*/
/* setting float */
    set         float_0, %l1
    ld          [%l1], %f0
    st          %f0, [%l0]
/* line number 6*/
/* Done. */
/* line number 6*/
/* Incrementing */
/* line number 6*/
/* Loading f1 to %f0 */
    set         -8, %l1
    add         %fp, %l1, %l1
    ld          [%l1], %f0
    set         FLOAT_FORCE_1, %l6
    ld          [%l6], %f1
    fadds       %f0, %f1, %f2
    set         -8, %l1
    add         %fp, %l1, %l1
    st          %f2, [%l1]
    fsubs       %f2, %f1, %f2
    set         -12, %l1
    add         %fp, %l1, %l1
    st          %f2, [%l1]
/* line number 8*/
/* setting f2 = Validating UnaryOp f1 as a FloatType for operator: ++...
 */
    set         -16, %l0
    add         %fp, %l0, %l0
    set         -12, %l1
    add         %fp, %l1, %l1
    ld          [%l1], %f0
    st          %f0, [%l0]
/* line number 8*/
/* Done. */
/* line number 8*/
/* printing float STO.VarSTO@17cd18d */
/* line number 8*/
/* Loading f2 to %f0 */
    set         -16, %l1
    add         %fp, %l1, %l1
    ld          [%l1], %f0
    call    printFloat
    nop
/* line number 8*/
/* Done printing float. */
/* line number 8*/
/* printing string */
    set         _strFmt, %o0
    set         str_1, %o1
    call    printf
    nop
/* line number 8*/
/* Done printing string. */
/* line number 8*/
/* printing float STO.VarSTO@fa1b85 */
/* line number 8*/
/* Loading f1 to %f0 */
    set         -8, %l1
    add         %fp, %l1, %l1
    ld          [%l1], %f0
    call    printFloat
    nop
/* line number 8*/
/* Done printing float. */
/* line number 8*/
/* printing string */
    set         _strFmt, %o0
    set         str_2, %o1
    call    printf
    nop
/* line number 8*/
/* Done printing string. */
/* line number 10*/
/* Incrementing */
/* line number 10*/
/* Loading f1 to %f0 */
    set         -8, %l1
    add         %fp, %l1, %l1
    ld          [%l1], %f0
    set         FLOAT_FORCE_1, %l6
    ld          [%l6], %f1
    fadds       %f0, %f1, %f2
    set         -8, %l1
    add         %fp, %l1, %l1
    st          %f2, [%l1]
    set         -20, %l1
    add         %fp, %l1, %l1
    st          %f2, [%l1]
/* line number 10*/
/* Storing variable Validating UnaryOp f1 as a FloatType for operator: ++...
 into f1 */
    set         -8, %l5
    add         %fp, %l5, %l5
    set         -20, %l3
    add         %fp, %l3, %l3
    ld          [%l3], %f1
    st          %f1, [%l5]
/* line number 11*/
/* Decrementing */
/* line number 11*/
/* Loading f2 to %f0 */
    set         -16, %l1
    add         %fp, %l1, %l1
    ld          [%l1], %f0
    set         FLOAT_FORCE_1, %l6
    ld          [%l6], %f1
    fsubs       %f0, %f1, %f2
    set         -16, %l1
    add         %fp, %l1, %l1
    st          %f2, [%l1]
    set         -24, %l1
    add         %fp, %l1, %l1
    st          %f2, [%l1]
/* line number 11*/
/* Storing variable Validating UnaryOp f2 as a FloatType for operator: --...
 into f2 */
    set         -16, %l5
    add         %fp, %l5, %l5
    set         -24, %l3
    add         %fp, %l3, %l3
    ld          [%l3], %f1
    st          %f1, [%l5]
/* line number 13*/
/* printing float STO.VarSTO@17cd18d */
/* line number 13*/
/* Loading f2 to %f0 */
    set         -16, %l1
    add         %fp, %l1, %l1
    ld          [%l1], %f0
    call    printFloat
    nop
/* line number 13*/
/* Done printing float. */
/* line number 13*/
/* printing string */
    set         _strFmt, %o0
    set         str_3, %o1
    call    printf
    nop
/* line number 13*/
/* Done printing string. */
/* line number 13*/
/* Incrementing */
/* line number 13*/
/* Loading f1 to %f0 */
    set         -8, %l1
    add         %fp, %l1, %l1
    ld          [%l1], %f0
    set         FLOAT_FORCE_1, %l6
    ld          [%l6], %f1
    fadds       %f0, %f1, %f2
    set         -8, %l1
    add         %fp, %l1, %l1
    st          %f2, [%l1]
    fsubs       %f2, %f1, %f2
    set         -28, %l1
    add         %fp, %l1, %l1
    st          %f2, [%l1]
/* line number 13*/
/* printing float STO.ExprSTO@d55a0f */
/* line number 13*/
/* Loading Validating UnaryOp f1 as a FloatType for operator: ++...
 to %f0 */
    set         -28, %l1
    add         %fp, %l1, %l1
    ld          [%l1], %f0
    call    printFloat
    nop
/* line number 13*/
/* Done printing float. */
/* line number 13*/
/* printing string */
    set         _strFmt, %o0
    set         str_4, %o1
    call    printf
    nop
/* line number 13*/
/* Done printing string. */
/* line number 13*/
/* printing float STO.VarSTO@fa1b85 */
/* line number 13*/
/* Loading f1 to %f0 */
    set         -8, %l1
    add         %fp, %l1, %l1
    ld          [%l1], %f0
    call    printFloat
    nop
/* line number 13*/
/* Done printing float. */
    set         _endl, %o0
    call    printf
    nop
main_end:
    ret 
    restore
SAVE.main = -(92 + 28) & -8
