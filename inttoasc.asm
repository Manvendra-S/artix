section .bss
    num_str resb 11   ; Buffer to store the ASCII representation of the integer (up to 10 digits + null terminator)

section .text
    global start

start:
    ; Test the program for various values of n

    ; Test case 1: n = 123
    mov edi, 123
    mov rsi, num_str
    call int_to_ascii
    ; Display the result
    mov rdi, 1        ; File descriptor (stdout)
    mov rdx, 11       ; Length of the string to be printed (including null terminator)
    mov rax, 1        ; Syscall number for sys_write
    syscall          ; Invoke the syscall to print the result

    ; Test case 2: n = -456
    mov edi, -456
    mov rsi, num_str
    call int_to_ascii
    ; Display the result
    mov rdi, 1        ; File descriptor (stdout)
    mov rdx, 11       ; Length of the string to be printed (including null terminator)
    mov rax, 1        ; Syscall number for sys_write
    syscall          ; Invoke the syscall to print the result

    ; Exit the program
    mov eax, 60       ; Syscall number for sys_exit
    xor edi, edi      ; Return code 0
    syscall          ; Invoke the syscall to exit the program

int_to_ascii:
    mov rbx, 10        ; Base 10
    mov rdi, rsi       ; Destination pointer (rsi points to num_str)
    add rdi, 10        ; Move rdi to the end of the buffer (before the null terminator)

    test edi, edi      ; Check if n is negative
    jns positive       ; If not negative, skip the negation part

    neg edi            ; Negate the number (make it positive)
    mov byte [rsi], '-'  ; Place a '-' sign at the beginning of the string
    inc rsi            ; Move the pointer to the next byte
    dec rdx            ; Decrease the length of the string to print

positive:
    mov qword [rdi], 0 ; Null-terminate the string

convert_loop:
    dec rdi            ; Move the pointer back
    xor rdx, rdx       ; Clear the remainder
    div rbx            ; Divide by 10 (n / 10, remainder in rdx)
    add dl, '0'        ; Convert the remainder to ASCII
    mov [rdi], dl      ; Store the digit in the buffer
    test rax, rax
    jnz convert_loop   ; If quotient (n / 10) is not zero, continue the loop

    ret