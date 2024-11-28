section .data
    num1 db 5              ; Definir num1 como byte con valor 5
    num2 db 11             ; Definir num2 como byte con valor 11
    result db 0            ; Definir result como byte inicialmente en 0
    msg db 'Resultado: ', 0 ; Mensaje que se imprimirá seguido de carácter nulo

section .bss
    buffer resb 4          ; Reservar 4 bytes de memoria para almacenar un valor

section .text
global _start              ; Punto de entrada del programa

_start:
    mov al, [num1]         ; Mover el valor de num1 al registro AL
    add al, [num2]         ; Sumar el valor de num2 a AL
    mov [result], al       ; Almacenar el resultado en la variable result

    ; Convertir el resultado a ASCII
    movzx eax, byte [result] ; Mover el valor de result a EAX y extender a 32 bits
    add eax, 48            ; Convertir el valor numérico en su correspondiente ASCII ('0' = 48)
    mov [buffer], al       ; Almacenar el carácter ASCII resultante en el buffer

    ; Imprimir el mensaje 'Resultado:'
    mov eax, 4             ; Syscall para escribir (sys_write)
    mov ebx, 1             ; File descriptor (1 = salida estándar)
    mov ecx, msg           ; Dirección del mensaje a imprimir
    mov edx, 12            ; Longitud del mensaje
    int 0x80               ; Interrupción del sistema

    ; Imprimir el resultado
    mov eax, 4             ; Syscall para escribir (sys_write)
    mov ebx, 1             ; File descriptor (1 = salida estándar)
    mov ecx, buffer        ; Dirección del buffer donde está el carácter a imprimir
    mov edx, 1             ; Longitud del carácter
    int 0x80               ; Interrupción del sistema

    ; Terminar el programa
    mov eax, 1             ; Syscall para salir (sys_exit)
    mov ebx, 0             ; Código de salida 0
    int 0x80               ; Interrupción del sistema
