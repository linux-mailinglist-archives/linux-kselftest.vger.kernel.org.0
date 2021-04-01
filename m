Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC60C3522F9
	for <lists+linux-kselftest@lfdr.de>; Fri,  2 Apr 2021 00:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbhDAW6h (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 1 Apr 2021 18:58:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:11530 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235119AbhDAW6h (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 1 Apr 2021 18:58:37 -0400
IronPort-SDR: 6qxxvLmIOyRf3Uug9icysVHVMkBKDO3Rvx5Gp7wjowq7SuOA9032GbJK7I6Ievnp0eWer5etjE
 XCdBe+/1gpnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="190117097"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="190117097"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:58:36 -0700
IronPort-SDR: q7L/L0FdeHJkJjMr0bbb57D+5sc7T5IRlhocoGooatCKHSZsDt/ujInWpA7FHz/2wy6kowF9Hq
 pQlIFNNOC/Cg==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="611092339"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 15:58:36 -0700
From:   ira.weiny@intel.com
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH V6 01/10] x86/pkeys: Create pkeys_common.h
Date:   Thu,  1 Apr 2021 15:58:24 -0700
Message-Id: <20210401225833.566238-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210401225833.566238-1-ira.weiny@intel.com>
References: <20210401225833.566238-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Protection Keys User (PKU) and Protection Keys Supervisor (PKS) work in
similar fashions and can share common defines.  Specifically PKS and PKU
each have:

	1. A single control register
	2. The same number of keys
	3. The same number of bits in the register per key
	4. Access and Write disable in the same bit locations

Given the above, share all the macros that synthesize and manipulate
register values between the two features.  Unlike PKU the PKS
definitions are needed in both pgtable.h and pkeys.h.  Create a common
header for those 2 headers to share. The alternative, including
pgtable.h in pkeys.h, triggers complex header dependencies.

Share these defines by moving them into a new header, change their names
to reflect the common use, and include the header where needed.

Also while editing the code remove the use of 'we' from comments being
touched.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
NOTE: The initialization of init_pkru_value cause checkpatch errors
because of the space after the '(' in the macros.  Leave this as is
because it is more readable in this format.  And it was existing code.

---
Changes from V5:
	Remove 'we' from code comments

Changes from V3:
	From Dan Williams
		Fix guard macro names
		Reword commit message.

Changes from RFC V3
	Per Dave Hansen
		Update commit message
		Add comment to PKR_AD_KEY macro
---
 arch/x86/include/asm/pgtable.h      | 18 +++++++-----------
 arch/x86/include/asm/pkeys.h        |  2 ++
 arch/x86/include/asm/pkeys_common.h | 15 +++++++++++++++
 arch/x86/kernel/fpu/xstate.c        | 10 +++++-----
 arch/x86/mm/pkeys.c                 | 14 ++++++--------
 5 files changed, 35 insertions(+), 24 deletions(-)
 create mode 100644 arch/x86/include/asm/pkeys_common.h

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index a02c67291cfc..53bbde334193 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1360,9 +1360,7 @@ static inline pmd_t pmd_swp_clear_uffd_wp(pmd_t pmd)
 }
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
 
-#define PKRU_AD_BIT 0x1
-#define PKRU_WD_BIT 0x2
-#define PKRU_BITS_PER_PKEY 2
+#include <asm/pkeys_common.h>
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
 extern u32 init_pkru_value;
@@ -1372,18 +1370,16 @@ extern u32 init_pkru_value;
 
 static inline bool __pkru_allows_read(u32 pkru, u16 pkey)
 {
-	int pkru_pkey_bits = pkey * PKRU_BITS_PER_PKEY;
-	return !(pkru & (PKRU_AD_BIT << pkru_pkey_bits));
+	int pkru_pkey_bits = pkey * PKR_BITS_PER_PKEY;
+
+	return !(pkru & (PKR_AD_BIT << pkru_pkey_bits));
 }
 
 static inline bool __pkru_allows_write(u32 pkru, u16 pkey)
 {
-	int pkru_pkey_bits = pkey * PKRU_BITS_PER_PKEY;
-	/*
-	 * Access-disable disables writes too so we need to check
-	 * both bits here.
-	 */
-	return !(pkru & ((PKRU_AD_BIT|PKRU_WD_BIT) << pkru_pkey_bits));
+	int pkru_pkey_bits = pkey * PKR_BITS_PER_PKEY;
+	/* Access-disable disables writes too so check both bits here. */
+	return !(pkru & ((PKR_AD_BIT|PKR_WD_BIT) << pkru_pkey_bits));
 }
 
 static inline u16 pte_flags_pkey(unsigned long pte_flags)
diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index 2ff9b98812b7..f9feba80894b 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_PKEYS_H
 #define _ASM_X86_PKEYS_H
 
