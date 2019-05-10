Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 311E6197DE
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 May 2019 06:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbfEJE6m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 May 2019 00:58:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57488 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725927AbfEJE6m (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 May 2019 00:58:42 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E015520882;
        Fri, 10 May 2019 04:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557464320;
        bh=2+oCBqi/CKHd4OFUbukKA2gvKd467R/z47Bh0opyEK4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=x64jEXLZ5zhsx1pvKAtGXMl9PPgz5OeeYFswfu+LnCftHsYKESZq/oIKGPN6430Vf
         S1vnnitLc3thLOl3VNuxMKBuYJE74KqVZmCfsD8LJyKym7VVh3wjh3pMUoJNbEAt4/
         E/AyKH8MaP4czVVmZ/2y7siM+1Et/N6YOcReDHFE=
Date:   Fri, 10 May 2019 13:58:31 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes <mbenes@suse.cz>,
        Petr Mladek <pmladek@suse.com>,
        Joe Lawrence <joe.lawrence@redhat.com>,
        Shuah Khan <shuah@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Juergen Gross <jgross@suse.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joerg Roedel <jroedel@suse.de>, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/4] x86/kprobes: Fix frame pointer annotations
Message-Id: <20190510135831.c4ad309c68fc254f819194fc@kernel.org>
In-Reply-To: <20190509171416.GY2623@hirez.programming.kicks-ass.net>
References: <20190508074901.982470324@infradead.org>
        <20190508080612.721269814@infradead.org>
        <20190508115416.nblx7c2kocidpytm@treble>
        <20190508120416.GL2589@hirez.programming.kicks-ass.net>
        <20190508124248.u5ukpbhnh4wpiccq@treble>
        <20190508153907.GM2589@hirez.programming.kicks-ass.net>
        <20190508184848.qerg3flv3ej3xsev@treble>
        <20190509102030.dfa62e058f09d0d8cbdd6053@kernel.org>
        <20190509081431.GO2589@hirez.programming.kicks-ass.net>
        <20190509230106.3551b08553440d125e437f66@kernel.org>
        <20190509171416.GY2623@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 9 May 2019 19:14:16 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, May 09, 2019 at 11:01:06PM +0900, Masami Hiramatsu wrote:
> > On Thu, 9 May 2019 10:14:31 +0200
> > Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > > But what I'd love to do is something like the belwo patch, and make all
> > > the trampolines (very much including ftrace) use that. Such that we then
> > > only have 1 copy of this magic (well, 2 because x86_64 also needs an
> > > implementation of this of course).
> > 
> > OK, but I will make kretprobe integrated with func-graph tracer,
> > since it is inefficient that we have 2 different hidden return stack...
> > 
> > Anyway,
> > 
> > > Changing ftrace over to this would be a little more work but it can
> > > easily chain things a little to get its original context back:
> > > 
> > > ENTRY(ftrace_regs_caller)
> > > GLOBAL(ftrace_regs_func)
> > > 	push ftrace_stub
> > > 	push ftrace_regs_handler
> > > 	jmp call_to_exception_trampoline
> > > END(ftrace_regs_caller)
> > > 
> > > typedef void (*ftrace_func_t)(unsigned long, unsigned long, struct ftrace_op *, struct pt_regs *);
> > > 
> > > struct ftrace_regs_stack {
> > > 	ftrace_func_t func;
> > > 	unsigned long parent_ip;
> > > };
> > > 
> > > void ftrace_regs_handler(struct pr_regs *regs)
> > > {
> > > 	struct ftrace_regs_stack *st = (void *)regs->sp;
> > > 	ftrace_func_t func = st->func;
> > > 
> > > 	regs->sp += sizeof(long); /* pop func */
> > 
> > Sorry, why pop here? 
> 
> Otherwise it stays on the return stack and bad things happen. Note how
> the below trampoline thing uses regs->sp.
> 
> > > 	func(regs->ip, st->parent_ip, function_trace_op, regs);
> > > }
> > > 
> > > Hmm? I didn't look into the function_graph thing, but I imagine it can
> > > be added without too much pain.
> > 
> > Yes, that should be good for function_graph trampoline too.
> > We use very similar technic.
> 
> Ideally also the optimized kprobe trampoline, but I've not managed to
> fully comprehend that one.

