Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0FE10A16
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2019 17:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbfEAPcn (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 May 2019 11:32:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:42220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726586AbfEAPcn (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 May 2019 11:32:43 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE1B0208C3;
        Wed,  1 May 2019 15:32:39 +0000 (UTC)
Date:   Wed, 1 May 2019 11:32:38 -0400
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
Subject: [RFC][PATCH v3] ftrace/x86_64: Emulate call function while updating
 in breakpoint handler
Message-ID: <20190501113238.0ab3f9dd@gandalf.local.home>
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

Changes since v2:

  - Moved inline asm to ftrace_64.S
  - Used PER_CPU_VAR() and TRACE_IRQS_ON macros in assembly
  - Renamed trampolines to be a little more coherent
  - Created assembly version of STACK_FRAME_NON_STANDARD() in asm/frame.h
  - Call ftrace_regs_caller instead of ftrace_caller
  - No longer support 32 bit (it crashed badly on tests, and I couldn't figure it out)


 arch/x86/include/asm/frame.h |  15 ++++++
 arch/x86/kernel/ftrace.c     | 102 ++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/ftrace_64.S  |  56 +++++++++++++++++++
 3 files changed, 172 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/frame.h b/arch/x86/include/asm/frame.h
index 5cbce6fbb534..04892b374b93 100644
--- a/arch/x86/include/asm/frame.h
+++ b/arch/x86/include/asm/frame.h
@@ -42,4 +42,19 @@
 
 #endif /* CONFIG_FRAME_POINTER */
 
+#ifdef __ASSEMBLY__
+#ifdef CONFIG_STACK_VALIDATION
+#define STACK_FRAME_NON_STANDARD(func)					\
+.section        .discard.func_stack_frame_non_standard,"aw";		\
+.align 8;								\
+.type		__func_stack_frame_non_standard_##func, @object;	\
+.size		__func_stack_frame_non_standard_##func, 8;		\
+__func_stack_frame_non_standard_##func:					\
+.quad		func;							\
+.previous
+#else /* !CONFIG_STACK_VALIDATION */
+#define STACK_FRAME_NON_STANDARD(func)
+#endif /* CONFIG_STACK_VALIDATION */
+#endif /* __ASSEMBLY__ */
+
 #endif /* _ASM_X86_FRAME_H */
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index ef49517f6bb2..634fc0d4fe97 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -232,6 +232,9 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 
 static unsigned long ftrace_update_func;
 
+/* Used within inline asm below */
+unsigned long ftrace_update_func_call;
+
 static int update_ftrace_func(unsigned long ip, void *new)
 {
 	unsigned char old[MCOUNT_INSN_SIZE];
@@ -259,6 +262,8 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	unsigned char *new;
 	int ret;
 
+	ftrace_update_func_call = (unsigned long)func;
+
 	new = ftrace_call_replace(ip, (unsigned long)func);
 	ret = update_ftrace_func(ip, new);
 
@@ -280,6 +285,46 @@ static nokprobe_inline int is_ftrace_caller(unsigned long ip)
 	return 0;
 }
 
+#ifdef CONFIG_X86_64
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
+extern asmlinkage void ftrace_emulate_call_sti(void);
+extern asmlinkage void ftrace_emulate_call(void);
+extern asmlinkage void ftrace_emulate_call_nmi(void);
+extern asmlinkage void ftrace_emulate_call_update_sti(void);
+extern asmlinkage void ftrace_emulate_call_update(void);
+extern asmlinkage void ftrace_emulate_call_update_nmi(void);
+
+DEFINE_PER_CPU(void *, ftrace_bp_call_return);
+DEFINE_PER_CPU(void *, ftrace_bp_call_nmi_return);
+
+/* To hold the ftrace_regs_caller address to push on the stack */
+void *ftrace_caller_func = (void *)ftrace_regs_caller;
+
 /*
  * A breakpoint was added to the code address we are about to
  * modify, and this is the handle that will just skip over it.
@@ -291,6 +336,58 @@ int ftrace_int3_handler(struct pt_regs *regs)
 {
 	unsigned long ip;
 
+	if (WARN_ON_ONCE(!regs))
+		return 0;
+
+	ip = regs->ip - 1;
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
+			regs->ip = (unsigned long) ftrace_emulate_call_sti;
+			/* Tell lockdep here we are enabling interrupts */
+			lockdep_hardirqs_on(_THIS_IP_);
+		} else {
+			regs->ip = (unsigned long) ftrace_emulate_call;
+		}
+		return 1;
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
+			regs->ip = (unsigned long) ftrace_emulate_call_update_sti;
+		} else {
+			regs->ip = (unsigned long) ftrace_emulate_call_update;
+		}
+		return 1;
+	}
+
+	return 0;
+}
+#else /* !X86_64 */
+int ftrace_int3_handler(struct pt_regs *regs)
+{
+	unsigned long ip;
+
 	if (WARN_ON_ONCE(!regs))
 		return 0;
 
@@ -299,9 +396,9 @@ int ftrace_int3_handler(struct pt_regs *regs)
 		return 0;
 
 	regs->ip += MCOUNT_INSN_SIZE - 1;
-
 	return 1;
 }
