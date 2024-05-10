#  CS 219, MIPS Assignment #5


#####################################################################
#  data segment

.data

hdr:	.ascii	"CS 219 - Assignment #5\n"
	.asciiz	"Floating Point Calculations.\n\n"
nline:	.asciiz	"\n"


# -----
#  Single precision

fval1:	.float	9.75
fval2:	.float	5.5
fval3:	.float	12.25
fval4:	.float	3.6

fans1:	.float	0.0
fans2:	.float	0.0

fval:	.float	0.001
fsum:	.float	0.0

fmsg1:	.asciiz	"\nFloat Answer #1 = "
fmsg2:	.asciiz	"\nFloat Answer #2 = "
fmsg3:	.asciiz	"\nFloat Sum = "

# -----
#  Double precision

dval1:	.double	9.75
dval2:	.double	5.5
dval3:	.double	12.25
dval4:	.double	3.6

dans1:	.double	0.0
dans2:	.double	0.0

dval:	.double	0.001
dsum:	.double	0.0

dmsg1:	.asciiz	"\nDouble Answer #1 = "
dmsg2:	.asciiz	"\nDouble Answer #2 = "
dmsg3:	.asciiz	"\nDouble Sum = "


#####################################################################
#  text/code segment

.text

.globl	main
.ent	main
main:

# -----
#  Display simple header

	li	$v0, 4
	la	$a0, hdr
	syscall

# -----
#  Calculate float values
#	fans1 = fval1 + fval2
#	fans2 = fval3 + fval4

#	your code goes here...

	l.s 	$f4, fval1
	l.s 	$f6, fval2
	add.s 	$f8, $f4, $f6
	s.s 	$f8, fans1
	
	l.s 	$f4, fval3
	l.s 	$f6, fval4
	add.s 	$f8, $f4, $f6
	s.s 	$f8, fans2

# -----
#  Display results.

	li	$v0, 4
	la	$a0, fmsg1
	syscall
	li	$v0, 2
	l.s	$f12, fans1
	syscall

	li	$v0, 4
	la	$a0, fmsg2
	syscall
	li	$v0, 2
	l.s	$f12, fans2
	syscall

	li	$v0, 4
	la	$a0, nline
	syscall

# -----
#  Calculate double values
#	dans1 = dval1 + dval2
#	dans2 = dval3 + dval4

#	your code goes here...

	l.d		$f4, dval1
	l.d		$f6, dval2
	add.d	$f8, $f4, $f6
	s.d 	$f8, dans1
	
	l.d 	$f4, dval3
	l.d 	$f6, dval4
	add.d 	$f8, $f4, $f6
	s.d 	$f8, dans2


# -----
#  Display results.

	li	$v0, 4
	la	$a0, dmsg1
	syscall
	li	$v0, 3
	l.d	$f12, dans1
	syscall

	li	$v0, 4
	la	$a0, dmsg2
	syscall
	li	$v0, 3
	l.d	$f12, dans2
	syscall

	li	$v0, 4
	la	$a0, nline
	syscall

# -----
#  Calcluate float values.
#	fsum = 0.0
#	do 1000 times
#		fsum = fsum + fval

#	your code goes here...
	
	li 		$t0, 1000
	l.s 	$f4, fsum
	l.s 	$f6, fval
	floatSum:
		add.s 	$f4, $f4, $f6
		s.s		$f4, fsum
		sub $t0, $t0, 1
		bnez $t0, floatSum

# -----
#  Display fsum.

	li	$v0, 4
	la	$a0, fmsg3
	syscall

	li	$v0, 2
	l.s	$f12, fsum
	syscall

# -----
#  Calcluate double values.
#	dsum = 0.0
#	do 10000 times
#		dsum = dsum + dval

#	your code goes here...

	li 		$t0, 10000
	l.d 	$f4, dsum
	l.d 	$f6, dval
	doubleSum:
		add.d 	$f4, $f4, $f6
		s.d 	$f4, dsum
		sub 	$t0, $t0, 1
		bnez 	$t0, doubleSum


# -----
#  Display dsum.

	li	$v0, 4
	la	$a0, dmsg3
	syscall

	li	$v0, 3
	l.d	$f12, dsum
	syscall

	li	$v0, 4
	la	$a0, nline
	syscall

# -----
#  Done, terminate program.

	li	$v0, 10
	syscall					# au revoir...

.end main

#####################################################################

