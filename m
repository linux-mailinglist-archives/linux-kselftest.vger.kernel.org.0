Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7538018B18
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2019 16:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfEIOBQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 May 2019 10:01:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:44748 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726192AbfEIOBQ (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 May 2019 10:01:16 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CA3492089E;
        Thu,  9 May 2019 14:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557410474;
        bh=CeMS/sCd8zS33MpeYALcLP/Yqm9rGmSNsKFNL7ZikOA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nXxvOXjKh6V0/dPiWa8hgkLmu0/Skk6GzVerSrb3HrHtR+sq0k4Cfhi3Ifbq95m/b
         pfGhLtaCKZ2nGUjTQjRczj6HH5/OzviuUXMUTJ9JNI1nVHs2ilpo1L4t3bzILekL7/
         nOuTQzGuSpRgzGx2tMjHQDTRBFsiAS82DV/EuU90=
Date:   Thu, 9 May 2019 23:01:06 +0900
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
Message-Id: <20190509230106.3551b08553440d125e437f66@kernel.org>
In-Reply-To: <20190509081431.GO2589@hirez.programming.kicks-ass.net>
References: <20190508074901.982470324@infradead.org>
        <20190508080612.721269814@infradead.org>
        <20190508115416.nblx7c2kocidpytm@treble>
        <20190508120416.GL2589@hirez.programming.kicks-ass.net>
        <20190508124248.u5ukpbhnh4wpiccq@treble>
        <20190508153907.GM2589@hirez.programming.kicks-ass.net>
        <20190508184848.qerg3flv3ej3xsev@treble>
        <20190509102030.dfa62e058f09d0d8cbdd6053@kernel.org>
        <20190509081431.GO2589@hirez.programming.kicks-ass.net>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, 9 May 2019 10:14:31 +0200
Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, May 09, 2019 at 10:20:30AM +0900, Masami Hiramatsu wrote:
> > Hi Josh,
> > 
> > On Wed, 8 May 2019 13:48:48 -0500
> > Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > 
> > > On Wed, May 08, 2019 at 05:39:07PM +0200, Peter Zijlstra wrote:
> > > > On Wed, May 08, 2019 at 07:42:48AM -0500, Josh Poimboeuf wrote:
> > > > > On Wed, May 08, 2019 at 02:04:16PM +0200, Peter Zijlstra wrote:
> > > > 
> > > > > > Do the x86_64 variants also want some ORC annotation?
> > > > > 
> > > > > Maybe so.  Though it looks like regs->ip isn't saved.  The saved
> > > > > registers might need to be tweaked.  I'll need to look into it.
> > > > 
> > > > What all these sites do (and maybe we should look at unifying them
> > > > somehow) is turn a CALL frame (aka RET-IP) into an exception frame (aka
> > > > pt_regs).
> > > > 
> > > > So regs->ip will be the return address (which is fixed up to be the CALL
> > > > address in the handler).
> > > 
> > > But from what I can tell, trampoline_handler() hard-codes regs->ip to
> > > point to kretprobe_trampoline(), and the original return address is
> > > placed in regs->sp.
> > > 
> > > Masami, is there a reason why regs->ip doesn't have the original return
> > > address and regs->sp doesn't have the original SP?  I think that would
> > > help the unwinder understand things.
> > 
> > Yes, for regs->ip, there is a histrical reason. Since previously, we had
> > an int3 at trampoline, so the user (kretprobe) handler expects that
> > regs->ip is trampoline address and ri->ret_addr is original return address.
> > It is better to check the other archs, but I think it is possible to
> > change the regs->ip to original return address, since no one cares such
> > "fixed address". :)
> > 
> > For the regs->sp, there are 2 reasons.
> > 
> > For x86-64, it's just for over-optimizing (reduce stack usage).
> > I think we can make a gap for putting return address, something like
> > 
> > 	"kretprobe_trampoline:\n"
> > #ifdef CONFIG_X86_64
> > 	"	pushq %rsp\n"	/* Make a gap for return address */
> > 	"	pushq 0(%rsp)\n"	/* Copy original stack pointer */
> > 	"	pushfq\n"
> > 	SAVE_REGS_STRING
> > 	"	movq %rsp, %rdi\n"
> > 	"	call trampoline_handler\n"
> > 	/* Push the true return address to the bottom */
> > 	"	movq %rax, 20*8(%rsp)\n"
> > 	RESTORE_REGS_STRING
> > 	"	popfq\n"
> > 	"	addq $8, %rsp\n"	/* Skip original stack pointer */
> > 
> > For i386 (x86-32), there is no other way to keep &regs->sp as
> > the original stack pointer. It has to be changed with this series,
> > maybe as same as x86-64.
> 
> Right; I already fixed that in my patch changing i386's pt_regs.

