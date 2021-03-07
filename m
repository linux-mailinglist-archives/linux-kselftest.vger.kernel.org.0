Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD2E330239
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Mar 2021 15:56:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbhCGOz2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Mar 2021 09:55:28 -0500
Received: from mga17.intel.com ([192.55.52.151]:5871 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231579AbhCGOzK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Mar 2021 09:55:10 -0500
IronPort-SDR: yrVAMhhzOqHjPQRHgH4NX2kpMkMLSzCHvOyjQh08XqRojCn9yfKQuJVayuOpEdqz2sechtWiiS
 JNsUp9zOIOeQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="167813495"
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="167813495"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 06:55:09 -0800
IronPort-SDR: ILStporg5Jq4m3wSY6Pa6QDh02Mhz7VpKSXG63RiiJDdOfIjMSCXdHRK6WwjarInoM/aVBLetC
 xIqTd4N4+Grw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="437189109"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Mar 2021 06:55:09 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Babu Moger" <babu.moger@amd.com>
Cc:     "linux-kselftest" <linux-kselftest@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v5 08/21] selftests/resctrl: Call kselftest APIs to log test results
Date:   Sun,  7 Mar 2021 14:54:49 +0000
Message-Id: <20210307145502.2916364-9-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210307145502.2916364-1-fenghua.yu@intel.com>
References: <20210307145502.2916364-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Call kselftest APIs instead of using printf() to log test results
for cleaner code and better future extension.

Suggested-by: Shuah Khan <shuah@kernel.org>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
Change Log:
v5:
- Add this patch (Shuah)

 tools/testing/selftests/resctrl/cat_test.c    | 37 +++++++--------
 tools/testing/selftests/resctrl/cmt_test.c    | 42 ++++++++---------
 tools/testing/selftests/resctrl/mba_test.c    | 24 +++++-----
 tools/testing/selftests/resctrl/mbm_test.c    | 28 ++++++------
 tools/testing/selftests/resctrl/resctrl.h     |  2 +-
 .../testing/selftests/resctrl/resctrl_tests.c | 40 +++++++++--------
 tools/testing/selftests/resctrl/resctrl_val.c |  4 +-
 tools/testing/selftests/resctrl/resctrlfs.c   | 45 +++++++------------
 8 files changed, 105 insertions(+), 117 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 20823725daca..0deb38ed971b 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -52,25 +52,28 @@ static int cat_setup(int num, ...)
 	return ret;
 }
 
-static void show_cache_info(unsigned long sum_llc_perf_miss, int no_of_bits,
-			    unsigned long span)
+static int show_cache_info(unsigned long sum_llc_perf_miss, int no_of_bits,
+			   unsigned long span)
 {
 	unsigned long allocated_cache_lines = span / 64;
 	unsigned long avg_llc_perf_miss = 0;
 	float diff_percent;
+	int ret;
 
 	avg_llc_perf_miss = sum_llc_perf_miss / (NUM_OF_RUNS - 1);
 	diff_percent = ((float)allocated_cache_lines - avg_llc_perf_miss) /
 				allocated_cache_lines * 100;
 
-	printf("%sok CAT: cache miss rate within %d%%\n",
-	       !is_amd && abs((int)diff_percent) > MAX_DIFF_PERCENT ?
-	       "not " : "", MAX_DIFF_PERCENT);
-	tests_run++;
-	printf("# Percent diff=%d\n", abs((int)diff_percent));
-	printf("# Number of bits: %d\n", no_of_bits);
-	printf("# Avg_llc_perf_miss: %lu\n", avg_llc_perf_miss);
-	printf("# Allocated cache lines: %lu\n", allocated_cache_lines);
+	ret = !is_amd && abs((int)diff_percent) > MAX_DIFF_PERCENT;
+	ksft_print_msg("cache miss rate %swithin %d%%\n",
+		       ret ? "not " : "", MAX_DIFF_PERCENT);
+
+	ksft_print_msg("Percent diff=%d\n", abs((int)diff_percent));
+	ksft_print_msg("Number of bits: %d\n", no_of_bits);
+	ksft_print_msg("Avg_llc_perf_miss: %lu\n", avg_llc_perf_miss);
+	ksft_print_msg("Allocated cache lines: %lu\n", allocated_cache_lines);
+
+	return ret;
 }
 
 static int check_results(struct resctrl_val_param *param)
