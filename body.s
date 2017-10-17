	.globl	ParseBody
ParseBody:
	PUSHQ		%rbp
	MOVQ		%rsp,		%rbp
	PUSHQ		%r14
	PUSHQ		%rbx
	MOVQ		(%rdx),		%r10
	XORL		%r11d,		%r11d

loop01: 
	MOVZBL		(%rdi),		%r8d
	INCQ		%rdi
	MOVL		$7,			%r9d

loop02:
	MOVB		(%rdi),		%al
	BTL			%r9d,		%r8d
	JB		loop02_sub01

	MOVZBL		%al,		%r14d
	MOVZBL		1(%rdi),	%ebx
	MOVQ		%r10,		%rcx
	SUBQ		%rbx,		%rcx
	DECQ		%rcx
	INCL		%r14d
	ADDQ		$2,			%rdi
	XORL		%ebx,		%ebx

loop02_cond01:
	MOVB		(%rcx,%rbx),	%al
	MOVB		%al,			(%r10,%rbx)
	LEAQ		1(%r11,%rbx),	%rax
	CMPQ		%rsi,			%rax
	JAE		end_loop01

	INCQ		%rbx
	CMPL		%r14d,		%ebx
	JLE		loop02_cond01

	ADDQ		%rbx,		%r11
	ADDQ		%rbx,		%r10
	JMP		end_loop02_cond01

loop02_sub01:
	MOVB		%al,		(%r10)
	INCQ		%r11
	CMPQ		%rsi,		%r11
	JAE		end_loop01

	INCQ		%rdi
	INCQ		%r10

end_loop02_cond01:  
	TESTL		%r9d,		%r9d
	LEAL		-1(%r9),	%r9d
	JG		loop02
	JMP		loop01

end_loop01: 
	MOVQ		(%rdx),		%rax
	POPQ		%rbx
	POPQ		%r14
	POPQ		%rbp
	RET

