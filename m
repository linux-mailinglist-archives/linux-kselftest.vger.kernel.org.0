Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 33B20FE61
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2019 19:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbfD3REF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Apr 2019 13:04:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:40220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726050AbfD3REF (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Apr 2019 13:04:05 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 613032075E;
        Tue, 30 Apr 2019 17:04:01 +0000 (UTC)
Date:   Tue, 30 Apr 2019 13:03:59 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
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
        Joerg Roedel <jroedel@suse.de>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        live-patching@vger.kernel.org,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 3/4] x86/ftrace: make ftrace_int3_handler() not to skip
 fops invocation
Message-ID: <20190430130359.330e895b@gandalf.local.home>
In-Reply-To: <CALCETrXujRWxwkgAwB+8xja3N9H22t52AYBYM_mbrjKKZ624Eg@mail.gmail.com>
References: <20190428133826.3e142cfd@oasis.local.home>
        <CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com>
        <CAHk-=wjphmrQXMfbw9j-tTzDvJ+Uc+asMHdFa=1_1xZoYVUC=g@mail.gmail.com>
        <CALCETrXvmZPHsfRVnW0AtyddfN-2zaCmWn+FsrF6XPTOFd_Jmw@mail.gmail.com>
        <CAHk-=whtt4K2f0KPtG-4Pykh3FK8UBOjD8jhXCUKB5nWDj_YRA@mail.gmail.com>
        <CALCETrWELBCK-kqX5FCEDVUy8kCT-yVu7m_7Dtn=GCsHY0Du5A@mail.gmail.com>
        <CAHk-=wgewK4eFhF3=0RNtk1KQjMANFH6oDE=8m=84RExn2gxhw@mail.gmail.com>
        <CAHk-=whay7eN6+2gZjY-ybRbkbcqAmgrLwwszzHx8ws3c=S-MA@mail.gmail.com>
        <CALCETrXzVU0Q7u1q=QFPaDr=aojjF5cjbOi9CxxXnp5GqTqsWA@mail.gmail.com>
        <CAHk-=wg1QPz0m+7jnVcjQgkySUQLzAXE8_PZARV-vWYK27LB=w@mail.gmail.com>
        <20190430135602.GD2589@hirez.programming.kicks-ass.net>
        <CAHk-=wg7vUGMRHyBsLig6qiPK0i4_BK3bRrTN+HHHziUGg1P_A@mail.gmail.com>
        <CALCETrXujRWxwkgAwB+8xja3N9H22t52AYBYM_mbrjKKZ624Eg@mail.gmail.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, 30 Apr 2019 09:33:51 -0700
Andy Lutomirski <luto@kernel.org> wrote:


> Linus, can I ask you to reconsider your opposition to Josh's other
> approach of just shifting the stack on int3 entry?  I agree that it's
> ugly, but the ugliness is easily manageable and fairly self-contained.
> We add a little bit of complication to the entry asm (but it's not
> like it's unprecedented -- the entry asm does all kinds of stack
> rearrangement due to IST and PTI crap already), and we add an
> int3_emulate_call(struct pt_regs *regs, unsigned long target) helper
> that has appropriate assertions that the stack is okay and emulates
> the call.  And that's it.

I also prefer Josh's stack shift solution, as I personally believe
that's a cleaner solution. But I went ahead and implemented Linus's
version to get it working for ftrace. Here's the code, and it survived
some preliminary tests.

There's three places that use the update code. One is the start of
every function call (yes, I counted that as one, and that case is
determined by: ftrace_location(ip)). The other is the trampoline itself
has an update. That could also be converted to a text poke, but for now
its here as it was written before text poke existed. The third place is
actually a jump (to the function graph code). But that can be safely
skipped if we are converting it, as it only goes from jump to nop, or
nop to jump.