I see it, and it is good to me. :)

> But what I'd love to do is something like the belwo patch, and make all
> the trampolines (very much including ftrace) use that. Such that we then
> only have 1 copy of this magic (well, 2 because x86_64 also needs an
> implementation of this of course).

OK, but I will make kretprobe integrated with func-graph tracer,
since it is inefficient that we have 2 different hidden return stack...

Anyway,

> Changing ftrace over to this would be a little more work but it can
> easily chain things a little to get its original context back:
> 
> ENTRY(ftrace_regs_caller)
> GLOBAL(ftrace_regs_func)
> 	push ftrace_stub
> 	push ftrace_regs_handler
> 	jmp call_to_exception_trampoline
> END(ftrace_regs_caller)
> 
> typedef void (*ftrace_func_t)(unsigned long, unsigned long, struct ftrace_op *, struct pt_regs *);
> 
> struct ftrace_regs_stack {
> 	ftrace_func_t func;
> 	unsigned long parent_ip;
> };
> 
> void ftrace_regs_handler(struct pr_regs *regs)
> {
> 	struct ftrace_regs_stack *st = (void *)regs->sp;
> 	ftrace_func_t func = st->func;
> 
> 	regs->sp += sizeof(long); /* pop func */

Sorry, why pop here? 

> 
> 	func(regs->ip, st->parent_ip, function_trace_op, regs);
> }
> 
> Hmm? I didn't look into the function_graph thing, but I imagine it can
> be added without too much pain.

Yes, that should be good for function_graph trampoline too.
We use very similar technic.

> 
> ---
> --- a/arch/x86/entry/entry_32.S
> +++ b/arch/x86/entry/entry_32.S
> @@ -1576,3 +1576,100 @@ ENTRY(rewind_stack_do_exit)
>  	call	do_exit
>  1:	jmp 1b
>  END(rewind_stack_do_exit)
> +
> +/*
> + * Transforms a CALL frame into an exception frame; IOW it pretends the CALL we
> + * just did was in fact scribbled with an INT3.
> + *
> + * Use this trampoline like:
> + *
> + *   PUSH $func
> + *   JMP call_to_exception_trampoline
> + *
> + * $func will see regs->ip point at the CALL instruction and must therefore
> + * modify regs->ip in order to make progress (just like a normal INT3 scribbled
> + * CALL).
> + *
> + * NOTE: we do not restore any of the segment registers.
> + */
> +ENTRY(call_to_exception_trampoline)
> +	/*
> +	 * On entry the stack looks like:
> +	 *
> +	 *   2*4(%esp) <previous context>
> +	 *   1*4(%esp) RET-IP
> +	 *   0*4(%esp) func
> +	 *
> +	 * transform this into:
> +	 *
> +	 *  19*4(%esp) <previous context>
> +	 *  18*4(%esp) gap / RET-IP
> +	 *  17*4(%esp) gap / func
> +	 *  16*4(%esp) ss
> +	 *  15*415*4(%esp) sp / <previous context>

isn't this "&<previous context>" ?

> +	 *  14*4(%esp) flags
> +	 *  13*4(%esp) cs
> +	 *  12*4(%esp) ip / RET-IP
> +	 *  11*4(%esp) orig_eax
> +	 *  10*4(%esp) gs
> +	 *   9*4(%esp) fs
> +	 *   8*4(%esp) es
> +	 *   7*4(%esp) ds
> +	 *   6*4(%esp) eax
> +	 *   5*4(%esp) ebp
> +	 *   4*4(%esp) edi
> +	 *   3*4(%esp) esi
> +	 *   2*4(%esp) edx
> +	 *   1*4(%esp) ecx
> +	 *   0*4(%esp) ebx
> +	 */
> +	pushl	%ss
> +	pushl	%esp		# points at ss
> +	addl	$3*4, (%esp)	#   point it at <previous context>
> +	pushfl
> +	pushl	%cs
> +	pushl	5*4(%esp)	# RET-IP
> +	subl	5, (%esp)	#   point at CALL instruction
> +	pushl	$-1
> +	pushl	%gs
> +	pushl	%fs
> +	pushl	%es
> +	pushl	%ds
> +	pushl	%eax
> +	pushl	%ebp
> +	pushl	%edi
> +	pushl	%esi
> +	pushl	%edx
> +	pushl	%ecx
> +	pushl	%ebx
> +
> +	ENCODE_FRAME_POINTER
> +
> +	movl	%esp, %eax	# 1st argument: pt_regs
> +
> +	movl	17*4(%esp), %ebx	# func
> +	CALL_NOSPEC %ebx
> +
> +	movl	PT_OLDESP(%esp), %eax

Is PT_OLDESP(%esp) "<previous context>" or "&<previous contex>"?

> +
> +	movl	PT_EIP(%esp), %ecx
> +	movl	%ecx, -1*4(%eax)

Ah, OK, so $func must set the true return address to regs->ip
instead of returning it.

> +
> +	movl	PT_EFLAGS(%esp), %ecx
> +	movl	%ecx, -2*4(%eax)
> +
> +	movl	PT_EAX(%esp), %ecx
> +	movl	%ecx, -3*4(%eax)

So, at this point, the stack becomes

 18*4(%esp) RET-IP
 17*4(%esp) eflags
 16*4(%esp) eax

Correct?

> +
> +	popl	%ebx
> +	popl	%ecx
> +	popl	%edx
> +	popl	%esi
> +	popl	%edi
> +	popl	%ebp
> +
> +	lea	-3*4(%eax), %esp
> +	popl	%eax
> +	popfl
> +	ret
> +END(call_to_exception_trampoline)
> --- a/arch/x86/kernel/kprobes/core.c
> +++ b/arch/x86/kernel/kprobes/core.c
> @@ -731,29 +731,8 @@ asm(
>  	".global kretprobe_trampoline\n"
>  	".type kretprobe_trampoline, @function\n"
>  	"kretprobe_trampoline:\n"
> -	/* We don't bother saving the ss register */
> -#ifdef CONFIG_X86_64
> -	"	pushq %rsp\n"
> -	"	pushfq\n"
> -	SAVE_REGS_STRING
> -	"	movq %rsp, %rdi\n"
> -	"	call trampoline_handler\n"
> -	/* Replace saved sp with true return address. */
> -	"	movq %rax, 19*8(%rsp)\n"
> -	RESTORE_REGS_STRING
> -	"	popfq\n"
> -#else
> -	"	pushl %esp\n"
> -	"	pushfl\n"
> -	SAVE_REGS_STRING
> -	"	movl %esp, %eax\n"
> -	"	call trampoline_handler\n"
> -	/* Replace saved sp with true return address. */
> -	"	movl %eax, 15*4(%esp)\n"
> -	RESTORE_REGS_STRING
> -	"	popfl\n"
> -#endif
> -	"	ret\n"

Here, we need a gap for storing ret-ip, because kretprobe_trampoline is
the address which is returned from the target function. We have no 
"ret-ip" here at this point. So something like

+	"push $0\n"	/* This is a gap, will be filled with real return address*/

> +	"push trampoline_handler\n"
> +	"jmp call_to_exception_trampoline\n"
>  	".size kretprobe_trampoline, .-kretprobe_trampoline\n"
>  );
>  NOKPROBE_SYMBOL(kretprobe_trampoline);
> @@ -791,12 +770,7 @@ static __used void *trampoline_handler(s
>  
>  	INIT_HLIST_HEAD(&empty_rp);
>  	kretprobe_hash_lock(current, &head, &flags);
> -	/* fixup registers */
> -	regs->cs = __KERNEL_CS;
> -#ifdef CONFIG_X86_32
> -	regs->cs |= get_kernel_rpl();
> -	regs->gs = 0;
> -#endif
> +
>  	/* We use pt_regs->sp for return address holder. */
>  	frame_pointer = &regs->sp;
>  	regs->ip = trampoline_address;

Thank you,

-- 
Masami Hiramatsu <mhiramat@kernel.org>
