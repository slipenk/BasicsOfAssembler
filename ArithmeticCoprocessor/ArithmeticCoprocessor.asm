.686
.model flat
.stack 256
.data
const1 real4 7.8
const2 real4 8.3
const3 real4 39.0
const4 real4 6.3
const5 real4 6.8
const6 real4 1.4
a real4 8.3
c1 real4 4.3
d real4 6.4
r real4 0.0
temp real4 0.0
.code
main PROC
finit
fld[c1]
fmul[const3]
fadd[const2]
fsqrt
fld[a]
fmul[d]
fld[c1]
fmul[const1]
fsubrp
fsubrp
fld[a]
fmul[const6]
fld[c1]
fdiv[const4]
fadd[const5]
fsubrp
fdivp
fst[r]
 retn
main ENDP
END main
