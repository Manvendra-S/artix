section .data
    newline db 10
    output_msg db "The Fibonacci number at position %d is: %d", 0

section .bss
    n resb 4
    fib resb 4

section .text
    global main
    extern printf

main:
    ; Read the input value of n from the command line argument
    mov eax, [esp + 8]    ; Get the first command line argument (n)
    mov [n], eax

    ; Calculate the Fibonacci number
    mov ebx, 0            ; Initialize the first number (fib(0))
    mov ecx, 1            ; Initialize the second number (fib(1))

    cmp eax, 1
    jbe display_result   ; If n is 0 or 1, directly display the result

calculate_fibonacci:
    add ebx, ecx          ; ebx = ebx + ecx (fib(n) = fib(n-1) + fib(n-2))
    xchg ebx, ecx         ; Swap ebx and ecx for the next iteration
    dec dword [n]         ; Decrement n
    cmp dword [n], 1
    jae calculate_fibonacci

display_result:
    ; Display the result
    push eax
    push ebx
    push dword output_msg
    call printf

    ; Exit the program
    mov eax, 0
    ret
