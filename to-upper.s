
.file "To_Upper.s"
.text
.globl To_Upper
.type To_Upper, @function

/* **********************
    Name: Dylan Krejci
    Wisc ID Number: 902312373
    Wisc Email: dkrejci@wisc.edu
************************ */


To_Upper:

# C version
/* **********************
    Write the equivalent C code to this function here (in the comment block)

    char* toUpper(char* str) {
        while (*str) {
            if (*str >= 97 && *str <= 122) {
                *str -= 32;
            }
            str++;
        }
        return str;
    }

************************ */


# Memory Layout
/* ************************
    Make a table showing the stack frame for your function (in the comment block)
    The first column should have a memory address (e.g. 8(%rsp))
    The second column should be the name of the C variable used above
    Update the example below with your variables and memory addresses

        -8(%rbp) |  char* str

************************ */

# Prologue

    pushq %rbp          # Store original base pointer on the stack
    movq %rsp, %rbp     # Move base pointer to original stack pointer
    subq $32, %rsp      # Allocate 32 bytes onto stack

# This code prints the letter 'a' (ascii value 97)
# Use this for debugging
# Comment out when finished - your function should not print anything
# Note putchar overwrites all caller saved registers including argument registers
        #movl $97, %eax
        #movl %eax, %edi
        #call putchar@PLT

# Body of function

START:
    movq %rax, -8(%rbp) # store pointer on stack (str)
    movb (%rax), %cl    # store character pointed to in %cl (*str)
    jmp CONDITIONAL     # jump to conditional

LOOP:
    cmpb $97, %cl       # *str - 97
    jl INCREMENT        # if above statement is < 0, jump to increment
    cmpb $122, %cl      # *str - 122
    jg INCREMENT        # if above statement is > 0, jump to increment
    subb $32, (%rax)    # if character is between 97 and 122, it is lower case.
                        # subtract 32 to convert to upper case

INCREMENT:
    incq %rax           # advance pointer to next character (str++)
    movb (%rax), %cl    # store new character being pointed to in %cl (*str)

CONDITIONAL:
    testb %cl, %cl      # if (char != NULL)
    jnz LOOP            # if character is non-zero, jump to loop

DONE:


# Epilogue
    addq $32, %rsp      # Deallocate stack frame
    popq %rbp           # Reset base pointer to original value
    ret                 # Return contents of %rax
