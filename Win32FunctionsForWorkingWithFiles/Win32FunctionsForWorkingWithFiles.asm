.686
.model flat,stdcall
.stack
INCLUDE Irvine32.inc
.data
str_ BYTE " Yurii   SlipenkYi     12.01.2001    RohaYyn      PZ-21", 0dh, 0ah
size_str = ($ -str_)
errMsg BYTE "ERROR!!!", 0dh, 0ah, 0
filename BYTE "Slipenkyi.txt", 0
fileHandle HANDLE ?  
byteCount DWORD ?     ; Число прочитаних байтів
size_str2 = size_str
str2 BYTE size_str2 DUP (?)
index_of_space DWORD 1
index_of_letter DWORD ?
count_of_Space DWORD 0
countY DWORD 0
temp DWORD ?
x DWORD 2
str3 BYTE "LAAG 92, NA 88", 0dh, 0ah
size_str3 = ($-str3)
size_str4 = 500
str4 BYTE size_str4 DUP(?)
.code
CounterSpace PROC  ;Рахує кількість пробілів та індекс наступного слова   
Go:
        mov al, ' ' 
        cld     
        repe scasb 
        jz _end 
        mov eax, size_str 
        sub eax, ecx    ; знаходжу індекс першого символу після пробілу
        mov index_of_letter, eax 
        sub eax, index_of_space ; кількість пробілів
        add count_of_Space, eax 
        _end: 
  mov al, ' ' 
        cld    
        repne scasb 
        jnz _end2 
        mov eax, size_str 
        sub eax, ecx ; індекс першого пробілу після слова
        mov index_of_space, eax  
  _end2:
  inc ecx
  loop Go
        ret
  CounterSpace ENDP

  CounterSymbol PROC  ; Рахує входження 'Y'
M:
        mov al, 'Y'
  cld
  repne scasb
  jnz _end
  mov eax, size_str
  sub eax, ecx; індекс Y
  mov temp, eax
  mov al, 'A'
  cld
  repe scasb
  jz _end
  mov eax, size_str
  sub eax, ecx; індекс першого не Y після Y
  sub eax, temp;  кількість Y підряд
  add countY, eax
  inc ecx
  loop M
  _end:
        ret
  CounterSymbol ENDP

main PROC
INVOKE CreateFile,
ADDR filename, GENERIC_WRITE, DO_NOT_SHARE, NULL, 
CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, 0
mov fileHandle, eax  
.IF eax == INVALID_HANDLE_VALUE
mov edx, OFFSET errMsg 
call WriteString 
jmp QuitNow 
.ENDIF
   mov  eax, fileHandle
   mov  edx, OFFSET str_
   mov  ecx, size_str
   call WriteToFile
INVOKE CloseHandle, fileHandle
   mov edx, OFFSET filename
   call OpenInputFile
   mov fileHandle, eax
   mov  eax, fileHandle
   mov  edx,OFFSET str2
   mov  ecx, size_str2
   call ReadFromFile
   mov  byteCount,eax
   INVOKE CloseHandle,fileHandle
   lea edi, str2
   mov ecx, size_str2
   call CounterSpace
   lea edi, str2
   mov ecx, size_str2  
   call CounterSymbol
   INVOKE CreateFile,
   ADDR filename, GENERIC_WRITE, DO_NOT_SHARE, NULL, 
   OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0 
   mov fileHandle, eax
   INVOKE SetFilePointer, fileHandle, 0, 0, x
   mov  eax,fileHandle
   mov  edx, OFFSET str3
   mov  ecx, size_str3
   call WriteToFile
   INVOKE CloseHandle, fileHandle

   mov edx, OFFSET filename
   call OpenInputFile
   mov fileHandle, eax
   mov  eax,fileHandle
   mov  edx,OFFSET str4
   mov  ecx, size_str4
   call ReadFromFile
   mov  byteCount,eax
   INVOKE CloseHandle, fileHandle
   mov edx, offset str4
   call WriteString
   QuitNow:
   INVOKE ExitProcess, 0   ; Завершимо програму
   main ENDP 
   END main
