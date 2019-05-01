Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D34D10829
	for <lists+linux-kselftest@lfdr.de>; Wed,  1 May 2019 15:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfEANLq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 1 May 2019 09:11:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54864 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726379AbfEANLq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 1 May 2019 09:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=AvGPznCE/iTe70MAZQn4mQb36PI2YYyXOJY8LHdHlgw=; b=R4hF8eF9hTBjLGxW2NxWd3MM9
        vW2/H0HyoIZbBdmeNnU/WVjxPxRc4wFen5tS8dDHP+17WlzVHGdkQb2sY2fnDQBs/jYE1VaY2schf
        f92m7BaViu1LwVvZxzXiR1ctga65HMuCiochguH7rUdfv3LLiIEu9ZVIgoqruqtqYPYyCtK3Gh4Cw
        eTeLbX8nf5LnmoeBMcMLdsVoF0SOtIDN9U6xYOFTyK4BNiMwUq0T88W9JPaOgj9jtucgP6szd3g3r
        ufL1fvl4L4IIQcNrP4tlPK/TCPQCi4KHXE6kPlm3YmQSuBWpjS2AHc/t3TAbfHba18+zoMoIIFTH6
        QtIDGDoOw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLp15-0003kh-Op; Wed, 01 May 2019 13:11:20 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4D4DB28691894; Wed,  1 May 2019 15:11:17 +0200 (CEST)
Date:   Wed, 1 May 2019 15:11:17 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Andy Lutomirski <luto@kernel.org>,
        Nicolai Stange <nstange@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
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
Subject: Re: [RFC][PATCH] ftrace/x86: Emulate call function while updating in
 breakpoint handler
Message-ID: <20190501131117.GW2623@hirez.programming.kicks-ass.net>
References: <CAHk-=whay7eN6+2gZjY-ybRbkbcqAmgrLwwszzHx8ws3c=S-MA@mail.gmail.com>
 <CALCETrXzVU0Q7u1q=QFPaDr=aojjF5cjbOi9CxxXnp5GqTqsWA@mail.gmail.com>
 <CAHk-=wg1QPz0m+7jnVcjQgkySUQLzAXE8_PZARV-vWYK27LB=w@mail.gmail.com>
 <20190430135602.GD2589@hirez.programming.kicks-ass.net>
 <CAHk-=wg7vUGMRHyBsLig6qiPK0i4_BK3bRrTN+HHHziUGg1P_A@mail.gmail.com>
 <CALCETrXujRWxwkgAwB+8xja3N9H22t52AYBYM_mbrjKKZ624Eg@mail.gmail.com>
 <20190430130359.330e895b@gandalf.local.home>
 <20190430132024.0f03f5b8@gandalf.local.home>
 <20190430134913.4e29ce72@gandalf.local.home>
 <CAHk-=wjJ8D74+FDcXGL65Q9aB0cc7B4vr2s2rS6V4d4a3hU-1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjJ8D74+FDcXGL65Q9aB0cc7B4vr2s2rS6V4d4a3hU-1Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

On Tue, Apr 30, 2019 at 11:33:21AM -0700, Linus Torvalds wrote:
> Anyway, since Andy really likes the entry code change, can we have
> that patch in parallel and judge the difference that way? Iirc, that
> was x86-64 specific too.

Here goes, compile tested only...

It obviously needs a self-test, but that shoulnd't be too hard to
arrange.

---
 arch/x86/entry/entry_32.S            |  7 +++++++
 arch/x86/entry/entry_64.S            | 14 ++++++++++++--
 arch/x86/include/asm/text-patching.h | 20 ++++++++++++++++++++
 arch/x86/kernel/ftrace.c             | 24 +++++++++++++++++++-----
 4 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 7b23431be5cb..d246302085a3 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -1479,6 +1479,13 @@ ENTRY(int3)
 	ASM_CLAC
 	pushl	$-1				# mark this as an int
 
+	testl	$SEGMENT_RPL_MASK, PT_CS(%esp)
+	jnz	.Lfrom_usermode_no_gap
+	.rept 6
+	pushl	5*4(%esp)
+	.endr
+.Lfrom_usermode_no_gap:
+
 	SAVE_ALL switch_stacks=1
 	ENCODE_FRAME_POINTER
 	TRACE_IRQS_OFF
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 20e45d9b4e15..268cd9affe04 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -878,7 +878,7 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
  * @paranoid == 2 is special: the stub will never switch stacks.  This is for
  * #DF: if the thread stack is somehow unusable, we'll still get a useful OOPS.
  */
