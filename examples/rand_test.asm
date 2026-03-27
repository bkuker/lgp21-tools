;
; Test that the random number generator output looks random.
;
    .org    1000
    .entry  start
start:
    ld      count_start
    st      counter
test_loop:
    sret    rand_return
    jmp     rand
    pr4
    shl4
    pr4
    shl4
    pr4
    shl4
    pr4
    shl4
    pr4
    shl4
    pr4
    shl4
    pr4
    shl4
    pr4
    ld      newline
    pr6
    ld      counter
    add     count_inc
    st      counter
    jn      test_loop
    hlt
newline:
    .dw     "\n"
count_start:
    .dw     #-200
count_inc:
    .dw     #2
counter:
    .dw     0
    .include random.asm
