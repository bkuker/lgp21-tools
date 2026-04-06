    .org 1000
    .entry start



                            ;Start a new fractal                    
start:      ld  iLow        ;Reset iPos to iLow
            st  iPos
                            ;Start a new line
newLine:    ld  rLow        ;Reset rPos to rLow
            st  rPos
            
            ld  eol         ;Print a new line
            pr6

            ld  iPos        ;iPos += iStep        
            add iStep
            st  iPos

            sub iHigh       ;If iPos > iHigh goto start
            jnt nextChar    ;else goto nextChar:
            hlt             ; TODO jmp start

nextChar:   ld  rPos        ;rPos += rStep
            add rStep
            st  rPos

            sub rHigh       ;if rPos > rHigh goto newLine
            jnt compute
            jmp newLine


compute:    ld  max         ;itr = max
            stc itr
            st x            ; x = 0
            st y            ; y = 0

                            ; xtemp := x^2 - y^2 + x0
iterate:    ld  y           ; yy = y * y
            mulh y
            shl4
            st yy
            nop
            ld x            ; x*x
            nop
            nop
            mulh x
            shl4
            st xx
            jmp 1039
.1039:
            sub yy          ; ... - y*y
            add rPos        ; + x0
            st  xTemp

                            ; y := 2*x*y + y0
            ld twoF
            jmp 1048
.1048:
            mulh x
            shl4
            mulh y
            shl4
            add iPos
            st y

            ld xTemp        ; x := xtemp
            st x

            ld itr          ;Decrement Iterator
            sub dec
            st itr

            jnt in          ;Iterator went negative, we are IN

            ld yy           ;Are we still inside the 2-unit circle?
            add xx
            sub fourF
            jnt iterate     ;Left the circle, we are out
            jmp out



out:        ld  itr
            shl6
            shl6
            shl6
            shl6
            shl4
            pr4
            jmp nextChar

in:         ld space
            pr6
            jmp nextChar

                    .org 2000
.2045:	iPos:	.dw 0
.2062:	rPos:	.dw 0;
.2043:	dec:	.dw #2
.2051:	itr:	.dw 0
.2013:	x:	    .dw 0
.2025:	y:	    .dw 0
.2006:	xTemp:	.dw 0
.2047:	xx:	    .dw 0
.2018:	yy:	    .dw 0
.2021:	twoF:	.dw 2.0 >> 4
.2055:	fourF:	.dw 4.0 >> 4
.2035:	rStep:	.dw 0.040 >> 4
.2024:	iHigh:	.dw 1.1 >> 4
.2030:	rHigh:	.dw 0.52 >> 4
.2026:	eol:	.dw "\n"
.2052:	space:	.dw " "
.2029:	iStep:	.dw 0.1 >> 4

.2136:	iLow:	.dw -1.1 >> 4
.2031:	rLow:	.dw -2.1 >> 4
.2033:	max:	.dw #28