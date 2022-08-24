; Author: Keith Beauvais
; Section: 1001
; Date Last Modified: 9/11/2021
; Program Description: This program will demonstrate mastery over arithmetic operations in x86 assembly.

section .data
; System service call values
SERVICE_EXIT equ 60
SERVICE_WRITE equ 1
EXIT_SUCCESS equ 0
STANDARD_OUT equ 1
NEWLINE equ 10

programDone db "Program Done.", NEWLINE 
stringLength dq 14

;	Example variables89 
byteExample1 db 0x10
byteExample2 db 0x32
byteExample3 db 0x00
byteExample4 db 100
wordExample1 dw 0x0002
wordExample2 dw 0x00F0
doubleExample1 dd 0x10101010
doubleExample2 dd 0
 
;	Data variables
doubleVariable2 dd 0x89ABCDEF
byteVariable3 db 250
doubleVariable4 dd 0x12345678
doubleVariable5 dd 0xC1240000
wordVariable6a dw -42
wordVariable6b dw 40
quadVariable8a dq 0xFFFFFFFFFFFFFFFF
quadVariable8b dq 0xF0F0F0F0F0F0F0F0
doubleVariable9 dd 0xC2860000
wordVariable9 dw 0x1234
byteVariable10a db 0x02
byteVariable10b db 0xF0
doubleVariable11a dd 40008
doubleVariable11b dd 12
quadVariable12a dq 0xFFFFFFFFFFFFFFFF
quadVariable12b dq 0x00000000000000F1
byteVariable13 db 0x0A
byteVariable14a db 0xF0
byteVariable14b db 0x02
doubleVariable15 dd 80009
wordVariable15 dw 3050
wordVariable16a dw 0x0497
wordVariable16b dw 0x0002
byteVariable17 db 0xB8
wordVariable18a dw 0x00FF
wordVariable18b dw 0xFFFA
wordVariable18c dw 0x0005
doubleVariable19a dd 0xB0040030
doubleVariable19b dd 0xC0000000
quadVariable20 dq 0x000000039ABCDEF0
doubleVariable20 dd 0xFEDCBA98
   
;	Answer variables
doubleAnswer1 dd 0xFFFFFFFF
doubleAnswer2 dd 0x00000000
quadAnswer3 dq 0xFFFFFFFFFFFFFFFF
quadAnswer4 dq 0xFFFFFFFFFFFFFFFF
quadAnswer5 dq 0
wordAnswer6 dw 0x00000000
doubleAnswer7 dd 0x0FFFFFFD
quadAnswer8 dq 0xFFFFFFFFFFFFFFFF
doubleAnswer9 dd 0x00000000
wordAnswer10 dw 0
quadAnswer11 dq 0
doubleQuadAnswer12 ddq 0
wordAnswer13 dw 0xFFFF
byteAnswer14 db 0x00
byteRemainder14 db 0x00
wordAnswer15 dw 0x0000
wordRemainder16 dw 0xFFFF   
byteAnswer17 db 0x00
wordAnswer18 dw 0x0000
doubleAnswer19 dd -1
doubleRemainder19 dd -1
doubleRemainder20 dd 0x00000000

section .text
global _start
_start:

;=====MOV=====
;  	Moving an immediate value into a register
	mov ax, 0
;  	Copying a value from one register to another
	mov ecx, ebx
;	Copying a value from a variable to a register
	mov edx, dword[doubleExample1]
	
;	1. doubleAnswer1 = 400000
	mov dword[doubleAnswer1], 400000 ; moving 400000 into the value variable of doubleAnswer1 (unsigned)

;	2. doubleAnswer2 = doubleVariable2
	mov eax, dword[doubleVariable2] ; moving the value of doubleVariable2 into eax register (unsigned)
	mov dword[doubleAnswer2], eax ; moving the value of the eax register into the value variable doubleAnswer2 (unsigned)

;=====MOVZX=====
;	3. quadAnswer3 = byteVariable3
	movzx rax, byte[byteVariable3] ; moving and expanding a byte into a double word, moving into rax register (signed)
	mov qword[quadAnswer3],rax ; moving the rax register into the value part of the variable 

