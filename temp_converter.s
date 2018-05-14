.data

b0:	.float 32.0 
b1:	.float 9.0
b2:	.float 5.0
b3:	.float 273.15

start:		.asciz	"Enter temperature in fahrenheight: "
Cel_print:	.asciz  "Celsius: "
Kel_print:	.asciz	"Kelvin: "
newln:		.asciz	"\r\n"


.text

main:
	li	a7,4			#print string
	la	a0,start
	ecall
	li	a7,6			
	ecall
	
	fmv.s	f0,fa0		#save result in ft1
	jal Celsius
	jal Kelvin
	j Exit
	
Celsius:
	flw f1, b0, t0  #32
	flw f2, b1, t0  #9
	flw f3, b2, t0  #5

	fsub.s f1, f0, f1
	fmul.s f1, f1, f3
	fdiv.s f1, f1, f2
	
	fmv.s	fa0, f1
	
    #print result for celsius
	li	a7,4			
	la	a0,newln
	
	li	a7,4
	la	a0,Cel_print
	ecall

	li	a7,2
	ecall
	ret
	
Kelvin:

	flw f1, b3, t0
	fadd.s f1, fa0, f1
	
	fmv.s	fa0, f1
	
	li	a7,4			
	la	a0,newln
	ecall

	li	a7,4			
	la	a0,Kel_print
	ecall

	li	a7,2			
	ecall
	ret
	
Exit:
