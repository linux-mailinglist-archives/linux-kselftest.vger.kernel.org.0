Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDDAE33E6D4
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Mar 2021 03:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230465AbhCQCZB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Mar 2021 22:25:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:55652 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230439AbhCQCYf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Mar 2021 22:24:35 -0400
IronPort-SDR: ZzS9lN2RWAMm/KMQUdN39VRkM6jgeL5W47t+FhyEhWfUtQMRlQ4v2Avs5Om9o0Pqywl2lPIaLR
 CMmDb/m33fvA==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="209328712"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="209328712"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 19:24:34 -0700
IronPort-SDR: HKLrFYooo+vr1YVgo3+9fBuRwSjSsyj90H0eudXkcOKXIV1uOGVyYU8E8EG+F3+PupyA3gyece
 v0+EYk3IMUNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="440290263"
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
Subject: [PATCH v6 09/21] selftests/resctrl: Share show_cache_info() by CAT and CMT tests
Date:   Wed, 17 Mar 2021 02:22:43 +0000
Message-Id: <20210317022255.2536745-10-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210317022255.2536745-1-fenghua.yu@intel.com>
References: <20210317022255.2536745-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

show_cache_info() functions are defined separately in CAT and CMT
tests. But the functions are same for the tests and unnecessary
to be defined separately. Share the function by the tests.

Suggested-by: Shuah Khan <shuah@kernel.org>
Tested-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
Change Log:
v5:
- Add this patch (Shuah)

 tools/testing/selftests/resctrl/cache.c    | 42 ++++++++++++++++++++++
 tools/testing/selftests/resctrl/cat_test.c | 28 ++-------------
 tools/testing/selftests/resctrl/cmt_test.c | 33 ++---------------
 tools/testing/selftests/resctrl/resctrl.h  |  4 +++
 4 files changed, 52 insertions(+), 55 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 2aa1b5c7d9e1..362e3a418caa 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -270,3 +270,45 @@ int cat_val(struct resctrl_val_param *param)
 
 	return ret;
 }
+
+/*
+ * show_cache_info:	show cache test result information
+ * @sum_llc_val:	sum of LLC cache result data
+ * @no_of_bits:		number of bits
+ * @cache_span:		cache span in bytes for CMT or in lines for CAT
+ * @max_diff:		max difference
+ * @max_diff_percent:	max difference percentage
+ * @num_of_runs:	number of runs
+ * @platform:		show test information on this platform
+ * @cmt:		CMT test or CAT test
+ *
+ * Return:		0 on success. non-zero on failure.
+ */
+int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
+		    unsigned long cache_span, unsigned long max_diff,
+		    unsigned long max_diff_percent, unsigned long num_of_runs,
+		    bool platform, bool cmt)
+{
+	unsigned long avg_llc_val = 0;
+	float diff_percent;
+	long avg_diff = 0;
+	int ret;
+
+	avg_llc_val = sum_llc_val / (num_of_runs - 1);
+	avg_diff = (long)abs(cache_span - avg_llc_val);
+	diff_percent = ((float)cache_span - avg_llc_val) / cache_span * 100;
+
+	ret = platform && abs((int)diff_percent) > max_diff_percent &&
+	      (cmt ? (abs(avg_diff) > max_diff) : true);
+
+	ksft_print_msg("%s cache miss rate within %d%%\n",
+		       ret ? "Fail:" : "Pass:", max_diff_percent);
+
+	ksft_print_msg("Percent diff=%d\n", abs((int)diff_percent));
+	ksft_print_msg("Number of bits: %d\n", no_of_bits);
+	ksft_print_msg("Average LLC val: %lu\n", avg_llc_val);
+	ksft_print_msg("Cache span (%s): %lu\n", cmt ? "bytes" : "lines",
+		       cache_span);
+
+	return ret;
+}
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 1daf911076c7..090d3afc7a78 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -52,30 +52,6 @@ static int cat_setup(int num, ...)
 	return ret;
 }
 
