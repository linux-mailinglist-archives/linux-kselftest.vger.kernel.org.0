Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71D550EAED
	for <lists+linux-kselftest@lfdr.de>; Mon, 25 Apr 2022 23:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245361AbiDYVE2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 25 Apr 2022 17:04:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245386AbiDYVE1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 25 Apr 2022 17:04:27 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B63D18B0B
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Apr 2022 14:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650920482; x=1682456482;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6ckgeL4KsZpXnATSXDzVXDebPJyUit3q85D8eEEEQdw=;
  b=JSr9gVQzAxws1JQLlnBFzWprCV0WFDw0esMKpCTZY18UWm8vZilO2UcO
   3kBEEX/I+mtUJ20Xv4OvVCWzR6X6jCaqtNoXit6ZWnTyZCwHIH95MzF/F
   JI3Q7PgXJu6/5310qbSqXZP08GEx0e/qZk4KBMsbxYrDztWN3pB82lGxu
   xVeCNrcjXIBIy0C4ddtIUUaLdKUVXvNbNlj7ACFwDjJ6P3grHiTeePG5/
   pT/Guqi8yxvvXM7oGoF/2/rO1FuL70XOfBjqNpWxpowWGS5YkObzwRclE
   Qsva1+zoSnOKIEkTeZQPqTx0IX8ZfhOkDe6LfOSYVpXvyBVrAunP43Vme
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10328"; a="290502311"
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="290502311"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 14:01:19 -0700
X-IronPort-AV: E=Sophos;i="5.90,289,1643702400"; 
   d="scan'208";a="579499502"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2022 14:01:19 -0700
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, sandipan@linux.ibm.com,
        fweimer@redhat.com, desnesn@linux.vnet.ibm.com, mingo@kernel.org,
        bauerman@linux.ibm.com, mpe@ellerman.id.au, msuchanek@suse.de,
        linux-mm@kvack.org, chang.seok.bae@intel.com, bp@suse.de,
        tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com,
        luto@kernel.org, x86@kernel.org
Subject: [PATCH V3 3/4] selftests/x86/amx: Use provided __cpuid_count() macro
Date:   Mon, 25 Apr 2022 14:01:13 -0700
Message-Id: <a0f9e38aa4ac66bf7769b91477114299e6e6f156.1650918160.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1650918160.git.reinette.chatre@intel.com>
References: <cover.1650918160.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
No changes since V2.

Changes since V1:
- Update changelog
- No longer include cpuid.h but obtain __cpuid_count() from
  kselftest.h.

 tools/testing/selftests/x86/amx.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index 2189f0322d8b..625e42901237 100644
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

