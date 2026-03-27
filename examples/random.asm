;
; Random number generator for the LGP-21.
;
; Seed the random number generator by incrementing the seed until the
; TC switch is turned on.
;
srand:
    ld      rand_seed
    add     rand_c
    and     rand_m
    stc     rand_seed
    jnt     srand_return
    jmp     srand
srand_return:
    jmp     0000
;
; Generate a random 31-bit word in the high bits of the accumulator.
; The high bits will be more random than the low bits.
;
; The result can also be interpreted as a random fractional value
; in the range [-1, 1).
;
rand:
    ld      rand_seed
    mull    rand_a
    mulh    rand_one_half   ; Correct for the values being * 2.
    add     rand_c
    and     rand_m
    st      rand_seed
rand_return:
    jmp     0000
;
; Constants for the RNG with M = 2^31 taken from here:
; https://www.ams.org/journals/mcom/1999-68-225/S0025-5718-99-00996-5/S0025-5718-99-00996-5.pdf
;
;   X = ((A * X) + C) mod M
;   A = 37769685
;   C = 1
;   M = 2^31
;
; Because we can't use the LSB of memory locations, multiply everything by 2,
; and correct for the extra bit when multiplying by A:
;
;   X = ((A' * X * 0.5) + C') mod M'
;
;   A' = 75539370
;   C' = 2
;   M' = 2^32
;
rand_a:
    .dw #75539370
rand_c:
    .dw #2
rand_m:
    .dw $FFFFFFFE
rand_one_half:
    .dw 0.5
;
; Do not set the random seed word when the tape is loaded so that we
; can use whatever random junk is in memory as the initial seed.
;
    .noemit
rand_seed:
    .dw 0
    .emit
