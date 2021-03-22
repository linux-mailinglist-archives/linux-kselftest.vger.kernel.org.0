Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9535E343893
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Mar 2021 06:31:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbhCVFao (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Mar 2021 01:30:44 -0400
Received: from mga09.intel.com ([134.134.136.24]:18631 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229905AbhCVFae (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Mar 2021 01:30:34 -0400
IronPort-SDR: dbHJR4k80k04eXEuERkApa4PI9bTjjzhpnI5V9tn0BHJ3234M2uZio3Y0o0zOlqjLFHaTM4xkb
 xlRBqhKaiLzA==
X-IronPort-AV: E=McAfee;i="6000,8403,9930"; a="190298142"
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; 
   d="scan'208";a="190298142"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2021 22:30:33 -0700
IronPort-SDR: ry40SVansIgNGu+yKgeI6X2P5H8oq2YpVGVU/H0yomDUuEIc9Z9ZLnYAPfEFSVdUmuyBstKdqB
 MzFw4SoiOBAQ==
X-IronPort-AV: E=Sophos;i="5.81,268,1610438400"; 
   d="scan'208";a="607238739"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2021 22:30:33 -0700
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
Subject: [PATCH V4 03/10] x86/pks: Add additional PKEY helper macros
Date:   Sun, 21 Mar 2021 22:30:13 -0700
Message-Id: <20210322053020.2287058-4-ira.weiny@intel.com>
X-Mailer: git-send-email 2.28.0.rc0.12.gb6a658bd00c9
In-Reply-To: <20210322053020.2287058-1-ira.weiny@intel.com>
References: <20210322053020.2287058-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Avoid open coding shift and mask operations by defining and using helper
macros for PKey operations.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V3:
	new patch suggested by Dan Williams to use macros better.
---
 arch/x86/include/asm/pgtable.h      |  7 ++-----
 arch/x86/include/asm/pkeys_common.h | 11 ++++++++---
 arch/x86/mm/pkeys.c                 |  8 +++-----
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index bfbfb951fe65..b1529b44a996 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1370,19 +1370,16 @@ extern u32 init_pkru_value;
 
 static inline bool __pkru_allows_read(u32 pkru, u16 pkey)
 {
-	int pkru_pkey_bits = pkey * PKR_BITS_PER_PKEY;
-
-	return !(pkru & (PKR_AD_BIT << pkru_pkey_bits));
+	return !(pkru & PKR_AD_KEY(pkey));
 }
 
 static inline bool __pkru_allows_write(u32 pkru, u16 pkey)
 {
-	int pkru_pkey_bits = pkey * PKR_BITS_PER_PKEY;
 	/*
 	 * Access-disable disables writes too so we need to check
 	 * both bits here.
 	 */
-	return !(pkru & ((PKR_AD_BIT|PKR_WD_BIT) << pkru_pkey_bits));
+	return !(pkru & (PKR_AD_KEY(pkey) | PKR_WD_KEY(pkey)));
 }
 
 static inline u16 pte_flags_pkey(unsigned long pte_flags)
diff --git a/arch/x86/include/asm/pkeys_common.h b/arch/x86/include/asm/pkeys_common.h
index e40b0ced733f..0681522974ba 100644
--- a/arch/x86/include/asm/pkeys_common.h
+++ b/arch/x86/include/asm/pkeys_common.h
@@ -6,10 +6,15 @@
 #define PKR_WD_BIT 0x2
 #define PKR_BITS_PER_PKEY 2
 
+#define PKR_PKEY_SHIFT(pkey) (pkey * PKR_BITS_PER_PKEY)
+#define PKR_PKEY_MASK(pkey)  (((1 << PKR_BITS_PER_PKEY) - 1) << PKR_PKEY_SHIFT(pkey))
+
 /*
- * Generate an Access-Disable mask for the given pkey.  Several of these can be
- * OR'd together to generate pkey register values.
+ * Generate an Access-Disable and Write-Disable mask for the given pkey.
+ * Several of the AD's are OR'd together to generate a default pkey register
+ * value.
  */
-#define PKR_AD_KEY(pkey)	(PKR_AD_BIT << ((pkey) * PKR_BITS_PER_PKEY))
+#define PKR_AD_KEY(pkey)     (PKR_AD_BIT << PKR_PKEY_SHIFT(pkey))
+#define PKR_WD_KEY(pkey)     (PKR_WD_BIT << PKR_PKEY_SHIFT(pkey))
 
 #endif /*_ASM_X86_PKEYS_COMMON_H */
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index d1dfe743e79f..fc8c7e2bb21b 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -218,16 +218,14 @@ __setup("init_pkru=", setup_init_pkru);
  */
 u32 update_pkey_val(u32 pk_reg, int pkey, unsigned int flags)
 {
-	int pkey_shift = pkey * PKR_BITS_PER_PKEY;
-
 	/*  Mask out old bit values */
-	pk_reg &= ~(((1 << PKR_BITS_PER_PKEY) - 1) << pkey_shift);
+	pk_reg &= ~PKR_PKEY_MASK(pkey);
 
 	/*  Or in new values */
 	if (flags & PKEY_DISABLE_ACCESS)
-		pk_reg |= PKR_AD_BIT << pkey_shift;
+		pk_reg |= PKR_AD_KEY(pkey);
 	if (flags & PKEY_DISABLE_WRITE)
-		pk_reg |= PKR_WD_BIT << pkey_shift;
+		pk_reg |= PKR_WD_KEY(pkey);
 
 	return pk_reg;
 }
-- 
2.28.0.rc0.12.gb6a658bd00c9

