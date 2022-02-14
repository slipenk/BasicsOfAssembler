.686
.model flat
.stack
.data
row        dd 6
col        dd 7
sumEl      dd 0
sc         dd 0
arr      dd -5,  3,   0,   9,  11,   -3,   2
         dd 11, -20,  5, -19,   1,   23,  16
         dd 12,  0, -12, -14,   3,   15,   4
         dd -4,  6,   8,   3,  -2,  -25,   13
         dd 13,  1,  15,   2,   0,   23,   -2
         dd 2,  34,   8,   7,   3,   -9,   77

arr1     dd  0, 0, 0, 0, 0, 0, 0
         dd  0, 0, 0, 0, 0, 0, 0
         dd  0, 0, 0, 0, 0, 0, 0
         dd  0, 0, 0, 0, 0, 0, 0
         dd  0, 0, 0, 0, 0, 0, 0
         dd  0, 0, 0, 0, 0, 0, 0

arr3     dd  0, 0, 0, 0, 0, 0
         dd  0, 0, 0, 0, 0, 0
         dd  0, 0, 0, 0, 0, 0
         dd  0, 0, 0, 0, 0, 0
         dd  0, 0, 0, 0, 0, 0
         dd  0, 0, 0, 0, 0, 0
         dd  0, 0, 0, 0, 0, 0
count1 dd 0
count2 dd 0
pl     dd 28
.code
main PROC
    lea ESI,arr
    lea EBX,arr1
    mov ECX,row
    imul ECX,col
arr_save:
    mov EAX,[ESI]
    mov [EBX],EAX
    add ESI,4
    add EBX,4
    loop arr_save
prepare_to_transpose:
    lea ESI,arr
    lea EBX,arr3
    mov ECX, row
transpose: 
    mov EAX,[ESI]
    mov [EBX],EAX
    add EBX, 4
    add ESI, pl
    loop transpose
new_col:
    add count1,4
    lea ESI,arr 
    add ESI,0                            
    mov ECX, row
    add count2,1
    mov EDX, count2
    cmp EDX,col
    jne transpose
prepere_to_sum:
    lea EBX,arr
    add EBX, 112
    mov ECX, col
    mov EAX, 0    
sum:
    add EAX,[EBX]
    add EBX,4
    loop sum
    mov sumEl, EAX ;    52
prepere_to_scalar:
    lea EBX,arr
    ;add EBX, 8
    lea ESI,arr
    add ESI, 24
    mov EAX,0
    mov ECX,row
    mov EDX,0
scalar:
    mov EDX,[EBX]
    imul EDX,[ESI]
    add EAX,EDX
    add EBX, pl
    add ESI, pl
    loop scalar
    mov sc, EAX ; 290
prepare_to_swap:
    lea EBX,arr
    lea ESI,arr
    add EBX,84
    add ESI,140
    mov ECX, col
swap:
    mov EAX,[EBX]
    mov EDX,[ESI]
    mov [ESI],EAX
    mov [EBX],EDX
    add EBX,4
    add ESI,4
    loop swap
    lea EBX,arr
    retn
main ENDP
END main
