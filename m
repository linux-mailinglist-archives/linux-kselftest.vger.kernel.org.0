Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA0733E6E4
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Mar 2021 03:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231167AbhCQCZI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Mar 2021 22:25:08 -0400
Received: from mga01.intel.com ([192.55.52.88]:55652 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230453AbhCQCYf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Mar 2021 22:24:35 -0400
IronPort-SDR: dZP+pVmJBvEGhklYAE466bRjdUuWUwMA2vd6iLRmEMWRESDerFEtkR9ZZ1y/vpHI17MPlO7I1y
 wWKebgRHFuNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="209328717"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="209328717"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 19:24:34 -0700
IronPort-SDR: mnkLHNNRO0JvSm/Tv0YnIuZB1k7++QBdn7Yjp2JIKPhcGvKg1b+VKwFt81DC9eQ30lFnckneEE
 KWi9h1Td4Oww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="440290279"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Mar 2021 19:24:34 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kselftest" <linux-kselftest@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v6 14/21] selftests/resctrl: Fix MBA/MBM results reporting format
Date:   Wed, 17 Mar 2021 02:22:48 +0000
Message-Id: <20210317022255.2536745-15-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210317022255.2536745-1-fenghua.yu@intel.com>
References: <20210317022255.2536745-1-fenghua.yu@intel.com>
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

Tested-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/mba_test.c | 22 +++++++++++++---------
 tools/testing/selftests/resctrl/mbm_test.c | 15 ++++++++-------
 2 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index f42d4ba70363..8842d379e886 100644
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
-			       avg_diff > MAX_DIFF ? "Fail:" : "Pass:",
-			       ALLOCATION_MAX - ALLOCATION_STEP * allocation,
-			       MAX_DIFF);
-		ksft_print_msg("avg_diff: %lu\n", avg_diff);
+		ksft_print_msg("%s MBA: diff within %d%% for schemata %u\n",
+			       avg_diff_per > MAX_DIFF_PERCENT ?
+			       "Fail:" : "Pass:",
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
index 0d65ba4b62b4..651d4ac15986 100644
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
-		       ret ? "Fail:" : "Pass:", MAX_DIFF);
-	ksft_print_msg("avg_diff: %lu\n", labs(avg_diff));
+		       ret ? "Fail:" : "Pass:", MAX_DIFF_PERCENT);
+	ksft_print_msg("avg_diff_per: %d%%\n", avg_diff_per);
 	ksft_print_msg("Span (MB): %d\n", span);
 	ksft_print_msg("avg_bw_imc: %lu\n", avg_bw_imc);
 	ksft_print_msg("avg_bw_resc: %lu\n", avg_bw_resc);
-- 
2.31.0

