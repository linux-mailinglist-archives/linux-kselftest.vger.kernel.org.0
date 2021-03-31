Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBECE35073F
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Mar 2021 21:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbhCaTOt (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Mar 2021 15:14:49 -0400
Received: from mga12.intel.com ([192.55.52.136]:51691 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235405AbhCaTOV (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Mar 2021 15:14:21 -0400
IronPort-SDR: 5k71VMr2/yBW7rHragUdlkEIoBz1tNdr9QgVLZmSkVi0WiQUIEhlqvxd2SELt5t+oRdshkGzQL
 mg+6S7gMQVPg==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="171490621"
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="171490621"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 12:14:21 -0700
IronPort-SDR: v3r3EqCUzTxSAiOJIcRSsUeUO25MfgocMvV/JzJ378UWSIrfAy23AgGmhUF5ueqFNi774Q9ztj
 AgbPzb40ZxyQ==
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="610625408"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 12:14:21 -0700
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH V5 07/10] x86/pks: Preserve the PKRS MSR on context switch
Date:   Wed, 31 Mar 2021 12:14:02 -0700
Message-Id: <20210331191405.341999-8-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210331191405.341999-1-ira.weiny@intel.com>
References: <20210331191405.341999-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The PKRS MSR is defined as a per-logical-processor register.  This
isolates memory access by logical CPU.  Unfortunately, the MSR is not
managed by XSAVE.  Therefore, tasks must save/restore the MSR value on
context switch.

Define a saved PKRS value in the task struct, as well as a cached
per-logical-processor MSR value which mirrors the MSR value of the
current CPU.  Initialize all tasks with the default MSR value.  Then, on
schedule in, call write_pkrs() which automatically avoids the overhead
of the MSR write if possible.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V4
	From kernel test robot <lkp@intel.com>
		Fix i386 build: pks_init_task not found
	Move MSR_IA32_PKRS and INIT_PKRS_VALUE to patch 5 where they are
		'used'.  (Technically nothing is used until the final
		test patch but this organization makes review better.)
	Fix checkpatch errors

Changes from V3
	From Dan Williams
		make pks_init_task() and pks_sched_in() macros
		To avoid Supervisor PKey '#ifdefery' in process.c and
		process_64.c
	Split write_pkrs() to an earlier patch to be used in setup_pks()
		Move Peter's authorship to that patch.
	From Dan Williams
		Use ARCH_ENABLE_SUPERVISOR_PKEYS
	Remove kernel doc comment from write_pkrs
	From Thomas Gleixner
		Fix where pks_sched_in() is called from.
			Should be called from __switch_to()
			NOTE: PKS requires x86_64 so there is no need to
			update process_32.c
		Make pkrs_cache static
		Remove unnecessary pkrs_cache declaration
		Clean up formatting

Changes from V2
	Adjust for PKS enable being final patch.

Changes from V1
	Rebase to latest tip/master
		Resolve conflicts with INIT_THREAD changes

Changes since RFC V3
	Per Dave Hansen
		Update commit message
		move saved_pkrs to be in a nicer place
	Per Peter Zijlstra
		Add Comment from Peter
		Clean up white space
		Update authorship
---
 arch/x86/include/asm/processor.h | 47 +++++++++++++++++++++++++++++++-
 arch/x86/kernel/process.c        |  3 ++
 arch/x86/kernel/process_64.c     |  2 ++
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index dc6d149bf851..e0ffb9c849c5 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -18,6 +18,7 @@ struct vm86;
 #include <asm/cpufeatures.h>
 #include <asm/page.h>
 #include <asm/pgtable_types.h>
+#include <asm/pkeys_common.h>
 #include <asm/percpu.h>
 #include <asm/msr.h>
 #include <asm/desc_defs.h>
@@ -519,6 +520,12 @@ struct thread_struct {
 	unsigned long		cr2;
 	unsigned long		trap_nr;
 	unsigned long		error_code;
+
+#ifdef	CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
+	/* Saved Protection key register for supervisor mappings */
+	u32			saved_pkrs;
+#endif
+
 #ifdef CONFIG_VM86
 	/* Virtual 86 mode info */
 	struct vm86		*vm86;
@@ -775,6 +782,37 @@ static inline void spin_lock_prefetch(const void *x)
 	((struct pt_regs *)__ptr) - 1;					\
 })
 
+#ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
+
+void write_pkrs(u32 new_pkrs);
+
+/*
+ * Define pks_init_task and pks_sched_in as macros to avoid requiring the
+ * definition of struct task_struct in this header while keeping the supervisor
+ * pkey #ifdefery out of process.c and process_64.c
+ */
+
+/*
+ * New tasks get the most restrictive PKRS value.
+ */
+#define pks_init_task(tsk) \
+	tsk->thread.saved_pkrs = INIT_PKRS_VALUE
+
+/*
+ * PKRS is only temporarily changed during specific code paths.  Only a
+ * preemption during these windows away from the default value would
+ * require updating the MSR.  write_pkrs() handles this optimization.
+ */
+#define pks_sched_in() \
+	write_pkrs(current->thread.saved_pkrs)
+
+#else /* !CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
+
+#define pks_init_task(tsk)
+#define pks_sched_in()
+
+#endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
+
 #ifdef CONFIG_X86_32
 #define INIT_THREAD  {							  \
 	.sp0			= TOP_OF_INIT_STACK,			  \
@@ -784,7 +822,14 @@ static inline void spin_lock_prefetch(const void *x)
 #define KSTK_ESP(task)		(task_pt_regs(task)->sp)
 
 #else
-#define INIT_THREAD { }
+
+#ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
+#define INIT_THREAD  {						\
+	.saved_pkrs = INIT_PKRS_VALUE,				\
+}
+#else
+#define INIT_THREAD  { }
+#endif
 
 extern unsigned long KSTK_ESP(struct task_struct *task);
 
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 9c214d7085a4..89f8454a8541 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -43,6 +43,7 @@
 #include <asm/io_bitmap.h>
 #include <asm/proto.h>
 #include <asm/frame.h>
+#include <asm/processor.h>
 
 #include "process.h"
 
@@ -195,6 +196,8 @@ void flush_thread(void)
 	memset(tsk->thread.tls_array, 0, sizeof(tsk->thread.tls_array));
 
 	fpu__clear_all(&tsk->thread.fpu);
+
+	pks_init_task(tsk);
 }
 
 void disable_TSC(void)
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index d08307df69ad..e590ecac1650 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -632,6 +632,8 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	/* Load the Intel cache allocation PQR MSR. */
 	resctrl_sched_in();
 
+	pks_sched_in();
+
 	return prev_p;
 }
 
-- 
2.28.0.rc0.12.gb6a658bd00c9

