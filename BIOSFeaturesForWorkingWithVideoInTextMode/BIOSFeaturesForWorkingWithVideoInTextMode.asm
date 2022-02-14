.686
INCLUDE Irvine32.inc
includelib Irvine32.lib
.data
color_name DWORD (lightMagenta SHL 4) OR cyan
color_name_blink DWORD (red SHL 4) OR blue
color_surname DWORD (black SHL 4) OR blue
color_group DWORD (magenta SHL 4) OR cyan 
color_group_blink DWORD (lightRed SHL 4) OR lightGreen 
_name  BYTE 'Yurii', 0dh, 0ah,0
_lenN=($-_name)
_surname  BYTE 'Slipenkyi', 0dh, 0ah,0
_lenS=($-_surname)
_group  BYTE 'PZ-21', 0dh, 0ah,0
_lenG=($-_group)
.code 
main PROC
;call ClrScr
mov dl, 70
mov dh, 23
call Gotoxy
mov eax, color_surname
mov ESI, 0
mov ECX, _lenS
C1:
mov al, _surname[ESI]
inc ESI
inc color_surname
call SetTextColor
call WriteChar
loop C1
M1:
mov dl, 40
mov dh, 7
call Gotoxy
mov eax,color_group
call SetTextColor
mov edx, offset _group
call WriteString
mov dl, 40
mov dh, 7
call Gotoxy
mov eax,color_group_blink
call SetTextColor
mov edx, offset _group
call WriteString
mov dl, 0
mov dh, 0
call Gotoxy
mov eax,color_name
call SetTextColor
mov edx, offset _name
call WriteString
mov dl, 0
mov dh, 0
call Gotoxy
mov eax,color_name_blink
call SetTextColor
mov edx, offset _name
call WriteString
mov ecx,1000
loop M1
mov dl, 60
mov dh, 20
call Gotoxy
retn
main endp
END main
