Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 135676DF711
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 15:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbjDLNY5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 09:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbjDLNYV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 09:24:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9ECAD04;
        Wed, 12 Apr 2023 06:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681305831; x=1712841831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9BpcUv8c66ST3WTF2B2MwfMyr+tzTg2Oeje0L1fhnUA=;
  b=ZZilYb17Sy4j5d0cPVISSrJ7PtF01FF6Lryjesn4ywKhrRQhNivLx8oh
   gkSrjV/2h4n71+IVWSZ3oMDuxjPfc00lg8EcvZreK08X7uGr7bPt06EoW
   NYwcT4D9iJlBxzP91xaFTtyLzy7FycMqvofUcf3dxOJ9yfwibyUzVRQDW
   DYj1NDm10bc6neA7cHNKl+KlxhBvuXJI78zIATws/yegcRRzwYg3IIs8o
   y9dfL7erIcG87tC1a25bmJiqgTVdSR3Ti24MFDUGR1q5SOpsusA5XLX7R
   1fCbGutiu4cKdsZmt0HHVeG18hljqGPru0nPL0Mf7EeWEmA8cakQ/as37
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332590260"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332590260"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:22:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="639230112"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="639230112"
Received: from chanse1-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.80])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:22:43 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 17/22] selftests/resctrl: Pass the real number of tests to show_cache_info()
Date:   Wed, 12 Apr 2023 16:21:17 +0300
Message-Id: <20230412132122.29452-18-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230412132122.29452-1-ilpo.jarvinen@linux.intel.com>
References: <20230412132122.29452-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Some results include warm-up tests which are discarded before passing
the sum to show_cache_info(). Currently, show_cache_info() handles this
by subtracting -1 from number of tests in divisor. It is a trappy
construct to have sum and number of tests parameters to disagree like
this.

A more logical place for subtracting the skipped tests is where the sum
is calculated so move it there. Pass the correct number of tests to
show_cache_info() soit can use directly as the divisor for calculating
the average.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c    | 2 +-
 tools/testing/selftests/resctrl/cat_test.c | 2 +-
 tools/testing/selftests/resctrl/cmt_test.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 5e59c239961c..835d5a892524 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -312,7 +312,7 @@ int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
 	long avg_diff = 0;
 	int ret;
 
-	avg_llc_val = sum_llc_val / (num_of_runs - 1);
+	avg_llc_val = sum_llc_val / num_of_runs;
 	avg_diff = (long)abs(cache_span - avg_llc_val);
 	diff_percent = ((float)cache_span - avg_llc_val) / cache_span * 100;
 
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 2b5333ad13bb..edcc340744d7 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -81,7 +81,7 @@ static int check_results(struct resctrl_val_param *param)
 	no_of_bits = count_consecutive_bits(param->mask, NULL);
 
 	return show_cache_info(sum_llc_perf_miss, no_of_bits, param->span / 64,
-			       MAX_DIFF, MAX_DIFF_PERCENT, NUM_OF_RUNS,
+			       MAX_DIFF, MAX_DIFF_PERCENT, runs - 1,
 			       get_vendor() == ARCH_INTEL, false);
 }
 
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 15e824ada9b5..70c656581686 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -63,7 +63,7 @@ static int check_results(struct resctrl_val_param *param, int no_of_bits)
 	fclose(fp);
 
 	return show_cache_info(sum_llc_occu_resc, no_of_bits, param->span,
-			       MAX_DIFF, MAX_DIFF_PERCENT, NUM_OF_RUNS,
+			       MAX_DIFF, MAX_DIFF_PERCENT, runs - 1,
 			       true, true);
 }
 
-- 
2.30.2