The trampolines reflect this. Also, as NMI code is traced by ftrace, I
had to duplicate the trampolines for the nmi case (but only for the
interrupts disabled case as NMIs don't have interrupts enabled).

-- Steve

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index ef49517f6bb2..bf320bf791dd 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -17,6 +17,7 @@
 #include <linux/uaccess.h>
 #include <linux/ftrace.h>
 #include <linux/percpu.h>
+#include <linux/frame.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/init.h>
@@ -232,6 +233,9 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 
 static unsigned long ftrace_update_func;
 
+/* Used within inline asm below */
+unsigned long ftrace_update_func_call;
+
 static int update_ftrace_func(unsigned long ip, void *new)
 {
 	unsigned char old[MCOUNT_INSN_SIZE];
@@ -259,6 +263,8 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	unsigned char *new;
 	int ret;
 
+	ftrace_update_func_call = (unsigned long)func;
+
 	new = ftrace_call_replace(ip, (unsigned long)func);
 	ret = update_ftrace_func(ip, new);
 
@@ -280,6 +286,70 @@ static nokprobe_inline int is_ftrace_caller(unsigned long ip)
 	return 0;
 }
 
+extern asmlinkage void ftrace_emulate_call_irqon(void);
+extern asmlinkage void ftrace_emulate_call_irqoff(void);
+extern asmlinkage void ftrace_emulate_call_nmi(void);
+extern asmlinkage void ftrace_emulate_call_update_irqoff(void);
+extern asmlinkage void ftrace_emulate_call_update_irqon(void);
+extern asmlinkage void ftrace_emulate_call_update_nmi(void);
+
+static DEFINE_PER_CPU(void *, ftrace_bp_call_return);
+static DEFINE_PER_CPU(void *, ftrace_bp_call_nmi_return);
+
+asm(
+	".text\n"
+	".global ftrace_emulate_call_irqoff\n"
+	".type ftrace_emulate_call_irqoff, @function\n"
+	"ftrace_emulate_call_irqoff:\n\t"
+		"push %gs:ftrace_bp_call_return\n\t"
+		"sti\n\t"
+		"jmp ftrace_caller\n"
+	".size ftrace_emulate_call_irqoff, .-ftrace_emulate_call_irqoff\n"
+
+	".global ftrace_emulate_call_irqon\n"
+	".type ftrace_emulate_call_irqon, @function\n"
+	"ftrace_emulate_call_irqon:\n\t"
+		"push %gs:ftrace_bp_call_return\n\t"
+		"jmp ftrace_caller\n"
+	".size ftrace_emulate_call_irqon, .-ftrace_emulate_call_irqon\n"
+
+	".global ftrace_emulate_call_nmi\n"
+	".type ftrace_emulate_call_nmi, @function\n"
+	"ftrace_emulate_call_nmi:\n\t"
+		"push %gs:ftrace_bp_call_nmi_return\n\t"
+		"jmp ftrace_caller\n"
+	".size ftrace_emulate_call_nmi, .-ftrace_emulate_call_nmi\n"
+
+	".global ftrace_emulate_call_update_irqoff\n"
+	".type ftrace_emulate_call_update_irqoff, @function\n"
+	"ftrace_emulate_call_update_irqoff:\n\t"
+		"push %gs:ftrace_bp_call_return\n\t"
+		"sti\n\t"
+		"jmp *ftrace_update_func_call\n"
+	".size ftrace_emulate_call_update_irqoff, .-ftrace_emulate_call_update_irqoff\n"
+
+	".global ftrace_emulate_call_update_irqon\n"
+	".type ftrace_emulate_call_update_irqon, @function\n"
+	"ftrace_emulate_call_update_irqon:\n\t"
+		"push %gs:ftrace_bp_call_return\n\t"
+		"jmp *ftrace_update_func_call\n"
+	".size ftrace_emulate_call_update_irqon, .-ftrace_emulate_call_update_irqon\n"
+
+	".global ftrace_emulate_call_update_nmi\n"
+	".type ftrace_emulate_call_update_nmi, @function\n"
+	"ftrace_emulate_call_update_nmi:\n\t"
+		"push %gs:ftrace_bp_call_nmi_return\n\t"
+		"jmp *ftrace_update_func_call\n"
+	".size ftrace_emulate_call_update_nmi, .-ftrace_emulate_call_update_nmi\n"
+	".previous\n");
+
+STACK_FRAME_NON_STANDARD(ftrace_emulate_call_irqoff);
+STACK_FRAME_NON_STANDARD(ftrace_emulate_call_irqon);
+STACK_FRAME_NON_STANDARD(ftrace_emulate_call_nmi);
+STACK_FRAME_NON_STANDARD(ftrace_emulate_call_update_irqoff);
+STACK_FRAME_NON_STANDARD(ftrace_emulate_call_update_irqon);
+STACK_FRAME_NON_STANDARD(ftrace_emulate_call_update_nmi);
+
 /*
  * A breakpoint was added to the code address we are about to
  * modify, and this is the handle that will just skip over it.
@@ -295,10 +365,40 @@ int ftrace_int3_handler(struct pt_regs *regs)
 		return 0;
 
 	ip = regs->ip - 1;
-	if (!ftrace_location(ip) && !is_ftrace_caller(ip))
+	if (ftrace_location(ip)) {
+		if (in_nmi()) {
+			this_cpu_write(ftrace_bp_call_nmi_return, (void *)ip + MCOUNT_INSN_SIZE);
+			regs->ip = (unsigned long) ftrace_emulate_call_nmi;
+			return 1;
+		}
+		this_cpu_write(ftrace_bp_call_return, (void *)ip + MCOUNT_INSN_SIZE);
+		if (regs->flags & X86_EFLAGS_IF) {
+			regs->flags &= ~X86_EFLAGS_IF;
+			regs->ip = (unsigned long) ftrace_emulate_call_irqoff;
+		} else {
+			regs->ip = (unsigned long) ftrace_emulate_call_irqon;
+		}
+	} else if (is_ftrace_caller(ip)) {
+		/* If it's a jump, just need to skip it */
+		if (!ftrace_update_func_call) {
+			regs->ip += MCOUNT_INSN_SIZE -1;
+			return 1;
+		}
+		if (in_nmi()) {
+			this_cpu_write(ftrace_bp_call_nmi_return, (void *)ip + MCOUNT_INSN_SIZE);
+			regs->ip = (unsigned long) ftrace_emulate_call_update_nmi;
+			return 1;
+		}
+		this_cpu_write(ftrace_bp_call_return, (void *)ip + MCOUNT_INSN_SIZE);
+		if (regs->flags & X86_EFLAGS_IF) {
+			regs->flags &= ~X86_EFLAGS_IF;
+			regs->ip = (unsigned long) ftrace_emulate_call_update_irqoff;
+		} else {
+			regs->ip = (unsigned long) ftrace_emulate_call_update_irqon;
+		}
+	} else {
 		return 0;
-
-	regs->ip += MCOUNT_INSN_SIZE - 1;
+	}
 
 	return 1;
 }
@@ -859,6 +959,8 @@ void arch_ftrace_update_trampoline(struct ftrace_ops *ops)
 
 	func = ftrace_ops_get_func(ops);
 
+	ftrace_update_func_call = (unsigned long)func;
+
 	/* Do a safe modify in case the trampoline is executing */
 	new = ftrace_call_replace(ip, (unsigned long)func);
 	ret = update_ftrace_func(ip, new);
@@ -960,6 +1062,7 @@ static int ftrace_mod_jmp(unsigned long ip, void *func)
 {
 	unsigned char *new;
 
+	ftrace_update_func_call = 0;
 	new = ftrace_jmp_replace(ip, (unsigned long)func);
 
 	return update_ftrace_func(ip, new);

