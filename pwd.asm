section .data
	back db "..", 0
	curr db ".", 0
	slash db "/", 0
	; declare global vars here

section .text
	global pwd

;;	void pwd(char **directories, int n, char *output)
;	Adauga in parametrul output path-ul rezultat din
;	parcurgerea celor n foldere din directories

; nu am stiut ca la acest task am voie sa folosesc move
; asa ca am reusit sa rezolv fara move :))
pwd:
	enter 0, 0

	push DWORD [esp + 8]
	pop edx

	push DWORD [esp + 12]
	pop ecx

	push DWORD [esp + 16]
	pop esi

	push ebx

pozitie:


	for_1:
		cmp ecx, 0
		je end_for_1

		xor eax, eax
		or eax, [edx]

		xor ebx, ebx
		or ebx, [eax]

		cmp bl, '.'
		je point

		and BYTE [esi], 0
		or BYTE [esi], '/'
		inc DWORD esi

		for_2:
			xor ebx, ebx
			or ebx, [eax]

			cmp bl, 0
			je increment1

			and BYTE [esi], 0
			or BYTE [esi], bl
			inc DWORD esi

		increment2:
			inc DWORD eax
			jmp for_2

	increment1:
		add DWORD edx, 4
		dec ecx
		jmp for_1

	end_for_1:

	jmp end_point
	point:
		cmp bh, '.'
		jne increment1

		remove_word:
			cmp BYTE [esi], '/'
			je increment1

			dec esi
			jmp remove_word

	end_point:



	and BYTE [esi], 0
	or BYTE [esi], '/'
	inc DWORD esi

	and BYTE [esi], 0
	or BYTE [esi], 0
	inc DWORD esi

	pop ebx

	leave
	ret