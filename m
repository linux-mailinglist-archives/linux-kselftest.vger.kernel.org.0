Return-Path: <linux-kselftest+bounces-22292-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9269D2A56
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 17:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1A2DB3532D
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Nov 2024 15:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF9D1D1512;
	Tue, 19 Nov 2024 15:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LE1NBLiU"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEDA1CFEC9
	for <linux-kselftest@vger.kernel.org>; Tue, 19 Nov 2024 15:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732030742; cv=none; b=ZvekgnO1DrifuMIcmL0cyX1S18HxivtD9qODzuAx4px4YcrxaOkGY13IhDYmJ37oQgsnZ6riSJDEsN1d8EBqop0Ty5Epic3avLn4913xqafwDkCjaLfFriHrtZEPuIQNOtKppGGNvJ7yeChgxiLf4skUn8R/hutiJREe9FYqn0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732030742; c=relaxed/simple;
	bh=Ehnt0BxdQ77p1LjEevHZqtmZgJlHu3XHS7C6LkZB1xY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qVWe+HYsPaxyNZeOVivugN6gDFkbCIj2+BzOtt06Em9d4b3r9Os8IPZf/vgFPoR6XdS5n24sPXlrT0kXuWIiO5UGWEyRM/xzhR8Re3foklwn9d5bDIzsboKfVwFhdri2tlkiOACxBux2rWUuaVriJMNEl8dA8a3detH9ciBkYOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LE1NBLiU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1732030739;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gBDFZv8Y0YCT5rYDqfeJn3PBG/oi2+BA7C4xITE08vE=;
	b=LE1NBLiUCdqlGgipkSjRIq9lmJ+0CFfcD2RYHf2kML54+z1aJAaygqViyAYlbPFTxqtl31
	jCvQ9XhgbO+10+RuxFZ3NxUrqRpklOBaK+S4b+FpkeKToUUn++KlOYQQbC7IIyiCqb0HP0
	IdIsdIKxFRW+QZu0TeswUEcNacuKIdM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-146-YBGQR59uOBaV7Ovj9k6N-g-1; Tue,
 19 Nov 2024 10:38:56 -0500
X-MC-Unique: YBGQR59uOBaV7Ovj9k6N-g-1
X-Mimecast-MFC-AGG-ID: YBGQR59uOBaV7Ovj9k6N-g
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 466291952D29;
	Tue, 19 Nov 2024 15:38:49 +0000 (UTC)
Received: from vschneid-thinkpadt14sgen2i.remote.csb (unknown [10.39.194.94])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 569B930001A2;
	Tue, 19 Nov 2024 15:38:33 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	x86@kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Nicolas Saenz Julienne <nsaenzju@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Kees Cook <keescook@chromium.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Juerg Haefliger <juerg.haefliger@canonical.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Nadav Amit <namit@vmware.com>,
	Dan Carpenter <error27@gmail.com>,
	Chuang Wang <nashuiliang@gmail.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Petr Mladek <pmladek@suse.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Song Liu <song@kernel.org>,
	Julian Pidancet <julian.pidancet@oracle.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>,
	Daniel Wagner <dwagner@suse.de>,
	Petr Tesarik <ptesarik@suse.com>
Subject: [RFC PATCH v3 11/15] context-tracking: Introduce work deferral infrastructure
Date: Tue, 19 Nov 2024 16:34:58 +0100
Message-ID: <20241119153502.41361-12-vschneid@redhat.com>
In-Reply-To: <20241119153502.41361-1-vschneid@redhat.com>
References: <20241119153502.41361-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

smp_call_function() & friends have the unfortunate habit of sending IPIs to
isolated, NOHZ_FULL, in-userspace CPUs, as they blindly target all online
CPUs.

Some callsites can be bent into doing the right, such as done by commit:

  cc9e303c91f5 ("x86/cpu: Disable frequency requests via aperfmperf IPI for nohz_full CPUs")

Unfortunately, not all SMP callbacks can be omitted in this
fashion. However, some of them only affect execution in kernelspace, which
means they don't have to be executed *immediately* if the target CPU is in
userspace: stashing the callback and executing it upon the next kernel entry
would suffice. x86 kernel instruction patching or kernel TLB invalidation
are prime examples of it.

