.org 1000
.entry start

x:
    .dw 0
y:
    .dw 0
max:
    .dw 32
inc:
    .dw 1
eol:
    .dw "\n"
space:
    .dw " "
mark:
    .dw "x"

start:
    stc y       ;y = 0
    st y
newLine:
    stc x       ;x = 0
    st x
    
    ld eol       ;print a new line
    pr6

    ld y        ;y++
    add inc
    st y

    sub max     ;if y < max nextChar else halt 
    jnt nextChar
    z 0300
    hlt

nextChar:
    ld x        ;x++
    add inc
    st x

    sub max
    jnt compute
    jmp newLine

compute:
    ld x
    and y
    sub inc
    jnt mm
    ld space
    pr6
    pr6
    jmp nextChar
mm:
    ld mark
    pr6
    pr6
    jmp nextChar