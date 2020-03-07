Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C8E917CBA6
	for <lists+linux-kselftest@lfdr.de>; Sat,  7 Mar 2020 04:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgCGDqR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 6 Mar 2020 22:46:17 -0500
Received: from mga11.intel.com ([192.55.52.93]:57583 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727052AbgCGDqR (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 6 Mar 2020 22:46:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Mar 2020 19:46:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,524,1574150400"; 
   d="scan'208";a="235036014"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by fmsmga008.fm.intel.com with ESMTP; 06 Mar 2020 19:46:16 -0800
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     shuah@kernel.org, linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, reinette.chatre@intel.com, babu.moger@amd.com,
        james.morse@arm.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH V1 06/13] selftests/resctrl: Fix MBA/MBM results reporting format
Date:   Fri,  6 Mar 2020 19:40:47 -0800
Message-Id: <8179b975778fb1d365f3b5d88b69976332a2f061.1583657204.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1583657204.git.sai.praneeth.prakhya@intel.com>
References: <cover.1583657204.git.sai.praneeth.prakhya@intel.com>
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

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
---
 tools/testing/selftests/resctrl/mba_test.c | 24 +++++++++++++-----------
 tools/testing/selftests/resctrl/mbm_test.c | 21 +++++++++++----------
 2 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 7bf8eaa6204b..165e5123e040 100644
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
@@ -62,31 +62,33 @@ static void show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 	     allocation++) {
 		unsigned long avg_bw_imc, avg_bw_resc;
 		unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
-		unsigned long avg_diff;
+		float avg_diff;
+		int avg_diff_per;
 
 		/*
 		 * The first run is discarded due to inaccurate value from
 		 * phase transition.
 		 */
 		for (runs = NUM_OF_RUNS * allocation + 1;
-		     runs < NUM_OF_RUNS * allocation + NUM_OF_RUNS ; runs++) {
+		     runs < NUM_OF_RUNS * allocation + NUM_OF_RUNS; runs++) {
 			sum_bw_imc += bw_imc[runs];
 			sum_bw_resc += bw_resc[runs];
 		}
 
 		avg_bw_imc = sum_bw_imc / (NUM_OF_RUNS - 1);
 		avg_bw_resc = sum_bw_resc / (NUM_OF_RUNS - 1);
-		avg_diff = labs((long)(avg_bw_resc - avg_bw_imc));
+		avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
+		avg_diff_per = (int)(avg_diff * 100);
 
-		printf("%sok MBA schemata percentage %u smaller than %d %%\n",
-		       avg_diff > MAX_DIFF ? "not " : "",
-		       ALLOCATION_MAX - ALLOCATION_STEP * allocation,
-		       MAX_DIFF);
-		tests_run++;
-		printf("# avg_diff: %lu\n", avg_diff);
+		printf("%sok MBA: diff within %d%% for schemata %u\n",
+		       avg_diff_per > MAX_DIFF_PERCENT ? "not " : "",
+		       MAX_DIFF_PERCENT,
+		       ALLOCATION_MAX - ALLOCATION_STEP * allocation);
 		printf("# avg_bw_imc: %lu\n", avg_bw_imc);
 		printf("# avg_bw_resc: %lu\n", avg_bw_resc);
-		if (avg_diff > MAX_DIFF)
+		printf("# avg_diff_per: %d%%\n", avg_diff_per);
+		tests_run++;
+		if (avg_diff_per > MAX_DIFF_PERCENT)
 			failed = true;
 	}
 
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 4700f7453f81..530ec5bec0b9 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -11,7 +11,7 @@
 #include "resctrl.h"
 
 #define RESULT_FILE_NAME	"result_mbm"
-#define MAX_DIFF		300
+#define MAX_DIFF_PERCENT	5
 #define NUM_OF_RUNS		5
 
 static void
@@ -19,29 +19,30 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, int span)
 {
 	unsigned long avg_bw_imc = 0, avg_bw_resc = 0;
 	unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
-	long avg_diff = 0;
-	int runs;
+	float avg_diff = 0;
+	int runs, avg_diff_per;
 
 	/*
 	 * Discard the first value which is inaccurate due to monitoring setup
 	 * transition phase.
 	 */
-	for (runs = 1; runs < NUM_OF_RUNS ; runs++) {
+	for (runs = 1; runs < NUM_OF_RUNS; runs++) {
 		sum_bw_imc += bw_imc[runs];
 		sum_bw_resc += bw_resc[runs];
 	}
 
-	avg_bw_imc = sum_bw_imc / 4;
-	avg_bw_resc = sum_bw_resc / 4;
-	avg_diff = avg_bw_resc - avg_bw_imc;
+	avg_bw_imc = sum_bw_imc / (NUM_OF_RUNS - 1);
+	avg_bw_resc = sum_bw_resc / (NUM_OF_RUNS - 1);
+	avg_diff = (float)labs(avg_bw_resc - avg_bw_imc) / avg_bw_imc;
+	avg_diff_per = (int)(avg_diff * 100);
 
 	printf("%sok MBM: diff within %d%%\n",
-	       labs(avg_diff) > MAX_DIFF ? "not " : "", MAX_DIFF);
-	tests_run++;
-	printf("# avg_diff: %lu\n", labs(avg_diff));
+	       avg_diff_per > MAX_DIFF_PERCENT ? "not " : "", MAX_DIFF_PERCENT);
 	printf("# Span (MB): %d\n", span);
 	printf("# avg_bw_imc: %lu\n", avg_bw_imc);
 	printf("# avg_bw_resc: %lu\n", avg_bw_resc);
+	printf("# avg_diff_per: %d%%\n", avg_diff_per);
+	tests_run++;
 }
 
 static int check_results(int span)
-- 
2.7.4