Reduce the RCU dynticks counter width to free up some bits to be used as a
deferred callback bitmask. Add some build-time checks to validate that
setup.

Presence of CT_STATE_KERNEL in the ct_state prevents queuing deferred work.

Later commits introduce the bit:callback mappings.

Link: https://lore.kernel.org/all/20210929151723.162004989@infradead.org/
Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 arch/Kconfig                                 |  9 ++++
 arch/x86/Kconfig                             |  1 +
 arch/x86/include/asm/context_tracking_work.h | 14 ++++++
 include/linux/context_tracking.h             | 21 +++++++++
 include/linux/context_tracking_state.h       | 30 ++++++++-----
 include/linux/context_tracking_work.h        | 26 +++++++++++
 kernel/context_tracking.c                    | 46 +++++++++++++++++++-
 kernel/time/Kconfig                          |  5 +++
 8 files changed, 140 insertions(+), 12 deletions(-)
 create mode 100644 arch/x86/include/asm/context_tracking_work.h
 create mode 100644 include/linux/context_tracking_work.h

diff --git a/arch/Kconfig b/arch/Kconfig
index bd9f095d69fa0..e7f3f797a34a4 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -912,6 +912,15 @@ config HAVE_CONTEXT_TRACKING_USER_OFFSTACK
 	  - No use of instrumentation, unless instrumentation_begin() got
 	    called.
 
+config HAVE_CONTEXT_TRACKING_WORK
+	bool
+	help
+	  Architecture supports deferring work while not in kernel context.
+	  This is especially useful on setups with isolated CPUs that might
+	  want to avoid being interrupted to perform housekeeping tasks (for
+	  ex. TLB invalidation or icache invalidation). The housekeeping
+	  operations are performed upon re-entering the kernel.
+
 config HAVE_TIF_NOHZ
 	bool
 	help
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 16354dfa6d965..c703376dd326b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -213,6 +213,7 @@ config X86
 	select HAVE_CMPXCHG_LOCAL
 	select HAVE_CONTEXT_TRACKING_USER		if X86_64
 	select HAVE_CONTEXT_TRACKING_USER_OFFSTACK	if HAVE_CONTEXT_TRACKING_USER
+	select HAVE_CONTEXT_TRACKING_WORK		if X86_64
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_OBJTOOL_MCOUNT		if HAVE_OBJTOOL
 	select HAVE_OBJTOOL_NOP_MCOUNT		if HAVE_OBJTOOL_MCOUNT
diff --git a/arch/x86/include/asm/context_tracking_work.h b/arch/x86/include/asm/context_tracking_work.h
new file mode 100644
index 0000000000000..5bc29e6b2ed38
--- /dev/null
+++ b/arch/x86/include/asm/context_tracking_work.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_CONTEXT_TRACKING_WORK_H
+#define _ASM_X86_CONTEXT_TRACKING_WORK_H
+
+static __always_inline void arch_context_tracking_work(int work)
+{
+	switch (work) {
+	case CONTEXT_WORK_n:
+		// Do work...
+		break;
+	}
+}
+
+#endif
diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index af9fe87a09225..16a2eb7525f1f 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -5,6 +5,7 @@
 #include <linux/sched.h>
 #include <linux/vtime.h>
 #include <linux/context_tracking_state.h>
+#include <linux/context_tracking_work.h>
 #include <linux/instrumentation.h>
 
 #include <asm/ptrace.h>
@@ -137,6 +138,26 @@ static __always_inline unsigned long ct_state_inc(int incby)
 	return raw_atomic_add_return(incby, this_cpu_ptr(&context_tracking.state));
 }
 
