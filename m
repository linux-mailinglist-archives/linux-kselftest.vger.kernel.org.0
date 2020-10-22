Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42FD9296739
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Oct 2020 00:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372778AbgJVW1Z (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Oct 2020 18:27:25 -0400
Received: from mga09.intel.com ([134.134.136.24]:58290 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S372836AbgJVW1Y (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Oct 2020 18:27:24 -0400
IronPort-SDR: jonclMCp04/B+vpiSsAslqT5Q1MXnXNk0MXMZhzCHY7irK6gDEwi09orgukuieBi74+mVvvMYS
 Ybyf7551YlLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="167725398"
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="167725398"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 15:27:24 -0700
IronPort-SDR: zzp2rD61QGyfjeDsKHhr1Y0CtB2pHKjvZffE36opsMWQ0czVk9vX81PjpVrNy2jPgelwZ19JKE
 G2K66b1zAoOw==
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="360004350"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 15:27:23 -0700
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 08/10] x86/entry: Preserve PKRS MSR across exceptions
Date:   Thu, 22 Oct 2020 15:26:59 -0700
Message-Id: <20201022222701.887660-9-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201022222701.887660-1-ira.weiny@intel.com>
References: <20201022222701.887660-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The PKRS MSR is not managed by XSAVE.  It is preserved through a context
switch but this support leaves exception handling code open to memory
accesses during exceptions.

2 possible places for preserving this state were considered,
irqentry_state_t or pt_regs.[1]  pt_regs was much more complicated and
was potentially fraught with unintended consequences.[2]
irqentry_state_t was already an object being used in the exception
handling and is straightforward.  It is also easy for any number of
nested states to be tracked and eventually can be enhanced to store the
reference counting required to support PKS through kmap reentry

Preserve the current task's PKRS values in irqentry_state_t on exception
entry and restoring them on exception exit.

Each nested exception is further saved allowing for any number of levels
of exception handling.

Peter and Thomas both suggested parts of the patch, IDT and NMI respectively.

[1] https://lore.kernel.org/lkml/CALCETrVe1i5JdyzD_BcctxQJn+ZE3T38EFPgjxN1F577M36g+w@mail.gmail.com/
[2] https://lore.kernel.org/lkml/874kpxx4jf.fsf@nanos.tec.linutronix.de/#t

Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from RFC V3
	Standardize on 'irq_state' variable name
	Per Dave Hansen
		irq_save_pkrs() -> irq_save_set_pkrs()
	Rebased based on clean up patch by Thomas Gleixner
		This includes moving irq_[save_set|restore]_pkrs() to
		the core as well.
---
 arch/x86/entry/common.c             | 39 +++++++++++++++++++++++++++++
 arch/x86/include/asm/pkeys_common.h |  5 ++--
 arch/x86/mm/pkeys.c                 |  2 +-
 include/linux/entry-common.h        | 12 +++++++++
 kernel/entry/common.c               | 14 +++++++++--
 5 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 87dea56a15d2..c047ea57bb8c 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -19,6 +19,7 @@
 #include <linux/nospec.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
+#include <linux/pkeys.h>
 
 #ifdef CONFIG_XEN_PV
 #include <xen/xen-ops.h>
@@ -209,6 +210,42 @@ SYSCALL_DEFINE0(ni_syscall)
 	return -ENOSYS;
 }
 
+#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
+/*
+ * PKRS is a per-logical-processor MSR which overlays additional protection for
+ * pages which have been mapped with a protection key.
+ *
+ * The register is not maintained with XSAVE so we have to maintain the MSR
+ * value in software during context switch and exception handling.
+ *
+ * Context switches save the MSR in the task struct thus taking that value to
+ * other processors if necessary.
+ *
+ * To protect against exceptions having access to this memory we save the
+ * current running value and set the PKRS value for the duration of the
+ * exception.  Thus preventing exception handlers from having the elevated
+ * access of the interrupted task.
+ */
+noinstr void irq_save_set_pkrs(irqentry_state_t *irq_state, u32 val)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_PKS))
+		return;
+
+	irq_state->thread_pkrs = current->thread.saved_pkrs;
+	irq_state->pkrs = this_cpu_read(pkrs_cache);
+	write_pkrs(INIT_PKRS_VALUE);
+}
+
+noinstr void irq_restore_pkrs(irqentry_state_t *irq_state)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_PKS))
+		return;
+
+	write_pkrs(irq_state->pkrs);
+	current->thread.saved_pkrs = irq_state->thread_pkrs;
+}
+#endif /* CONFIG_ARCH_HAS_SUPERVISOR_PKEYS */
+
 #ifdef CONFIG_XEN_PV
 #ifndef CONFIG_PREEMPTION
 /*
@@ -272,6 +309,8 @@ __visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
 
 	inhcall = get_and_clear_inhcall();
 	if (inhcall && !WARN_ON_ONCE(irq_state.exit_rcu)) {
+		/* Normally called by irqentry_exit, we must restore pkrs here */
+		irq_restore_pkrs(&irq_state);
 		instrumentation_begin();
 		irqentry_exit_cond_resched();
 		instrumentation_end();
