! --globals--
                .section     ".data"
                .align 4
FLOAT_FORCE_1:    .single      0r1.0       
float_0:        .single      0r4.44      
str_1:          .asciz       "main"      
str_2:          .asciz       "end"       
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
/* setting x = 3 */
    set         3, %l0
    st          %l0, [%fp-8]
/* line number 6*/
/* Done. */
/* line number 8*/
/* setting y = 4.44 */
    set         -12, %l0
    add         %fp, %l0, %l0
/* line number 8*/
/* setting float */
    set         float_0, %l1
    ld          [%l1], %f0
    st          %f0, [%l0]
/* line number 8*/
/* Done. */
/* line number 8*/
/* printing string */
    set         _strFmt, %o0
    set         str_1, %o1
    call    printf
    nop
/* line number 8*/
/* Done printing string. */
/* line number 8*/
/* Decrementing */
/* line number 8*/
/* Loading x to %l0 */
    set         -8, %l1
    add         %fp, %l1, %l1
    ld          [%l1], %l0
    dec     %l0
    set         -8, %l2
    add         %fp, %l2, %l2
    st          %l0, [%l2]
    set         -16, %l1
    add         %fp, %l1, %l1
    st          %l0, [%l1]
/* line number 8*/
/* Printing int Validating UnaryOp x as a IntegerType for operator: --...
 */
    set         _intFmt, %o0
/* line number 8*/
/* Loading Validating UnaryOp x as a IntegerType for operator: --...
 to %o1 */
    set         -16, %l1
    add         %fp, %l1, %l1
    ld          [%l1], %o1
    call    printf
    nop
/* line number 8*/
/* Done printing int. */
/* line number 8*/
/* Decrementing */
/* line number 8*/
/* Loading x to %l0 */
    set         -8, %l1
    add         %fp, %l1, %l1
    ld          [%l1], %l0
    dec     %l0
    set         -8, %l2
    add         %fp, %l2, %l2
    st          %l0, [%l2]
    set         -20, %l1
    add         %fp, %l1, %l1
    st          %l0, [%l1]
/* line number 8*/
/* Printing int Validating UnaryOp x as a IntegerType for operator: --...
 */
    set         _intFmt, %o0
/* line number 8*/
/* Loading Validating UnaryOp x as a IntegerType for operator: --...
 to %o1 */
    set         -20, %l1
    add         %fp, %l1, %l1
    ld          [%l1], %o1
    call    printf
    nop
/* line number 8*/
/* Done printing int. */
/* line number 8*/
/* Decrementing */
/* line number 8*/
/* Loading y to %f0 */
    set         -12, %l1
    add         %fp, %l1, %l1
    ld          [%l1], %f0
    set         FLOAT_FORCE_1, %l6
    ld          [%l6], %f1
    fsubs       %f0, %f1, %f2
    set         -12, %l1
    add         %fp, %l1, %l1
    st          %f2, [%l1]
    set         -24, %l1
    add         %fp, %l1, %l1
    st          %f2, [%l1]
/* line number 8*/
/* printing float STO.ExprSTO@1be4050 */
/* line number 8*/
/* Loading Validating UnaryOp y as a FloatType for operator: --...
 to %f0 */
    set         -24, %l1
    add         %fp, %l1, %l1
    ld          [%l1], %f0
    call    printFloat
    nop
/* line number 8*/
/* Done printing float. */
/* line number 8*/
/* Decrementing */
/* line number 8*/
/* Loading y to %f0 */
    set         -12, %l1
    add         %fp, %l1, %l1
    ld          [%l1], %f0
    set         FLOAT_FORCE_1, %l6
    ld          [%l6], %f1
    fsubs       %f0, %f1, %f2
    set         -12, %l1
    add         %fp, %l1, %l1
    st          %f2, [%l1]
    set         -28, %l1
    add         %fp, %l1, %l1
    st          %f2, [%l1]
/* line number 8*/
/* printing float STO.ExprSTO@170526a */
/* line number 8*/
/* Loading Validating UnaryOp y as a FloatType for operator: --...
 to %f0 */
    set         -28, %l1
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
    set         _endl, %o0
    call    printf
    nop
main_end:
    ret 
    restore
SAVE.main = -(92 + 28) & -8
