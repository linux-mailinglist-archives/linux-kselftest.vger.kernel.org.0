Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25BD1343897
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Mar 2021 06:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230040AbhCVFap (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Mar 2021 01:30:45 -0400
Received: from mga09.intel.com ([134.134.136.24]:18629 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229956AbhCVFai (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Mar 2021 01:30:38 -0400
IronPort-SDR: Gp9+Rr9yzGfozM1uamYPy7c/hP2/DqB6yJed2xbYN0DDuI5Dxb38+csOEBhe4PvtFfJgwb1DNd
 5blkncZP+mdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9930"; a="190298147"
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; 
   d="scan'208";a="190298147"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2021 22:30:36 -0700
IronPort-SDR: rDhgwVuZx9D+75Si1AW9dPH/ADq4eJdnyQVNmXAPrRmaxfLDKnJDC+Ad/numNe9XIelhpqx3mf
 ig9qRqPLcAhQ==
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; 
   d="scan'208";a="607238754"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2021 22:30:36 -0700
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
Subject: [PATCH V4 05/10] x86/pks: Add PKS setup code
Date:   Sun, 21 Mar 2021 22:30:15 -0700
Message-Id: <20210322053020.2287058-6-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210322053020.2287058-1-ira.weiny@intel.com>
References: <20210322053020.2287058-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Protection Keys for Supervisor pages (PKS) enables fast, hardware thread
specific, manipulation of permission restrictions on supervisor page
mappings.  It uses the same mechanism of Protection Keys as those on
User mappings but applies that mechanism to supervisor mappings using a
supervisor specific MSR.

Add setup code and the lowest level of PKS MSR write support.  The write
value is cached per-cpu to avoid the overhead of the MSR write if the
value has not changed.

That said, it should be noted that the underlying WRMSR(MSR_IA32_PKRS)
is not serializing but still maintains ordering properties similar to
WRPKRU.  The current SDM section on PKRS needs updating but should be
the same as that of WRPKRU.  So to quote from the WRPKRU text:

	WRPKRU will never execute transiently. Memory accesses affected
	by PKRU register will not execute (even transiently) until all
	prior executions of WRPKRU have completed execution and updated
	the PKRU register.

write_pkrs() contributed by Peter Zijlstra.

Introduce asm/pks.h to declare setup_pks() as an internal function call.
Later patches will also need this new header as a place to declare
internal structures and functions.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Co-developed-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V3:
	From Dan Williams:
		Update commit message
		Add pks.h to hold ifdefery out of *.c files
		s/ARCH_HAS.../SUPERVISOR_PKEYS
		move setup_pks to pkeys.c (remove more ifdefery)
		Remove 'domain' language from commit message
		Clarify comment in fault handler
	Move the removal of the WARN_ON_ONCE in the fault path to this
	patch.  Previously it was in:
		[07/10] x86/fault: Report the PKRS state on fault

Changes from V2
	From Thomas: Make this patch last so PKS is not enabled until
	all the PKS mechanisms are in place.  Specifically:
		1) Modify setup_pks() to call write_pkrs() to properly
		   set up the initial value when enabled.

		2) Split this patch into two. 1) a precursor patch with
		   the required defines/config options and 2) this patch
		   which actually enables feature on CPUs which support
		   it.

Changes since RFC V3
	Per Dave Hansen
		Update comment
		Add X86_FEATURE_PKS to disabled-features.h
	Rebase based on latest TIP tree
---
 arch/x86/include/asm/pks.h   | 15 +++++++++++
 arch/x86/kernel/cpu/common.c |  2 ++
 arch/x86/mm/pkeys.c          | 48 ++++++++++++++++++++++++++++++++++++
 3 files changed, 65 insertions(+)
 create mode 100644 arch/x86/include/asm/pks.h

diff --git a/arch/x86/include/asm/pks.h b/arch/x86/include/asm/pks.h
new file mode 100644
index 000000000000..5d7067ada8fb
--- /dev/null
+++ b/arch/x86/include/asm/pks.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_PKS_H
+#define _ASM_X86_PKS_H
+
+#ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
+
+void setup_pks(void);
+
+#else /* !CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
+
+static inline void setup_pks(void) { }
+
+#endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
+
+#endif /* _ASM_X86_PKS_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index ab640abe26b6..de49d0c0f4e0 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -58,6 +58,7 @@
 #include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
 #include <asm/uv/uv.h>
+#include <asm/pks.h>
 
 #include "cpu.h"
 
@@ -1594,6 +1595,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 
 	x86_init_rdrand(c);
 	setup_pku(c);
+	setup_pks();
 
 	/*
 	 * Clear/Set all flags overridden by options, need do it
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index fc8c7e2bb21b..f6a3a54b8d7d 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -229,3 +229,51 @@ u32 update_pkey_val(u32 pk_reg, int pkey, unsigned int flags)
 
 	return pk_reg;
 }
+
+#ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
+
+static DEFINE_PER_CPU(u32, pkrs_cache);
+
+/*
+ * write_pkrs() optimizes MSR writes by maintaining a per cpu cache which can
+ * be checked quickly.
+ *
+ * It should also be noted that the underlying WRMSR(MSR_IA32_PKRS) is not
+ * serializing but still maintains ordering properties similar to WRPKRU.
+ * The current SDM section on PKRS needs updating but should be the same as
+ * that of WRPKRU.  So to quote from the WRPKRU text:
+ *
+ *     WRPKRU will never execute transiently. Memory accesses
+ *     affected by PKRU register will not execute (even transiently)
+ *     until all prior executions of WRPKRU have completed execution
+ *     and updated the PKRU register.
+ */
+void write_pkrs(u32 new_pkrs)
+{
+	u32 *pkrs;
+
+	if (!static_cpu_has(X86_FEATURE_PKS))
+		return;
+
+	pkrs = get_cpu_ptr(&pkrs_cache);
+	if (*pkrs != new_pkrs) {
+		*pkrs = new_pkrs;
+		wrmsrl(MSR_IA32_PKRS, new_pkrs);
+	}
+	put_cpu_ptr(pkrs);
+}
+
+/*
+ * PKS is independent of PKU and either or both may be supported on a CPU.
+ * Configure PKS if the CPU supports the feature.
+ */
+void setup_pks(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_PKS))
+		return;
+
+	write_pkrs(INIT_PKRS_VALUE);
+	cr4_set_bits(X86_CR4_PKS);
+}
+
+#endif
-- 
2.28.0.rc0.12.gb6a658bd00c9