@@ -80,7 +83,7 @@ static int check_results(struct resctrl_val_param *param)
 	int runs = 0, no_of_bits = 0;
 	FILE *fp;
 
-	printf("# Checking for pass/fail\n");
+	ksft_print_msg("Checking for pass/fail\n");
 	fp = fopen(param->filename, "r");
 	if (!fp) {
 		perror("# Cannot open file");
@@ -108,9 +111,7 @@ static int check_results(struct resctrl_val_param *param)
 	fclose(fp);
 	no_of_bits = count_bits(param->mask);
 
-	show_cache_info(sum_llc_perf_miss, no_of_bits, param->span);
-
-	return 0;
+	return show_cache_info(sum_llc_perf_miss, no_of_bits, param->span);
 }
 
 void cat_test_cleanup(void)
@@ -146,15 +147,15 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	ret = get_cache_size(cpu_no, cache_type, &cache_size);
 	if (ret)
 		return ret;
-	printf("cache size :%lu\n", cache_size);
+	ksft_print_msg("cache size :%lu\n", cache_size);
 
 	/* Get max number of bits from default-cabm mask */
 	count_of_bits = count_bits(long_mask);
 
 	if (n < 1 || n > count_of_bits - 1) {
-		printf("Invalid input value for no_of_bits n!\n");
-		printf("Please Enter value in range 1 to %d\n",
-		       count_of_bits - 1);
+		ksft_print_msg("Invalid input value for no_of_bits n!\n");
+		ksft_print_msg("Please Enter value in range 1 to %d\n",
+			       count_of_bits - 1);
 		return -1;
 	}
 
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index ca82db37c1f7..e5af19335115 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -39,36 +39,33 @@ static int cmt_setup(int num, ...)
 	return 0;
 }
 
-static void show_cache_info(unsigned long sum_llc_occu_resc, int no_of_bits,
-			    unsigned long span)
+static int show_cache_info(unsigned long sum_llc_occu_resc, int no_of_bits,
+			   unsigned long span)
 {
 	unsigned long avg_llc_occu_resc = 0;
 	float diff_percent;
 	long avg_diff = 0;
-	bool res;
+	int ret;
 
 	avg_llc_occu_resc = sum_llc_occu_resc / (NUM_OF_RUNS - 1);
 	avg_diff = (long)abs(span - avg_llc_occu_resc);
 
 	diff_percent = (((float)span - avg_llc_occu_resc) / span) * 100;
 
-	if ((abs((int)diff_percent) <= MAX_DIFF_PERCENT) ||
-	    (abs(avg_diff) <= MAX_DIFF))
-		res = true;
-	else
-		res = false;
+	ret = (abs((int)diff_percent) > MAX_DIFF_PERCENT) &&
+	      (abs(avg_diff) > MAX_DIFF);
 
-	printf("%sok CMT: diff within %d, %d\%%\n", res ? "" : "not",
-	       MAX_DIFF, (int)MAX_DIFF_PERCENT);
+	ksft_print_msg("%scache miss diff within %d, %d\%%\n",
+		       ret ? "fail: " : "not", MAX_DIFF, (int)MAX_DIFF_PERCENT);
 
-	printf("# diff: %ld\n", avg_diff);
-	printf("# percent diff=%d\n", abs((int)diff_percent));
-	printf("# Results are displayed in (Bytes)\n");
-	printf("# Number of bits: %d\n", no_of_bits);
-	printf("# Avg_llc_occu_resc: %lu\n", avg_llc_occu_resc);
-	printf("# llc_occu_exp (span): %lu\n", span);
+	ksft_print_msg("diff: %ld\n", avg_diff);
+	ksft_print_msg("percent diff=%d\n", abs((int)diff_percent));
+	ksft_print_msg("Results are displayed in (Bytes)\n");
+	ksft_print_msg("Number of bits: %d\n", no_of_bits);
+	ksft_print_msg("Avg_llc_occu_resc: %lu\n", avg_llc_occu_resc);
+	ksft_print_msg("llc_occu_exp (span): %lu\n", span);
 
-	tests_run++;
+	return ret;
 }
 
 static int check_results(struct resctrl_val_param *param, int no_of_bits)
