.data
sum: .word  0 #I will use this to store the value of the users input
message1: .asciiz "Input\n" #I'll need this to communicate with the user
message2: .asciiz "Output\n" #I'll display this after I finish converting everything.
message3: .asciiz "Invalid Input.\n" #I'll display this aft
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
li $t3, 0
addu $t3,$t3,$t7                           #$t0 = x
addu $t3,$t3,$a1                           #$t0 = $a1 at position x
lbu $a2,0($t3)                             #load $t0 to $a2
bgt $a2,32,endtrailSpaces                      #if a2 is greater than 32, jump to endTrail
subu $t7,$t7,1                             #decrement x by 1
j trailSpaces                              #starts the loop over
endtrailSpaces:   jal calculate                #jump to calculate



Invalid:

li $v0,4                        #going to print a string
li $a0,0                        #a0 = 0
la $a0, message2                #loads message2
syscall                         #executes

li $v0,4
li $a0,0
la $a0, message3                #Loads message 3
syscall

li $v0, 10
syscall                         #terminates Program





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

constants:

li $t0, 87                   #will use this value to subtract 87 from my lowercse letters
li $t1,55                    #will use this value to subtract 55 from my upper case letters
li $t2,48                    # will use this value to subtract 48 from the value of my numbers
li $t6, 0                    #Cheking my string length.

li $t8,33                    #base 33 :]




calcuate:

li $t3,0

addu $t3, $t3, $t7          #adds x to t3
addu $t3, $t3, $a1          #t3 now has the value at a[x]
lbu $a2, ($t3)              #load ascii value of $t3 to $a2

bltz $t3,EndProgram                  #If position x is less than 0
ble $a2,32,Decision         #If a2 <= 32 jump to choice
beq $t6,4, OutofRange       #If $t6 is 4 then it is out of range.

bgt $a2,119,OutofRange      #if a2 is larger than 119 it is not in my base system

bge $a2,97, SubtractLower   #if a2 is less than 119 and more than 97 go to Subtractlower function

btg $a2,87, OutofRange
bge $a2,65, SubtractUpper  #If a2 is less han 87 and more than 65 got to SubtractUpper

bge $a2,57,OutofRange
bge $a2,48,SubtractNumber  #If a2 is less than 57 and more than 48 jump to Subtract Number.

j OutofRange               #If a2 is less than 48 jump to out of range





SubtractUpper:
subu $a2,$a2,$t1                #subtract 55 to et the decimal value

SubtractLower:                  #subtract 87 to get the decimal value
subu $a2,$a2,$t0


SubtractNumber:
subu $a2,$a2,$t2                #subtract 48 to get decimal value

DoMath: multu $a2,$t5           #Multiplying by 33 raised to my exponent.
mflo $a2                        #Stores previous math into a2

addu $a0,$a0,$a2                #adds current summation to my final sum
multu $t5,$t8                   #incrementing my exponent

mflo $t5                        #stores previous math into t3

subu $t7,$t7,1                  #increment x
addu $t6,$t6,1                  #increment length

j calculate                     #starts at the beginning of calculate


OutofRange:
j Invalid       #Prints invalid





Decide:
beq $t6, 4, EndProgram      #when the end is reached ends program
j OutofRange                #if it doesnt reach the end jump to out of range

EndProgram: jr $ra





