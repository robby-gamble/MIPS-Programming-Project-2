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


addi $t7,$t7,0      #initializing my counter
addi $t6,$t6,1      #1: continues loopiing, 0: haults the loop
addi $t5,$t5,1      #exponent of base- 33
addi $t4,$t4,0      #length of my string



#Get rid of my trailing Spaces

jal lengthOfString #First I'll need to figure out the lenght of my string.
li $t7,0            #setting my counter to 0
sub $t7, $t4,1
trailSpaces:



Invalid:



lengthOfString:
li $t4,0                          #setting the intital value of my string's length to 0 string length
count: li $t3,0
addu $t3,$t3,$t7                  #$t3 = my iterator
addu $t3,$t3,$a1                  #$t3 = position in my string
lbu $a2,($t3)                     #loads position to $a2
beq $a2,0,exit                    #check for a NULL value
addi $t7,$t7,1                    #increment my iterator by 1
addi $t4,$t4,1                    #increaseing the value of my string length by 1
j count                           #restarts my count loop
exit: jr $ra



Calcuate:



