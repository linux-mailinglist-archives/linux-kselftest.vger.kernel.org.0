Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3A7DB186A4
	for <lists+linux-kselftest@lfdr.de>; Thu,  9 May 2019 10:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725869AbfEIIOv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 9 May 2019 04:14:51 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33452 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbfEIIOu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 9 May 2019 04:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4gsCH6N3Jjf/QP36vZJIojLa6bdh4xfLgPH+yAuJwg4=; b=l8B93p389xzMXHJCBPJt2khaw
        gib8irniUqaKdnWpBPFa3V7SSdPwp5Rd37Z0intpllPZ3858M/CC7Bp/8ZV4FQNrzjkA9cUiRqIhS
        9bEBZU33cQkc3JqoaqMAmQJa6j/I769q5AxmZBqEIzZ6JEWrhqCQwcW1k6JrSJ+ttSGOplR0QFMrV
        L83RhV9aZKmVLE1A3AWnCYB0KvCc05n1AJh2i1z01n78CeeNGs7UQJpLFLvMrs6Q5IIK8mTBXciRW
        6v5hy9Hong6DEoHFBkDFjQQy12EPlDcpzmxj5P2vGli95Pf7DqChwZEkbAZSOxR34zIHel0v7PS5a
        6n7lGB8ig==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hOeCH-0007kz-JH; Thu, 09 May 2019 08:14:33 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4FB97209DFF18; Thu,  9 May 2019 10:14:31 +0200 (CEST)
Date:   Thu, 9 May 2019 10:14:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Masami Hiramatsu <mhiramat@kernel.org>
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
Message-ID: <20190509081431.GO2589@hirez.programming.kicks-ass.net>
References: <20190508074901.982470324@infradead.org>
 <20190508080612.721269814@infradead.org>
 <20190508115416.nblx7c2kocidpytm@treble>
 <20190508120416.GL2589@hirez.programming.kicks-ass.net>
 <20190508124248.u5ukpbhnh4wpiccq@treble>
 <20190508153907.GM2589@hirez.programming.kicks-ass.net>
 <20190508184848.qerg3flv3ej3xsev@treble>
 <20190509102030.dfa62e058f09d0d8cbdd6053@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190509102030.dfa62e058f09d0d8cbdd6053@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Thu, May 09, 2019 at 10:20:30AM +0900, Masami Hiramatsu wrote:
> Hi Josh,
> 
> On Wed, 8 May 2019 13:48:48 -0500
> Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> 
> > On Wed, May 08, 2019 at 05:39:07PM +0200, Peter Zijlstra wrote:
> > > On Wed, May 08, 2019 at 07:42:48AM -0500, Josh Poimboeuf wrote:
> > > > On Wed, May 08, 2019 at 02:04:16PM +0200, Peter Zijlstra wrote:
> > > 
> > > > > Do the x86_64 variants also want some ORC annotation?
> > > > 
> > > > Maybe so.  Though it looks like regs->ip isn't saved.  The saved
> > > > registers might need to be tweaked.  I'll need to look into it.
> > > 
> > > What all these sites do (and maybe we should look at unifying them
> > > somehow) is turn a CALL frame (aka RET-IP) into an exception frame (aka
> > > pt_regs).
> > > 
> > > So regs->ip will be the return address (which is fixed up to be the CALL
> > > address in the handler).
> > 
> > But from what I can tell, trampoline_handler() hard-codes regs->ip to
> > point to kretprobe_trampoline(), and the original return address is
> > placed in regs->sp.
> > 
> > Masami, is there a reason why regs->ip doesn't have the original return
> > address and regs->sp doesn't have the original SP?  I think that would
> > help the unwinder understand things.
> 
> Yes, for regs->ip, there is a histrical reason. Since previously, we had
> an int3 at trampoline, so the user (kretprobe) handler expects that
> regs->ip is trampoline address and ri->ret_addr is original return address.
> It is better to check the other archs, but I think it is possible to
> change the regs->ip to original return address, since no one cares such
> "fixed address". :)
> 
> For the regs->sp, there are 2 reasons.
> 
> For x86-64, it's just for over-optimizing (reduce stack usage).
> I think we can make a gap for putting return address, something like
> 
> 	"kretprobe_trampoline:\n"
> #ifdef CONFIG_X86_64
> 	"	pushq %rsp\n"	/* Make a gap for return address */
> 	"	pushq 0(%rsp)\n"	/* Copy original stack pointer */
> 	"	pushfq\n"
> 	SAVE_REGS_STRING
> 	"	movq %rsp, %rdi\n"
> 	"	call trampoline_handler\n"
> 	/* Push the true return address to the bottom */
> 	"	movq %rax, 20*8(%rsp)\n"
> 	RESTORE_REGS_STRING
> 	"	popfq\n"
> 	"	addq $8, %rsp\n"	/* Skip original stack pointer */
> 
> For i386 (x86-32), there is no other way to keep &regs->sp as
> the original stack pointer. It has to be changed with this series,
> maybe as same as x86-64.

Right; I already fixed that in my patch changing i386's pt_regs.

But what I'd love to do is something like the belwo patch, and make all
the trampolines (very much including ftrace) use that. Such that we then
only have 1 copy of this magic (well, 2 because x86_64 also needs an
implementation of this of course).

Changing ftrace over to this would be a little more work but it can
easily chain things a little to get its original context back:

ENTRY(ftrace_regs_caller)
GLOBAL(ftrace_regs_func)
	push ftrace_stub
	push ftrace_regs_handler
	jmp call_to_exception_trampoline
END(ftrace_regs_caller)

typedef void (*ftrace_func_t)(unsigned long, unsigned long, struct ftrace_op *, struct pt_regs *);

struct ftrace_regs_stack {
	ftrace_func_t func;
	unsigned long parent_ip;
};

void ftrace_regs_handler(struct pr_regs *regs)
{
	struct ftrace_regs_stack *st = (void *)regs->sp;
	ftrace_func_t func = st->func;

	regs->sp += sizeof(long); /* pop func */

	func(regs->ip, st->parent_ip, function_trace_op, regs);
}

Hmm? I didn't look into the function_graph thing, but I imagine it can
be added without too much pain.

---
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1576,3 +1576,100 @@ ENTRY(rewind_stack_do_exit)
 	call	do_exit
 1:	jmp 1b
 END(rewind_stack_do_exit)
+
+/*
+ * Transforms a CALL frame into an exception frame; IOW it pretends the CALL we
+ * just did was in fact scribbled with an INT3.
+ *
+ * Use this trampoline like:
+ *
+ *   PUSH $func
+ *   JMP call_to_exception_trampoline
+ *
+ * $func will see regs->ip point at the CALL instruction and must therefore
+ * modify regs->ip in order to make progress (just like a normal INT3 scribbled
+ * CALL).
+ *
+ * NOTE: we do not restore any of the segment registers.
+ */
+ENTRY(call_to_exception_trampoline)
+	/*
+	 * On entry the stack looks like:
+	 *
+	 *   2*4(%esp) <previous context>
+	 *   1*4(%esp) RET-IP
+	 *   0*4(%esp) func
+	 *
+	 * transform this into:
+	 *
+	 *  19*4(%esp) <previous context>
+	 *  18*4(%esp) gap / RET-IP
+	 *  17*4(%esp) gap / func
+	 *  16*4(%esp) ss
+	 *  15*4(%esp) sp / <previous context>
+	 *  14*4(%esp) flags
+	 *  13*4(%esp) cs
+	 *  12*4(%esp) ip / RET-IP
+	 *  11*4(%esp) orig_eax
+	 *  10*4(%esp) gs
+	 *   9*4(%esp) fs
+	 *   8*4(%esp) es
+	 *   7*4(%esp) ds
+	 *   6*4(%esp) eax
+	 *   5*4(%esp) ebp
+	 *   4*4(%esp) edi
+	 *   3*4(%esp) esi
+	 *   2*4(%esp) edx
+	 *   1*4(%esp) ecx
+	 *   0*4(%esp) ebx
+	 */
+	pushl	%ss
+	pushl	%esp		# points at ss
+	addl	$3*4, (%esp)	#   point it at <previous context>
+	pushfl
+	pushl	%cs
+	pushl	5*4(%esp)	# RET-IP
+	subl	5, (%esp)	#   point at CALL instruction
+	pushl	$-1
+	pushl	%gs
+	pushl	%fs
+	pushl	%es
+	pushl	%ds
+	pushl	%eax
+	pushl	%ebp
+	pushl	%edi
+	pushl	%esi
+	pushl	%edx
+	pushl	%ecx
+	pushl	%ebx
+
+	ENCODE_FRAME_POINTER
+
+	movl	%esp, %eax	# 1st argument: pt_regs
+
+	movl	17*4(%esp), %ebx	# func
+	CALL_NOSPEC %ebx
+
+	movl	PT_OLDESP(%esp), %eax
+
+	movl	PT_EIP(%esp), %ecx
+	movl	%ecx, -1*4(%eax)
+
+	movl	PT_EFLAGS(%esp), %ecx
+	movl	%ecx, -2*4(%eax)
+
+	movl	PT_EAX(%esp), %ecx
+	movl	%ecx, -3*4(%eax)
+
+	popl	%ebx
+	popl	%ecx
+	popl	%edx
+	popl	%esi
+	popl	%edi
+	popl	%ebp
+
+	lea	-3*4(%eax), %esp
+	popl	%eax
+	popfl
+	ret
+END(call_to_exception_trampoline)
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -731,29 +731,8 @@ asm(
 	".global kretprobe_trampoline\n"
 	".type kretprobe_trampoline, @function\n"
 	"kretprobe_trampoline:\n"
-	/* We don't bother saving the ss register */
-#ifdef CONFIG_X86_64
-	"	pushq %rsp\n"
-	"	pushfq\n"
-	SAVE_REGS_STRING
-	"	movq %rsp, %rdi\n"
-	"	call trampoline_handler\n"
-	/* Replace saved sp with true return address. */
-	"	movq %rax, 19*8(%rsp)\n"
-	RESTORE_REGS_STRING
-	"	popfq\n"
-#else
-	"	pushl %esp\n"
-	"	pushfl\n"
-	SAVE_REGS_STRING
-	"	movl %esp, %eax\n"
-	"	call trampoline_handler\n"
-	/* Replace saved sp with true return address. */
-	"	movl %eax, 15*4(%esp)\n"
-	RESTORE_REGS_STRING
-	"	popfl\n"
-#endif
-	"	ret\n"
+	"push trampoline_handler\n"
+	"jmp call_to_exception_trampoline\n"
 	".size kretprobe_trampoline, .-kretprobe_trampoline\n"
 );
 NOKPROBE_SYMBOL(kretprobe_trampoline);
@@ -791,12 +770,7 @@ static __used void *trampoline_handler(s
 
 	INIT_HLIST_HEAD(&empty_rp);
 	kretprobe_hash_lock(current, &head, &flags);
-	/* fixup registers */
-	regs->cs = __KERNEL_CS;
-#ifdef CONFIG_X86_32
-	regs->cs |= get_kernel_rpl();
-	regs->gs = 0;
-#endif
+
 	/* We use pt_regs->sp for return address holder. */
 	frame_pointer = &regs->sp;
 	regs->ip = trampoline_address;