@@ -78,7 +75,7 @@ static int check_results(struct resctrl_val_param *param, int no_of_bits)
 	int runs = 0;
 	FILE *fp;
 
-	printf("# checking for pass/fail\n");
+	ksft_print_msg("checking for pass/fail\n");
 	fp = fopen(param->filename, "r");
 	if (!fp) {
 		perror("# Error in opening file\n");
@@ -101,9 +98,8 @@ static int check_results(struct resctrl_val_param *param, int no_of_bits)
 		runs++;
 	}
 	fclose(fp);
-	show_cache_info(sum_llc_occu_resc, no_of_bits, param->span);
 
-	return 0;
+	return show_cache_info(sum_llc_occu_resc, no_of_bits, param->span);
 }
 
 void cmt_test_cleanup(void)
@@ -134,13 +130,13 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 	ret = get_cache_size(cpu_no, "L3", &cache_size);
 	if (ret)
 		return ret;
-	printf("cache size :%lu\n", cache_size);
+	ksft_print_msg("cache size :%lu\n", cache_size);
 
 	count_of_bits = count_bits(long_mask);
 
 	if (n < 1 || n > count_of_bits) {
-		printf("Invalid input value for numbr_of_bits n!\n");
-		printf("Please Enter value in range 1 to %d\n", count_of_bits);
+		ksft_print_msg("Invalid input value for numbr_of_bits n!\n");
+		ksft_print_msg("Please Enter value in range 1 to %d\n", count_of_bits);
 		return -1;
 	}
 
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 6449fbd96096..3a226effe80c 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -56,7 +56,7 @@ static void show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 	int allocation, runs;
 	bool failed = false;
 
-	printf("# Results are displayed in (MB)\n");
+	ksft_print_msg("Results are displayed in (MB)\n");
 	/* Memory bandwidth from 100% down to 10% */
 	for (allocation = 0; allocation < ALLOCATION_MAX / ALLOCATION_STEP;
 	     allocation++) {
@@ -78,21 +78,21 @@ static void show_mba_info(unsigned long *bw_imc, unsigned long *bw_resc)
 		avg_bw_resc = sum_bw_resc / (NUM_OF_RUNS - 1);
 		avg_diff = labs((long)(avg_bw_resc - avg_bw_imc));
 
-		printf("%sok MBA schemata percentage %u smaller than %d %%\n",
-		       avg_diff > MAX_DIFF ? "not " : "",
-		       ALLOCATION_MAX - ALLOCATION_STEP * allocation,
-		       MAX_DIFF);
-		tests_run++;
-		printf("# avg_diff: %lu\n", avg_diff);
-		printf("# avg_bw_imc: %lu\n", avg_bw_imc);
-		printf("# avg_bw_resc: %lu\n", avg_bw_resc);
+		ksft_print_msg("%s MBA schemata percentage %u smaller than %d %%\n",
+			       avg_diff > MAX_DIFF ? "fail:" : "pass:",
+			       ALLOCATION_MAX - ALLOCATION_STEP * allocation,
+			       MAX_DIFF);
+		ksft_print_msg("avg_diff: %lu\n", avg_diff);
+		ksft_print_msg("avg_bw_imc: %lu\n", avg_bw_imc);
+		ksft_print_msg("avg_bw_resc: %lu\n", avg_bw_resc);
 		if (avg_diff > MAX_DIFF)
 			failed = true;
 	}
 
-	printf("%sok schemata change using MBA%s\n", failed ? "not " : "",
-	       failed ? " # at least one test failed" : "");
-	tests_run++;
+	ksft_print_msg("%s schemata change using MBA\n",
+		       failed ? "fail:" : "pass:");
+	if (failed)
+		ksft_print_msg("at least one test failed");
 }
 
 static int check_results(void)
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index ec6cfe01c9c2..2b4f26013d84 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -14,13 +14,13 @@
 #define MAX_DIFF		300
 #define NUM_OF_RUNS		5
 
