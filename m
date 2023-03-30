Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46D2F6D13A0
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Mar 2023 01:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjC3XsY (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Mar 2023 19:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbjC3Xrx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Mar 2023 19:47:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE5710AAB;
        Thu, 30 Mar 2023 16:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680220042; x=1711756042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=BDOVJxkv4ZCtP+exumrul4a9lyDZPaoK8i+VzmJqHJE=;
  b=MfEAjojD+Gk3mEDX8uSsu1pjgKRg28dU9ELllbN6P4FqIyaPRiWBDXrB
   BAgU0/RffY6Ils1UiexOs7Zbu+GOeeGf48Mj/kMCbFlJSynjTIkxV/wcL
   YqswD5g399LT//D6OJp9JrNA0FnTeuOSrO4ba3Lr9sZT/7sXgQt/Pe9Tt
   H0dc7RLwVRi1BZ5QdkhZn17xZoT6iYIOapfiKiMujBSCAaBdNFb+9pYuo
   2KoB6t51LFcciVU+5loAskbXoUcjQ0IKhN6flt4s/WD3x0Q4xdA6TM4Ah
   Snnb++932y6W/ahT6x9W+bTlb7xMEK5mjHE/W5q9YTJUbSMgXh+vWGjn+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="427587834"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="427587834"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 16:47:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="930926055"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="930926055"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga006.fm.intel.com with ESMTP; 30 Mar 2023 16:47:16 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        bp@alien8.de, chang.seok.bae@intel.com
Subject: [PATCH v3 3/3] selftests/x86/amx: Remove unneeded code
Date:   Thu, 30 Mar 2023 16:35:20 -0700
Message-Id: <20230330233520.21937-4-chang.seok.bae@intel.com>
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

Remove some unused helper code. Also, get rid of the redundant permission
request.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v2:
* Add as a new patch
---
 tools/testing/selftests/x86/amx.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/tools/testing/selftests/x86/amx.c b/tools/testing/selftests/x86/amx.c
index f0b1efe89ef7..854f7d61be89 100644
--- a/tools/testing/selftests/x86/amx.c
+++ b/tools/testing/selftests/x86/amx.c
@@ -39,16 +39,6 @@ struct xsave_buffer {
 	};
 };
 
-static inline uint64_t xgetbv(uint32_t index)
-{
-	uint32_t eax, edx;
-
-	asm volatile("xgetbv;"
-		     : "=a" (eax), "=d" (edx)
-		     : "c" (index));
-	return eax + ((uint64_t)edx << 32);
-}
-
 static inline void xsave(struct xsave_buffer *xbuf, uint64_t rfbm)
 {
 	uint32_t rfbm_lo = rfbm;
@@ -110,8 +100,6 @@ static struct {
 
 #define CPUID_LEAF_XSTATE		0xd
 #define CPUID_SUBLEAF_XSTATE_USER	0x0
-#define TILE_CPUID			0x1d
-#define TILE_PALETTE_ID			0x1
 
 static void check_cpuid_xtiledata(void)
 {
@@ -161,12 +149,6 @@ static inline void clear_xstate_header(struct xsave_buffer *buffer)
 	memset(&buffer->header, 0, sizeof(buffer->header));
 }
 
-static inline uint64_t get_xstatebv(struct xsave_buffer *buffer)
-{
-	/* XSTATE_BV is at the beginning of the header: */
-	return *(uint64_t *)&buffer->header;
-}
-
 static inline void set_xstatebv(struct xsave_buffer *buffer, uint64_t bv)
 {
 	/* XSTATE_BV is at the beginning of the header: */
@@ -769,8 +751,6 @@ static void test_context_switch(void)
 	/* Affinitize to one CPU to force context switches */
 	affinitize_cpu0();
 
-	req_xtiledata_perm();
-
 	printf("[RUN]\tCheck tiledata context switches, %d iterations, %d threads.\n",
 	       ctxtswtest_config.iterations,
 	       ctxtswtest_config.num_threads);
-- 
2.17.1

