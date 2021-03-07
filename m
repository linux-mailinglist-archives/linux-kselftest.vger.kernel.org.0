Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B0A33024C
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Mar 2021 15:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbhCGOzd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Mar 2021 09:55:33 -0500
Received: from mga17.intel.com ([192.55.52.151]:5871 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231613AbhCGOzL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Mar 2021 09:55:11 -0500
IronPort-SDR: oHWgxDIsnH03ZoD0iWTi9F6FGHz+TIgrR9K8IkSU48dXtysSciqV0OGT0RFXKs4SZ2HZsvfI1f
 KNR+JW9RCHWg==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="167813501"
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="167813501"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 06:55:10 -0800
IronPort-SDR: 7jthAWboxoeD/POSAeXJaxxT+6Vs/I4iurOE5MckvuVRWBeF3JXDzLDbHYfRFGGbEuLwNl6hmG
 EqDl/HEbyViQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="437189128"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Mar 2021 06:55:10 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Babu Moger" <babu.moger@amd.com>
Cc:     "linux-kselftest" <linux-kselftest@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v5 14/21] selftests/resctrl: Fix MBA/MBM results reporting format
Date:   Sun,  7 Mar 2021 14:54:55 +0000
Message-Id: <20210307145502.2916364-15-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210307145502.2916364-1-fenghua.yu@intel.com>
References: <20210307145502.2916364-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

MBM unit test starts fill_buf (default built-in benchmark) in a new con_mon
group (c1, m1) and records resctrl reported mbm values and iMC (Integrated
Memory Controller) values every second. It does this for five seconds
(randomly chosen value) in total. It then calculates average of resctrl_mbm
values and imc_mbm values and if the difference is greater than 300 MB/sec
(randomly chosen value), the test treats it as a failure. MBA unit test is
similar to MBM but after every run it changes schemata.

Checking for a difference of 300 MB/sec doesn't look very meaningful when
the mbm values are changing over a wide range. For example, below are the
values running MBA test on SKL with different allocations

1. With 10% as schemata both iMC and resctrl mbm_values are around 2000
   MB/sec
2. With 100% as schemata both iMC and resctrl mbm_values are around 10000
   MB/sec

A 300 MB/sec difference between resctrl_mbm and imc_mbm values is
acceptable at 100% schemata but it isn't acceptable at 10% schemata because
that's a huge difference.

So, fix this by checking for percentage difference instead of absolute
difference i.e. check if the difference between resctrl_mbm value and
imc_mbm value is within 5% (randomly chosen value) of imc_mbm value. If the
difference is greater than 5% of imc_mbm value, treat it is a failure.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/mba_test.c | 22 +++++++++++++---------
 tools/testing/selftests/resctrl/mbm_test.c | 15 ++++++++-------
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 3a226effe80c..fd66a831062c 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -12,7 +12,7 @@
 
 #define RESULT_FILE_NAME	"result_mba"
 #define NUM_OF_RUNS		5
-#define MAX_DIFF		300
+#define MAX_DIFF_PERCENT	5
 #define ALLOCATION_MAX		100
 #define ALLOCATION_MIN		10
 #define ALLOCATION_STEP		10
@@ -62,7 +62,8 @@ static void show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 	     allocation++) {
 		unsigned long avg_bw_imc, avg_bw_resc;
 		unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
-		unsigned long avg_diff;
+		int avg_diff_per;
+		float avg_diff;
 
 		/*
 		 * The first run is discarded due to inaccurate value from
@@ -76,16 +77,19 @@ static void show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 
 		avg_bw_imc = sum_bw_imc / (NUM_OF_RUNS - 1);
 		avg_bw_resc = sum_bw_resc / (NUM_OF_RUNS - 1);
-		avg_diff = labs((long)(avg_bw_resc - avg_bw_imc));
+		avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
+		avg_diff_per = (int)(avg_diff * 100);
 
-		ksft_print_msg("%s MBA schemata percentage %u smaller than %d %%\n",
-			       avg_diff > MAX_DIFF ? "fail:" : "pass:",
-			       ALLOCATION_MAX - ALLOCATION_STEP * allocation,
-			       MAX_DIFF);
-		ksft_print_msg("avg_diff: %lu\n", avg_diff);
+		ksft_print_msg("%s MBA: diff within %d%% for schemata %u\n",
+			       avg_diff_per > MAX_DIFF_PERCENT ?
+			       "fail:" : "pass:",
+			       MAX_DIFF_PERCENT,
+			       ALLOCATION_MAX - ALLOCATION_STEP * allocation);
+
+		ksft_print_msg("avg_diff_per: %d%%\n", avg_diff_per);
 		ksft_print_msg("avg_bw_imc: %lu\n", avg_bw_imc);
 		ksft_print_msg("avg_bw_resc: %lu\n", avg_bw_resc);
-		if (avg_diff > MAX_DIFF)
+		if (avg_diff_per > MAX_DIFF_PERCENT)
 			failed = true;
 	}
 
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 2b4f26013d84..44a89e0267eb 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -11,7 +11,7 @@
 #include "resctrl.h"
 
 #define RESULT_FILE_NAME	"result_mbm"
-#define MAX_DIFF		300
+#define MAX_DIFF_PERCENT	5
 #define NUM_OF_RUNS		5
 
 static int
@@ -19,8 +19,8 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, int span)
 {
 	unsigned long avg_bw_imc = 0, avg_bw_resc = 0;
 	unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
-	long avg_diff = 0;
-	int runs, ret;
+	int runs, ret, avg_diff_per;
+	float avg_diff = 0;
 
 	/*
 	 * Discard the first value which is inaccurate due to monitoring setup
@@ -33,12 +33,13 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, int span)
 
 	avg_bw_imc = sum_bw_imc / 4;
 	avg_bw_resc = sum_bw_resc / 4;
-	avg_diff = avg_bw_resc - avg_bw_imc;
+	avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
+	avg_diff_per = (int)(avg_diff * 100);
 
-	ret = labs(avg_diff) > MAX_DIFF;
+	ret = avg_diff_per > MAX_DIFF_PERCENT;
 	ksft_print_msg("%s MBM: diff within %d%%\n",
-		       ret ? "fail:" : "pass:", MAX_DIFF);
-	ksft_print_msg("avg_diff: %lu\n", labs(avg_diff));
+		       ret ? "fail:" : "pass:", MAX_DIFF_PERCENT);
+	ksft_print_msg("avg_diff_per: %d%%\n", avg_diff_per);
 	ksft_print_msg("Span (MB): %d\n", span);
 	ksft_print_msg("avg_bw_imc: %lu\n", avg_bw_imc);
 	ksft_print_msg("avg_bw_resc: %lu\n", avg_bw_resc);
-- 
2.30.1