-static int show_cache_info(unsigned long sum_llc_perf_miss, int no_of_bits,
-			   unsigned long span)
-{
-	unsigned long allocated_cache_lines = span / 64;
-	unsigned long avg_llc_perf_miss = 0;
-	float diff_percent;
-	int ret;
-
-	avg_llc_perf_miss = sum_llc_perf_miss / (NUM_OF_RUNS - 1);
-	diff_percent = ((float)allocated_cache_lines - avg_llc_perf_miss) /
-				allocated_cache_lines * 100;
-
-	ret = !is_amd && abs((int)diff_percent) > MAX_DIFF_PERCENT;
-	ksft_print_msg("Cache miss rate %swithin %d%%\n",
-		       ret ? "not " : "", MAX_DIFF_PERCENT);
-
-	ksft_print_msg("Percent diff=%d\n", abs((int)diff_percent));
-	ksft_print_msg("Number of bits: %d\n", no_of_bits);
-	ksft_print_msg("Avg_llc_perf_miss: %lu\n", avg_llc_perf_miss);
-	ksft_print_msg("Allocated cache lines: %lu\n", allocated_cache_lines);
-
-	return ret;
-}
-
 static int check_results(struct resctrl_val_param *param)
 {
 	char *token_array[8], temp[512];
@@ -111,7 +87,9 @@ static int check_results(struct resctrl_val_param *param)
 	fclose(fp);
 	no_of_bits = count_bits(param->mask);
 
-	return show_cache_info(sum_llc_perf_miss, no_of_bits, param->span);
+	return show_cache_info(sum_llc_perf_miss, no_of_bits, param->span / 64,
+			       MAX_DIFF, MAX_DIFF_PERCENT, NUM_OF_RUNS,
+			       !is_amd, false);
 }
 
 void cat_test_cleanup(void)
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index b1ab1bd1f74d..8968e36db99d 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -39,35 +39,6 @@ static int cmt_setup(int num, ...)
 	return 0;
 }
 
-static int show_cache_info(unsigned long sum_llc_occu_resc, int no_of_bits,
-			   unsigned long span)
-{
-	unsigned long avg_llc_occu_resc = 0;
-	float diff_percent;
-	long avg_diff = 0;
-	int ret;
-
-	avg_llc_occu_resc = sum_llc_occu_resc / (NUM_OF_RUNS - 1);
-	avg_diff = (long)abs(span - avg_llc_occu_resc);
-
-	diff_percent = (((float)span - avg_llc_occu_resc) / span) * 100;
-
-	ret = (abs((int)diff_percent) > MAX_DIFF_PERCENT) &&
-	      (abs(avg_diff) > MAX_DIFF);
-
-	ksft_print_msg("%s cache miss diff within %d, %d\%%\n",
-		       ret ? "Fail:" : "Pass:", MAX_DIFF, (int)MAX_DIFF_PERCENT);
-
-	ksft_print_msg("Diff: %ld\n", avg_diff);
-	ksft_print_msg("Percent diff=%d\n", abs((int)diff_percent));
-	ksft_print_msg("Results are displayed in (Bytes)\n");
-	ksft_print_msg("Number of bits: %d\n", no_of_bits);
-	ksft_print_msg("Avg_llc_occu_resc: %lu\n", avg_llc_occu_resc);
-	ksft_print_msg("llc_occu_exp (span): %lu\n", span);
-
-	return ret;
-}
-
 static int check_results(struct resctrl_val_param *param, int no_of_bits)
 {
 	char *token_array[8], temp[512];
@@ -99,7 +70,9 @@ static int check_results(struct resctrl_val_param *param, int no_of_bits)
 	}
 	fclose(fp);
 
-	return show_cache_info(sum_llc_occu_resc, no_of_bits, param->span);
+	return show_cache_info(sum_llc_occu_resc, no_of_bits, param->span,
+			       MAX_DIFF, MAX_DIFF_PERCENT, NUM_OF_RUNS,
+			       true, true);
 }
 
 void cmt_test_cleanup(void)
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index ebf88217f9de..81f322245ef7 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -108,5 +108,9 @@ unsigned int count_bits(unsigned long n);
 void cmt_test_cleanup(void);
 int get_core_sibling(int cpu_no);
 int measure_cache_vals(struct resctrl_val_param *param, int bm_pid);
+int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
+		    unsigned long cache_span, unsigned long max_diff,
+		    unsigned long max_diff_percent, unsigned long num_of_runs,
+		    bool platform, bool cmt);
 
 #endif /* RESCTRL_H */
-- 
2.31.0