-.macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1 ist_offset=0
+.macro idtentry sym do_sym has_error_code:req paranoid=0 shift_ist=-1 ist_offset=0 create_gap=0
 ENTRY(\sym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
 
@@ -898,6 +898,16 @@ ENTRY(\sym)
 	jnz	.Lfrom_usermode_switch_stack_\@
 	.endif
 
+	.if \create_gap == 1
+	testb	$3, CS-ORIG_RAX(%rsp)
+	jnz	.Lfrom_usermode_no_gap_\@
+	.rept 6
+	pushq	5*8(%rsp)
+	.endr
+	UNWIND_HINT_IRET_REGS offset=8
+.Lfrom_usermode_no_gap_\@:
+	.endif
+
 	.if \paranoid
 	call	paranoid_entry
 	.else
@@ -1129,7 +1139,7 @@ apicinterrupt3 HYPERV_STIMER0_VECTOR \
 #endif /* CONFIG_HYPERV */
 
 idtentry debug			do_debug		has_error_code=0	paranoid=1 shift_ist=IST_INDEX_DB ist_offset=DB_STACK_OFFSET
-idtentry int3			do_int3			has_error_code=0
+idtentry int3			do_int3			has_error_code=0	create_gap=1
 idtentry stack_segment		do_stack_segment	has_error_code=1
 
 #ifdef CONFIG_XEN_PV
diff --git a/arch/x86/include/asm/text-patching.h b/arch/x86/include/asm/text-patching.h
index e85ff65c43c3..ba275b6292db 100644
--- a/arch/x86/include/asm/text-patching.h
+++ b/arch/x86/include/asm/text-patching.h
@@ -39,4 +39,24 @@ extern int poke_int3_handler(struct pt_regs *regs);
 extern void *text_poke_bp(void *addr, const void *opcode, size_t len, void *handler);
 extern int after_bootmem;
 
+static inline void int3_emulate_push(struct pt_regs *regs, unsigned long val)
+{
+	regs->sp -= sizeof(unsigned long);
+	*(unsigned long *)regs->sp = val;
+}
+
+static inline void int3_emulate_jmp(struct pt_regs *regs, unsigned long ip)
+{
+	regs->ip = ip;
+}
+
+#define INT3_INSN_SIZE 1
+#define CALL_INSN_SIZE 5
+
+static inline void int3_emulate_call(struct pt_regs *regs, unsigned long func)
+{
+	int3_emulate_push(regs, regs->ip - INT3_INSN_SIZE + CALL_INSN_SIZE);
+	int3_emulate_jmp(regs, func);
+}
+
 #endif /* _ASM_X86_TEXT_PATCHING_H */
diff --git a/arch/x86/kernel/ftrace.c b/arch/x86/kernel/ftrace.c
index ef49517f6bb2..90d319687d7e 100644
--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -29,6 +29,7 @@
 #include <asm/kprobes.h>
 #include <asm/ftrace.h>
 #include <asm/nops.h>
+#include <asm/text-patching.h>
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
@@ -231,6 +232,7 @@ int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 }
 
 static unsigned long ftrace_update_func;
+static unsigned long ftrace_update_func_call;
 
 static int update_ftrace_func(unsigned long ip, void *new)
 {
@@ -259,6 +261,8 @@ int ftrace_update_ftrace_func(ftrace_func_t func)
 	unsigned char *new;
 	int ret;
 
+	ftrace_update_func_call = (unsigned long)func;
+
 	new = ftrace_call_replace(ip, (unsigned long)func);
 	ret = update_ftrace_func(ip, new);
 
@@ -295,12 +299,19 @@ int ftrace_int3_handler(struct pt_regs *regs)
 		return 0;
 
 	ip = regs->ip - 1;
-	if (!ftrace_location(ip) && !is_ftrace_caller(ip))
-		return 0;
-
-	regs->ip += MCOUNT_INSN_SIZE - 1;
+	if (ftrace_location(ip)) {
+		int3_emulate_call(regs, ftrace_update_func_call);
+		return 1;
+	} else if (is_ftrace_caller(ip)) {
+		if (!ftrace_update_func_call) {
+			int3_emulate_jmp(regs, regs->ip - INT3_INSN_SIZE + CALL_INSN_SIZE);
+			return 1;
+		}
+		int3_emulate_call(regs, ftrace_update_func_call);
+		return 1;
+	}
 
-	return 1;
+	return 0;
 }
 NOKPROBE_SYMBOL(ftrace_int3_handler);
 
@@ -859,6 +870,8 @@ void arch_ftrace_update_trampoline(struct ftrace_ops *ops)
 
 	func = ftrace_ops_get_func(ops);
 
+	ftrace_update_func_call = (unsigned long)func;
+
 	/* Do a safe modify in case the trampoline is executing */
 	new = ftrace_call_replace(ip, (unsigned long)func);
 	ret = update_ftrace_func(ip, new);
@@ -960,6 +973,7 @@ static int ftrace_mod_jmp(unsigned long ip, void *func)
 {
 	unsigned char *new;
 
+	ftrace_update_func_call = 0UL;
 	new = ftrace_jmp_replace(ip, (unsigned long)func);
 
 	return update_ftrace_func(ip, new);
