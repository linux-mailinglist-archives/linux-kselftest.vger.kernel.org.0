Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4403438A7
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Mar 2021 06:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhCVFbV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Mar 2021 01:31:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:18626 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229455AbhCVFal (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Mar 2021 01:30:41 -0400
IronPort-SDR: EulzqdgenwXhadwJe7Wt1T6KRAM2kU2LS8A6Iv3sPMuDuYguBDa2Rer67OKR6JqSoJ3vfBMWMl
 dsxF/GRATZMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9930"; a="190298153"
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; 
   d="scan'208";a="190298153"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2021 22:30:38 -0700
IronPort-SDR: gwDLtwMN7+Qjzz+r79uIPFMUurCkAwG/hW6+7yXqSU3u4MOpzuSqCcoz+PAezv5+DKTIi9qHfq
 oVZGsJQTpWAw==
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; 
   d="scan'208";a="607238769"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2021 22:30:38 -0700
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
Subject: [PATCH V4 07/10] x86/pks: Preserve the PKRS MSR on context switch
Date:   Sun, 21 Mar 2021 22:30:17 -0700
Message-Id: <20210322053020.2287058-8-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210322053020.2287058-1-ira.weiny@intel.com>
References: <20210322053020.2287058-1-ira.weiny@intel.com>
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
Changes from V3
	From Dan Williams
		make pks_init_task() and pks_sched_in() macros
		To avoid Supervisor PKey '#ifdefery' in process.c and
		process_64.c
		Use ARCH_ENABLE_SUPERVISOR_PKEYS
	Split write_pkrs() to an earlier patch to be used in setup_pks()
		Move Peter's authorship to that patch.
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
 arch/x86/include/asm/msr-index.h    |  1 +
 arch/x86/include/asm/pkeys_common.h | 14 ++++++++++
 arch/x86/include/asm/processor.h    | 43 ++++++++++++++++++++++++++++-
 arch/x86/kernel/process.c           |  3 ++
 arch/x86/kernel/process_64.c        |  2 ++
 5 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 546d6ecf0a35..c15a049bf6ac 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -765,6 +765,7 @@
 
 #define MSR_IA32_TSC_DEADLINE		0x000006E0
 
+#define MSR_IA32_PKRS			0x000006E1
 
 #define MSR_TSX_FORCE_ABORT		0x0000010F
 
diff --git a/arch/x86/include/asm/pkeys_common.h b/arch/x86/include/asm/pkeys_common.h
index 0681522974ba..6917f1a27479 100644
--- a/arch/x86/include/asm/pkeys_common.h
+++ b/arch/x86/include/asm/pkeys_common.h
@@ -17,4 +17,18 @@
 #define PKR_AD_KEY(pkey)     (PKR_AD_BIT << PKR_PKEY_SHIFT(pkey))
 #define PKR_WD_KEY(pkey)     (PKR_WD_BIT << PKR_PKEY_SHIFT(pkey))
 
+/*
+ * Define a default PKRS value for each task.
+ *
+ * Key 0 has no restriction.  All other keys are set to the most restrictive
+ * value which is access disabled (AD=1).
+ *
+ * NOTE: This needs to be a macro to be used as part of the INIT_THREAD macro.
+ */
+#define INIT_PKRS_VALUE (PKR_AD_KEY(1) | PKR_AD_KEY(2) | PKR_AD_KEY(3) | \
+			 PKR_AD_KEY(4) | PKR_AD_KEY(5) | PKR_AD_KEY(6) | \
+			 PKR_AD_KEY(7) | PKR_AD_KEY(8) | PKR_AD_KEY(9) | \
+			 PKR_AD_KEY(10) | PKR_AD_KEY(11) | PKR_AD_KEY(12) | \
+			 PKR_AD_KEY(13) | PKR_AD_KEY(14) | PKR_AD_KEY(15))
+
 #endif /*_ASM_X86_PKEYS_COMMON_H */
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index dc6d149bf851..b7ae396285dd 100644
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
@@ -784,7 +791,41 @@ static inline void spin_lock_prefetch(const void *x)
 #define KSTK_ESP(task)		(task_pt_regs(task)->sp)
 
 #else
-#define INIT_THREAD { }
+
+#ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
+#define INIT_THREAD_PKRS	.saved_pkrs = INIT_PKRS_VALUE
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
+	tsk->thread.saved_pkrs = INIT_PKRS_VALUE;
+
+/*
+ * PKRS is only temporarily changed during specific code paths.  Only a
+ * preemption during these windows away from the default value would
+ * require updating the MSR.  write_pkrs() handles this optimization.
+ */
+#define pks_sched_in() \
+	write_pkrs(current->thread.saved_pkrs);
+
+#else
+#define INIT_THREAD_PKRS	0
+#define pks_init_task(tsk)
+#define pks_sched_in()
+#endif
+
+#define INIT_THREAD  {						\
+	INIT_THREAD_PKRS,					\
+}
 
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

