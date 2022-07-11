Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A9AE5708B3
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Jul 2022 19:13:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiGKRMy (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Jul 2022 13:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230460AbiGKRMw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Jul 2022 13:12:52 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D35FF37FAC;
        Mon, 11 Jul 2022 10:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657559570; x=1689095570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=UGq5Gzr0ziO1J3esOfv3AHluUVXjQNM4yjg4DeRb35Q=;
  b=nI2XvYNdVMQPhrbWnP01+xr04gdGhd1mVkFT3llNA6G6KprFeM69Sa3b
   FbHHfo4I795t8uTZuSzlbegti9h4Hq/mzFmFBhO2kn//mKagh3frEpe91
   m0Q7i+qrodKpsoa5db5G+xT2J5dlnPvg+0JqxL5suOFxcMkQDGegvLvoM
   dqZbUixM7C83kuBrSz4wTW8pGIaqWKcHZOPC/Enxpchl9e5KqA8tQ9GxQ
   HyLOvZP+JIYCkAE3uYg//aOtqFmNhOcRCVVteJBv9OiJcZK7ulXBVtmgs
   t/cxqvrYSC7bRzIcvP8FLAkHnuzA+vxACqggN88PzYQDK846A5pqARaDj
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="348697922"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="348697922"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 10:12:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="652544240"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jul 2022 10:12:49 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kselftest@vger.kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@suse.de,
        chang.seok.bae@intel.com
Subject: [PATCH v2 2/2] selftests/x86/amx: Fix the test to avoid failure when AMX is unavailable
Date:   Mon, 11 Jul 2022 10:03:30 -0700
Message-Id: <20220711170330.27138-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220711170330.27138-1-chang.seok.bae@intel.com>
References: <20220711170330.27138-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v1:
* Simplify the feature check code (Shuah Khan).
---
 tools/testing/selftests/x86/amx.c | 31 ++++++++++---------------------
 1 file changed, 10 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index 625e42901237..52e7dec50018 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -99,24 +99,6 @@ static void clearhandler(int sig)
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
@@ -348,6 +330,7 @@ enum expected_result { FAIL_EXPECTED, SUCCESS_EXPECTED };
 
 /* arch_prctl() and sigaltstack() test */
 
+#define ARCH_GET_XCOMP_SUPP	0x1021
 #define ARCH_GET_XCOMP_PERM	0x1022
 #define ARCH_REQ_XCOMP_PERM	0x1023
 
@@ -828,10 +811,16 @@ static void test_context_switch(void)
 
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

