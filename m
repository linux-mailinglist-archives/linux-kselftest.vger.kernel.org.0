Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910FE75B491
	for <lists+linux-kselftest@lfdr.de>; Thu, 20 Jul 2023 18:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjGTQge (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 20 Jul 2023 12:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjGTQgN (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 20 Jul 2023 12:36:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B6735BD
        for <linux-kselftest@vger.kernel.org>; Thu, 20 Jul 2023 09:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689870844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cIltxl7gcT/0RKwYlLQ4QEv0npfMouojSk9ktXBKfqI=;
        b=e0aWU2El2R+LrUbSPviYx3UQQnPC+CPqr5Q9K3HVi3OJTC5mMWnwZ6RHVm5DfelzepAFid
        j6GB+ezYxLAnqcrLQQj+MFJKnE9X2N0b25IZUDvO6Pn9BQ2b/455snApzZ2S+YnGFHkvDJ
        IbZwCBpgfSRpJym44TwrmCFWF1llIzg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-397-kJOWCWFhOl2lgITiWh1clA-1; Thu, 20 Jul 2023 12:34:03 -0400
X-MC-Unique: kJOWCWFhOl2lgITiWh1clA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E3F4B936D34;
        Thu, 20 Jul 2023 16:33:58 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.42.28.48])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A11640C2070;
        Thu, 20 Jul 2023 16:33:51 +0000 (UTC)
From:   Valentin Schneider <vschneid@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
        bpf@vger.kernel.org, x86@kernel.org, rcu@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
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
        "Jason A. Donenfeld" <Jason@zx2c4.com>, Song Liu <song@kernel.org>,
        Julian Pidancet <julian.pidancet@oracle.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dionna Glaze <dionnaglaze@google.com>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Yair Podemsky <ypodemsk@redhat.com>
Subject: [RFC PATCH v2 15/20] context-tracking: Introduce work deferral infrastructure
Date:   Thu, 20 Jul 2023 17:30:51 +0100
Message-Id: <20230720163056.2564824-16-vschneid@redhat.com>
In-Reply-To: <20230720163056.2564824-1-vschneid@redhat.com>
References: <20230720163056.2564824-1-vschneid@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

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

Presence of CONTEXT_KERNEL in the ct_state prevents queuing deferred work.

Later commits introduce the bit:callback mappings.

Link: https://lore.kernel.org/all/20210929151723.162004989@infradead.org/
Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 arch/Kconfig                                 |  9 +++
 arch/x86/Kconfig                             |  1 +
 arch/x86/include/asm/context_tracking_work.h | 14 +++++
 include/linux/context_tracking.h             | 25 ++++++++
 include/linux/context_tracking_state.h       | 62 +++++++++++++++-----
 include/linux/context_tracking_work.h        | 26 ++++++++
 kernel/context_tracking.c                    | 51 +++++++++++++++-
 kernel/time/Kconfig                          |  5 ++
 8 files changed, 176 insertions(+), 17 deletions(-)
 create mode 100644 arch/x86/include/asm/context_tracking_work.h
 create mode 100644 include/linux/context_tracking_work.h

diff --git a/arch/Kconfig b/arch/Kconfig
index aff2746c8af28..1bcb3bbdddaad 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -871,6 +871,15 @@ config HAVE_CONTEXT_TRACKING_USER_OFFSTACK
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
index 7422db4097701..71481a80774f6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -198,6 +198,7 @@ config X86
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
index 6e76b9dba00e7..8aee086d0a25f 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -5,10 +5,15 @@
 #include <linux/sched.h>
 #include <linux/vtime.h>
 #include <linux/context_tracking_state.h>
+#include <linux/context_tracking_work.h>
 #include <linux/instrumentation.h>
 
 #include <asm/ptrace.h>
 
+#ifdef CONFIG_CONTEXT_TRACKING_WORK
+static_assert(CONTEXT_WORK_MAX_OFFSET <= CONTEXT_WORK_END + 1 - CONTEXT_WORK_START,
+	      "Not enough bits for CONTEXT_WORK");
+#endif
 
 #ifdef CONFIG_CONTEXT_TRACKING_USER
 extern void ct_cpu_track_user(int cpu);
@@ -131,6 +136,26 @@ static __always_inline unsigned long ct_state_inc(int incby)
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
index bbff5f7f88030..828fcdb801f73 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -9,21 +9,6 @@
 /* Offset to allow distinguishing irq vs. task-based idle entry/exit. */
 #define DYNTICK_IRQ_NONIDLE	((LONG_MAX / 2) + 1)
 
