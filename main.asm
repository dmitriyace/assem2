global _start
extern read_word
extern find_word
extern string_length
extern print_string
extern print_newline
extern exit

section .text
%include "colon.inc"

section .data
msg: db "No such word in the dictionary", 0
buffer: times 256 db 0x00
%include "words.inc"

section .text
_start:
    mov rdi, buffer
    mov rsi, 256
    call read_word
    mov rdi, rax
    mov rsi, next_word
    call find_word
    cmp rax, 0
    je .err
    add rax, 8
    mov rdi, rax
    push rdi
    call string_length
    pop rdi
    add rdi, rax
    inc rdi
    call print_string
    call print_newline
    call exit
.err:
    mov rdi, msg
    call string_length
    mov rsi, rdi
    mov rdi, 2
    mov rdx, rax
    mov rax, 1
    syscall
    call exit