section .data
    numeros dd 5, 8, 12, 3, -4, 6, 7  ; Lista de números
    sum dd 0                          ; Variable para la suma
    
section .text
    global _start

_start:
    mov esi, numeros    ; ESI apunta al inicio de la lista
    mov ebx, [sum]      ; EBX almacenará nuestra suma

do_while:
    mov eax, [esi]      ; Cargar el número actual en EAX
    add ebx, eax        ; Añadir el número a la suma
    add esi, 4          ; Mover el puntero al siguiente número (4 bytes)
    
    cmp eax, 0          ; Comparar el número con 0
    js do_while         ; Si no es negativo (JS = Jump if Sign), continuar el bucle

fin:
    mov [sum], ebx      ; Guardar el resultado final en sum
    mov eax, 1          ; Código de salida
    int 0x80           ; Llamada al sistema para terminar