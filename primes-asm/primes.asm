SECTION .text
	global _start

_start:
	mov ebx,2	;	set ebx to 2, because no one cares about 1

iloopstart:
	cmp ebx,10000	;	set max to 10k
	je quit		;	quit if we hit 10k
	mov ecx,ebx	;	copy the outer loop counter to ecx
	mov edx,0	;	zero out edx
	mov eax,ebx	;	copy outer loop counter to eax
	dec ecx		;	decrement inner loop counter by 1

innerloop:
	cmp ecx,0	;	is inner loop counter 0?
	je next		;	start next loop cycle
	mov edx,0	;	clear edx
	mov eax,ebx	;	copy outer loop to eax
	div ecx		;	divide eax by ecx, leaving quo in eax and rem in edx
	cmp edx,0	;	is edx 0?
	je testprime	;	if it is see if ebx is a prime number
	dec ecx		;	decerment inner loop counter by 1
	jmp innerloop	;	next inner loop cycle

testprime:
	cmp ecx,1	;	is the divisor 1?
	je isprime	;	if it is, eax is prime!
	jmp next	;	start next outer loop cycle

isprime:
	call iprintLF	;	print out eax!
	jmp next	;	next outer loop cycle

next:
	inc ebx		;	increment outer loop counter by 1
	jmp iloopstart	;	start a new inner loop set







iprint:
    push    eax             ; preserve eax on the stack to be restored after function runs
    push    ecx             ; preserve ecx on the stack to be restored after function runs
    push    edx             ; preserve edx on the stack to be restored after function runs
    push    esi             ; preserve esi on the stack to be restored after function runs
    mov     ecx, 0          ; counter of how many bytes we need to print in the end
 
divideLoop:
    inc     ecx             ; count each byte to print - number of characters
    mov     edx, 0          ; empty edx
    mov     esi, 10         ; mov 10 into esi
    idiv    esi             ; divide eax by esi
    add     edx, 48         ; convert edx to it's ascii representation - edx holds the remainder after a divide instruction
    push    edx             ; push edx (string representation of an intger) onto the stack
    cmp     eax, 0          ; can the integer be divided anymore?
    jnz     divideLoop      ; jump if not zero to the label divideLoop
 
printLoop:
    dec     ecx             ; count down each byte that we put on the stack
    mov     eax, esp        ; mov the stack pointer into eax for printing
    call    sprint          ; call our string print function
    pop     eax             ; remove last character from the stack to move esp forward
    cmp     ecx, 0          ; have we printed all bytes we pushed onto the stack?
    jnz     printLoop       ; jump is not zero to the label printLoop
 
    pop     esi             ; restore esi from the value we pushed onto the stack at the start
    pop     edx             ; restore edx from the value we pushed onto the stack at the start
    pop     ecx             ; restore ecx from the value we pushed onto the stack at the start
    pop     eax             ; restore eax from the value we pushed onto the stack at the start
    ret


;------------------------------------------
; void iprintLF(Integer number)
; Integer printing function with linefeed (itoa)
iprintLF:
    call    iprint          ; call our integer printing function
 
    push    eax             ; push eax onto the stack to preserve it while we use the eax register in this function
    mov     eax, 0Ah        ; move 0Ah into eax - 0Ah is the ascii character for a linefeed
    push    eax             ; push the linefeed onto the stack so we can get the address
    mov     eax, esp        ; move the address of the current stack pointer into eax for sprint
    call    sprint          ; call our sprint function
    pop     eax             ; remove our linefeed character from the stack
    pop     eax             ; restore the original value of eax before our function was called
    ret

; void sprintLF(String message)
;print with a linefeed
sprintLF:
        call    sprint

        push    eax
        mov     eax,0Ah
        push    eax
        mov     eax,esp
        call    sprint
        pop     eax
        pop     eax
        ret

; void sprint(String message)
; print a string
sprint:
        push    edx
        push    ecx
        push    ebx
        push    eax
        call    slen

        mov     edx,eax
        pop     eax

        mov     ecx,eax
        mov     ebx, 1
        mov     eax,4
        int     80h

        pop     ebx
        pop     ecx
        pop     edx
        ret

;int slen(String message)
; calc str len
slen:
        push    ebx
        mov     ebx, eax

nextchar:
        cmp     byte [eax], 0
        jz      finished
        inc     eax
        jmp     nextchar

finished:
        sub     eax,ebx
        pop     ebx
        ret

;void exit()
; exit program
quit:
        mov     ebx,0
        mov     eax,1
        int     80h
        ret
