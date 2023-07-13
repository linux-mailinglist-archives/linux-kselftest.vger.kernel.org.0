Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30812752371
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 15:21:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234147AbjGMNV1 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 09:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbjGMNVB (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 09:21:01 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26BF72D78;
        Thu, 13 Jul 2023 06:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689254449; x=1720790449;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BcZjX/SIsP1+j3QddjGF0vdJ105WHXlg8OCe+/JJGQ4=;
  b=WDh7NYCJu6l1utBp1ITiw0ITIWyWbgTDhf0y4FqR4vqjgOCMQmuWJb0l
   m734ufadY/bW8jHmJUJ2FG1AUcqRxiWyvhJQ6DKWD6h/Z0z7RAXeEp5va
   2zwd8+SnboXQiWelhdj4eHWeD53HDgG5P0aadQ/8X3pTgRPird6qLgfqx
   P/oMyvtWVqNlvGb6ud3YhcmXx5kxWMZSnw/84gNOh5R/dNjevG5Nlxiqp
   DT/FVDfiX4ooFTwlrtmCdvXm9vwWh0ptuGsTbxQMOmbkJYFp3eoZKeipg
   4R007S9b6Aqhruc1be7MsPUt+4pKDHIrPkpxgMXbRaYP6uHUh+ciQqu2s
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="345496729"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="345496729"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 06:20:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="968615849"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="968615849"
Received: from ijarvine-mobl2.ger.corp.intel.com ([10.251.222.39])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 06:20:46 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 09/19] selftests/resctrl: Convert span to size_t
Date:   Thu, 13 Jul 2023 16:19:22 +0300
Message-Id: <20230713131932.133258-10-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Span is defined either as unsigned long or int.

Consistently use size_t everywhere for span as it refers to size of the
memory block.

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c         |  4 ++--
 tools/testing/selftests/resctrl/cmt_test.c      |  2 +-
 tools/testing/selftests/resctrl/fill_buf.c      |  8 ++++----
 tools/testing/selftests/resctrl/mbm_test.c      |  8 ++++----
 tools/testing/selftests/resctrl/resctrl.h       | 10 +++++-----
 tools/testing/selftests/resctrl/resctrl_tests.c | 11 ++++++-----
 tools/testing/selftests/resctrl/resctrlfs.c     |  2 +-
 7 files changed, 23 insertions(+), 22 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index ced47b445d1e..f2c7d322bd76 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -282,7 +282,7 @@ int cat_val(struct resctrl_val_param *param)
  * Return:		0 on success. non-zero on failure.
  */
 int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
-		    unsigned long cache_span, unsigned long max_diff,
+		    size_t cache_span, unsigned long max_diff,
 		    unsigned long max_diff_percent, unsigned long num_of_runs,
 		    bool platform, bool cmt)
 {
@@ -304,7 +304,7 @@ int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
 	ksft_print_msg("Percent diff=%d\n", abs((int)diff_percent));
 	ksft_print_msg("Number of bits: %d\n", no_of_bits);
 	ksft_print_msg("Average LLC val: %lu\n", avg_llc_val);
-	ksft_print_msg("Cache span (%s): %lu\n", cmt ? "bytes" : "lines",
+	ksft_print_msg("Cache span (%s): %zu\n", cmt ? "bytes" : "lines",
 		       cache_span);
 
 	return ret;
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index d31e28416bb7..beb0f0687c6d 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -121,7 +121,7 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 	};
 
 	if (strcmp(benchmark_cmd[0], "fill_buf") == 0)
-		sprintf(benchmark_cmd[1], "%lu", param.span);
+		sprintf(benchmark_cmd[1], "%zu", param.span);
 
 	remove(RESULT_FILE_NAME);
 
diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 3b328c844896..785cbd8d0148 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -139,7 +139,7 @@ static int fill_cache_write(unsigned char *start_ptr, unsigned char *end_ptr,
 }
 
 static int
-fill_cache(unsigned long long buf_size, int malloc_and_init, int memflush,
+fill_cache(size_t buf_size, int malloc_and_init, int memflush,
 	   int op, char *resctrl_val)
 {
 	unsigned char *start_ptr, *end_ptr;
@@ -188,10 +188,10 @@ fill_cache(unsigned long long buf_size, int malloc_and_init, int memflush,
 	return 0;
 }
 
-int run_fill_buf(unsigned long span, int malloc_and_init_memory,
-		 int memflush, int op, char *resctrl_val)
+int run_fill_buf(size_t span, int malloc_and_init_memory, int memflush, int op,
+		 char *resctrl_val)
 {
-	unsigned long long cache_size = span;
+	size_t cache_size = span;
 	int ret;
 
 	ret = fill_cache(cache_size, malloc_and_init_memory, memflush, op,
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 24326cb7bc21..fd116158d008 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -15,7 +15,7 @@
 #define NUM_OF_RUNS		5
 
 static int
-show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, int span)
+show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, size_t span)
 {
 	unsigned long avg_bw_imc = 0, avg_bw_resc = 0;
 	unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
@@ -40,14 +40,14 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, int span)
 	ksft_print_msg("%s Check MBM diff within %d%%\n",
 		       ret ? "Fail:" : "Pass:", MAX_DIFF_PERCENT);
 	ksft_print_msg("avg_diff_per: %d%%\n", avg_diff_per);
-	ksft_print_msg("Span (MB): %d\n", span);
+	ksft_print_msg("Span (MB): %zu\n", span);
 	ksft_print_msg("avg_bw_imc: %lu\n", avg_bw_imc);
 	ksft_print_msg("avg_bw_resc: %lu\n", avg_bw_resc);
 
 	return ret;
 }
 
-static int check_results(int span)
+static int check_results(size_t span)
 {
 	unsigned long bw_imc[NUM_OF_RUNS], bw_resc[NUM_OF_RUNS];
 	char temp[1024], *token_array[8];
@@ -115,7 +115,7 @@ void mbm_test_cleanup(void)
 	remove(RESULT_FILE_NAME);
 }
 
-int mbm_bw_change(int span, int cpu_no, char *bw_report, char **benchmark_cmd)
+int mbm_bw_change(size_t span, int cpu_no, char *bw_report, char **benchmark_cmd)
 {
 	struct resctrl_val_param param = {
 		.resctrl_val	= MBM_STR,
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 99678d688a80..52068ceea956 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -63,7 +63,7 @@ struct resctrl_val_param {
 	char		ctrlgrp[64];
 	char		mongrp[64];
 	int		cpu_no;
-	unsigned long	span;
+	size_t		span;
 	char		filename[64];
 	char		*bw_report;
 	unsigned long	mask;
@@ -97,10 +97,10 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
 			    char *resctrl_val);
 int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 		    int group_fd, unsigned long flags);
-int run_fill_buf(unsigned long span, int malloc_and_init_memory, int memflush,
-		 int op, char *resctrl_va);
+int run_fill_buf(size_t span, int malloc_and_init_memory, int memflush, int op,
+		 char *resctrl_va);
 int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param);
-int mbm_bw_change(int span, int cpu_no, char *bw_report, char **benchmark_cmd);
+int mbm_bw_change(size_t span, int cpu_no, char *bw_report, char **benchmark_cmd);
 void tests_cleanup(void);
 void mbm_test_cleanup(void);
 int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd);
@@ -119,7 +119,7 @@ void cmt_test_cleanup(void);
 int get_core_sibling(int cpu_no);
 int measure_cache_vals(struct resctrl_val_param *param, int bm_pid);
 int show_cache_info(unsigned long sum_llc_val, int no_of_bits,
-		    unsigned long cache_span, unsigned long max_diff,
+		    size_t cache_span, unsigned long max_diff,
 		    unsigned long max_diff_percent, unsigned long num_of_runs,
 		    bool platform, bool cmt);
 
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 3f26d2279f75..6b2ca1b4744f 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -70,7 +70,7 @@ void tests_cleanup(void)
 	cat_test_cleanup();
 }
 