-enum ctx_state {
-	CONTEXT_DISABLED	= -1,	/* returned by ct_state() if unknown */
-	CONTEXT_KERNEL		= 0,
-	CONTEXT_IDLE		= 1,
-	CONTEXT_USER		= 2,
-	CONTEXT_GUEST		= 3,
-	CONTEXT_MAX		= 4,
-};
-
-/* Even value for idle, else odd. */
-#define RCU_DYNTICKS_IDX CONTEXT_MAX
-
-#define CT_STATE_MASK (CONTEXT_MAX - 1)
-#define CT_DYNTICKS_MASK (~CT_STATE_MASK)
-
 struct context_tracking {
 #ifdef CONFIG_CONTEXT_TRACKING_USER
 	/*
@@ -44,6 +29,53 @@ struct context_tracking {
 #endif
 };
 
+enum ctx_state {
+	/* Following are values */
+	CONTEXT_DISABLED	= -1,	/* returned by ct_state() if unknown */
+	CONTEXT_KERNEL		= 0,
+	CONTEXT_IDLE		= 1,
+	CONTEXT_USER		= 2,
+	CONTEXT_GUEST		= 3,
+	CONTEXT_MAX             = 4,
+};
+
+/*
+ * We cram three different things within the same atomic variable:
+ *
+ *                CONTEXT_STATE_END                        RCU_DYNTICKS_END
+ *                         |       CONTEXT_WORK_END                |
+ *                         |               |                       |
+ *                         v               v                       v
+ *         [ context_state ][ context work ][ RCU dynticks counter ]
+ *         ^                ^               ^
+ *         |                |               |
+ *         |        CONTEXT_WORK_START      |
+ * CONTEXT_STATE_START              RCU_DYNTICKS_START
+ */
+
+#define CT_STATE_SIZE (sizeof(((struct context_tracking *)0)->state) * BITS_PER_BYTE)
+
+#define CONTEXT_STATE_START 0
+#define CONTEXT_STATE_END   (bits_per(CONTEXT_MAX - 1) - 1)
+
+#define RCU_DYNTICKS_BITS  (IS_ENABLED(CONFIG_CONTEXT_TRACKING_WORK) ? 16 : 31)
+#define RCU_DYNTICKS_START (CT_STATE_SIZE - RCU_DYNTICKS_BITS)
+#define RCU_DYNTICKS_END   (CT_STATE_SIZE - 1)
+#define RCU_DYNTICKS_IDX   BIT(RCU_DYNTICKS_START)
+
+#define	CONTEXT_WORK_START (CONTEXT_STATE_END + 1)
+#define CONTEXT_WORK_END   (RCU_DYNTICKS_START - 1)
+
+/* Make sure all our bits are accounted for */
+static_assert((CONTEXT_STATE_END + 1 - CONTEXT_STATE_START) +
+	      (CONTEXT_WORK_END  + 1 - CONTEXT_WORK_START) +
+	      (RCU_DYNTICKS_END  + 1 - RCU_DYNTICKS_START) ==
+	      CT_STATE_SIZE);
+
+#define CT_STATE_MASK GENMASK(CONTEXT_STATE_END, CONTEXT_STATE_START)
+#define CT_WORK_MASK  GENMASK(CONTEXT_WORK_END, CONTEXT_WORK_START)
+#define CT_DYNTICKS_MASK GENMASK(RCU_DYNTICKS_END, RCU_DYNTICKS_START)
+
 #ifdef CONFIG_CONTEXT_TRACKING
 DECLARE_PER_CPU(struct context_tracking, context_tracking);
 #endif
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
index cc4f3a57f848c..1a3f6e355826d 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -72,6 +72,51 @@ static __always_inline void rcu_dynticks_task_trace_exit(void)
 #endif /* #ifdef CONFIG_TASKS_TRACE_RCU */
 }
 
+#ifdef CONFIG_CONTEXT_TRACKING_WORK
+static noinstr void ct_work_flush(unsigned long seq)
+{
+	int bit;
+
+	seq = (seq & CT_WORK_MASK) >> CONTEXT_WORK_START;
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
+	 * - the target CPU no longer accepts any more deferred work
+	 * - the work has been set
+	 *
+	 * NOTE: CONTEXT_GUEST intersects with CONTEXT_USER and CONTEXT_IDLE
+	 * as they are regular integers rather than bits, but that doesn't
+	 * matter here: if any of the context state bit is set, the CPU isn't
+	 * in kernel context.
+	 */
+	while ((old & (CONTEXT_GUEST | CONTEXT_USER | CONTEXT_IDLE)) && !ret)
+		ret = atomic_try_cmpxchg(&ct->state, &old, old | (work << CONTEXT_WORK_START));
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
@@ -88,7 +133,8 @@ static noinstr void ct_kernel_exit_state(int offset)
 	 * next idle sojourn.
 	 */
 	rcu_dynticks_task_trace_enter();  // Before ->dynticks update!
-	seq = ct_state_inc(offset);
+	seq = ct_state_inc_clear_work(offset);
+
 	// RCU is no longer watching.  Better be in extended quiescent state!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && (seq & RCU_DYNTICKS_IDX));
 }
@@ -100,7 +146,7 @@ static noinstr void ct_kernel_exit_state(int offset)
  */
 static noinstr void ct_kernel_enter_state(int offset)
 {
-	int seq;
+	unsigned long seq;
 
 	/*
 	 * CPUs seeing atomic_add_return() must see prior idle sojourns,
@@ -108,6 +154,7 @@ static noinstr void ct_kernel_enter_state(int offset)
 	 * critical section.
 	 */
 	seq = ct_state_inc(offset);
+	ct_work_flush(seq);
 	// RCU is now watching.  Better not be in an extended quiescent state!
 	rcu_dynticks_task_trace_exit();  // After ->dynticks update!
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !(seq & RCU_DYNTICKS_IDX));
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index bae8f11070bef..fdb266f2d774b 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -181,6 +181,11 @@ config CONTEXT_TRACKING_USER_FORCE
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
2.31.1