+#include <asm/pkeys_common.h>
+
 #define ARCH_DEFAULT_PKEY	0
 
 /*
diff --git a/arch/x86/include/asm/pkeys_common.h b/arch/x86/include/asm/pkeys_common.h
new file mode 100644
index 000000000000..e40b0ced733f
--- /dev/null
+++ b/arch/x86/include/asm/pkeys_common.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_PKEYS_COMMON_H
+#define _ASM_X86_PKEYS_COMMON_H
+
+#define PKR_AD_BIT 0x1
+#define PKR_WD_BIT 0x2
+#define PKR_BITS_PER_PKEY 2
+
+/*
+ * Generate an Access-Disable mask for the given pkey.  Several of these can be
+ * OR'd together to generate pkey register values.
+ */
+#define PKR_AD_KEY(pkey)	(PKR_AD_BIT << ((pkey) * PKR_BITS_PER_PKEY))
+
+#endif /*_ASM_X86_PKEYS_COMMON_H */
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 683749b80ae2..406ad78e1969 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -995,7 +995,7 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		unsigned long init_val)
 {
 	u32 old_pkru;
-	int pkey_shift = (pkey * PKRU_BITS_PER_PKEY);
+	int pkey_shift = (pkey * PKR_BITS_PER_PKEY);
 	u32 new_pkru_bits = 0;
 
 	/*
@@ -1012,18 +1012,18 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 	 */
 	WARN_ON_ONCE(pkey >= arch_max_pkey());
 
-	/* Set the bits we need in PKRU:  */
+	/* Set the bits needed in PKRU:  */
 	if (init_val & PKEY_DISABLE_ACCESS)
-		new_pkru_bits |= PKRU_AD_BIT;
+		new_pkru_bits |= PKR_AD_BIT;
 	if (init_val & PKEY_DISABLE_WRITE)
-		new_pkru_bits |= PKRU_WD_BIT;
+		new_pkru_bits |= PKR_WD_BIT;
 
 	/* Shift the bits in to the correct place in PKRU for pkey: */
 	new_pkru_bits <<= pkey_shift;
 
 	/* Get old PKRU and mask off any old bits in place: */
 	old_pkru = read_pkru();
-	old_pkru &= ~((PKRU_AD_BIT|PKRU_WD_BIT) << pkey_shift);
+	old_pkru &= ~((PKR_AD_BIT|PKR_WD_BIT) << pkey_shift);
 
 	/* Write old part along with new part: */
 	write_pkru(old_pkru | new_pkru_bits);
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 8873ed1438a9..f5efb4007e74 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -111,19 +111,17 @@ int __arch_override_mprotect_pkey(struct vm_area_struct *vma, int prot, int pkey
 	return vma_pkey(vma);
 }
 
-#define PKRU_AD_KEY(pkey)	(PKRU_AD_BIT << ((pkey) * PKRU_BITS_PER_PKEY))
-
 /*
  * Make the default PKRU value (at execve() time) as restrictive
  * as possible.  This ensures that any threads clone()'d early
  * in the process's lifetime will not accidentally get access
  * to data which is pkey-protected later on.
  */
-u32 init_pkru_value = PKRU_AD_KEY( 1) | PKRU_AD_KEY( 2) | PKRU_AD_KEY( 3) |
-		      PKRU_AD_KEY( 4) | PKRU_AD_KEY( 5) | PKRU_AD_KEY( 6) |
-		      PKRU_AD_KEY( 7) | PKRU_AD_KEY( 8) | PKRU_AD_KEY( 9) |
-		      PKRU_AD_KEY(10) | PKRU_AD_KEY(11) | PKRU_AD_KEY(12) |
-		      PKRU_AD_KEY(13) | PKRU_AD_KEY(14) | PKRU_AD_KEY(15);
+u32 init_pkru_value = PKR_AD_KEY( 1) | PKR_AD_KEY( 2) | PKR_AD_KEY( 3) |
+		      PKR_AD_KEY( 4) | PKR_AD_KEY( 5) | PKR_AD_KEY( 6) |
+		      PKR_AD_KEY( 7) | PKR_AD_KEY( 8) | PKR_AD_KEY( 9) |
+		      PKR_AD_KEY(10) | PKR_AD_KEY(11) | PKR_AD_KEY(12) |
+		      PKR_AD_KEY(13) | PKR_AD_KEY(14) | PKR_AD_KEY(15);
 
 /*
  * Called from the FPU code when creating a fresh set of FPU
@@ -173,7 +171,7 @@ static ssize_t init_pkru_write_file(struct file *file,
 	 * up immediately if someone attempts to disable access
 	 * or writes to pkey 0.
 	 */
-	if (new_init_pkru & (PKRU_AD_BIT|PKRU_WD_BIT))
+	if (new_init_pkru & (PKR_AD_BIT|PKR_WD_BIT))
 		return -EINVAL;
 
 	WRITE_ONCE(init_pkru_value, new_init_pkru);
-- 
2.28.0.rc0.12.gb6a658bd00c9

