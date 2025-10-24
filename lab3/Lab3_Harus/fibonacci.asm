extern printf
extern scanf

section .data
    prompt_msg db "Введіть номер числа Фібоначчі (0-93): ", 0
    format_in  db "%d", 0
    result_msg db "Число Фібоначчі №%d дорівнює %llu", 10, 0

section .bss
    input_n resq 1 ; Резервуємо 8 байт для введеного числа

section .text
global main

; Функція для рекурсивного обчислення Фібоначчі
fibonacci:
    push rbp
    mov rbp, rsp

    cmp rdi, 0
    je .return_0
    cmp rdi, 1
    je .return_1

    dec rdi
    push rdi
    call fibonacci
    pop rdi

    push rax

    dec rdi
    call fibonacci

    pop rbx
    add rax, rbx

    jmp .end

.return_0:
    mov rax, 0
    jmp .end

.return_1:
    mov rax, 1

.end:
    mov rsp, rbp
    pop rbp
    ret

; Головна функція програми
main:
    push rbp
    mov rbp, rsp

    mov rdi, prompt_msg
    call printf

    mov rdi, format_in
    mov rsi, input_n
    call scanf

    mov rdi, [input_n]
    call fibonacci

    mov rdi, result_msg
    mov rsi, [input_n]
    mov rdx, rax
    call printf

    mov rax, 0
    leave
    ret