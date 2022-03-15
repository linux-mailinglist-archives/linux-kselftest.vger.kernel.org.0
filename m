Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E5DA4DA050
	for <lists+linux-kselftest@lfdr.de>; Tue, 15 Mar 2022 17:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350155AbiCOQqE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 15 Mar 2022 12:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350156AbiCOQqD (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 15 Mar 2022 12:46:03 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E4E5717A;
        Tue, 15 Mar 2022 09:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647362690; x=1678898690;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g8Bmok9TU2BixmwZBvkUyF3g21CNVOQYbFMkghV/9hU=;
  b=ZFCkRvPrNx8FfAuDED5T941/GgRhmiT2IwpQf6G1q38L/1c4owCa5sMJ
   MA1A+wggtXLYoApGbbKJhf4pcV0an48r5Zl1Q9MvI47ZiKzQa5Bs7VJCy
   kKbD+fcrYVbYbipJ80FdW+s8Op06cMu/7Bvw/IVTXXzW8VGS7SM66v5dD
   w/Ht/Zw0OrNf0wV6fADRpxjZHSy62W7UzjYU0H+jUCjNGgw7V3tIyEJU5
   Q05t2lQdquCSe3Xc9aquyzTa3E4iBDDO5qreEwHwXfuR46Rk05yqRb0XL
   eQcTwMXyGvhy1TQCwn92Rpel5qBFsp50o0AQpvTRmgnb857aX3Rw9MXGH
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="342782291"
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="342782291"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 09:44:48 -0700
X-IronPort-AV: E=Sophos;i="5.90,184,1643702400"; 
   d="scan'208";a="714236355"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 09:44:47 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        sandipan@linux.ibm.com, fweimer@redhat.com,
        desnesn@linux.vnet.ibm.com, mingo@kernel.org,
        bauerman@linux.ibm.com, mpe@ellerman.id.au, msuchanek@suse.de,
        linux-mm@kvack.org, chang.seok.bae@intel.com, bp@suse.de,
        tglx@linutronix.de, hpa@zytor.com, x86@kernel.org, luto@kernel.org
Subject: [PATCH V2 3/4] selftests/x86/amx: Use provided __cpuid_count() macro
Date:   Tue, 15 Mar 2022 09:44:27 -0700
Message-Id: <1eb321d7cbded690f22b6cb91b29b82234cb4be0.1647360971.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1647360971.git.reinette.chatre@intel.com>
References: <cover.1647360971.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

kselftest.h makes the __cpuid_count() macro available
to conveniently call the CPUID instruction.

Remove the local CPUID wrapper and use __cpuid_count()
from kselftest.h instead.

__cpuid_count() from kselftest.h is used instead of the
macro provided by the compiler since gcc v4.4 (via cpuid.h)
because the selftest needs to be supported with gcc v3.2,
the minimal required version for stable kernels.

Cc: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
Changes since V1:
- Update changelog
- No longer include cpuid.h but obtain __cpuid_count() from
  kselftest.h.

 tools/testing/selftests/x86/amx.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index 3615ef4a48bb..d463ea30d90f 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -17,6 +17,8 @@
 #include <sys/syscall.h>
 #include <sys/wait.h>
 
+#include "../kselftest.h" /* For __cpuid_count() */
+
 #ifndef __x86_64__
 # error This test is 64-bit only
 #endif
@@ -45,13 +47,6 @@ static inline uint64_t xgetbv(uint32_t index)
 	return eax + ((uint64_t)edx << 32);
 }
 
-static inline void cpuid(uint32_t *eax, uint32_t *ebx, uint32_t *ecx, uint32_t *edx)
-{
-	asm volatile("cpuid;"
-		     : "=a" (*eax), "=b" (*ebx), "=c" (*ecx), "=d" (*edx)
-		     : "0" (*eax), "2" (*ecx));
-}
-
 static inline void xsave(struct xsave_buffer *xbuf, uint64_t rfbm)
 {
 	uint32_t rfbm_lo = rfbm;
@@ -115,9 +110,7 @@ static inline void check_cpuid_xsave(void)
 	 * support for the XSAVE feature set, including
 	 * XGETBV.
 	 */
-	eax = 1;
-	ecx = 0;
-	cpuid(&eax, &ebx, &ecx, &edx);
+	__cpuid_count(1, 0, eax, ebx, ecx, edx);
 	if (!(ecx & CPUID_LEAF1_ECX_XSAVE_MASK))
 		fatal_error("cpuid: no CPU xsave support");
 	if (!(ecx & CPUID_LEAF1_ECX_OSXSAVE_MASK))
@@ -140,9 +133,8 @@ static void check_cpuid_xtiledata(void)
 {
 	uint32_t eax, ebx, ecx, edx;
 
-	eax = CPUID_LEAF_XSTATE;
-	ecx = CPUID_SUBLEAF_XSTATE_USER;
-	cpuid(&eax, &ebx, &ecx, &edx);
+	__cpuid_count(CPUID_LEAF_XSTATE, CPUID_SUBLEAF_XSTATE_USER,
+		      eax, ebx, ecx, edx);
 
 	/*
 	 * EBX enumerates the size (in bytes) required by the XSAVE
@@ -153,10 +145,8 @@ static void check_cpuid_xtiledata(void)
 	 */
 	xbuf_size = ebx;
 
-	eax = CPUID_LEAF_XSTATE;
-	ecx = XFEATURE_XTILEDATA;
-
-	cpuid(&eax, &ebx, &ecx, &edx);
+	__cpuid_count(CPUID_LEAF_XSTATE, XFEATURE_XTILEDATA,
+		      eax, ebx, ecx, edx);
 	/*
 	 * eax: XTILEDATA state component size
 	 * ebx: XTILEDATA state component offset in user buffer
-- 
2.25.1

