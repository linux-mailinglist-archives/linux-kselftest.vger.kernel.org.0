Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2D0350733
	for <lists+linux-kselftest@lfdr.de>; Wed, 31 Mar 2021 21:15:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235975AbhCaTOp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 31 Mar 2021 15:14:45 -0400
Received: from mga12.intel.com ([192.55.52.136]:51675 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235071AbhCaTOS (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 31 Mar 2021 15:14:18 -0400
IronPort-SDR: I7FsLRxJyhFpLXFSgbR6dUrX6EkQSj+YYdbSR1s43r3e1hja6KG1kpzraLyBFYtg0MlnQB72DL
 xaH9tMdBzNPA==
X-IronPort-AV: E=McAfee;i="6000,8403,9940"; a="171490606"
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="171490606"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 12:14:18 -0700
IronPort-SDR: YIUMPilsVwhW1NiIvFp/vPcEZfTqHx1jz8UVgdCI34evD+lCCqhSLjqSJPFyQ63hOAiOKJiFdl
 2kDXREDSMQIg==
X-IronPort-AV: E=Sophos;i="5.81,293,1610438400"; 
   d="scan'208";a="610625390"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2021 12:14:18 -0700
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
Subject: [PATCH V5 04/10] x86/pks: Add PKS defines and Kconfig options
Date:   Wed, 31 Mar 2021 12:13:59 -0700
Message-Id: <20210331191405.341999-5-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210331191405.341999-1-ira.weiny@intel.com>
References: <20210331191405.341999-1-ira.weiny@intel.com>
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

Kernel users can define domains of page mappings which have an extra
level of protection beyond those specified in the supervisor page table
entries.

Define the PKS CPU feature bits.

Add the Kconfig ARCH_HAS_SUPERVISOR_PKEYS to indicate to consumers that
an architecture supports pkeys.

Introduce ARCH_ENABLE_SUPERVISOR_PKEYS to allow kernel users to specify
to the arch that they wish to use the supervisor key support if
ARCH_HAS_SUPERVISOR_PKEYS is available.  ARCH_ENABLE_SUPERVISOR_PKEYS
remains off until the first use case sets it.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V3:
	From Dan
		Clean up commit message
		Add ARCH_ENABLE_SUPERVISOR_PKEYS option so we don't have
		the overhead of PKS unless there is a user
	Clean up commit message grammar

Changes from V2
	New patch for V3:  Split this off from the enable patch to be
	able to create cleaner bisectability
---
 arch/x86/Kconfig                            | 1 +
 arch/x86/include/asm/cpufeatures.h          | 1 +
 arch/x86/include/asm/disabled-features.h    | 8 +++++++-
 arch/x86/include/uapi/asm/processor-flags.h | 2 ++
 mm/Kconfig                                  | 4 ++++
 5 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 2792879d398e..5e3a7c2bc342 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -1870,6 +1870,7 @@ config X86_INTEL_MEMORY_PROTECTION_KEYS
 	depends on X86_64 && (CPU_SUP_INTEL || CPU_SUP_AMD)
 	select ARCH_USES_HIGH_VMA_FLAGS
 	select ARCH_HAS_PKEYS
+	select ARCH_HAS_SUPERVISOR_PKEYS
 	help
 	  Memory Protection Keys provides a mechanism for enforcing
 	  page-based protections, but without requiring modification of the
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index cc96e26d69f7..83ed73407417 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -359,6 +359,7 @@
 #define X86_FEATURE_MOVDIR64B		(16*32+28) /* MOVDIR64B instruction */
 #define X86_FEATURE_ENQCMD		(16*32+29) /* ENQCMD and ENQCMDS instructions */
 #define X86_FEATURE_SGX_LC		(16*32+30) /* Software Guard Extensions Launch Control */
+#define X86_FEATURE_PKS			(16*32+31) /* Protection Keys for Supervisor pages */
 
 /* AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17 */
 #define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* MCA overflow recovery support */
diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index b7dd944dc867..fd09ae852c04 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -44,6 +44,12 @@
 # define DISABLE_OSPKE		(1<<(X86_FEATURE_OSPKE & 31))
 #endif /* CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS */
 
+#ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
+# define DISABLE_PKS		0
+#else
+# define DISABLE_PKS		(1<<(X86_FEATURE_PKS & 31))
+#endif
+
 #ifdef CONFIG_X86_5LEVEL
 # define DISABLE_LA57	0
 #else
@@ -88,7 +94,7 @@
 #define DISABLED_MASK14	0
 #define DISABLED_MASK15	0
 #define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP| \
-			 DISABLE_ENQCMD)
+			 DISABLE_ENQCMD|DISABLE_PKS)
 #define DISABLED_MASK17	0
 #define DISABLED_MASK18	0
 #define DISABLED_MASK19	0
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
index 24c045b24b95..c7d1fc780358 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -808,6 +808,10 @@ config ARCH_USES_HIGH_VMA_FLAGS
 	bool
 config ARCH_HAS_PKEYS
 	bool
+config ARCH_HAS_SUPERVISOR_PKEYS
+	bool
+config ARCH_ENABLE_SUPERVISOR_PKEYS
+	bool
 
 config PERCPU_STATS
 	bool "Collect percpu memory statistics"
-- 
2.28.0.rc0.12.gb6a658bd00c9

