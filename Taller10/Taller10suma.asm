section .data
    num1 db 0          ; Primer número (0-9)
    num2 db 0          ; Segundo número (0-9)
    result db 0        ; Variable para almacenar el resultado
    msg db "Resultado: ", 0
    msgLen equ $ - msg
    resultStr db "0", 0   ; Buffer para el resultado + salto de línea
    zeroMsg db "Esto es un cero", 0
    zeroMsgLen equ $ - zeroMsg

section .text
global _start

_start:
    ; Realizar la suma
    mov al, [num1]     ; Cargar primer número en al
    add al, [num2]     ; Sumar segundo número
    mov [result], al   ; Guardar resultado

    ; Verificar si el resultado es cero
    cmp al, 0
    je print_zero

    ; Convertir resultado a ASCII
    add al, '0'        ; Convertir a ASCII
    mov [resultStr], al

    ; Imprimir mensaje inicial
    mov eax, 4         ; sys_write
    mov ebx, 1         ; stdout
    mov ecx, msg       ; mensaje
    mov edx, msgLen    ; longitud
    int 0x80

    ; Imprimir resultado
    mov eax, 4
    mov ebx, 1
    mov ecx, resultStr
    mov edx, 2         ; longitud (número + salto de línea)
    int 0x80
    jmp exit_program

print_zero:
    ; Imprimir mensaje "Esto es un cero"
    mov eax, 4
    mov ebx, 1
    mov ecx, zeroMsg
    mov edx, zeroMsgLen
    int 0x80

exit_program:
    ; Terminar programa
    mov eax, 1        
    xor ebx, ebx      
    int 0x80