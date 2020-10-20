Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44A52945A6
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 01:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439519AbgJTXwV (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Oct 2020 19:52:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:11167 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439372AbgJTXvh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Oct 2020 19:51:37 -0400
IronPort-SDR: jZSOppBYJenG4AjzmLlpG+cZtmempKzIIW/kYTVBNa/bi2K/IBVk2nQPDCRYfj8biyNzjxRKpt
 fQKuLPllVd0A==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="231486361"
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="231486361"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 16:51:31 -0700
IronPort-SDR: D0VnyMM8QBvac823em46Q12m79yAHAC/xk7r/1uZhWgEBev9KLXUmfbWbd6sAwhG/OhkS1oN7s
 KUTc1aS9lGrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="320833841"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by orsmga006.jf.intel.com with ESMTP; 20 Oct 2020 16:51:31 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kselftest" <linux-kselftest@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3 10/21] selftests/resctrl: Fix MBA/MBM results reporting format
Date:   Tue, 20 Oct 2020 23:51:15 +0000
Message-Id: <20201020235126.1871815-11-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201020235126.1871815-1-fenghua.yu@intel.com>
References: <20201020235126.1871815-1-fenghua.yu@intel.com>
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

Fixes: 01fee6b4d1f9 ("selftests/resctrl: Add MBA test")
Fixes: ecdbb911f22d ("selftests/resctrl: Add MBM test")
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/mba_test.c | 20 +++++++++++---------
 tools/testing/selftests/resctrl/mbm_test.c | 13 +++++++------
 2 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 7bf8eaa6204b..ba0234d4829e 100644
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
@@ -76,17 +77,18 @@ static void show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 
 		avg_bw_imc = sum_bw_imc / (NUM_OF_RUNS - 1);
 		avg_bw_resc = sum_bw_resc / (NUM_OF_RUNS - 1);
-		avg_diff = labs((long)(avg_bw_resc - avg_bw_imc));
+		avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
+		avg_diff_per = (int)(avg_diff * 100);
 
-		printf("%sok MBA schemata percentage %u smaller than %d %%\n",
-		       avg_diff > MAX_DIFF ? "not " : "",
-		       ALLOCATION_MAX - ALLOCATION_STEP * allocation,
-		       MAX_DIFF);
+		printf("%sok MBA: diff within %d%% for schemata %u\n",
+		       avg_diff_per > MAX_DIFF_PERCENT ? "not " : "",
+		       MAX_DIFF_PERCENT,
+		       ALLOCATION_MAX - ALLOCATION_STEP * allocation);
 		tests_run++;
-		printf("# avg_diff: %lu\n", avg_diff);
+		printf("# avg_diff_per: %d%%\n", avg_diff_per);
 		printf("# avg_bw_imc: %lu\n", avg_bw_imc);
 		printf("# avg_bw_resc: %lu\n", avg_bw_resc);
-		if (avg_diff > MAX_DIFF)
+		if (avg_diff_per > MAX_DIFF_PERCENT)
 			failed = true;
 	}
 
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 4700f7453f81..ca610c3ebc8c 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -11,7 +11,7 @@
 #include "resctrl.h"
 
 #define RESULT_FILE_NAME	"result_mbm"
-#define MAX_DIFF		300
+#define MAX_DIFF_PERCENT	5
 #define NUM_OF_RUNS		5
 
 static void
@@ -19,8 +19,8 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, int span)
 {
 	unsigned long avg_bw_imc = 0, avg_bw_resc = 0;
 	unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
-	long avg_diff = 0;
-	int runs;
+	int runs, avg_diff_per;
+	float avg_diff = 0;
 
 	/*
 	 * Discard the first value which is inaccurate due to monitoring setup
@@ -33,12 +33,13 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, int span)
 
 	avg_bw_imc = sum_bw_imc / 4;
 	avg_bw_resc = sum_bw_resc / 4;
-	avg_diff = avg_bw_resc - avg_bw_imc;
+	avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
+	avg_diff_per = (int)(avg_diff * 100);
 
 	printf("%sok MBM: diff within %d%%\n",
-	       labs(avg_diff) > MAX_DIFF ? "not " : "", MAX_DIFF);
+	       avg_diff_per > MAX_DIFF_PERCENT ? "not " : "", MAX_DIFF_PERCENT);
 	tests_run++;
-	printf("# avg_diff: %lu\n", labs(avg_diff));
+	printf("# avg_diff_per: %d%%\n", avg_diff_per);
 	printf("# Span (MB): %d\n", span);
 	printf("# avg_bw_imc: %lu\n", avg_bw_imc);
 	printf("# avg_bw_resc: %lu\n", avg_bw_resc);
-- 
2.29.0

