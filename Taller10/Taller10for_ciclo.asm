section .data
    product dw 1    ; Variable para almacenar el resultado
    i dw 1         ; Variable contador

section .text
    global _start

_start:
    mov ax, 1      ; producto = 1
    mov [product], ax
    mov ax, 1      ; i = 1
    mov [i], ax

bucle_for:
    mov ax, [i]
    cmp ax, 5      ; Compara i con 5
    jg fin_bucle   ; Si i > 5, salta a fin_bucle

    ; Multiplicar product por i
    mov ax, [product]
    mov bx, [i]
    mul bx         ; ax = ax * bx
    mov [product], ax

    ; Incrementar i
    mov ax, [i]
    inc ax         ; i++
    mov [i], ax

    ; Volver al inicio del bucle
    jmp bucle_for

fin_bucle:
    ; Aquí el resultado está en la variable product

    mov eax, 1     
    mov ebx, 0      
    int 0x80   