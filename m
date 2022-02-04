Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A510C4A9FDD
	for <lists+linux-kselftest@lfdr.de>; Fri,  4 Feb 2022 20:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbiBDTSB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 4 Feb 2022 14:18:01 -0500
Received: from mga11.intel.com ([192.55.52.93]:61194 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232133AbiBDTSB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 4 Feb 2022 14:18:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644002281; x=1675538281;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ywYTttuJXRdjJ0OJ0BK1t3r8NzP6IBsoSbAsrF/D1DY=;
  b=ncmqmrnFHBd4sGT+iJ+O+5AWiy+ArifGssbHvUKElCqOErTJFgEMsFCm
   pUqR2hjSyCSWFcf8R90Lu2j4pxkccGZpXaijFOuCe2cClaURPV/dwvB+F
   k1wCI8g6uLXGILDwp/KH4vysrpQOrc/OC+hr5wZG71MPAA/KIu0VeFOoF
   tJcUHqh4i61OFzvQaxKE9iXe/5Jaz33LORBn2hqXt7v7cPGss4IguVUL2
   +yvPr228T/IMSSjTVNyDoai+QRp5YBNVGwuGoiOz8JaI2tERsgBqwdoM+
   RFEKBqr2ditu5OoucHh2b6GQB2Mvkd3vnwzvMLFWMpmZc7aZJNmJUvEd8
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="246017069"
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="246017069"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 11:18:00 -0800
X-IronPort-AV: E=Sophos;i="5.88,343,1635231600"; 
   d="scan'208";a="524412817"
Received: from rchatre-ws.ostc.intel.com ([10.54.69.144])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Feb 2022 11:17:59 -0800
From:   Reinette Chatre <reinette.chatre@intel.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        "Chang S . Bae" <chang.seok.bae@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: [PATCH 2/3] selftests/x86/amx: Use existing __cpuid_count() macro
Date:   Fri,  4 Feb 2022 11:17:10 -0800
Message-Id: <3a5898efba81249dfb9f46f575e565f14409dde2.1644000145.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1644000145.git.reinette.chatre@intel.com>
References: <cover.1644000145.git.reinette.chatre@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

gcc as well as clang makes the __cpuid_count() macro available
via cpuid.h to conveniently call the CPUID instruction.

Below is a copy of the macro as found in cpuid.h:

 #define __cpuid_count(level, count, a, b, c, d)         \
   __asm__ ("cpuid\n\t"                                  \
            : "=a" (a), "=b" (b), "=c" (c), "=d" (d)     \
            : "0" (level), "2" (count))

The amx test contains a local function used as wrapper
to the CPUID instruction. One difference between the amx
implementation and the macro from cpuid.h is that the amx
implementation provides the "volatile" qualifier to the asm()
call. The "volatile" qualifier is necessary if CPUID has side
effects and thus any optimizations should be avoided. The
amx test uses CPUID to query the system's support for
XSAVE/XRSTOR and the save area properties, queries without
side effect, the "volatile" qualifier is thus not required
and the macro from cpuid.h can be used instead.

Remove the duplicated wrapper to CPUID and use __cpuid_count()
from cpuid.h instead.

Cc: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/x86/amx.c | 23 ++++++-----------------
 1 file changed, 6 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index 3615ef4a48bb..6476ab826603 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #define _GNU_SOURCE
+#include <cpuid.h>
 #include <err.h>
 #include <errno.h>
 #include <pthread.h>
@@ -45,13 +46,6 @@ static inline uint64_t xgetbv(uint32_t index)
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
@@ -115,9 +109,7 @@ static inline void check_cpuid_xsave(void)
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
@@ -140,9 +132,8 @@ static void check_cpuid_xtiledata(void)
 {
 	uint32_t eax, ebx, ecx, edx;
 
-	eax = CPUID_LEAF_XSTATE;
-	ecx = CPUID_SUBLEAF_XSTATE_USER;
-	cpuid(&eax, &ebx, &ecx, &edx);
+	__cpuid_count(CPUID_LEAF_XSTATE, CPUID_SUBLEAF_XSTATE_USER,
+		      eax, ebx, ecx, edx);
 
 	/*
 	 * EBX enumerates the size (in bytes) required by the XSAVE
@@ -153,10 +144,8 @@ static void check_cpuid_xtiledata(void)
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

