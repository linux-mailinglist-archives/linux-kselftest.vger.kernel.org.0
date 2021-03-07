Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1215B33023A
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Mar 2021 15:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhCGOz2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Mar 2021 09:55:28 -0500
Received: from mga17.intel.com ([192.55.52.151]:5870 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231575AbhCGOzK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Mar 2021 09:55:10 -0500
IronPort-SDR: yoxlaCapk8V2jLAR65P1L9nKoz4wu8EmjylL6ryUKdkcu7TtREQW/tAuMWAVH02GB0vUwX2A6C
 fTMSlq8V9dkA==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="167813496"
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="167813496"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 06:55:10 -0800
IronPort-SDR: Ycj+eQ3GUTbhcqh+RwRCXhueILXRZv7OPqCFkIOLLMkHX8HwyzM7WMbt8j85bzlBLSPMLZABYV
 j/vtw3hw1G+A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="437189112"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Mar 2021 06:55:09 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Babu Moger" <babu.moger@amd.com>
Cc:     "linux-kselftest" <linux-kselftest@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v5 09/21] selftests/resctrl: Share show_cache_info() by CAT and CMT tests
Date:   Sun,  7 Mar 2021 14:54:50 +0000
Message-Id: <20210307145502.2916364-10-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210307145502.2916364-1-fenghua.yu@intel.com>
References: <20210307145502.2916364-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

show_cache_info() functions are defined separately in CAT and CMT
tests. But the functions are same for the tests and unnecessary
to be defined separately. Share the function by the tests.

Suggested-by: Shuah Khan <shuah@kernel.org>
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
index 2aa1b5c7d9e1..eaf5116b112c 100644
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
+	ksft_print_msg("%scache miss rate within %d%%\n",
+		       ret ? "fail: " : "", max_diff_percent);
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
index 0deb38ed971b..109363e9a7d7 100644
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
-	ksft_print_msg("cache miss rate %swithin %d%%\n",
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
index e5af19335115..4adb92cb6ca1 100644
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
-	ksft_print_msg("%scache miss diff within %d, %d\%%\n",
-		       ret ? "fail: " : "not", MAX_DIFF, (int)MAX_DIFF_PERCENT);
-
-	ksft_print_msg("diff: %ld\n", avg_diff);
-	ksft_print_msg("percent diff=%d\n", abs((int)diff_percent));
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
2.30.1

