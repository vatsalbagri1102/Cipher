#ifndef MYENCRYPT_S
#else
// version 1.0 11/12/2022
    .arch armv6
    .arm
    .fpu vfp
    .syntax unified

    #include "cipher.h"

    .text     // start of text segment

    //////////////////////////////////////////////////
    // int encrypt(char *iobuf, char *bookbuf, int cnt)
    // encrypts  iobuf with bookbuf; updating iobuf
    //////////////////////////////////////////////////
    .global encrypt
    .type   encrypt, %function
    .equ    FP_OFF, 28

encrypt:
    push    {r4-r9, fp, lr}
    add     fp, sp, FP_OFF
    // do not alter anything above this line
    // r0 contains char *iobuf
    // r1 contains char *bookbuf
    // r2 contains cnt
    // r3 is ok to use
    // r4-r9 preserved registers are ok to use

    cmp     r2, 0               // if buffer empty we are done
    ble     .Ldone
     
    mov r3, 0 //output -> reversed
    mov r4, 0 // i
    mov r5, 0 // j
    mov r7, 0 // dereferenced iobuf
    mov r8, 0 // dereferenced bookbuf
    mov r9, 0 // last element to be added to r3

    .Lfor1:
    cmp r4, r2
    bge .Lendfor1

    LDRB r7, [r0]
    mov r3, 0
    mov r5, 0

    .Lfor2:
        cmp r5, 8
        bge .Lendfor2

        mov r6, 0 //unsigned int x
        LSL r3, r3, 1
        AND r6, r7, 1
        add r3, r3, r6
        LSR r7, r7, 1


        add r5, r5, 1
        b .Lfor2

    .Lendfor2:

    STRB r3, [r0]
    LDRB r8, [r1]
    LDRB r9, [r0]
    EOR r9, r9, r8
    STRB r9, [r0]
    add r1, r1, 1
    add r0, r0, 1

    add r4, r4, 1

    b .Lfor1

    .Lendfor1:
        


    

    // do not alter anything below this line
.Ldone:
    mov     r0, r2              // return cnt processed
    sub     sp, fp, FP_OFF
    pop     {r4-r9, fp, lr}
    bx      lr

    .size encrypt, (. - encrypt)
    .section .note.GNU-stack,"",%progbits
.end
#endif
