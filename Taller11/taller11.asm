section .data
    msg_fecha db "Fecha: ", 0
    msg_email db "Email: ", 0
    msg_dir db "Direccion: ", 0
    msg_curp db "CURP: ", 0
    newline db 10, 0

section .bss
    buffer resb 100           ; Buffer general para operaciones

section .text
    global _start

; Macro para definir una fecha (DD/MM/YYYY)
%macro DEFINE_FECHA 3
    fecha_dia db %1, '/'      ; Día y separador
    fecha_mes db %2, '/'      ; Mes y separador
    fecha_anio db %3          ; Año
    fecha_len equ $ - fecha_dia
%endmacro

; Macro para definir un email
%macro DEFINE_EMAIL 2
    email_usuario db %1       ; Username
    email_arroba db '@'       ; @
    email_dominio db %2       ; Dominio.com
    email_len equ $ - email_usuario
%endmacro

; Macro para definir una dirección
%macro DEFINE_DIRECCION 4
    dir_calle db %1, ' '      ; Calle y espacio
    dir_num db %2, ' '        ; Número y espacio
    dir_col db %3, ' '        ; Colonia y espacio
    dir_cp db %4              ; Código postal
    dir_len equ $ - dir_calle
%endmacro

; Macro para definir CURP
%macro DEFINE_CURP 1
    curp_valor db %1          ; 18 caracteres de CURP
    curp_len equ $ - curp_valor
%endmacro

; Macro para imprimir cadena
%macro PRINT_STRING 2
    mov eax, 4                ; syscall write
    mov ebx, 1                ; stdout
    mov ecx, %1               ; mensaje
    mov edx, %2               ; longitud
    int 0x80
%endmacro

; Macro para imprimir fecha
%macro PRINT_FECHA 0
    PRINT_STRING msg_fecha, 7
    PRINT_STRING fecha_dia, fecha_len
    PRINT_STRING newline, 1
%endmacro

; Macro para imprimir email
%macro PRINT_EMAIL 0
    PRINT_STRING msg_email, 7
    PRINT_STRING email_usuario, email_len
    PRINT_STRING newline, 1
%endmacro

; Macro para imprimir dirección
%macro PRINT_DIRECCION 0
    PRINT_STRING msg_dir, 11
    PRINT_STRING dir_calle, dir_len
    PRINT_STRING newline, 1
%endmacro

; Macro para imprimir CURP
%macro PRINT_CURP 0
    PRINT_STRING msg_curp, 6
    PRINT_STRING curp_valor, curp_len
    PRINT_STRING newline, 1
%endmacro

; Definimos los datos usando las macros
DEFINE_FECHA "15", "03", "2024"
DEFINE_EMAIL "usuario.123", "gmail.com"
DEFINE_DIRECCION "Calle Principal", "123", "Centro", "12345"
DEFINE_CURP "MAAA990101HDFRTL09"

_start:
    ; Imprimimos todos los datos
    PRINT_FECHA
    PRINT_EMAIL
    PRINT_DIRECCION
    PRINT_CURP

    ; Salir del programa
    mov eax, 1
    xor ebx, ebx
    int 0x80
