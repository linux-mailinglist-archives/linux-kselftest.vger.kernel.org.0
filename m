Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70D863549D0
	for <lists+linux-kselftest@lfdr.de>; Tue,  6 Apr 2021 02:53:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243033AbhDFAxM (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Apr 2021 20:53:12 -0400
Received: from mga03.intel.com ([134.134.136.65]:50206 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237938AbhDFAxK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Apr 2021 20:53:10 -0400
IronPort-SDR: xeIaEK2e31K3rYK10lKHgsVtSX5ZgUbN506vdrcNi558yp9dVjQFNSAPmPRYy7zLIDkBERJVKN
 KaexUyfBz/gA==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="192993131"
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="192993131"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Apr 2021 17:53:02 -0700
IronPort-SDR: lC5vbvukdzXt21VHIfSyHrHOJShRjOAe5LMv4XbGc2iPafxEBAHQoPjB8fKLlt8WqMkUJhDK6k
 NXACFn4+YQWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; 
   d="scan'208";a="386353022"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by fmsmga007.fm.intel.com with ESMTP; 05 Apr 2021 17:53:01 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kselftest" <linux-kselftest@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH] selftests/resctrl: Change a few printed messages
Date:   Tue,  6 Apr 2021 00:52:42 +0000
Message-Id: <20210406005242.3248706-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A few printed messages contain pass/fail strings which should be shown
in test results. Remove the pass/fail strings in the messages to avoid
confusion.

Add "\n" at the end of one printed message.

Suggested-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
This is a follow-up patch of recent resctrl selftest patches and can be
applied cleanly to:
git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
branch next.

 tools/testing/selftests/resctrl/cache.c     | 3 +--
 tools/testing/selftests/resctrl/mba_test.c  | 9 +++------
 tools/testing/selftests/resctrl/mbm_test.c  | 3 +--
 tools/testing/selftests/resctrl/resctrlfs.c | 7 ++-----
 4 files changed, 7 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 362e3a418caa..310bbc997c60 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -301,8 +301,7 @@ int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
 	ret = platform && abs((int)diff_percent) > max_diff_percent &&
 	      (cmt ? (abs(avg_diff) > max_diff) : true);
 
-	ksft_print_msg("%s cache miss rate within %d%%\n",
-		       ret ? "Fail:" : "Pass:", max_diff_percent);
+	ksft_print_msg("Check cache miss rate within %d%%\n", max_diff_percent);
 
 	ksft_print_msg("Percent diff=%d\n", abs((int)diff_percent));
 	ksft_print_msg("Number of bits: %d\n", no_of_bits);
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 26f12ad4c663..a909a745754f 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -80,9 +80,7 @@ static void show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 		avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
 		avg_diff_per = (int)(avg_diff * 100);
 
-		ksft_print_msg("%s MBA: diff within %d%% for schemata %u\n",
-			       avg_diff_per > MAX_DIFF_PERCENT ?
-			       "Fail:" : "Pass:",
+		ksft_print_msg("Check MBA diff within %d%% for schemata %u\n",
 			       MAX_DIFF_PERCENT,
 			       ALLOCATION_MAX - ALLOCATION_STEP * allocation);
 
@@ -93,10 +91,9 @@ static void show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 			failed = true;
 	}
 
-	ksft_print_msg("%s schemata change using MBA\n",
-		       failed ? "Fail:" : "Pass:");
+	ksft_print_msg("Check schemata change using MBA\n");
 	if (failed)
-		ksft_print_msg("At least one test failed");
+		ksft_print_msg("At least one test failed\n");
 }
 
 static int check_results(void)
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 02b1ed03f1e5..e2e7ee4ec630 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -37,8 +37,7 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, int span)
 	avg_diff_per = (int)(avg_diff * 100);
 
 	ret = avg_diff_per > MAX_DIFF_PERCENT;
-	ksft_print_msg("%s MBM: diff within %d%%\n",
-		       ret ? "Fail:" : "Pass:", MAX_DIFF_PERCENT);
+	ksft_print_msg("Check MBM diff within %d%%\n", MAX_DIFF_PERCENT);
 	ksft_print_msg("avg_diff_per: %d%%\n", avg_diff_per);
 	ksft_print_msg("Span (MB): %d\n", span);
 	ksft_print_msg("avg_bw_imc: %lu\n", avg_bw_imc);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index ade5f2b8b843..91cb3c48a7da 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -570,15 +570,12 @@ bool check_resctrlfs_support(void)
 
 	fclose(inf);
 
-	ksft_print_msg("%s kernel supports resctrl filesystem\n",
-		       ret ? "Pass:" : "Fail:");
-
+	ksft_print_msg("Check kernel support for resctrl filesystem\n");
 	if (!ret)
 		return ret;
 
 	dp = opendir(RESCTRL_PATH);
-	ksft_print_msg("%s resctrl mountpoint \"%s\" exists\n",
-		       dp ? "Pass:" : "Fail:", RESCTRL_PATH);
+	ksft_print_msg("Check resctrl mountpoint \"%s\"\n", RESCTRL_PATH);
 	if (dp)
 		closedir(dp);
 
-- 
2.31.1

