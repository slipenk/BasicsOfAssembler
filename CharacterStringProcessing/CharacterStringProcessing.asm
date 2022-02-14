.686
.model flat, stdcall
.stack 4096
option casemap : none
ExitProcess PROTO, dwExitCode: dword

.data 
info db 'Yurii  Slipenkyi  12.01.2001  Rohatyn   PZ-21    00'
sizeTxt = $ - info
_name db 21 dup(?)
surname db 21 dup(?)
date db 21 dup(?)
town db 21 dup(?)
_group db 21 dup(?)
name_size dd ?
surname_size dd ?
date_size dd ?
town_size dd ?
group_size dd ?
ind_of_space dd 1
ind_of_letter dd 1
space_counter dd 0
tmp dd 0
tmp_counter dd ?

.code 
SpaceCounter PROC  ; Підрахункок кількості пробілів та вирахування першого індексу наступного слова    
    mov al, ' '
    cld    
    repe scasb
    jz _end
    mov eax, sizeTxt
    sub eax, ecx    
    mov ind_of_letter, eax
    sub eax, ind_of_space
    add space_counter, eax
    _end: 
    ret
    SpaceCounter ENDP

LengthCounter PROC  ; Підрахунок довжин слів та вирахування першого індексу першого пробілу після слова     
    mov al, ' '
    cld    
    repne scasb
    jnz _end
    mov eax, sizeTxt
    sub eax, ecx
    mov ind_of_space, eax
    sub eax, ind_of_letter
    mov tmp, eax
    _end: 
    ret
    LengthCounter ENDP

main PROC
    lea edi, info
    mov ecx, sizeTxt  
 ;Ім'я
    call SpaceCounter
    call LengthCounter
    mov eax, tmp
    mov name_size, eax

 
    mov ebp, edi
    mov tmp_counter, ecx
    cld
    mov ecx, name_size
    sub edi, ecx
    dec edi
    mov esi, edi
    mov edi, OFFSET _name
    rep movsb
	lea edx,_name
    mov edi,ebp
    mov ecx,tmp_counter

 ;Прізвище
    call SpaceCounter
    call LengthCounter
    mov eax, tmp
    mov surname_size, eax


    mov ebp, edi
    mov tmp_counter, ecx
    cld
    mov ecx, surname_size
    sub edi, ecx
    dec edi
    mov esi, edi
    mov edi, OFFSET surname
    rep movsb
	lea edx,surname
    mov edi,ebp
    mov ecx,tmp_counter

;Дата народження
    call SpaceCounter
    call LengthCounter
    mov eax, tmp
    mov date_size, eax

;Копіювання дати народження в змінну
    mov ebp, edi
    mov tmp_counter, ecx
    cld
    mov ecx, date_size
    sub edi, ecx
    dec edi
    mov esi, edi
    mov edi, OFFSET date
    rep movsb
	lea edx,date
    mov edi,ebp
    mov ecx,tmp_counter

;Місто 
    call SpaceCounter
    call LengthCounter
    mov eax, tmp
    mov town_size, eax

;Копіювання міста народження в змінну
    mov ebp, edi
    mov tmp_counter, ecx
    cld
    mov ecx, town_size
    sub edi, ecx
    dec edi
    mov esi, edi
    mov edi, OFFSET town
    rep movsb
	lea edx,town
    mov edi,ebp
    mov ecx,tmp_counter

;Група
    call SpaceCounter
    call LengthCounter
    mov eax, tmp
    mov group_size, eax


    mov ebp, edi
    mov tmp_counter, ecx
    cld
    mov ecx, group_size
    sub edi, ecx
    dec edi
    mov esi, edi
    mov edi, OFFSET _group
    rep movsb
	lea edx,_group
    mov edi,ebp
    mov ecx,tmp_counter

 
    call SpaceCounter  ;Підрахунок пробілів після останнього слова

INVOKE ExitProcess, 0 
main ENDP
END main