+#ifdef CONTEXT_TRACKING_WORK
+static __always_inline unsigned long ct_state_inc_clear_work(int incby)
+{
+	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
+	unsigned long new, old, state;
+
+	state = arch_atomic_read(&ct->state);
+	do {
+		old = state;
+		new = old & ~CONTEXT_WORK_MASK;
+		new += incby;
+		state = arch_atomic_cmpxchg(&ct->state, old, new);
+	} while (old != state);
+
+	return new;
+}
+#else
+#define ct_state_inc_clear_work(x) ct_state_inc(x)
+#endif
+
 static __always_inline bool warn_rcu_enter(void)
 {
 	bool ret = false;
diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 0b81248aa03e2..d1d37dbdf7195 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -5,6 +5,7 @@
 #include <linux/percpu.h>
 #include <linux/static_key.h>
 #include <linux/context_tracking_irq.h>
+#include <linux/context_tracking_work.h>
 
 /* Offset to allow distinguishing irq vs. task-based idle entry/exit. */
 #define CT_NESTING_IRQ_NONIDLE	((LONG_MAX / 2) + 1)
@@ -39,16 +40,19 @@ struct context_tracking {
 };
 
 /*
- * We cram two different things within the same atomic variable:
+ * We cram up to three different things within the same atomic variable:
  *
- *                     CT_RCU_WATCHING_START  CT_STATE_START
- *                                |                |
- *                                v                v
- *     MSB [ RCU watching counter ][ context_state ] LSB
- *         ^                       ^
- *         |                       |
- * CT_RCU_WATCHING_END        CT_STATE_END
+ *                     CT_RCU_WATCHING_START                  CT_STATE_START
+ *                                |         CT_WORK_START          |
+ *                                |               |                |
+ *                                v               v                v
+ *     MSB [ RCU watching counter ][ context work ][ context_state ] LSB
+ *         ^                       ^               ^
+ *         |                       |               |
+ *         |                  CT_WORK_END          |
+ * CT_RCU_WATCHING_END                        CT_STATE_END
  *
+ * The [ context work ] region spans 0 bits if CONFIG_CONTEXT_WORK=n
  * Bits are used from the LSB upwards, so unused bits (if any) will always be in
  * upper bits of the variable.
  */
@@ -59,18 +63,24 @@ struct context_tracking {
 #define CT_STATE_START 0
 #define CT_STATE_END   (CT_STATE_START + CT_STATE_WIDTH - 1)
 
-#define CT_RCU_WATCHING_MAX_WIDTH (CT_SIZE - CT_STATE_WIDTH)
+#define CT_WORK_WIDTH (IS_ENABLED(CONFIG_CONTEXT_TRACKING_WORK) ? CONTEXT_WORK_MAX_OFFSET : 0)
+#define	CT_WORK_START (CT_STATE_END + 1)
+#define CT_WORK_END   (CT_WORK_START + CT_WORK_WIDTH - 1)
+
+#define CT_RCU_WATCHING_MAX_WIDTH (CT_SIZE - CT_WORK_WIDTH - CT_STATE_WIDTH)
 #define CT_RCU_WATCHING_WIDTH     (IS_ENABLED(CONFIG_RCU_DYNTICKS_TORTURE) ? 2 : CT_RCU_WATCHING_MAX_WIDTH)
-#define CT_RCU_WATCHING_START     (CT_STATE_END + 1)
+#define CT_RCU_WATCHING_START     (CT_WORK_END + 1)
 #define CT_RCU_WATCHING_END       (CT_RCU_WATCHING_START + CT_RCU_WATCHING_WIDTH - 1)
 #define CT_RCU_WATCHING           BIT(CT_RCU_WATCHING_START)
 
 #define CT_STATE_MASK        GENMASK(CT_STATE_END,        CT_STATE_START)
+#define CT_WORK_MASK         GENMASK(CT_WORK_END,         CT_WORK_START)
 #define CT_RCU_WATCHING_MASK GENMASK(CT_RCU_WATCHING_END, CT_RCU_WATCHING_START)
 
 #define CT_UNUSED_WIDTH (CT_RCU_WATCHING_MAX_WIDTH - CT_RCU_WATCHING_WIDTH)
 
 static_assert(CT_STATE_WIDTH        +
+	      CT_WORK_WIDTH         +
 	      CT_RCU_WATCHING_WIDTH +
 	      CT_UNUSED_WIDTH       ==
 	      CT_SIZE);
diff --git a/include/linux/context_tracking_work.h b/include/linux/context_tracking_work.h
new file mode 100644
index 0000000000000..fb74db8876dd2
--- /dev/null
+++ b/include/linux/context_tracking_work.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CONTEXT_TRACKING_WORK_H
+#define _LINUX_CONTEXT_TRACKING_WORK_H
+
+#include <linux/bitops.h>
+
+enum {
+	CONTEXT_WORK_n_OFFSET,
+	CONTEXT_WORK_MAX_OFFSET
+};
+
+enum ct_work {
+	CONTEXT_WORK_n        = BIT(CONTEXT_WORK_n_OFFSET),
+	CONTEXT_WORK_MAX      = BIT(CONTEXT_WORK_MAX_OFFSET)
+};
+
+#include <asm/context_tracking_work.h>
+
+#ifdef CONFIG_CONTEXT_TRACKING_WORK
+extern bool ct_set_cpu_work(unsigned int cpu, unsigned int work);
+#else
+static inline bool
+ct_set_cpu_work(unsigned int cpu, unsigned int work) { return false; }
+#endif
+
+#endif
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 938c48952d265..37b094ea56fb6 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -72,6 +72,47 @@ static __always_inline void rcu_task_trace_heavyweight_exit(void)
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 }
 
+#ifdef CONFIG_CONTEXT_TRACKING_WORK
+static noinstr void ct_work_flush(unsigned long seq)
+{
+	int bit;
+
+	seq = (seq & CT_WORK_MASK) >> CT_WORK_START;
+
+	/*
+	 * arch_context_tracking_work() must be noinstr, non-blocking,
+	 * and NMI safe.
+	 */
+	for_each_set_bit(bit, &seq, CONTEXT_WORK_MAX)
+		arch_context_tracking_work(BIT(bit));
+}
+
+bool ct_set_cpu_work(unsigned int cpu, unsigned int work)
+{
+	struct context_tracking *ct = per_cpu_ptr(&context_tracking, cpu);
+	unsigned int old;
+	bool ret = false;
+
+	preempt_disable();
+
+	old = atomic_read(&ct->state);
+	/*
+	 * Try setting the work until either
+	 * - the target CPU has entered kernelspace
+	 * - the work has been set
+	 */
+	do {
+		ret = atomic_try_cmpxchg(&ct->state, &old, old | (work << CT_WORK_START));
+	} while (!ret && ((old & CT_STATE_MASK) != CT_STATE_KERNEL));
+
+	preempt_enable();
+	return ret;
+}
+#else
+static __always_inline void ct_work_flush(unsigned long work) { }
+static __always_inline void ct_work_clear(struct context_tracking *ct) { }
+#endif
+
 /*
  * Record entry into an extended quiescent state.  This is only to be
  * called when not already in an extended quiescent state, that is,
@@ -88,7 +129,7 @@ static noinstr void ct_kernel_exit_state(int offset)
 	 * next idle sojourn.
 	 */
 	rcu_task_trace_heavyweight_enter();  // Before CT state update!
-	seq = ct_state_inc(offset);
+	seq = ct_state_inc_clear_work(offset);
 	// RCU is no longer watching.  Better be in extended quiescent state!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && (seq & CT_RCU_WATCHING));
 }
@@ -100,7 +141,7 @@ static noinstr void ct_kernel_exit_state(int offset)
  */
 static noinstr void ct_kernel_enter_state(int offset)
 {
-	int seq;
+	unsigned long seq;
 
 	/*
 	 * CPUs seeing atomic_add_return() must see prior idle sojourns,
@@ -108,6 +149,7 @@ static noinstr void ct_kernel_enter_state(int offset)
 	 * critical section.
 	 */
 	seq = ct_state_inc(offset);
+	ct_work_flush(seq);
 	// RCU is now watching.  Better not be in an extended quiescent state!
 	rcu_task_trace_heavyweight_exit();  // After CT state update!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !(seq & CT_RCU_WATCHING));
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 8ebb6d5a106be..04efc2b605823 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -186,6 +186,11 @@ config CONTEXT_TRACKING_USER_FORCE
 	  Say N otherwise, this option brings an overhead that you
 	  don't want in production.
 
+config CONTEXT_TRACKING_WORK
+	bool
+	depends on HAVE_CONTEXT_TRACKING_WORK && CONTEXT_TRACKING_USER
+	default y
+
 config NO_HZ
 	bool "Old Idle dynticks config"
 	help
-- 
2.43.0


