extern string_equals
global find_word

section .text
find_word:
  push r15
.loop:
  cmp rsi, 0
  je .end
  mov r15, rsi
  add rsi, 8
  call string_equals
  cmp rax, 0
  je .next_word
  mov rax, r15
  jmp .end
.next_word:
  mov rsi, qword[r15]
  jmp .loop
.end:
  pop r15
  ret
