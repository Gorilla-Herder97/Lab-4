.data

c0: .word 0
c1:	.word 0	
c2:	.word 0

.text

main:	
	addi	a2,x0,3
	jal	fibonacci
	sw	a0,c0,t0
	
	addi	a2,x0,10
	jal	fibonacci	
	sw	a0,c1,t0
	
	addi	a2,x0,20
	jal	fibonacci
	sw	a0,c2,t0
	
	li	a7,10
	ecall

fibonacci:
	addi 	sp,sp,-12
	sw	x1,0(sp)
	sw	s1,4(sp)
	sw	s1,8(sp)
	
	add	s1,a2,x0
	addi	t1,x0,1
	beq	s1,x0,else1
	beq	s1,t1,else0
	
	addi	a2,s1,-1
	jal	fibonacci
	add	s1,x0,a0
	addi	a2,s1,-2
	jal	fibonacci
	add	a0,a0,s1
	
EXIT:
	lw	x1,0(sp)
	lw	s1,4(sp)
	lw	s1,8(sp)
	addi	sp,sp,12
	jr	x1,0
	
else0:
	li	a0,1
	j	EXIT
else1:
	li	a0,0
	j	EXIT

