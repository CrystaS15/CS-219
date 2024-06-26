#  CS 219
#  MIPS Provided Example Program

#  Example program to display a list of
#  numbers and find the mimimum and maximum.


###########################################################
#  data segment

.data

list:	.word	 101,  342,   83,  454,  125,  456,  147,  788,  129,  110
	.word	 332,  351,  376,  387,  390,  400,  411,  423,  432,  435
	.word	  42,   51,   76,   87,   90,  100,  111,  123,  132,  145
	.word	 102,  113,  122,  139,  144,  151,  161,  178,  186,  197
	.word	 206,  212,  222,  231,  246,  250,  254,  278,  288,  292
	.word	 123,  193,  982,  339,  564,  631,  421,  148,  936,  157
	.word	 117,  171,  697,  161,  147,  137,  327,  151,  147,  354
	.word	 432,  551,  176,  487,  490,  810,  111,  523,  532,  445
	.word	 163,  745,  571,  529,  218,  219,  122,  934,  370,  121
	.word	 315,  145,  313,  174,  118,  259,  672,  126,  230,  135
	.word	 199,  104,  106,  107,  124,  625,  126,  229,  248,  999
	.word	 132,  133,  936,  136,  338,  941,  843,  645,  447,  449
	.word	 171,  271,  477,  228,  178,  184,  586,  186,  388,  188
	.word	 950,  852,  754,  256,  658,  760,  161,  562,  263,  764
	.word	 199,  213,  124,  366,  740,  356,  375,  387,  115,  426

len:	.word	150

min:	.word	0
max:	.word	0
sum:	.word	0
avg:	.word	0

hdr:	.asciiz	"\nExample program to find max/min\n\n"
new_ln:	.asciiz	"\n"

a1Msg:	.asciiz	"min (odd) = "
a2Msg:	.asciiz	"\nmax (odd) = "
a3Msg:	.asciiz	"\nsum (odd) = "
a4Msg:	.asciiz "\navg (odd) = "


###########################################################
#  text/code segment

#  Registers Utilized:
#	$t0 - array address
#	$t1 - count of elements
#	$t2 - min
#	$t3 - max
#	$t4 - sum
#	$t5 - each word from array
#	$t6 - remainder of element
#	$t7 - count of odd values
#	$t8 - average of odd values

.text
.globl	main
.ent	main
main:

# -----
#  Display header.
#  Uses system call for output ->
#	call code 4 (output ASCII string
#	arg -> address of string

	la	$a0, hdr
	li	$v0, 4
	syscall					# print header

# -----
#  These instructions are not used
#  Inserted for example only...

	li	$t0, 42
	li	$t1, 65539
	li	$t2, -42
	li	$t3, -65539

	add	$t0, $t0, 100000

	blt	$t0, $t1, testLabel
	ble	$t0, $t1, testLabel
	bgt	$t0, $t1, testLabel
	bge	$t0, $t1, testLabel

	sll	$t0, $t0, 3
	sll	$t0, $t0, $t1

	add	$t0, $a0, $s5


	j	testLabel			# useless
testLabel:

# -----
#  Find max, min, and sum of the array.

	la	$t0, list			# set $t0 addr of the array
	lw	$t1, len			# set $t1 to length

	lw	$t2, ($t0)			# set min, $t2 to array[0]
	lw	$t3, ($t0)			# set max, $t3 to array[0]
	li	$s0, 0				# set sum=0
	li	$t7, 0				# set count of odd values=0
	li	$t8, 0				# set avg=0

loop:	lw	$t5, ($t0)			# get list[n]
	
	rem $t6, $t5, 2			# store remainder in $t6
	beqz $t6, skipAdd		# skip sum & odd value count if list[n] is even
	
	add $t7, $t7, 1			# increment number of odd values

	add	$s0, $s0, $t5			# sum = sum+list[n]

skipAdd:
	
	beqz $t6, notMin		# skip min if even

	bge	$t5, $t2, notMin		# is new min?
	move	$t2, $t5			# set new min (into $t2)
notMin:
	
	beqz $t6, notMax		#skip max if even

	ble	$t5, $t3, notMax		# is new max?
	move	$t3, $t5			# set new max (into $t5)
notMax:
	sub	$t1, $t1, 1			# decrement length counter
	add	$t0, $t0, 4			# increment addr by word (+4 bytes)
	bnez	$t1, loop
	
	div $t8, $s0, $t7		# avg = sum / count (odd)

	sw	$t2, min			# save min
	sw	$t3, max			# save max
	sw	$s0, sum			# save sum
	sw	$t8, avg			# save avg

# -----
#  Display results.

#  Note, some of the system calls utilize/alter the
#        temporary registers.

	la	$a0, a1Msg
	li	$v0, 4
	syscall				# print "min = "

	lw	$a0, min
	li	$v0, 1
	syscall				# print min

	la	$a0, a2Msg
	li	$v0, 4
	syscall				# print "max = "

	lw	$a0, max
	li	$v0, 1
	syscall				# print max

	la	$a0, a3Msg
	li	$v0, 4
	syscall				# print "sum = "

	lw	$a0, sum
	li	$v0, 1
	syscall				# print sum

	la $a0, a4Msg
	li $v0, 4
	syscall

	lw $a0, avg
	li $v0, 1
	syscall

	la	$a0, new_ln		# print a newline
	li	$v0, 4
	syscall

# -----
#  Done, terminate program.

	li	$v0, 10
	syscall				# all done!

.end main