-static void
+static int
 show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, int span)
 {
 	unsigned long avg_bw_imc = 0, avg_bw_resc = 0;
 	unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
 	long avg_diff = 0;
-	int runs;
+	int runs, ret;
 
 	/*
 	 * Discard the first value which is inaccurate due to monitoring setup
@@ -35,13 +35,15 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, int span)
 	avg_bw_resc = sum_bw_resc / 4;
 	avg_diff = avg_bw_resc - avg_bw_imc;
 
-	printf("%sok MBM: diff within %d%%\n",
-	       labs(avg_diff) > MAX_DIFF ? "not " : "", MAX_DIFF);
-	tests_run++;
-	printf("# avg_diff: %lu\n", labs(avg_diff));
-	printf("# Span (MB): %d\n", span);
-	printf("# avg_bw_imc: %lu\n", avg_bw_imc);
-	printf("# avg_bw_resc: %lu\n", avg_bw_resc);
+	ret = labs(avg_diff) > MAX_DIFF;
+	ksft_print_msg("%s MBM: diff within %d%%\n",
+		       ret ? "fail:" : "pass:", MAX_DIFF);
+	ksft_print_msg("avg_diff: %lu\n", labs(avg_diff));
+	ksft_print_msg("Span (MB): %d\n", span);
+	ksft_print_msg("avg_bw_imc: %lu\n", avg_bw_imc);
+	ksft_print_msg("avg_bw_resc: %lu\n", avg_bw_resc);
+
+	return ret;
 }
 
 static int check_results(int span)
@@ -49,10 +51,10 @@ static int check_results(int span)
 	unsigned long bw_imc[NUM_OF_RUNS], bw_resc[NUM_OF_RUNS];
 	char temp[1024], *token_array[8];
 	char output[] = RESULT_FILE_NAME;
-	int runs;
+	int runs, ret;
 	FILE *fp;
 
-	printf("# Checking for pass/fail\n");
+	ksft_print_msg("Checking for pass/fail\n");
 
 	fp = fopen(output, "r");
 	if (!fp) {
@@ -76,11 +78,11 @@ static int check_results(int span)
 		runs++;
 	}
 
-	show_bw_info(bw_imc, bw_resc, span);
+	ret = show_bw_info(bw_imc, bw_resc, span);
 
 	fclose(fp);
 
-	return 0;
+	return ret;
 }
 
 static int mbm_setup(int num, ...)
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 1a58767a0bd2..ebf88217f9de 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -23,6 +23,7 @@
 #include <sys/eventfd.h>
 #include <asm/unistd.h>
 #include <linux/perf_event.h>
+#include "../kselftest.h"
 
 #define MB			(1024 * 1024)
 #define RESCTRL_PATH		"/sys/fs/resctrl"
@@ -68,7 +69,6 @@ struct resctrl_val_param {
 #define CAT_STR			"cat"
 
 extern pid_t bm_pid, ppid;
-extern int tests_run;
 
 extern char llc_occup_path[1024];
 extern bool is_amd;
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 01f7aed7f54e..ebc24992cc2c 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -60,7 +60,7 @@ int main(int argc, char **argv)
 	int res, c, cpu_no = 1, span = 250, argc_new = argc, i, no_of_bits = 5;
 	char *benchmark_cmd[BENCHMARK_ARGS], bw_report[64], bm_type[64];
 	char benchmark_cmd_area[BENCHMARK_ARGS][BENCHMARK_ARG_SIZE];
-	int ben_ind, ben_count;
+	int ben_ind, ben_count, tests = 0;
 	bool cat_test = true;
 
 	for (i = 0; i < argc; i++) {
@@ -87,12 +87,16 @@ int main(int argc, char **argv)
 			while (token) {
 				if (!strncmp(token, MBM_STR, sizeof(MBM_STR))) {
 					mbm_test = true;
+					tests++;
 				} else if (!strncmp(token, MBA_STR, sizeof(MBA_STR))) {
 					mba_test = true;
+					tests++;
 				} else if (!strncmp(token, CMT_STR, sizeof(CMT_STR))) {
 					cmt_test = true;
+					tests++;
 				} else if (!strncmp(token, CAT_STR, sizeof(CAT_STR))) {
 					cat_test = true;
+					tests++;
 				} else {
 					printf("invalid argument\n");
 
@@ -118,7 +122,7 @@ int main(int argc, char **argv)
 		}
 	}
 
-	printf("TAP version 13\n");
+	ksft_print_header();
 
 	/*
 	 * Typically we need root privileges, because:
@@ -126,7 +130,7 @@ int main(int argc, char **argv)
 	 * 2. We execute perf commands
 	 */
 	if (geteuid() != 0)
-		printf("# WARNING: not running as root, tests may fail.\n");
+		return ksft_exit_fail_msg("not running as root, abort testing.\n");
 
 	/* Detect AMD vendor */
 	detect_amd();
@@ -155,48 +159,46 @@ int main(int argc, char **argv)
 	sprintf(bw_report, "reads");
 	sprintf(bm_type, "fill_buf");
 
-	check_resctrlfs_support();
+	if (!check_resctrlfs_support())
+		return ksft_exit_fail_msg("resctrl FS does not exist\n");
+
 	filter_dmesg();
 
+	ksft_set_plan(tests ? : 4);
+
 	if (!is_amd && mbm_test) {
-		printf("# Starting MBM BW change ...\n");
+		ksft_print_msg("Starting MBM BW change ...\n");
 		if (!has_ben)
 			sprintf(benchmark_cmd[5], "%s", MBA_STR);
 		res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
-		printf("%sok MBM: bw change\n", res ? "not " : "");
+		ksft_test_result(!res, "MBM: bw change\n");
 		mbm_test_cleanup();
-		tests_run++;
 	}
 
 	if (!is_amd && mba_test) {
-		printf("# Starting MBA Schemata change ...\n");
+		ksft_print_msg("Starting MBA Schemata change ...\n");
 		if (!has_ben)
 			sprintf(benchmark_cmd[1], "%d", span);
 		res = mba_schemata_change(cpu_no, bw_report, benchmark_cmd);
-		printf("%sok MBA: schemata change\n", res ? "not " : "");
+		ksft_test_result(!res, "MBA: schemata change\n");
 		mba_test_cleanup();
-		tests_run++;
 	}
 
 	if (cmt_test) {
-		printf("# Starting CMT test ...\n");
+		ksft_print_msg("Starting CMT test ...\n");
 		if (!has_ben)
 			sprintf(benchmark_cmd[5], "%s", "cmt");
 		res = cmt_resctrl_val(cpu_no, no_of_bits, benchmark_cmd);
-		printf("%sok CMT: test\n", res ? "not " : "");
+		ksft_test_result(!res, "CMT: test\n");
 		cmt_test_cleanup();
-		tests_run++;
 	}
 
 	if (cat_test) {
-		printf("# Starting CAT test ...\n");
+		ksft_print_msg("Starting CAT test ...\n");
 		res = cat_perf_miss_val(cpu_no, no_of_bits, "L3");
-		printf("%sok CAT: test\n", res ? "not " : "");
-		tests_run++;
+		ksft_test_result(!res, "CAT: test\n");
 		cat_test_cleanup();
 	}
 
-	printf("1..%d\n", tests_run);
-
-	return 0;
+	return ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 17770095c98e..48bcd5fd7d79 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -449,7 +449,7 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr)
 	kill(bm_pid, SIGKILL);
 	umount_resctrlfs();
 	tests_cleanup();
