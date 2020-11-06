Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF3372AA14F
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Nov 2020 00:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgKFX3i (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Nov 2020 18:29:38 -0500
Received: from mga11.intel.com ([192.55.52.93]:33110 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728270AbgKFX3i (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Nov 2020 18:29:38 -0500
IronPort-SDR: 3VLyvhvDiNTVAXyPdpnx72z1LGlQFa9PnZDpMhB5Yzh5YHXwnNIKrDoYBZK3OrnHxPHTahq9o8
 zmSNHVP0fgvA==
X-IronPort-AV: E=McAfee;i="6000,8403,9797"; a="166102931"
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400"; 
   d="scan'208";a="166102931"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 15:29:37 -0800
IronPort-SDR: k4byyvrseYAeoBugGywJ+QOjnx9bAxJF6P0x70TOG2wyk/Qhysfn8ADhVz292RTBJTIDkyng9d
 GrFVwhEgV3Mw==
X-IronPort-AV: E=Sophos;i="5.77,457,1596524400"; 
   d="scan'208";a="307352972"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2020 15:29:37 -0800
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Dave Hansen <dave.hansen@linux.intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Ira Weiny <ira.weiny@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>,
        Greg KH <gregkh@linuxfoundation.org>
Subject: [PATCH V3 09/10] x86/pks: Enable Protection Keys Supervisor (PKS)
Date:   Fri,  6 Nov 2020 15:29:07 -0800
Message-Id: <20201106232908.364581-10-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20201106232908.364581-1-ira.weiny@intel.com>
References: <20201106232908.364581-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Fenghua Yu <fenghua.yu@intel.com>

Protection Keys for Supervisor pages (PKS) enables fast, hardware thread
specific, manipulation of permission restrictions on supervisor page
mappings.  It uses the same mechanism of Protection Keys as those on
User mappings but applies that mechanism to supervisor mappings using a
supervisor specific MSR.

Kernel users can thus defines 'domains' of page mappings which have an
extra level of protection beyond those specified in the supervisor page
table entries.

Enable PKS on supported CPUS.

Co-developed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>

---
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
 arch/x86/include/asm/disabled-features.h |  6 +++++-
 arch/x86/kernel/cpu/common.c             | 15 +++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
index 164587177152..82540f0c5b6c 100644
--- a/arch/x86/include/asm/disabled-features.h
+++ b/arch/x86/include/asm/disabled-features.h
@@ -44,7 +44,11 @@
 # define DISABLE_OSPKE		(1<<(X86_FEATURE_OSPKE & 31))
 #endif /* CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS */
 
-#define DISABLE_PKS           (1<<(X86_FEATURE_PKS & 31))
+#ifdef CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
+# define DISABLE_PKS		0
+#else
+# define DISABLE_PKS		(1<<(X86_FEATURE_PKS & 31))
+#endif
 
 #ifdef CONFIG_X86_5LEVEL
 # define DISABLE_LA57	0
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 35ad8480c464..f8929a557d72 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -58,6 +58,7 @@
 #include <asm/intel-family.h>
 #include <asm/cpu_device_id.h>
 #include <asm/uv/uv.h>
+#include <linux/pkeys.h>
 
 #include "cpu.h"
 
@@ -1494,6 +1495,19 @@ static void validate_apic_and_package_id(struct cpuinfo_x86 *c)
 #endif
 }
 
+/*
+ * PKS is independent of PKU and either or both may be supported on a CPU.
+ * Configure PKS if the CPU supports the feature.
+ */
+static void setup_pks(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_PKS))
+		return;
+
+	write_pkrs(INIT_PKRS_VALUE);
+	cr4_set_bits(X86_CR4_PKS);
+}
+
 /*
  * This does the hard work of actually picking apart the CPU stuff...
  */
@@ -1591,6 +1605,7 @@ static void identify_cpu(struct cpuinfo_x86 *c)
 
 	x86_init_rdrand(c);
 	setup_pku(c);
+	setup_pks();
 
 	/*
 	 * Clear/Set all flags overridden by options, need do it
-- 
2.28.0.rc0.12.gb6a658bd00c9

