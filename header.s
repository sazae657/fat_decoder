	.globl	ParseHeader
ParseHeader:
	PUSHQ		%rbp
	MOVQ		%rsp,		%rbp
	PUSHQ		%r15
	PUSHQ		%r14
	PUSHQ		%r12
	PUSHQ		%rbx
	MOVQ		(%rdx),		%rax
	XORL		%r11d,		%r11d
	MOVL		$2,			%r8d

loop01:
	MOVZBL		(%rdi),		%r9d
	INCQ		%rdi
	MOVL		$7,			%r10d


loop02: 
	BTL			%r10d,		%r9d
	JB		loop02_exit

	MOVZBL		1(%rdi),	%r12d
	MOVL		%r12d,		%ebx
	ANDL		$15,		%ebx
	SHLL		$4,			%ebx
	MOVZBL		(%rdi),		%r14d
	MOVB		%r14b,		%cl
	SHRB		$4,			%cl
	MOVZBL		%cl,		%r15d
	ORL			%ebx,		%r15d
	SHRB		$4,			%r12b
	MOVZBL		%r12b,		%ecx
	SHLL		$8,			%ecx
	ORL			%r15d,		%ecx
	ADDQ		$2,			%rdi
	ANDL		$15,		%r14d
	XORL		%ebx,		%ebx
	LEAL		3(%rcx, %rcx,2),	%ecx
	MOVSLQ		%ecx,		%r15
	MOVQ		%r8,		%r12
	SUBQ		%r15,		%r12

/* loop02 */
loop02_sub01:
	MOVB		-2(%rax,%r12),	%cl
	MOVB		%cl,			(%rax)
	MOVB		-1(%rax, %r12),	%cl
	MOVB		%cl,			1(%rax)
	MOVB		(%rax,%r12),	%cl
	MOVB		%cl,			2(%rax)
	LEAQ		1(%r11,%rbx),	%rcx
	CMPQ		%rsi,			%rcx
	JAE		end_loop01

	ADDQ		$3,			%rax
	INCQ		%rbx
	CMPL		%r14d,		%ebx
	JLE		loop02_sub01
   
	ADDQ		%rbx,		%r11
	JMP		loop02_jmp_exit

loop02_exit:
	MOVB		(%rdi),		%cl
	MOVB		%cl,		(%rax)
	MOVB		1(%rdi),	%cl
	MOVB		%cl,		1(%rax)
	MOVB		2(%rdi),	%cl
	MOVB		%cl,		2(%rax)
	INCQ		%r11
	CMPQ		%rsi,		%r11
	JAE		end_loop01

	ADDQ		$3,			%rax
	ADDQ		$3,			%rdi

loop02_jmp_exit:
	TESTL		%r10d,		%r10d
	LEAL		-1(%r10),	%r10d
	JG		loop02
	JMP		loop01

/* loop01 end */
end_loop01:
	MOVQ		(%rdx),		%rax
	POPQ		%rbx
	POPQ		%r12
	POPQ		%r14
	POPQ		%r15
	POPQ		%rbp
	RET