-	printf("Ending\n\n");
+	ksft_print_msg("Ending\n\n");
 
 	exit(EXIT_SUCCESS);
 }
@@ -645,7 +645,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 		PARENT_EXIT("Child is done");
 	}
 
-	printf("# benchmark PID: %d\n", bm_pid);
+	ksft_print_msg("benchmark PID: %d\n", bm_pid);
 
 	/*
 	 * Register CTRL-C handler for parent, as it has to kill benchmark
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index b47f4f150189..e3d18e113313 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -10,8 +10,6 @@
  */
 #include "resctrl.h"
 
-int tests_run;
-
 static int find_resctrl_mount(char *buffer)
 {
 	FILE *mounts;
@@ -68,23 +66,17 @@ int remount_resctrlfs(bool mum_resctrlfs)
 	if (ret)
 		strcpy(mountpoint, RESCTRL_PATH);
 
-	if (!ret && mum_resctrlfs && umount(mountpoint)) {
-		printf("not ok unmounting \"%s\"\n", mountpoint);
-		perror("# umount");
-		tests_run++;
-	}
+	if (!ret && mum_resctrlfs && umount(mountpoint))
+		ksft_print_msg("fail: unmounting \"%s\"\n", mountpoint);
 
 	if (!ret && !mum_resctrlfs)
 		return 0;
 
+	ksft_print_msg("mounting resctrl to \"%s\"\n", RESCTRL_PATH);
 	ret = mount("resctrl", RESCTRL_PATH, "resctrl", 0, NULL);
-	printf("%sok mounting resctrl to \"%s\"\n", ret ? "not " : "",
-	       RESCTRL_PATH);
 	if (ret)
 		perror("# mount");
 
-	tests_run++;
-
 	return ret;
 }
 
