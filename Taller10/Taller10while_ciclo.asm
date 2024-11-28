section .data
    sum dd 0    ; Variable para almacenar la suma
    count dd 1  ; Contador inicializado en 1

section .text
    global _start

_start:
    mov eax, [count]     ; Carga count en eax
while:
    cmp eax, 10         ; Compara count con 10
    jle sumar           ; Si count <= 10, salta a sumar
    jmp fin             ; Si no, termina el programa

sumar:
    add [sum], eax      ; Suma count a sum
    inc eax             ; Incrementa count
    mov [count], eax    ; Actualiza count en memoria
    jmp while           ; Vuelve al inicio del bucle

fin:
    ; Aquí el programa termina
    mov eax, 1          ; Código de salida del sistema
    int 0x80           ; Llamada al sistema para terminar