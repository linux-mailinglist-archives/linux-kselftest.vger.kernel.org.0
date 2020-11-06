Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB20F2AA145
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Nov 2020 00:29:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgKFX3a (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Nov 2020 18:29:30 -0500
Received: from mga18.intel.com ([134.134.136.126]:39565 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbgKFX33 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Nov 2020 18:29:29 -0500
IronPort-SDR: GtpfHQQ76D55EMZCGsojQ+BOoCcZPQNMjzYPAoXhIBhJfBpryr/Y0JYCM5VodJflRFIfqW+CGM
 oet4JidzAmRA==
X-IronPort-AV: E=McAfee;i="6000,8403,9797"; a="157393066"
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400"; 
   d="scan'208";a="157393066"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 15:29:27 -0800
IronPort-SDR: DRILZ/fMinr2M+FX6GZSgQpGx/ViwIRcnkY/P46CPHhkkCRrf66RpDIg2SkbtVupXclOyDcXEo
 R0QrGaQOkY4g==
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400"; 
   d="scan'208";a="326572884"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 15:29:27 -0800
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH V3 03/10] x86/pks: Add PKS defines and Kconfig options
Date:   Fri,  6 Nov 2020 15:29:01 -0800
Message-Id: <20201106232908.364581-4-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201106232908.364581-1-ira.weiny@intel.com>
References: <20201106232908.364581-1-ira.weiny@intel.com>
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

Kernel users can thus defines 'domains' of page mappings which have an
extra level of protection beyond those specified in the supervisor page
table entries.

Add the Kconfig ARCH_HAS_SUPERVISOR_PKEYS to indicate to core code that
an architecture support pkeys.  Select it for x86.

Define the CPU features bit needed but leave DISABLE_PKS set to disable
the feature until the implementation can be completed and enabled in a
final patch.

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V2
	New patch for V3:  Split this off from the enable patch to be
	able to create cleaner bisectability
---
 arch/x86/Kconfig                            | 1 +
 arch/x86/include/asm/cpufeatures.h          | 1 +
 arch/x86/include/asm/disabled-features.h    | 4 +++-
 arch/x86/include/uapi/asm/processor-flags.h | 2 ++
 mm/Kconfig                                  | 2 ++
 5 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f6946b81f74a..78c4c749c6a9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1876,6 +1876,7 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
 	depends on X86_64 && (CPU_SUP_INTEL || CPU_SUP_AMD)
 	select ARCH_USES_HIGH_VMA_FLAGS
 	select ARCH_HAS_PKEYS
+	select ARCH_HAS_SUPERVISOR_PKEYS
 	help
 	  Memory Protection Keys provides a mechanism for enforcing
 	  page-based protections, but without requiring modification of the
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index dad350d42ecf..4deb580324e8 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -356,6 +356,7 @@
 #define X86_FEATURE_MOVDIRI		(16*32+27) /* MOVDIRI instruction */
 #define X86_FEATURE_MOVDIR64B		(16*32+28) /* MOVDIR64B instruction */
 #define X86_FEATURE_ENQCMD		(16*32+29) /* ENQCMD and ENQCMDS instructions */
+#define X86_FEATURE_PKS			(16*32+31) /* Protection Keys for Supervisor pages */
 
 /* AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17 */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* MCA overflow recovery support */
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 5861d34f9771..164587177152 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -44,6 +44,8 @@
 # define DISABLE_OSPKE		(1<<(X86_FEATURE_OSPKE & 31))
 #endif /* CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS */
 
+#define DISABLE_PKS           (1<<(X86_FEATURE_PKS & 31))
+
 #ifdef CONFIG_X86_5LEVEL
 # define DISABLE_LA57	0
 #else
@@ -82,7 +84,7 @@
 #define DISABLED_MASK14	0
 #define DISABLED_MASK15	0
 #define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP| \
-			 DISABLE_ENQCMD)
+			 DISABLE_ENQCMD|DISABLE_PKS)
 #define DISABLED_MASK17	0
 #define DISABLED_MASK18	0
 #define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 19)
diff --git a/arch/x86/include/uapi/asm/processor-flags.h b/arch/x86/include/uapi/asm/processor-flags.h
index bcba3c643e63..191c574b2390 100644
--- a/arch/x86/include/uapi/asm/processor-flags.h
+++ b/arch/x86/include/uapi/asm/processor-flags.h
@@ -130,6 +130,8 @@
 #define X86_CR4_SMAP		_BITUL(X86_CR4_SMAP_BIT)
 #define X86_CR4_PKE_BIT		22 /* enable Protection Keys support */
 #define X86_CR4_PKE		_BITUL(X86_CR4_PKE_BIT)
+#define X86_CR4_PKS_BIT		24 /* enable Protection Keys for Supervisor */
+#define X86_CR4_PKS		_BITUL(X86_CR4_PKS_BIT)
 
 /*
  * x86-64 Task Priority Register, CR8
diff --git a/mm/Kconfig b/mm/Kconfig
index d42423f884a7..fc9ce7f65683 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -826,6 +826,8 @@ config ARCH_USES_HIGH_VMA_FLAGS
 	bool
 config ARCH_HAS_PKEYS
 	bool
+config ARCH_HAS_SUPERVISOR_PKEYS
+	bool
 
 config PERCPU_STATS
 	bool "Collect percpu memory statistics"
-- 
2.28.0.rc0.12.gb6a658bd00c9

