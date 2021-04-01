Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2106F352310
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Apr 2021 00:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235805AbhDAW6p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Apr 2021 18:58:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:11537 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235754AbhDAW6i (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Apr 2021 18:58:38 -0400
IronPort-SDR: 9jByYU2xbcpT3CAy54yFoUlCyfY5+QhZdjExaDO9RbA5PHRxsfkNFPBRfQ8LJhfwz1q2fvYoub
 njQ3+ZDpRA3g==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="190117105"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="190117105"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:58:37 -0700
IronPort-SDR: aOc1KcGMAj65GRrfhvsZD51joqt+aRroI+/SsHiZlVBeOt+tp+wQY37xPbcKigu3O0W1mYKE7U
 tHaKT/8XVfYw==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="611092357"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:58:37 -0700
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
Subject: [PATCH V6 05/10] x86/pks: Add PKS setup code
Date:   Thu,  1 Apr 2021 15:58:28 -0700
Message-Id: <20210401225833.566238-6-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210401225833.566238-1-ira.weiny@intel.com>
References: <20210401225833.566238-1-ira.weiny@intel.com>
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
Changes from V4:
	Move MSR_IA32_PKRS and INIT_PKRS_VALUE into this patch where
	they are first 'used'.  (Technically nothing is used until the
	test patch but this is correct for review purposes.)

Changes from V3:
	From Dan Williams:
		Update commit message
		Add pks.h to hold ifdefery out of *.c files
		s/ARCH_HAS.../SUPERVISOR_PKEYS
		move setup_pks to pkeys.c (remove more ifdefery)
	From Dan Williams:
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
 arch/x86/include/asm/msr-index.h    |  1 +
 arch/x86/include/asm/pkeys_common.h | 14 +++++++++
 arch/x86/include/asm/pks.h          | 15 +++++++++
 arch/x86/kernel/cpu/common.c        |  2 ++
 arch/x86/mm/pkeys.c                 | 48 +++++++++++++++++++++++++++++
 5 files changed, 80 insertions(+)
 create mode 100644 arch/x86/include/asm/pks.h

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

