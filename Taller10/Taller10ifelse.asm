section .data
    num dd 8              ; Número a comprobar
    result_even db "El numero es par", 0
    result_odd  db "El numero es impar", 0

section .text
    global _start

_start:
    ; Cargar el valor de num en eax
    mov eax, [num]
    
    ; Comprobar si es par usando AND
    test eax, 1          ; AND con 1 para verificar el bit menos significativo
    jz es_par            ; Si el resultado es cero (ZF=1), el número es par
    
    ; Si llegamos aquí, el número es impar
    mov ebx, result_odd
    jmp fin
    
es_par:
    mov ebx, result_even
    
fin:
    ; Aquí ebx contiene el puntero al mensaje correspondiente
    
    mov eax, 1        
    int 0x80            