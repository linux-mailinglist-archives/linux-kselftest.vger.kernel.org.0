Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24826D139F
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Mar 2023 01:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231822AbjC3XsX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 30 Mar 2023 19:48:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbjC3Xrx (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 30 Mar 2023 19:47:53 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 720AA12BF4;
        Thu, 30 Mar 2023 16:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680220042; x=1711756042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=PXl1dGOSTl3mjfBv99XnPT3QfP3sbVC8+kNUvV4iUz4=;
  b=YWeOrMdjuvUsAeQlKBK4PxqDsMoposkoi4rhIYI6AGr8Y/nlLEC6ftou
   jOXfKdaeAx06cC+G6jgtYttjtL0TAMahGdlOlEjUwUv+QyuvvDZngA72a
   icL1B7i9TNlxRtvMzAGDzLMBeHCZBrF7IePxV90TvyKwZiDn520Q/qCjs
   HItQuVtUkZsuksOYshCWmheS8DpVI0Mu8gZaDxjs28KekkpmVZnFzF+wK
   AoLTdkr5XbdWnlOhR8CMR3JA1o8R/Ri2eRMFhxnScLLHBckhTBU9T5QDv
   o4yFcgbjTESKccKJLUKYvcGgFYS7c3RTK8yLztR1cldQ+KdPyfKsgDFG6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="427587825"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="427587825"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2023 16:47:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10665"; a="930926049"
X-IronPort-AV: E=Sophos;i="5.98,306,1673942400"; 
   d="scan'208";a="930926049"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga006.fm.intel.com with ESMTP; 30 Mar 2023 16:47:16 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     shuah@kernel.org, tglx@linutronix.de, dave.hansen@linux.intel.com,
        bp@alien8.de, chang.seok.bae@intel.com
Subject: [PATCH v3 1/3] selftests/x86/sigaltstack: Adjust the test to the kernel's altstack check
Date:   Thu, 30 Mar 2023 16:35:18 -0700
Message-Id: <20230330233520.21937-2-chang.seok.bae@intel.com>
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

The test assumes an insufficient altstack is allowed. Then it raises a
signal to test the delivery failure due to an altstack overflow.

The kernel now provides the STRICT_SIGALTSTACK_SIZE option to tweak
sigaltstack()'s sanity check to prevent an insufficient altstack.
ENOMEM is returned on the check failure.

Adjust the code to skip the test when this option is on.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v2:
* Fix the subsystem name in the subject.

Changes from v1:
* Call out the config name (Shuah Khan).
* Massage the print message (Shuah Khan).
---
 tools/testing/selftests/x86/sigaltstack.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/sigaltstack.c b/tools/testing/selftests/x86/sigaltstack.c
index f689af75e979..22a88b764a8e 100644
--- a/tools/testing/selftests/x86/sigaltstack.c
+++ b/tools/testing/selftests/x86/sigaltstack.c
@@ -88,8 +88,18 @@ static void sigalrm(int sig, siginfo_t *info, void *ctx_void)
 
 static void test_sigaltstack(void *altstack, unsigned long size)
 {
-	if (setup_altstack(altstack, size))
+	if (setup_altstack(altstack, size)) {
+		/*
+		 * The kernel may return ENOMEM when the altstack size
+		 * is insufficient. Skip the test in this case.
+		 */
+		if (errno == ENOMEM && size < at_minstack_size) {
+			printf("[SKIP]\tThe running kernel disallows an insufficient size.\n");
+			return;
+		}
+
 		err(1, "sigaltstack()");
+	}
 
 	sigalrm_expected = (size > at_minstack_size) ? true : false;
 
-- 
2.17.1

