Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D47D1D8A7B
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 May 2020 00:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728135AbgERWOA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 May 2020 18:14:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:46546 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgERWN7 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 May 2020 18:13:59 -0400
IronPort-SDR: pYdjsI5hAHPynpKrrBHSxQNctuINghMhEj2G9uWkLSfydJ6lPBlBV9V4VsJtEAx3S1yPGqyrNQ
 3iIC4/kgCNaQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 15:13:59 -0700
IronPort-SDR: ADt+NZ83GvRJRZr8KQ3kozYTz1r+sSJn6cisjgcTA9cqhVkRvDxi03iHrqwQLrwiZtDe+9fHpc
 1OkqtKCJ9owA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="411420373"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by orsmga004.jf.intel.com with ESMTP; 18 May 2020 15:13:58 -0700
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     shuah@kernel.org, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, reinette.chatre@intel.com, babu.moger@amd.com,
        james.morse@arm.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel,
        dan.carpenter@oracle.com, dcb314@hotmail.com,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH V2 10/19] selftests/resctrl: Fix MBA/MBM results reporting format
Date:   Mon, 18 May 2020 15:08:30 -0700
Message-Id: <d952ce65fe90c36ab84b2fd1b6ac401d74efdd5c.1589835155.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
References: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Currently MBM/MBA tests use absolute values to check results. But, iMC
values and MBM resctrl values may vary on different platforms and
specifically for MBA the values may vary as schemata changes. Hence, use
percentage instead of absolute values to check tests result.

Fixes: 01fee6b4d1f9 ("selftests/resctrl: Add MBA test")
Fixes: ecdbb911f22d ("selftests/resctrl: Add MBM test")
Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
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
2.19.1

