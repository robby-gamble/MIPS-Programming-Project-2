.data
sum: .word  0 #I will use this to store the value of the users input
message1: .asciiz "Input your characters" #I'll need this to communicate with the user
message2: .asciiz "This is the value of your characters.\n" #I'll display this after I finish converting everything.
buffer: .space 1001

.text
main:

#I'm about to ask the user to input 10 characters
li $v0, 4   #Command to print a string
la $a0, message1    #Loading the string into the argument to enable printing
syscall #executing command


li $v0, 8 #Command to read a string
la $a0, buffer #storing space for the string
li $a1, 1001 #allocating byte space for string to be stored
syscall #executing command

