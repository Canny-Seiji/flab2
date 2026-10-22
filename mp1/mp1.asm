
    ; =========================================================
    ; Mystic Zodiac Oracle
    ; NASM x86 32-bit Assembly for Linux
    ; Stage 1: Welcome Screen
    ; =========================================================

    section .data
        welcome_msg db 10
                    db "========================================", 10
                    db "       MYSTIC ZODIAC ORACLE", 10
                    db "========================================", 10
                    db " Welcome to the Zodiac Horoscope System!", 10
                    db " Discover your zodiac and fortune.", 10
                    db "========================================", 10, 10

        welcome_len equ $ - welcome_msg


    section .text
        global _start

    _start:
        call display_welcome

        call exit_program


    ; ---------------------------------------------------------
    ; Procedure: display_welcome
    ; Purpose: Display the program's welcome screen.
    ; Preserves: EBX
    ; ---------------------------------------------------------
    display_welcome:
        push ebx

        mov eax, 4              ; sys_write
        mov ebx, 1              ; standard output
        mov ecx, welcome_msg    ; address of message
        mov edx, welcome_len    ; number of bytes
        int 0x80

        pop ebx
        ret


    ; ---------------------------------------------------------
    ; Procedure: exit_program
    ; Purpose: Terminate the program.
    ; Does not return.
    ; ---------------------------------------------------------
    exit_program:
        mov eax, 1              ; sys_exit
        mov ebx, 0              ; exit status: success
        int 0x80
