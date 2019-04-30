Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA1E2FF19
	for <lists+linux-kselftest@lfdr.de>; Tue, 30 Apr 2019 19:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbfD3RtT (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 30 Apr 2019 13:49:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:54242 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725942AbfD3RtT (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 30 Apr 2019 13:49:19 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C86320835;
        Tue, 30 Apr 2019 17:49:15 +0000 (UTC)
Date:   Tue, 30 Apr 2019 13:49:13 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
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
Subject: [RFC][PATCH] ftrace/x86: Emulate call function while updating in
 breakpoint handler
Message-ID: <20190430134913.4e29ce72@gandalf.local.home>
In-Reply-To: <20190430132024.0f03f5b8@gandalf.local.home>
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
        <20190430130359.330e895b@gandalf.local.home>
        <20190430132024.0f03f5b8@gandalf.local.home>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org


From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>


Nicolai Stange discovered[1] that if live kernel patching is enabled, and the
function tracer started tracing the same function that was patched, the
conversion of the fentry call site during the translation of going from
calling the live kernel patch trampoline to the iterator trampoline, would
have as slight window where it didn't call anything.

As live kernel patching depends on ftrace to always call its code (to
prevent the function being traced from being called, as it will redirect
it). This small window would allow the old buggy function to be called, and
this can cause undesirable results.

Nicolai submitted new patches[2] but these were controversial. As this is
similar to the static call emulation issues that came up a while ago[3],
Linus suggested using per CPU data along with special trampolines[4] to emulate
the calls.

Linus's solution was for text poke (which was mostly what the static_call
code did), but as ftrace has its own mechanism, it required doing its own
thing.

Having ftrace use its own per CPU data and having its own set of specialized
trampolines solves the issue of missed calls that live kernel patching
suffers.

[1] http://lkml.kernel.org/r/20180726104029.7736-1-nstange@suse.de
[2] http://lkml.kernel.org/r/20190427100639.15074-1-nstange@suse.de
[3] http://lkml.kernel.org/r/3cf04e113d71c9f8e4be95fb84a510f085aa4afa.1541711457.git.jpoimboe@redhat.com
[4] http://lkml.kernel.org/r/CAHk-=wh5OpheSU8Em_Q3Hg8qw_JtoijxOdPtHru6d+5K8TWM=A@mail.gmail.com

Inspired-by: Linus Torvalds <torvalds@linux-foundation.org>
Cc: stable@vger.kernel.org
Fixes: b700e7f03df5 ("livepatch: kernel: add support for live patching")
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/kernel/ftrace.c | 146 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 143 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index ef49517f6bb2..835277043348 100644
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
 
@@ -280,6 +286,103 @@ static nokprobe_inline int is_ftrace_caller(unsigned long ip)
 	return 0;
 }
 