-static void run_mbm_test(bool has_ben, char **benchmark_cmd, int span,
+static void run_mbm_test(bool has_ben, char **benchmark_cmd, size_t span,
 			 int cpu_no, char *bw_report)
 {
 	int res;
@@ -99,7 +99,7 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, int span,
 	umount_resctrlfs();
 }
 
-static void run_mba_test(bool has_ben, char **benchmark_cmd, int span,
+static void run_mba_test(bool has_ben, char **benchmark_cmd, size_t span,
 			 int cpu_no, char *bw_report)
 {
 	int res;
@@ -118,7 +118,7 @@ static void run_mba_test(bool has_ben, char **benchmark_cmd, int span,
 	}
 
 	if (!has_ben)
-		sprintf(benchmark_cmd[1], "%d", span);
+		sprintf(benchmark_cmd[1], "%zu", span);
 	res = mba_schemata_change(cpu_no, bw_report, benchmark_cmd);
 	ksft_test_result(!res, "MBA: schemata change\n");
 
@@ -181,11 +181,12 @@ static void run_cat_test(int cpu_no, int no_of_bits)
 int main(int argc, char **argv)
 {
 	bool has_ben = false, mbm_test = true, mba_test = true, cmt_test = true;
-	int c, cpu_no = 1, span = 250, argc_new = argc, i, no_of_bits = 0;
 	char *benchmark_cmd[BENCHMARK_ARGS], bw_report[64], bm_type[64];
 	char benchmark_cmd_area[BENCHMARK_ARGS][BENCHMARK_ARG_SIZE];
+	int c, cpu_no = 1, argc_new = argc, i, no_of_bits = 0;
 	int ben_ind, ben_count, tests = 0;
 	bool cat_test = true;
+	size_t span = 250;
 
 	for (i = 0; i < argc; i++) {
 		if (strcmp(argv[i], "-b") == 0) {
@@ -273,7 +274,7 @@ int main(int argc, char **argv)
 			benchmark_cmd[i] = benchmark_cmd_area[i];
 
 		strcpy(benchmark_cmd[0], "fill_buf");
-		sprintf(benchmark_cmd[1], "%d", span);
+		sprintf(benchmark_cmd[1], "%zu", span);
 		strcpy(benchmark_cmd[2], "1");
 		strcpy(benchmark_cmd[3], "1");
 		strcpy(benchmark_cmd[4], "0");
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index f622245adafe..8be5b745226d 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -298,7 +298,7 @@ int taskset_benchmark(pid_t bm_pid, int cpu_no)
 void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 {
 	int operation, ret, malloc_and_init_memory, memflush;
-	unsigned long span, buffer_span;
+	size_t span, buffer_span;
 	char **benchmark_cmd;
 	char resctrl_val[64];
 	FILE *fp;
-- 
2.30.2