;	4. quadAnswer4 = doubleVariable4
	mov eax, dword[doubleVariable4] ; moving a double sized variable into eax register rax -> edx:eax (unsigned)
	mov qword[quadAnswer4], rax ; moving rax register into a quad variable 

;=====MOVSX=====
;	5. quadAnswer5 = doubleVariable5
	movsxd rax, dword[doubleVariable5] ; moving a double sized variable into rax register (signed)
	mov qword[quadAnswer5], rax ; moving rax register into quad sized variable  
	
;=====ADD=====
;  Adding two byte values together
	mov al, byte[byteExample1]	; moving a byte sized variable into al register
	add al, byte[byteExample2]	; adding al register and a byte sized variable, answer then goes into al register
	mov byte[byteExample3], al	; moving al register into a byte sized variable

;	6. wordAnswer6 = wordVariable6a + wordVariable6b
	mov ax, word[wordVariable6b] ; moving a word sized variable into ax register
	add ax, word[wordVariable6a] ; adding ax register with a word sized variable, answer then goes into ax register
	mov word[wordAnswer6], ax ; moving ax register into a word sized variable 

;	7. doubleAnswer7 = doubleAnswer7 + 2
	mov eax, 2 ; moving an immediate value into a eax, double sized register
	add eax, dword[doubleAnswer7]	; adding eax register with double sized variable, answer then goes into eax register
	mov dword[doubleAnswer7], eax	; moving eax register into double sixed variable

;=====SUB=====
;	8. quadAnswer8 = quadVariable8a - quadVariable8b
	mov rax, qword[quadVariable8a] ; moving a quad sized variable into rax register
	sub rax, qword[quadVariable8b] ; substracting rax register with quad variable; answer then goes into rax 
	mov qword[quadAnswer8], rax ; moving rax into quad sized variable 

;	9. doubleAnswer9 = doubleVariable9 - wordVariable9
	movzx ecx, word[wordVariable9] ; expanded a word into a double using ecx register 
	mov eax, dword[doubleVariable9] ; moved a double in into eax register
	sub eax, ecx ; subtracting eax register from ecx register, answer goes into eax register
	mov dword[doubleAnswer9], eax ; moved eax register into double variable

;=====INC=====
;	Using inc to increment a register
	inc ax

;=====DEC=====
;	Using dec to decrement a variable
	dec byte[byteExample4]
	
;=====MUL=====
;	Multiplying two words and storing the parts into a dword sized variable
	mov ax, word[wordExample1]
	mul word[wordExample2]
	mov word[doubleExample2], ax ; Stores the lower bits
	mov word[doubleExample2+2], dx	; Stores the upper bits

;	10. wordAnswer10 = byteVariable10a x byteVariable10b
	mov al, byte[byteVariable10a] ; moves byte variable into al register
	mul byte[byteVariable10b] ; multiplies al register by byte sized variable 
	mov word[wordAnswer10], ax ; ax -> ah:al so we can just move the ax into a word sized variable since ah and al make up ax we dont have to separate the two and merge them  

;	11. quadAnswer11 = doubleVariable11a x doubleVariable11b
	mov eax, dword[doubleVariable11a] ; moves double variable into eax register
	mul dword[doubleVariable11b] ; edx:eax multiplies double variable with eax register and lower half goes into eax upper edx
	mov dword[quadAnswer11], eax ; accessing lower 32 bits (4 bytes of memory) from quadAnswer11 and moving eax register into there
	mov dword[quadAnswer11+4], edx ; accessing upper 32 bits (4 bytes of memory) from quadAnswer11 and moving edx register into there

;	12. doubleQuadAnswer12 = quadVariable12a x quadVariable12b
	mov rax, qword[quadVariable12a] ; moves quad variable into rax register
	mul qword[quadVariable12b] ; rdx:rax multiplies quad variable with rax register and lower half goes into rax upper rdx
	mov qword[doubleQuadAnswer12], rax ; accessing lower 64 bits (8 bytes of memory) from doubleQuadAnswer12 and moving rax register into there
	mov qword[doubleQuadAnswer12+8], rdx ; accessing upper 64 bits (8 bytes of memory) from doubleQuadAnswer12 and moving rdx register into there

