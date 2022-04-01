Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEF44EFCB6
	for <lists+linux-kselftest@lfdr.de>; Sat,  2 Apr 2022 00:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349970AbiDAWUa (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 1 Apr 2022 18:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236871AbiDAWU3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 1 Apr 2022 18:20:29 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4251B6446;
        Fri,  1 Apr 2022 15:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648851518; x=1680387518;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=MOFSRUY4vkr1OSoHJcHl0ihCsdiiWyX8LybT3qRw3P4=;
  b=hxXuZlwPhsxYgJavoYjz2VXHcce43SGqoqQTQisCbZKudD11oMfpbscj
   v9HjE5jphHIg5Cd22ooZ7jIwimeLpEnppihDem4sKaj3GRNiRMod3f+Nd
   tGOVG+8tKcNhzh6jrP257uwtmf6zdYCc7rZx4xs7qR71qgoW8vFIsOrn0
   gwlZZ4IWZpg1ATbNa9kNNOuBNaRMIIMHzDmxlvmUkqYCJnHsZyjhjqH15
   4Ahhn0kPS8/7ydAXzKpQMrnJFRpfxkIsnSDZUs8Y1ptd8ud5VNWi953kI
   HK+NXCpO7Q6AqKqzaEsRbx04MpVQf/dRmzay6yNkCcVSo58K+YOTEnmh9
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="259070830"
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="259070830"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 15:18:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,228,1643702400"; 
   d="scan'208";a="567860546"
Received: from chang-linux-3.sc.intel.com ([172.25.112.114])
  by orsmga008.jf.intel.com with ESMTP; 01 Apr 2022 15:18:35 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kselftest@vger.kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@suse.de,
        chang.seok.bae@intel.com
Subject: [PATCH 2/2] selftests/x86/amx: Fix the test to avoid failure when AMX is unavailable
Date:   Fri,  1 Apr 2022 15:10:14 -0700
Message-Id: <20220401221014.13556-3-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220401221014.13556-1-chang.seok.bae@intel.com>
References: <20220401221014.13556-1-chang.seok.bae@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Fixes: 6a3e0651b4a ("selftests/x86/amx: Add test cases for AMX state management")
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 tools/testing/selftests/x86/amx.c | 42 +++++++++++++++++++++++--------
 1 file changed, 31 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index 3615ef4a48bb..14abb6072a7d 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -106,6 +106,12 @@ static void clearhandler(int sig)
 
 #define CPUID_LEAF1_ECX_XSAVE_MASK	(1 << 26)
 #define CPUID_LEAF1_ECX_OSXSAVE_MASK	(1 << 27)
+
+static struct {
+	unsigned xsave:   1;
+	unsigned osxsave: 1;
+} cpuinfo;
+
 static inline void check_cpuid_xsave(void)
 {
 	uint32_t eax, ebx, ecx, edx;
@@ -118,10 +124,8 @@ static inline void check_cpuid_xsave(void)
 	eax = 1;
 	ecx = 0;
 	cpuid(&eax, &ebx, &ecx, &edx);
-	if (!(ecx & CPUID_LEAF1_ECX_XSAVE_MASK))
-		fatal_error("cpuid: no CPU xsave support");
-	if (!(ecx & CPUID_LEAF1_ECX_OSXSAVE_MASK))
-		fatal_error("cpuid: no OS xsave support");
+	cpuinfo.xsave = !!(ecx & CPUID_LEAF1_ECX_XSAVE_MASK);
+	cpuinfo.osxsave = !!(ecx & CPUID_LEAF1_ECX_OSXSAVE_MASK);
 }
 
 static uint32_t xbuf_size;
@@ -161,14 +165,31 @@ static void check_cpuid_xtiledata(void)
 	 * eax: XTILEDATA state component size
 	 * ebx: XTILEDATA state component offset in user buffer
 	 */
-	if (!eax || !ebx)
-		fatal_error("xstate cpuid: invalid tile data size/offset: %d/%d",
-				eax, ebx);
-
 	xtiledata.size	      = eax;
 	xtiledata.xbuf_offset = ebx;
 }
 
+static bool amx_available(void)
+{
+	check_cpuid_xsave();
+	if (!cpuinfo.xsave) {
+		printf("[SKIP]\tcpuid: no CPU xsave support\n");
+		return false;
+	} else if (!cpuinfo.osxsave) {
+		printf("[SKIP]\tcpuid: no OS xsave support\n");
+		return false;
+	}
+
+	check_cpuid_xtiledata();
+	if (!xtiledata.size || !xtiledata.xbuf_offset) {
+		printf("[SKIP]\txstate cpuid: no tile data (size/offset: %d/%d)\n",
+		       xtiledata.size, xtiledata.xbuf_offset);
+		return false;
+	}
+
+	return true;
+}
+
 /* The helpers for managing XSAVE buffer and tile states: */
 
 struct xsave_buffer *alloc_xbuf(void)
@@ -826,9 +847,8 @@ static void test_context_switch(void)
 
 int main(void)
 {
-	/* Check hardware availability at first */
-	check_cpuid_xsave();
-	check_cpuid_xtiledata();
+	if (!amx_available())
+		return 0;
 
 	init_stashed_xsave();
 	sethandler(SIGILL, handle_noperm, 0);
-- 
2.17.1

