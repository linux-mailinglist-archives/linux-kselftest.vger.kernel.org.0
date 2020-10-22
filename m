Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48BF029674C
	for <lists+linux-kselftest@lfdr.de>; Fri, 23 Oct 2020 00:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S372815AbgJVW1m (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 22 Oct 2020 18:27:42 -0400
Received: from mga06.intel.com ([134.134.136.31]:43802 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S372830AbgJVW1X (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 22 Oct 2020 18:27:23 -0400
IronPort-SDR: rg3sG/ErWyFhyBMO/QW5FWFQieErw8VpyptS2DCiYdLLuScqULdOOvRLPM+8JrHNjIcXqySNLp
 nb24ws8MnZ5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9782"; a="229236874"
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="229236874"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 15:27:21 -0700
IronPort-SDR: ay6jcPxJebLGWrOYdNxv1McOYP32pqKcqe+sQMqbMBZuQO46WeTfpvuDcojj9VnxaOQNS2JtMi
 +3Zc/AvXDsQQ==
X-IronPort-AV: E=Sophos;i="5.77,404,1596524400"; 
   d="scan'208";a="523289113"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2020 15:27:21 -0700
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: [PATCH 06/10] x86/entry: Move nmi entry/exit into common code
Date:   Thu, 22 Oct 2020 15:26:57 -0700
Message-Id: <20201022222701.887660-7-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201022222701.887660-1-ira.weiny@intel.com>
References: <20201022222701.887660-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Lockdep state handling on NMI enter and exit is nothing specific to X86. It's
not any different on other architectures. Also the extra state type is not
necessary, irqentry_state_t can carry the necessary information as well.

Move it to common code and extend irqentry_state_t to carry lockdep state.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 arch/x86/entry/common.c         | 34 -------------------------------
 arch/x86/include/asm/idtentry.h |  3 ---
 arch/x86/kernel/cpu/mce/core.c  |  6 +++---
 arch/x86/kernel/nmi.c           |  6 +++---
 arch/x86/kernel/traps.c         | 13 ++++++------
 include/linux/entry-common.h    | 24 +++++++++++++++++++++-
 kernel/entry/common.c           | 36 +++++++++++++++++++++++++++++++++
 7 files changed, 72 insertions(+), 50 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 870efeec8bda..18d8f17f755c 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -209,40 +209,6 @@ SYSCALL_DEFINE0(ni_syscall)
 	return -ENOSYS;
 }
 
-noinstr bool idtentry_enter_nmi(struct pt_regs *regs)
-{
-	bool irq_state = lockdep_hardirqs_enabled();
-
-	__nmi_enter();
-	lockdep_hardirqs_off(CALLER_ADDR0);
-	lockdep_hardirq_enter();
-	rcu_nmi_enter();
-
-	instrumentation_begin();
-	trace_hardirqs_off_finish();
-	ftrace_nmi_enter();
-	instrumentation_end();
-
-	return irq_state;
-}
-
-noinstr void idtentry_exit_nmi(struct pt_regs *regs, bool restore)
-{
-	instrumentation_begin();
-	ftrace_nmi_exit();
-	if (restore) {
-		trace_hardirqs_on_prepare();
-		lockdep_hardirqs_on_prepare(CALLER_ADDR0);
-	}
-	instrumentation_end();
-
-	rcu_nmi_exit();
-	lockdep_hardirq_exit();
-	if (restore)
-		lockdep_hardirqs_on(CALLER_ADDR0);
-	__nmi_exit();
-}
-
 #ifdef CONFIG_XEN_PV
 #ifndef CONFIG_PREEMPTION
 /*
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index b2442eb0ac2f..247a60a47331 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -11,9 +11,6 @@
 
 #include <asm/irq_stack.h>
 
-bool idtentry_enter_nmi(struct pt_regs *regs);
-void idtentry_exit_nmi(struct pt_regs *regs, bool irq_state);
-
 /**
  * DECLARE_IDTENTRY - Declare functions for simple IDT entry points
  *		      No error code pushed by hardware
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 1c08cb9eb9f6..eb3338c0bbc1 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1983,7 +1983,7 @@ void (*machine_check_vector)(struct pt_regs *) = unexpected_machine_check;
 
 static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 {
-	bool irq_state;
+	irqentry_state_t irq_state;
 
 	WARN_ON_ONCE(user_mode(regs));
 
@@ -1995,7 +1995,7 @@ static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 	    mce_check_crashing_cpu())
 		return;
 
-	irq_state = idtentry_enter_nmi(regs);
+	irq_state = irqentry_nmi_enter(regs);
 	/*
 	 * The call targets are marked noinstr, but objtool can't figure
 	 * that out because it's an indirect call. Annotate it.
@@ -2006,7 +2006,7 @@ static __always_inline void exc_machine_check_kernel(struct pt_regs *regs)
 	if (regs->flags & X86_EFLAGS_IF)
 		trace_hardirqs_on_prepare();
 	instrumentation_end();
-	idtentry_exit_nmi(regs, irq_state);
+	irqentry_nmi_exit(regs, irq_state);
 }
 
 static __always_inline void exc_machine_check_user(struct pt_regs *regs)
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 4bc77aaf1303..bf250a339655 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -475,7 +475,7 @@ static DEFINE_PER_CPU(unsigned long, nmi_dr7);
 
 DEFINE_IDTENTRY_RAW(exc_nmi)
 {
-	bool irq_state;
+	irqentry_state_t irq_state;
 
 	/*
 	 * Re-enable NMIs right here when running as an SEV-ES guest. This might
@@ -502,14 +502,14 @@ DEFINE_IDTENTRY_RAW(exc_nmi)
 
 	this_cpu_write(nmi_dr7, local_db_save());
 
-	irq_state = idtentry_enter_nmi(regs);
+	irq_state = irqentry_nmi_enter(regs);
 
 	inc_irq_stat(__nmi_count);
 
 	if (!ignore_nmis)
 		default_do_nmi(regs);
 
-	idtentry_exit_nmi(regs, irq_state);
+	irqentry_nmi_exit(regs, irq_state);
 
 	local_db_restore(this_cpu_read(nmi_dr7));
 
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 3c70fb34028b..bffbbe29fc8c 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -405,7 +405,7 @@ DEFINE_IDTENTRY_DF(exc_double_fault)
 	}
 #endif
 
-	idtentry_enter_nmi(regs);
+	irqentry_nmi_enter(regs);
 	instrumentation_begin();
 	notify_die(DIE_TRAP, str, regs, error_code, X86_TRAP_DF, SIGSEGV);
 
@@ -651,12 +651,13 @@ DEFINE_IDTENTRY_RAW(exc_int3)
 		instrumentation_end();
 		irqentry_exit_to_user_mode(regs);
 	} else {
-		bool irq_state = idtentry_enter_nmi(regs);
+		irqentry_state_t irq_state = irqentry_nmi_enter(regs);
+
 		instrumentation_begin();
 		if (!do_int3(regs))
 			die("int3", regs, 0);
 		instrumentation_end();
-		idtentry_exit_nmi(regs, irq_state);
+		irqentry_nmi_exit(regs, irq_state);
 	}
 }
 
@@ -864,7 +865,7 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 	 * includes the entry stack is excluded for everything.
 	 */
 	unsigned long dr7 = local_db_save();
-	bool irq_state = idtentry_enter_nmi(regs);
+	irqentry_state_t irq_state = irqentry_nmi_enter(regs);
 	instrumentation_begin();
 
 	/*
@@ -907,7 +908,7 @@ static __always_inline void exc_debug_kernel(struct pt_regs *regs,
 		regs->flags &= ~X86_EFLAGS_TF;
 out:
 	instrumentation_end();
-	idtentry_exit_nmi(regs, irq_state);
+	irqentry_nmi_exit(regs, irq_state);
 
 	local_db_restore(dr7);
 }
@@ -925,7 +926,7 @@ static __always_inline void exc_debug_user(struct pt_regs *regs,
 
 	/*
 	 * NB: We can't easily clear DR7 here because
-	 * idtentry_exit_to_usermode() can invoke ptrace, schedule, access
+	 * irqentry_exit_to_usermode() can invoke ptrace, schedule, access
 	 * user memory, etc.  This means that a recursive #DB is possible.  If
 	 * this happens, that #DB will hit exc_debug_kernel() and clear DR7.
 	 * Since we're not on the IST stack right now, everything will be
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 474f29638d2c..47f9a0658acf 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -342,7 +342,10 @@ void irqentry_exit_to_user_mode(struct pt_regs *regs);
 
 #ifndef irqentry_state
 typedef struct irqentry_state {
-	bool	exit_rcu;
+	union {
+		bool	exit_rcu;
+		bool	lockdep;
+	};
 } irqentry_state_t;
 #endif
 
@@ -402,4 +405,23 @@ void irqentry_exit_cond_resched(void);
  */
 void noinstr irqentry_exit(struct pt_regs *regs, irqentry_state_t state);
 
+/**
+ * irqentry_nmi_enter - Handle NMI entry
+ * @regs:	Pointer to currents pt_regs
+ *
+ * Similar to irqentry_enter() but taking care of the NMI constraints.
+ */
+irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs);
+
+/**
+ * irqentry_nmi_exit - Handle return from NMI handling
+ * @regs:	Pointer to pt_regs (NMI entry regs)
+ * @irq_state:	Return value from matching call to irqentry_nmi_enter()
+ *
+ * Last action before returning to the low level assmenbly code.
+ *
+ * Counterpart to irqentry_nmi_enter().
+ */
+void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state);
+
 #endif
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 0a1e20f8d4e8..5cc2e4174d7c 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -398,3 +398,39 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 			rcu_irq_exit();
 	}
 }
+
+irqentry_state_t noinstr irqentry_nmi_enter(struct pt_regs *regs)
+{
+	irqentry_state_t irq_state;
+
+	irq_state.lockdep = lockdep_hardirqs_enabled();
+
+	__nmi_enter();
+	lockdep_hardirqs_off(CALLER_ADDR0);
+	lockdep_hardirq_enter();
+	rcu_nmi_enter();
+
+	instrumentation_begin();
+	trace_hardirqs_off_finish();
+	ftrace_nmi_enter();
+	instrumentation_end();
+
+	return irq_state;
+}
+
+void noinstr irqentry_nmi_exit(struct pt_regs *regs, irqentry_state_t irq_state)
+{
+	instrumentation_begin();
+	ftrace_nmi_exit();
+	if (irq_state.lockdep) {
+		trace_hardirqs_on_prepare();
+		lockdep_hardirqs_on_prepare(CALLER_ADDR0);
+	}
+	instrumentation_end();
+
+	rcu_nmi_exit();
+	lockdep_hardirq_exit();
+	if (irq_state.lockdep)
+		lockdep_hardirqs_on(CALLER_ADDR0);
+	__nmi_exit();
+}
-- 
2.28.0.rc0.12.gb6a658bd00c9

