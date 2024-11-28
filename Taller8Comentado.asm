section .data
    msg db 'Resultado: ', 0 ; Mensaje inicial
    newline db 0xA          ; Define el carácter de nueva línea (ASCII 10)

section .bss
    res resb 4              ; Reserva 4 bytes para almacenar el resultado

section .text
global _start
_start:
    ; PASO 1: Operaciones aritméticas iniciales
    mov eax, 10            ; EAX = 10 (decimal)
    mov ebx, 5             ; EBX = 5
    add eax, ebx           ; EAX = EAX + EBX = 15

    ; PASO 2: Operación Lógica AND
    and eax, 0xF           ; EAX = EAX AND 0xF
                            ; 15 AND 15 = 15 (1111 AND 1111 = 1111)

    ; PASO 3: Desplazamiento de bits a la izquierda
    shl eax, 1             ; Desplaza 1 bit a la izquierda
                            ; 1111 -> 11110 = 30 en decimal

    ; PASO 4: Guardar resultado
    mov [res], eax         ; Guarda 30 en la variable 'res'

    ; PASO 5: Imprimir mensaje "Resultado:"
    mov eax, 4             ; Syscall 4 = write
    mov ebx, 1             ; File descriptor 1 = STDOUT
    mov ecx, msg           ; Puntero al mensaje
    mov edx, 12            ; Longitud del mensaje
    int 0x80               ; Llamada al sistema

    ; PASO 6: Convertir y mostrar el número
    mov eax, [res]         ; EAX = 30
    add eax, 48            ; Convierte a ASCII sumando 48 ('0')
    mov [res], eax         ; Guarda el carácter 'N' en res

    mov eax, 4             ; Syscall write
    mov ebx, 1             ; STDOUT
    mov ecx, res           ; Puntero al resultado
    mov edx, 1             ; Imprime 1 byte
    int 0x80               ; Llamada al sistema

    ; PASO 8: Imprimir nueva línea
    mov eax, 4             ; Syscall write
    mov ebx, 1             ; STDOUT
    mov ecx, newline       ; Puntero a nueva línea
    mov edx, 1             ; Imprime 1 byte
    int 0x80               ; Llamada al sistema

    ; PASO 9: Terminar programa
    mov eax, 1             ; Syscall 1 = exit
    mov ebx, 0             ; Código de salida 0
    int 0x80               ; Llamada al sistema