diff --git a/arch/x86/include/asm/pkeys_common.h b/arch/x86/include/asm/pkeys_common.h
index cd492c23b28c..f921c58793f9 100644
--- a/arch/x86/include/asm/pkeys_common.h
+++ b/arch/x86/include/asm/pkeys_common.h
@@ -31,9 +31,10 @@
 #define        PKS_NUM_KEYS            16
 
 #ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
-void write_pkrs(u32 new_pkrs);
+DECLARE_PER_CPU(u32, pkrs_cache);
+noinstr void write_pkrs(u32 new_pkrs);
 #else
-static inline void write_pkrs(u32 new_pkrs) { }
+static __always_inline void write_pkrs(u32 new_pkrs) { }
 #endif
 
 #endif /*_ASM_X86_PKEYS_INTERNAL_H */
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index fd5c4d34c3a5..a05f4edf2f80 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -252,7 +252,7 @@ DEFINE_PER_CPU(u32, pkrs_cache);
  *     until all prior executions of WRPKRU have completed execution
  *     and updated the PKRU register.
  */
-void write_pkrs(u32 new_pkrs)
+noinstr void write_pkrs(u32 new_pkrs)
 {
 	u32 *pkrs;
 
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index b79704af744f..3395931d55d0 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -342,6 +342,10 @@ void irqentry_exit_to_user_mode(struct pt_regs *regs);
 
 #ifndef irqentry_state
 typedef struct irqentry_state {
+#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
+	u32 pkrs;
+	u32 thread_pkrs;
+#endif
 	union {
 		bool	exit_rcu;
 		bool	lockdep;
@@ -349,6 +353,14 @@ typedef struct irqentry_state {
 } irqentry_state_t;
 #endif
 
+#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
+noinstr void irq_save_set_pkrs(irqentry_state_t *irq_state, u32 val);
+noinstr void irq_restore_pkrs(irqentry_state_t *irq_state);
+#else
+static __always_inline void irq_save_set_pkrs(irqentry_state_t *irq_state, u32 val) { }
+static __always_inline void irq_restore_pkrs(irqentry_state_t *irq_state) { }
+#endif
+
 /**
  * irqentry_enter - Handle state tracking on ordinary interrupt entries
  * @regs:	Pointer to pt_regs of interrupted context
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index e4f745b3a229..1d3df88e1657 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -327,7 +327,7 @@ noinstr void irqentry_enter(struct pt_regs *regs, irqentry_state_t *irq_state)
 		instrumentation_end();
 
 		irq_state->exit_rcu = true;
-		return;
+		goto done;
 	}
 
 	/*
@@ -341,6 +341,9 @@ noinstr void irqentry_enter(struct pt_regs *regs, irqentry_state_t *irq_state)
 	/* Use the combo lockdep/tracing function */
 	trace_hardirqs_off();
 	instrumentation_end();
+
+done:
+	irq_save_set_pkrs(irq_state, INIT_PKRS_VALUE);
 }
 
 void irqentry_exit_cond_resched(void)
@@ -362,7 +365,12 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t *irq_state)
 	/* Check whether this returns to user mode */
 	if (user_mode(regs)) {
 		irqentry_exit_to_user_mode(regs);
-	} else if (!regs_irqs_disabled(regs)) {
+		return;
+	}
+
+	irq_restore_pkrs(irq_state);
+
+	if (!regs_irqs_disabled(regs)) {
 		/*
 		 * If RCU was not watching on entry this needs to be done
 		 * carefully and needs the same ordering of lockdep/tracing
@@ -408,10 +416,12 @@ void noinstr irqentry_nmi_enter(struct pt_regs *regs, irqentry_state_t *irq_stat
 	trace_hardirqs_off_finish();
 	ftrace_nmi_enter();
 	instrumentation_end();
+	irq_save_set_pkrs(irq_state, INIT_PKRS_VALUE);
 }
 
 void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t *irq_state)
 {
+	irq_restore_pkrs(irq_state);
 	instrumentation_begin();
 	ftrace_nmi_exit();
 	if (irq_state->lockdep) {
-- 
2.28.0.rc0.12.gb6a658bd00c9

