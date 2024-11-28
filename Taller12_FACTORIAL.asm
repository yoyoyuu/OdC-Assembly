; -----------------------------------------------------
; Programa: Calculadora de Factorial
; Objetivo: Calcular el factorial de un número ingresado
;           por el usuario (1-8)
; Lopez Cisneros Isis Vanesa
; Organización de computadoras - Taller 12
; -----------------------------------------------------
section .data
    msg_input db 'Ingrese un numero (1-9): ', 0
    len_input equ $ - msg_input
    msg_result db 'El factorial es: ', 0
    len_result equ $ - msg_result
    newline db 10

section .bss
    num resb 2      ; Buffer para entrada
    result resb 8   ; Buffer para resultado

section .text
    global _start

_start:
    ; Imprimir mensaje de entrada
    mov eax, 4      ; syscall write
    mov ebx, 1      ; stdout
    mov ecx, msg_input
    mov edx, len_input
    int 80h

    ; Leer número
    mov eax, 3      ; syscall read
    mov ebx, 0      ; stdin
    mov ecx, num
    mov edx, 2
    int 80h

    ; Convertir ASCII a número
    movzx eax, byte [num]
    sub eax, '0'    ; Convertir ASCII a número

    ; Calcular factorial
    mov ebx, eax    ; Copiar número a ebx
    dec ebx         ; Decrementar para empezar loop

factorial_loop:
    cmp ebx, 0      ; Si llegamos a 0
    je print_prep   ; Terminar el cálculo
    mul ebx         ; Multiplicar eax por ebx
    dec ebx         ; Decrementar contador
    jmp factorial_loop

print_prep:
    mov edi, eax    ; Guardar resultado en edi 
    
    ; Imprimir mensaje de resultado
    mov eax, 4      ; syscall write
    mov ebx, 1      ; stdout
    mov ecx, msg_result
    mov edx, len_result
    int 80h

    mov eax, edi    ; Recuperar resultado 

    ; Convertir número a ASCII
    mov ecx, 10     ; Divisor
    mov ebx, result ; Puntero al final del buffer
    add ebx, 7      ; Mover al final
    mov byte [ebx], 0 ; Terminator
    dec ebx
    mov byte [ebx], 10 ; Newline

convert_loop:
    xor edx, edx    ; Limpiar edx para división
    div ecx         ; Dividir eax por 10
    add dl, '0'     ; Convertir residuo a ASCII
    dec ebx         ; Mover puntero
    mov [ebx], dl   ; Guardar dígito
    test eax, eax   ; Ver si quedan más dígitos
    jnz convert_loop

    ; Imprimir resultado
    mov eax, 4      ; syscall write
    mov ecx, ebx    ; Usar puntero donde quedamos
    mov ebx, 1      ; stdout
    mov edx, result ; Calcular longitud
    add edx, 8
    sub edx, ecx
    int 80h

    ; Salir
    mov eax, 1      ; syscall exit
    xor ebx, ebx    ; código de retorno 0
    int 80h