As you pointed in other reply, save/restore can be a macro, but
each trampoline code is slightly different. Optprobe template has
below parts

(jumped from probed address)
[store regs]
[setup function arguments (pt_regs and probed address)]
[handler call]
[restore regs]
[execute copied instruction]
[jump back to probed address]

Note that there is a limitation that if it is optiomized probe, user
handler can not change regs->ip. (we can not use "ret" after executed
a copied instruction, which must run on same stack)

> 
> > > 
> > > ---
> > > --- a/arch/x86/entry/entry_32.S
> > > +++ b/arch/x86/entry/entry_32.S
> > > @@ -1576,3 +1576,100 @@ ENTRY(rewind_stack_do_exit)
> > >  	call	do_exit
> > >  1:	jmp 1b
> > >  END(rewind_stack_do_exit)
> > > +
> > > +/*
> > > + * Transforms a CALL frame into an exception frame; IOW it pretends the CALL we
> > > + * just did was in fact scribbled with an INT3.
> > > + *
> > > + * Use this trampoline like:
> > > + *
> > > + *   PUSH $func
> > > + *   JMP call_to_exception_trampoline
> > > + *
> > > + * $func will see regs->ip point at the CALL instruction and must therefore
> > > + * modify regs->ip in order to make progress (just like a normal INT3 scribbled
> > > + * CALL).
> > > + *
> > > + * NOTE: we do not restore any of the segment registers.
> > > + */
> > > +ENTRY(call_to_exception_trampoline)
> > > +	/*
> > > +	 * On entry the stack looks like:
> > > +	 *
> > > +	 *   2*4(%esp) <previous context>
> > > +	 *   1*4(%esp) RET-IP
> > > +	 *   0*4(%esp) func
> > > +	 *
> > > +	 * transform this into:
> > > +	 *
> > > +	 *  19*4(%esp) <previous context>
> > > +	 *  18*4(%esp) gap / RET-IP
> > > +	 *  17*4(%esp) gap / func
> > > +	 *  16*4(%esp) ss
> > > +	 *  15*415*4(%esp) sp / <previous context>
> > 
> > isn't this "&<previous context>" ?
> 
> Yes.
> 
> > > +	 *  14*4(%esp) flags
> > > +	 *  13*4(%esp) cs
> > > +	 *  12*4(%esp) ip / RET-IP
> > > +	 *  11*4(%esp) orig_eax
> > > +	 *  10*4(%esp) gs
> > > +	 *   9*4(%esp) fs
> > > +	 *   8*4(%esp) es
> > > +	 *   7*4(%esp) ds
> > > +	 *   6*4(%esp) eax
> > > +	 *   5*4(%esp) ebp
> > > +	 *   4*4(%esp) edi
> > > +	 *   3*4(%esp) esi
> > > +	 *   2*4(%esp) edx
> > > +	 *   1*4(%esp) ecx
> > > +	 *   0*4(%esp) ebx
> > > +	 */
> > > +	pushl	%ss
> > > +	pushl	%esp		# points at ss
> > > +	addl	$3*4, (%esp)	#   point it at <previous context>
> > > +	pushfl
> > > +	pushl	%cs
> > > +	pushl	5*4(%esp)	# RET-IP
> > > +	subl	5, (%esp)	#   point at CALL instruction
> > > +	pushl	$-1
> > > +	pushl	%gs
> > > +	pushl	%fs
> > > +	pushl	%es
> > > +	pushl	%ds
> > > +	pushl	%eax
> > > +	pushl	%ebp
> > > +	pushl	%edi
> > > +	pushl	%esi
> > > +	pushl	%edx
> > > +	pushl	%ecx
> > > +	pushl	%ebx
> > > +
> > > +	ENCODE_FRAME_POINTER
> > > +
> > > +	movl	%esp, %eax	# 1st argument: pt_regs
> > > +
> > > +	movl	17*4(%esp), %ebx	# func
> > > +	CALL_NOSPEC %ebx
> > > +
> > > +	movl	PT_OLDESP(%esp), %eax
> > 
> > Is PT_OLDESP(%esp) "<previous context>" or "&<previous contex>"?
> 
> The latter.
> 
> > > +
> > > +	movl	PT_EIP(%esp), %ecx
> > > +	movl	%ecx, -1*4(%eax)
> > 
> > Ah, OK, so $func must set the true return address to regs->ip
> > instead of returning it.
> 
> Just so.
> 
> > > +
> > > +	movl	PT_EFLAGS(%esp), %ecx
> > > +	movl	%ecx, -2*4(%eax)
> > > +
> > > +	movl	PT_EAX(%esp), %ecx
> > > +	movl	%ecx, -3*4(%eax)
> > 
> > So, at this point, the stack becomes
> > 
>   3*4(%esp) &regs->sp
>   2*4(%esp) RET-IP
>   1*4(%esp) eflags
>   0*4(%esp) eax
> 
> > Correct?
> 
> Yes, relative to regs->sp, which is why we need to pop 'func', otherwise
> it stays on the stack.
> 
> > > +
> > > +	popl	%ebx
> > > +	popl	%ecx
> > > +	popl	%edx
> > > +	popl	%esi
> > > +	popl	%edi
> > > +	popl	%ebp
> > > +
> > > +	lea	-3*4(%eax), %esp
> > > +	popl	%eax
> > > +	popfl
> > > +	ret
> > > +END(call_to_exception_trampoline)
> > > --- a/arch/x86/kernel/kprobes/core.c
> > > +++ b/arch/x86/kernel/kprobes/core.c
> > > @@ -731,29 +731,8 @@ asm(
> > >  	".global kretprobe_trampoline\n"
> > >  	".type kretprobe_trampoline, @function\n"
> > >  	"kretprobe_trampoline:\n"
> > > -	/* We don't bother saving the ss register */
> > > -#ifdef CONFIG_X86_64
> > > -	"	pushq %rsp\n"
> > > -	"	pushfq\n"
> > > -	SAVE_REGS_STRING
> > > -	"	movq %rsp, %rdi\n"
> > > -	"	call trampoline_handler\n"
> > > -	/* Replace saved sp with true return address. */
> > > -	"	movq %rax, 19*8(%rsp)\n"
> > > -	RESTORE_REGS_STRING
> > > -	"	popfq\n"
> > > -#else
> > > -	"	pushl %esp\n"
> > > -	"	pushfl\n"
> > > -	SAVE_REGS_STRING
> > > -	"	movl %esp, %eax\n"
> > > -	"	call trampoline_handler\n"
> > > -	/* Replace saved sp with true return address. */
> > > -	"	movl %eax, 15*4(%esp)\n"
> > > -	RESTORE_REGS_STRING
> > > -	"	popfl\n"
> > > -#endif
> > > -	"	ret\n"
> > 
> > Here, we need a gap for storing ret-ip, because kretprobe_trampoline is
> > the address which is returned from the target function. We have no 
> > "ret-ip" here at this point. So something like
> > 
> > +	"push $0\n"	/* This is a gap, will be filled with real return address*/
> 
> The trampoline already provides a gap, trampoline_handler() will need to
> use int3_emulate_push() if it wants to inject something on the return
> stack.

I guess you mean the int3 case. This trampoline is used as a return destination.
When the target function is called, kretprobe interrupts the first instruction,
and replace the return address with this trampoline. When a "ret" instruction
is done, it returns to this trampoline. Thus the stack frame start with
previous context here. As you described above,

> > > +	 * On entry the stack looks like:
> > > +	 *
> > > +	 *   2*4(%esp) <previous context>
> > > +	 *   1*4(%esp) RET-IP
> > > +	 *   0*4(%esp) func

From this trampoline call, the stack looks like:

	 *   1*4(%esp) <previous context>
	 *   0*4(%esp) func

So we need one more push.

> 
> > > +	"push trampoline_handler\n"
> > > +	"jmp call_to_exception_trampoline\n"
> > >  	".size kretprobe_trampoline, .-kretprobe_trampoline\n"
> > >  );
> > >  NOKPROBE_SYMBOL(kretprobe_trampoline);

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
