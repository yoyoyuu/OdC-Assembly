section .data
    numero db 0       ; Variable para almacenar cada dígito
    newline db 10     ; Salto de línea (ASCII 10)

section .bss
    digit resb 1      ; Reserva 1 byte para el dígito convertido

section .text
    global _start

_start:
    mov ecx, 10       ; Inicializamos el contador en 10
    
bucle:
    ; Guardar el valor de ecx porque lo necesitaremos
    push ecx
    
    ; Convertir el número a ASCII
    add ecx, 48       ; Convertir a ASCII (48 es '0' en ASCII)
    mov [digit], cl   ; Guardar el dígito
    
    ; Imprimir el número
    mov eax, 4        ; syscall write
    mov ebx, 1        ; stdout
    mov ecx, digit    ; dirección del dígito
    mov edx, 1        ; longitud (1 byte)
    int 0x80
    
    ; Imprimir salto de línea
    mov eax, 4        ; syscall write
    mov ebx, 1        ; stdout
    mov ecx, newline  ; dirección del salto de línea
    mov edx, 1        ; longitud (1 byte)
    int 0x80
    
    ; Recuperar el contador
    pop ecx
    
    ; Decrementar el contador
    dec ecx
    
    ; Comparar si hemos llegado a 0
    cmp ecx, 0
    jg bucle          ; Si ecx > 0, continuar el bucle
    
    ; Terminar el programa
    mov eax, 1       
    mov ebx, 0       
    int 0x80