+/*
+ * We need to handle the "call func1" -> "call func2" case.
+ * Just skipping the call is not sufficient as it will be like
+ * changing to "nop" first and then updating the call. But some
+ * users of ftrace require calls never to be missed.
+ *
+ * To emulate the call while converting the call site with a breakpoint,
+ * some trampolines are used along with per CPU buffers.
+ * There are three trampolines for the call sites and three trampolines
+ * for the updating of the call in ftrace trampoline. The three
+ * trampolines are:
+ *
+ * 1) Interrupts are enabled when the breakpoint is hit
+ * 2) Interrupts are disabled when the breakpoint is hit
+ * 3) The breakpoint was hit in an NMI
+ *
+ * As per CPU data is used, interrupts must be disabled to prevent them
+ * from corrupting the data. A separate NMI trampoline is used for the
+ * NMI case. If interrupts are already disabled, then the return path
+ * of where the breakpoint was hit (saved in the per CPU data) is pushed
+ * on the stack and then a jump to either the ftrace_caller (which will
+ * loop through all registered ftrace_ops handlers depending on the ip
+ * address), or if its a ftrace trampoline call update, it will call
+ * ftrace_update_func_call which will hold the call that should be
+ * called.
+ */
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
+
+	/* Trampoline for function update with interrupts enabled */
+	".global ftrace_emulate_call_irqoff\n"
+	".type ftrace_emulate_call_irqoff, @function\n"
+	"ftrace_emulate_call_irqoff:\n\t"
+		"push %gs:ftrace_bp_call_return\n\t"
+		"sti\n\t"
+		"jmp ftrace_caller\n"
+	".size ftrace_emulate_call_irqoff, .-ftrace_emulate_call_irqoff\n"
+
+	/* Trampoline for function update with interrupts disabled*/
+	".global ftrace_emulate_call_irqon\n"
+	".type ftrace_emulate_call_irqon, @function\n"
+	"ftrace_emulate_call_irqon:\n\t"
+		"push %gs:ftrace_bp_call_return\n\t"
+		"jmp ftrace_caller\n"
+	".size ftrace_emulate_call_irqon, .-ftrace_emulate_call_irqon\n"
+
+	/* Trampoline for function update in an NMI */
+	".global ftrace_emulate_call_nmi\n"
+	".type ftrace_emulate_call_nmi, @function\n"
+	"ftrace_emulate_call_nmi:\n\t"
+		"push %gs:ftrace_bp_call_nmi_return\n\t"
+		"jmp ftrace_caller\n"
+	".size ftrace_emulate_call_nmi, .-ftrace_emulate_call_nmi\n"
+
+	/* Trampoline for ftrace trampoline call update with interrupts enabled */
+	".global ftrace_emulate_call_update_irqoff\n"
+	".type ftrace_emulate_call_update_irqoff, @function\n"
+	"ftrace_emulate_call_update_irqoff:\n\t"
+		"push %gs:ftrace_bp_call_return\n\t"
+		"sti\n\t"
+		"jmp *ftrace_update_func_call\n"
+	".size ftrace_emulate_call_update_irqoff, .-ftrace_emulate_call_update_irqoff\n"
+
+	/* Trampoline for ftrace trampoline call update with interrupts disabled */
+	".global ftrace_emulate_call_update_irqon\n"
+	".type ftrace_emulate_call_update_irqon, @function\n"
+	"ftrace_emulate_call_update_irqon:\n\t"
+		"push %gs:ftrace_bp_call_return\n\t"
+		"jmp *ftrace_update_func_call\n"
+	".size ftrace_emulate_call_update_irqon, .-ftrace_emulate_call_update_irqon\n"
+
+	/* Trampoline for ftrace trampoline call update in an NMI */
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
@@ -295,10 +398,44 @@ int ftrace_int3_handler(struct pt_regs *regs)
 		return 0;
 
 	ip = regs->ip - 1;
-	if (!ftrace_location(ip) && !is_ftrace_caller(ip))
+	if (ftrace_location(ip)) {
+		/* A breakpoint at the beginning of the function was hit */
+		if (in_nmi()) {
+			/* NMIs have their own trampoline */
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
+		/* An ftrace trampoline is being updated */
+		if (!ftrace_update_func_call) {
+			/* If it's a jump, just need to skip it */
+			regs->ip += MCOUNT_INSN_SIZE -1;
+			return 1;
+		}
+		if (in_nmi()) {
+			/* NMIs have their own trampoline */
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
@@ -859,6 +996,8 @@ void arch_ftrace_update_trampoline(struct ftrace_ops *ops)
 
 	func = ftrace_ops_get_func(ops);
 
+	ftrace_update_func_call = (unsigned long)func;
+
 	/* Do a safe modify in case the trampoline is executing */
 	new = ftrace_call_replace(ip, (unsigned long)func);
 	ret = update_ftrace_func(ip, new);
@@ -960,6 +1099,7 @@ static int ftrace_mod_jmp(unsigned long ip, void *func)
 {
 	unsigned char *new;
 
+	ftrace_update_func_call = 0;
 	new = ftrace_jmp_replace(ip, (unsigned long)func);
 
 	return update_ftrace_func(ip, new);
-- 
2.20.1

