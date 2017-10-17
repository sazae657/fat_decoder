	.globl	Extend
Extend:
	PUSHQ		%rbp
	MOVQ		%rsp,		%rbp
	TESTL		%ecx,		%ecx
	JE		end_loop01

	MOVQ		%rdi,		%r9
loop01:
	MOVB		(%rsi),		%al
	MOVB		%al,		(%r9)
	MOVB		1(%rsi),	%al
	MOVB		%al,		1(%r9)
	MOVB		2(%rsi),	%al
	MOVB		%al,		2(%r9)
	ADDQ		$3,			%rsi
	MOVB		(%rdx),		%r8b
	INCQ		%rdx
	MOVB		%r8b,		3(%r9)
	ADDQ		$4,			%r9
	DECL		%ecx
	JNE		loop01

end_loop01: 
	MOVQ		%rdi,		%rax
	POPQ		%rbp
	RET

