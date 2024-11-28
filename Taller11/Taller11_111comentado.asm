; Programa que suma dos números y muestra el resultado
; Arquitectura: x86
; Sistema Operativo: Linux (usa interrupciones 0x80)

section .data
    ; Declaración de variables inicializadas
    num1 db 5            ; Primera variable, valor = 5
    num2 db 11           ; Segunda variable, valor = 11
    result db 0          ; Variable para almacenar el resultado
    message db "Resultado: ", 0   ; Mensaje a mostrar (null-terminated)

section .bss
    ; Declaración de variables no inicializadas
    buffer resb 4        ; Reserva 4 bytes para convertir números a caracteres

section .text
    global _start

; Macro para imprimir una cadena
; Parámetro 1: dirección de la cadena a imprimir
%macro PRINT_STRING 1
    mov eax, 4           ; Syscall 4 = write
    mov ebx, 1           ; File descriptor 1 = stdout
    mov ecx, %1          ; Puntero al mensaje
    mov edx, 13          ; Longitud del mensaje
    int 0x80             ; Llamada al sistema
%endmacro

; Macro para imprimir un número
; Parámetro 1: número a imprimir
%macro PRINT_NUMBER 1
    mov eax, %1          ; Mueve el número a eax
    add eax, '0'         ; Convierte el número a su representación ASCII
    mov [buffer], eax    ; Guarda el carácter en el buffer
    mov eax, 4           ; Syscall 4 = write
    mov ebx, 1           ; File descriptor 1 = stdout
    mov ecx, buffer      ; Puntero al buffer
    mov edx, 1           ; Longitud = 1 byte
    int 0x80             ; Llamada al sistema
%endmacro

_start:
    ; Suma los dos números
    mov al, [num1]       ; Carga el primer número en al
    add al, [num2]       ; Suma el segundo número
    mov [result], al     ; Guarda el resultado

    ; Imprime el mensaje y el resultado
    PRINT_STRING message  ; Imprime "Resultado: "
    PRINT_NUMBER [result] ; Imprime el número resultante

    ; Termina el programa
    mov eax, 1           ; Syscall 1 = exit
    mov ebx, 0           ; Código de retorno 0 = éxito
    int 0x80             ; Llamada al sistema para terminar