;=====IMUL=====

;	13. wordAnswer13 = byteVariable13 x -3
	mov al, -3 ; moves -3 into al register
	imul byte[byteVariable13] ; multiplies al by byte variable ; answer is is lower al and upper ah 
	mov word[wordAnswer13], ax ; ah and al make up ax so move ax into a word variable

;=====DIV=====

;	14. byteAnswer14 = byteVariable14a / byteVariable14b
;	      byteRemainder14 =  byteVariable14a % byteVariable14b
	mov ax, 0 ; zeroize the ax register so that the upper will be 0's
	mov al, byte[byteVariable14a] ; move a byte sized variable into al register
	div byte[byteVariable14b] ; divides al by a byte sized variable the answer is stored in al and the remainder is stored in ah
	mov byte[byteAnswer14], al ; moves the answer from al to a byte sized variable
	mov byte[byteRemainder14], ah ; moves the remainder from ah to a byte sized variable
	
;	15. wordAnswer15 = doubleVariable15 / wordVariable15
	mov ax, word[doubleVariable15] ; takes the lower word size out of a double and stores it in ax
	mov dx, word[doubleVariable15+2] ; takes the upper word size out of double variable and stores it in dx
	div word[wordVariable15] ; divides ax by a word sized variable; answer goes in ax and remainder goes in dx
	mov word[wordAnswer15], ax ; moves ax into a word sized variable
	
;	16. wordRemainder16 = wordVariable16a % wordVariable16b
	mov dx, 0 ; moves 0 into the upper portion of word 
	mov ax, word[wordVariable16a] ; moves word sized variable into ax register
	div word[wordVariable16b] ; divides ax register by a word sized variable answer stored into ax remainder into dx
	mov word[wordRemainder16], dx ; moves dx into word sized variable

;=====IDIV=====

;	17. byteAnswer17 = byteVariable17 / 5
	mov al, byte[byteVariable17] ; moves a byte sized variable into al register
	cbw ; signed extension al ax -> ah:al
	mov bl, 5 ; moves 5 into bl register
	idiv bl ; divides al by bl register answer in al register and remainder in ah register
	mov byte[byteAnswer17], al ; moves al register into byte sized variable

;	18. wordAnswer18 = (wordVariable18a x wordVariable18b) / wordVariable18c
	mov ax, word[wordVariable18a] ; moves a word sized variable into ax register
	imul word[wordVariable18b] ; multiplies ax register with a word sized variable (signed); answer is in ax register
	idiv word[wordVariable18c] ; divides ax register by a word sized variable; answer is in ax register and remainder is in dx register
	mov word[wordAnswer18], ax ; moves ax register into a word sized variable

;	19. doubleAnswer19 = doubleVariable19a / doubleVariable19b
;	      doubleRemainder19 = doubleVariable19a % doubleVariable19b
	mov eax, dword[doubleVariable19a] ; moves a double into eax register
	cdq ; eax -> edx : eax
	idiv dword[doubleVariable19b] ; divides eax by double variable answer goes into eax remainder goes into edx
	mov dword[doubleAnswer19], eax ; moves eax into double variable 
	mov dword[doubleRemainder19], edx ; moves edx into double variable

;	20. doubleRemainder20 = quadVariable20 % doubleVariable20
	mov eax, dword[quadVariable20] ; moves lower 32 bits of a quad into eax
	mov edx, dword[quadVariable20+4] ; moves upper 32 bits of a quad into edx
	idiv dword[doubleVariable20] ; divides eax by double variable 
	mov dword[doubleRemainder20], edx ; moves edx into double variable
	
	
endProgram:
; 	Outputs "Program Done." to the console
	mov rax, SERVICE_WRITE
	mov rdi, STANDARD_OUT
	mov rsi, programDone
	mov rdx, qword[stringLength]
	syscall

; 	Ends program with success return value
	mov rax, SERVICE_EXIT
	mov rdi, EXIT_SUCCESS
	syscall