@@ -477,13 +469,10 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
 	}
 
 out:
-	printf("%sok writing benchmark parameters to resctrl FS\n",
-	       ret ? "not " : "");
+	ksft_print_msg("writing benchmark parameters to resctrl FS\n");
 	if (ret)
 		perror("# writing to resctrlfs");
 
-	tests_run++;
-
 	return ret;
 }
 
@@ -511,7 +500,7 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
 		return -ENOENT;
 
 	if (!schemata) {
-		printf("# Skipping empty schemata update\n");
+		ksft_print_msg("Skipping empty schemata update\n");
 
 		return -1;
 	}
@@ -552,10 +541,9 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
 	fclose(fp);
 
 out:
-	printf("%sok Write schema \"%s\" to resctrl FS%s%s\n",
-	       ret ? "not " : "", schema, ret ? " # " : "",
-	       ret ? reason : "");
-	tests_run++;
+	ksft_print_msg("Write schema \"%s\" to resctrl FS%s%s\n",
+		       schema, ret ? " # " : "",
+		       ret ? reason : "");
 
 	return ret;
 }
@@ -579,18 +567,17 @@ bool check_resctrlfs_support(void)
 
 	fclose(inf);
 
-	printf("%sok kernel supports resctrl filesystem\n", ret ? "" : "not ");
-	tests_run++;
+	ksft_print_msg("%s kernel supports resctrl filesystem\n",
+		       ret ? "pass:" : "fail:");
 
 	dp = opendir(RESCTRL_PATH);
-	printf("%sok resctrl mountpoint \"%s\" exists\n",
-	       dp ? "" : "not ", RESCTRL_PATH);
+	ksft_print_msg("%s resctrl mountpoint \"%s\" exists\n",
+		       dp ? "pass:" : "fail:", RESCTRL_PATH);
 	if (dp)
 		closedir(dp);
-	tests_run++;
 
-	printf("# resctrl filesystem %s mounted\n",
-	       find_resctrl_mount(NULL) ? "not" : "is");
+	ksft_print_msg("resctrl filesystem %s mounted\n",
+		       find_resctrl_mount(NULL) ? "not" : "is");
 
 	return ret;
 }
@@ -672,9 +659,9 @@ int filter_dmesg(void)
 
 	while (fgets(line, 1024, fp)) {
 		if (strstr(line, "intel_rdt:"))
-			printf("# dmesg: %s", line);
+			ksft_print_msg("dmesg: %s", line);
 		if (strstr(line, "resctrl:"))
-			printf("# dmesg: %s", line);
+			ksft_print_msg("dmesg: %s", line);
 	}
 	fclose(fp);
 	waitpid(pid, NULL, 0);
-- 
2.30.1