+#endif
 NOKPROBE_SYMBOL(ftrace_int3_handler);
 
 static int ftrace_write(unsigned long ip, const char *val, int size)
@@ -859,6 +956,8 @@ void arch_ftrace_update_trampoline(struct ftrace_ops *ops)
 
 	func = ftrace_ops_get_func(ops);
 
+	ftrace_update_func_call = (unsigned long)func;
+
 	/* Do a safe modify in case the trampoline is executing */
 	new = ftrace_call_replace(ip, (unsigned long)func);
 	ret = update_ftrace_func(ip, new);
@@ -960,6 +1059,7 @@ static int ftrace_mod_jmp(unsigned long ip, void *func)
 {
 	unsigned char *new;
 
+	ftrace_update_func_call = 0;
 	new = ftrace_jmp_replace(ip, (unsigned long)func);
 
 	return update_ftrace_func(ip, new);
diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 75f2b36b41a6..8642e1719370 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -9,6 +9,9 @@
 #include <asm/export.h>
 #include <asm/nospec-branch.h>
 #include <asm/unwind_hints.h>
+#include <asm/irqflags.h>
+#include <asm/percpu.h>
+#include <asm/frame.h>
 
 	.code64
 	.section .entry.text, "ax"
@@ -262,6 +265,59 @@ GLOBAL(ftrace_regs_caller_end)
 ENDPROC(ftrace_regs_caller)
 
 
+/* Trampoline for function update with interrupts enabled */
+GLOBAL(ftrace_emulate_call_sti)
+	push PER_CPU_VAR(ftrace_bp_call_return)
+	push ftrace_caller_func
+	TRACE_IRQS_ON
+	sti
+	ret
+ENDPROC(ftrace_emulate_call_sti)
+
+/* Trampoline for function update with interrupts disabled*/
+GLOBAL(ftrace_emulate_call)
+	push PER_CPU_VAR(ftrace_bp_call_return)
+	push ftrace_caller_func
+	ret
+ENDPROC(ftrace_emulate_call)
+
+/* Trampoline for function update in an NMI */
+GLOBAL(ftrace_emulate_call_nmi)
+	push PER_CPU_VAR(ftrace_bp_call_nmi_return)
+	push ftrace_caller_func
+	ret
+ENDPROC(ftrace_emulate_call_nmi)
+
+/* Trampoline for ftrace trampoline call update with interrupts enabled */
+GLOBAL(ftrace_emulate_call_update_sti)
+	push PER_CPU_VAR(ftrace_bp_call_return)
+	push ftrace_update_func_call
+	TRACE_IRQS_ON
+	sti
+	ret
+ENDPROC(ftrace_emulate_call_update_sti)
+
+/* Trampoline for ftrace trampoline call update with interrupts disabled */
+GLOBAL(ftrace_emulate_call_update)
+	push PER_CPU_VAR(ftrace_bp_call_return)
+	push ftrace_update_func_call
+	ret
+ENDPROC(ftrace_emulate_call_update)
+
+/* Trampoline for ftrace trampoline call update in an NMI */
+GLOBAL(ftrace_emulate_call_update_nmi)
+	push PER_CPU_VAR(ftrace_bp_call_nmi_return)
+	push ftrace_update_func_call
+	ret
+ENDPROC(ftrace_emulate_call_update_nmi)
+
+STACK_FRAME_NON_STANDARD(ftrace_emulate_call_sti)
+STACK_FRAME_NON_STANDARD(ftrace_emulate_call)
+STACK_FRAME_NON_STANDARD(ftrace_emulate_call_nmi)
+STACK_FRAME_NON_STANDARD(ftrace_emulate_call_update_sti)
+STACK_FRAME_NON_STANDARD(ftrace_emulate_call_update)
+STACK_FRAME_NON_STANDARD(ftrace_emulate_call_update_nmi)
+
 #else /* ! CONFIG_DYNAMIC_FTRACE */
 
 ENTRY(function_hook)
-- 
2.20.1

