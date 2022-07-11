Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C0955708AF
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Jul 2022 19:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbiGKRMv (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Jul 2022 13:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiGKRMv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Jul 2022 13:12:51 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C0CA37F97;
        Mon, 11 Jul 2022 10:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657559570; x=1689095570;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=t/nejBfKH/Zw9RquMZNWn+wzwhu4ohyZBaui/+FJ/6k=;
  b=ALDmmnc8LOnMvRk3vfefvHwsxjYs6NpRHx/DmvM9UP3CHurJKtQD5GvP
   cBCbf/8P8LagYNIn0yM+KQ7rAkSCtAuUiHfNswTiKjVoJYvLaChmm5wnj
   fZDMgETcYx4M+CHwxE3SOJdpra6dr0XaXwQya6P2sy1OCJJGHwmGylDgh
   svLczrGJcBpkJuYkAt8EYqtEjNVR7lS+5PeJK6kNd/DHEJD5gKOGnVMxi
   I9sWXbvXZMPGIamtw1m0CZ2imxhdCLqgLSWZwIAMQUuLXFLAk/aCqaNyK
   hBiRvuqhvdBJfiSghk/9v6OqAzrB9yhtL2D9u2cnPhdZzsG6ieuKP2f45
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="348697919"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="348697919"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 10:12:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="652544229"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by fmsmga008.fm.intel.com with ESMTP; 11 Jul 2022 10:12:49 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kselftest@vger.kernel.org, shuah@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     dave.hansen@linux.intel.com, tglx@linutronix.de, bp@suse.de,
        chang.seok.bae@intel.com
Subject: [PATCH v2 1/2] selftests/x86/signal: Adjust the test to the kernel's altstack check
Date:   Mon, 11 Jul 2022 10:03:29 -0700
Message-Id: <20220711170330.27138-2-chang.seok.bae@intel.com>
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

The test assumes an insufficient altstack is allowed. Then it raises a
signal to test the delivery failure due to an altstack overflow.

The kernel now provides the STRICT_SIGALTSTACK_SIZE option to tweak
sigaltstack()'s sanity check to prevent an insufficient altstack. ENOMEM is
returned on the check failure.

Adjust the code to skip the test when this option is on.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Changes from v1:
* Call out the config name (Shuah Khan).
* Massage the print message (Shuah Khan).
---
 tools/testing/selftests/x86/sigaltstack.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/x86/sigaltstack.c b/tools/testing/selftests/x86/sigaltstack.c
index f689af75e979..0e9842e69ca4 100644
--- a/tools/testing/selftests/x86/sigaltstack.c
+++ b/tools/testing/selftests/x86/sigaltstack.c
@@ -88,8 +88,20 @@ static void sigalrm(int sig, siginfo_t *info, void *ctx_void)
 
 static void test_sigaltstack(void *altstack, unsigned long size)
 {
-	if (setup_altstack(altstack, size))
+	if (setup_altstack(altstack, size)) {
+		/*
+		 * If the kernel rejects an insufficient altstack with
+		 * ENOMEM, then skip the test.
+		 */
+		if (errno == ENOMEM && size < at_minstack_size) {
+			printf("[SKIP]\tThe running kernel disallows an insufficient altstack with "
+			       "the STRICT_SIGALTSTACK_SIZE option. As the altstack was already "
+			       "measured, the overflow test is not needed.\n");
+			return;
+		}
+
 		err(1, "sigaltstack()");
+	}
 
 	sigalrm_expected = (size > at_minstack_size) ? true : false;
 
-- 
2.17.1

