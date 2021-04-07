Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74D0135754B
	for <lists+linux-kselftest@lfdr.de>; Wed,  7 Apr 2021 21:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348878AbhDGT5x (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 7 Apr 2021 15:57:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:42318 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231335AbhDGT5w (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 7 Apr 2021 15:57:52 -0400
IronPort-SDR: redly7H3jfJI+WW5Usc216fVlgSEHdVI47VXjaX3lDq+dwMriNltW7Lhroj+vN1HoZdo9QLKDk
 lpNNjFZW8USQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9947"; a="191227339"
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="191227339"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2021 12:57:43 -0700
IronPort-SDR: n3aZFrTVorVAcVb/gIfKRVknSctv4AwMUnh8B+o3gJ0yaF1QYkusBS8WSwt3IQ1g+2UevDeGXx
 RBPH8YXQjCmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,203,1613462400"; 
   d="scan'208";a="448376696"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Apr 2021 12:57:42 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kselftest" <linux-kselftest@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v2] selftests/resctrl: Change a few printed messages
Date:   Wed,  7 Apr 2021 19:57:28 +0000
Message-Id: <20210407195728.1436270-1-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Change a few printed messages to report test progress more clearly.

Add a missing "\n" at the end of one printed message.

Suggested-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
Change log:
v2:
- Add "Pass:" and "Fail:" sub-strings back (Shuah).

This is a follow-up patch of recent resctrl selftest patches and can be
applied cleanly to:
git git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git
branch next.

 tools/testing/selftests/resctrl/cache.c     | 2 +-
 tools/testing/selftests/resctrl/mba_test.c  | 6 +++---
 tools/testing/selftests/resctrl/mbm_test.c  | 2 +-
 tools/testing/selftests/resctrl/resctrlfs.c | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 362e3a418caa..68ff856d36f0 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -301,7 +301,7 @@ int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
 	ret = platform && abs((int)diff_percent) > max_diff_percent &&
 	      (cmt ? (abs(avg_diff) > max_diff) : true);
 
-	ksft_print_msg("%s cache miss rate within %d%%\n",
+	ksft_print_msg("%s Check cache miss rate within %d%%\n",
 		       ret ? "Fail:" : "Pass:", max_diff_percent);
 
 	ksft_print_msg("Percent diff=%d\n", abs((int)diff_percent));
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 26f12ad4c663..1a1bdb6180cf 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -80,7 +80,7 @@ static void show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 		avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
 		avg_diff_per = (int)(avg_diff * 100);
 
-		ksft_print_msg("%s MBA: diff within %d%% for schemata %u\n",
+		ksft_print_msg("%s Check MBA diff within %d%% for schemata %u\n",
 			       avg_diff_per > MAX_DIFF_PERCENT ?
 			       "Fail:" : "Pass:",
 			       MAX_DIFF_PERCENT,
@@ -93,10 +93,10 @@ static void show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 			failed = true;
 	}
 
-	ksft_print_msg("%s schemata change using MBA\n",
+	ksft_print_msg("%s Check schemata change using MBA\n",
 		       failed ? "Fail:" : "Pass:");
 	if (failed)
-		ksft_print_msg("At least one test failed");
+		ksft_print_msg("At least one test failed\n");
 }
 
 static int check_results(void)
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 02b1ed03f1e5..8392e5c55ed0 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -37,7 +37,7 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, int span)
 	avg_diff_per = (int)(avg_diff * 100);
 
 	ret = avg_diff_per > MAX_DIFF_PERCENT;
-	ksft_print_msg("%s MBM: diff within %d%%\n",
+	ksft_print_msg("%s Check MBM diff within %d%%\n",
 		       ret ? "Fail:" : "Pass:", MAX_DIFF_PERCENT);
 	ksft_print_msg("avg_diff_per: %d%%\n", avg_diff_per);
 	ksft_print_msg("Span (MB): %d\n", span);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index ade5f2b8b843..5f5a166ade60 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -570,14 +570,14 @@ bool check_resctrlfs_support(void)
 
 	fclose(inf);
 
-	ksft_print_msg("%s kernel supports resctrl filesystem\n",
+	ksft_print_msg("%s Check kernel supports resctrl filesystem\n",
 		       ret ? "Pass:" : "Fail:");
 
 	if (!ret)
 		return ret;
 
 	dp = opendir(RESCTRL_PATH);
-	ksft_print_msg("%s resctrl mountpoint \"%s\" exists\n",
+	ksft_print_msg("%s Check resctrl mountpoint \"%s\" exists\n",
 		       dp ? "Pass:" : "Fail:", RESCTRL_PATH);
 	if (dp)
 		closedir(dp);
-- 
2.31.1

