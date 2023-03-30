Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C0AD6D139E
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Mar 2023 01:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbjC3XsW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Mar 2023 19:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231705AbjC3Xrx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Mar 2023 19:47:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066091287F;
        Thu, 30 Mar 2023 16:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680220039; x=1711756039;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ICpoF7mu9Aw52F1J5i0VBfsK43335W9h7I5PoX16fbU=;
  b=NvNnoRt3EtZAjx/7i0Gc0+r3jiYoDXI7TvrS4gg2Mof8PewT28pQirJt
   f3meeVSLfz6DUxYJSComdkcSk243uwu1/wWhF+pA2EJhI2i1Wqp92Snk0
   RXi5r4PFZTmu4NweNN37HO+JWPT0GhfnpxheSnmRaTEhm0IMTg8se6XQx
   30lLtvWKtVnkNdUva6huzZtgAVb57QpexMRbebH4LVozsJDrzQM1pPISe
   ge2TpY62fnAFnDhxb7BhbF6SVCQEZkweBoyH9moD8C5DY46zXZIguMyAB
   Kd/42wUcW7akw0OM9oj3NZOGLt/zgGWcdrjjCFMuipb1KMtTF1Y1Kmcd8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="427587829"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="427587829"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 16:47:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="930926052"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="930926052"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga006.fm.intel.com with ESMTP; 30 Mar 2023 16:47:16 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        bp@alien8.de, chang.seok.bae@intel.com
Subject: [PATCH v3 2/3] selftests/x86/amx: Fix the test to avoid failure when AMX is unavailable
Date:   Thu, 30 Mar 2023 16:35:19 -0700
Message-Id: <20230330233520.21937-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230330233520.21937-1-chang.seok.bae@intel.com>
References: <20220711170330.27138-1-chang.seok.bae@intel.com>
 <20230330233520.21937-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When a CPU does not have AMX, the test fails. But this is wrong as it
should be runnable regardless. Skip the test instead.

Also, simplify the feature check using arch_prctl() instead of CPUID. The
syscall is more trustworthy as the kernel controls the feature permission.

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Fixes: 6a3e0651b4a ("selftests/x86/amx: Add test cases for AMX state management")
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v2: None

Changes from v1:
* Simplify the feature check code (Shuah Khan).
---
 tools/testing/selftests/x86/amx.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index d884fd69dd51..f0b1efe89ef7 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -101,24 +101,6 @@ static void clearhandler(int sig)
 #define XFEATURE_MASK_XTILEDATA	(1 << XFEATURE_XTILEDATA)
 #define XFEATURE_MASK_XTILE	(XFEATURE_MASK_XTILECFG | XFEATURE_MASK_XTILEDATA)
 
-#define CPUID_LEAF1_ECX_XSAVE_MASK	(1 << 26)
-#define CPUID_LEAF1_ECX_OSXSAVE_MASK	(1 << 27)
-static inline void check_cpuid_xsave(void)
-{
-	uint32_t eax, ebx, ecx, edx;
-
-	/*
-	 * CPUID.1:ECX.XSAVE[bit 26] enumerates general
-	 * support for the XSAVE feature set, including
-	 * XGETBV.
-	 */
-	__cpuid_count(1, 0, eax, ebx, ecx, edx);
-	if (!(ecx & CPUID_LEAF1_ECX_XSAVE_MASK))
-		fatal_error("cpuid: no CPU xsave support");
-	if (!(ecx & CPUID_LEAF1_ECX_OSXSAVE_MASK))
-		fatal_error("cpuid: no OS xsave support");
-}
-
 static uint32_t xbuf_size;
 
 static struct {
@@ -350,6 +332,7 @@ enum expected_result { FAIL_EXPECTED, SUCCESS_EXPECTED };
 
 /* arch_prctl() and sigaltstack() test */
 
+#define ARCH_GET_XCOMP_SUPP	0x1021
 #define ARCH_GET_XCOMP_PERM	0x1022
 #define ARCH_REQ_XCOMP_PERM	0x1023
 
@@ -928,10 +911,16 @@ static void test_ptrace(void)
 
 int main(void)
 {
-	/* Check hardware availability at first */
-	check_cpuid_xsave();
-	check_cpuid_xtiledata();
+	unsigned long features;
+	long rc;
 
+	rc = syscall(SYS_arch_prctl, ARCH_GET_XCOMP_SUPP, &features);
+	if (rc || (features & XFEATURE_MASK_XTILE) != XFEATURE_MASK_XTILE) {
+		printf("[SKIP]\tno AMX support.\n");
+		exit(KSFT_FAIL);
+	}
+
+	check_cpuid_xtiledata();
 	init_stashed_xsave();
 	sethandler(SIGILL, handle_noperm, 0);
 
-- 
2.17.1

