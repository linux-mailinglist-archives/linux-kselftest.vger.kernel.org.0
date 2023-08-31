Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35FEB78EB68
	for <lists+linux-kselftest@lfdr.de>; Thu, 31 Aug 2023 13:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345540AbjHaLJQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Aug 2023 07:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345486AbjHaLJP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Aug 2023 07:09:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 851B0CE4;
        Thu, 31 Aug 2023 04:09:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693480152; x=1725016152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cQBr6Gpbc8GUcsVBf5xGHk55H28a0WnaCnbDjN1N8Vg=;
  b=EWPFXy5lTHRUKHC7rtqNkQ0rnif3Q2yvRfoAASF5kNahMFhUh3LDK7WX
   jL46Hknx3kW2JTbmwJ5XXiun8KQ6OFtLZqG1uyIA9AFsRAeuM85+UFTBI
   P78EsGXccPLMOLLiRGqfLjGnwSO3zh2oce/eXU0CR2RO5JkBp39ZyuM06
   w1rtStP9zG9F70te/KsT+sARFaC6nF16Jth7BcCtDQK4LNVitfreGt/gF
   8c39bYDW2gx4H5+aYMxiBfN3UfDWDDjzR7jjO6MRVj2/yXpXEeTugJ6v5
   PaO+mUbwnc9OCF0LP25g3/mytjBNMIzRYjKj9YmW3PeLtxZiYBF0YbW0u
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="439852248"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="439852248"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 04:09:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="863021013"
X-IronPort-AV: E=Sophos;i="6.02,216,1688454000"; 
   d="scan'208";a="863021013"
Received: from pshishpo-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.251.214.20])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 04:09:09 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 4/8] selftests/resctrl: Simplify span lifetime
Date:   Thu, 31 Aug 2023 14:08:39 +0300
Message-Id: <20230831110843.26719-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230831110843.26719-1-ilpo.jarvinen@linux.intel.com>
References: <20230831110843.26719-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

struct resctrl_val_param contains span member. resctrl_val(), however,
never uses it because the value of span is embedded into the default
benchmark command and parsed from it by run_benchmark().

Remove span from resctrl_val_param. Provide DEFAULT_SPAN for the code
that needs it. CMT and CAT tests communicate span that is different
from the DEFAULT_SPAN between their internal functions which is
converted into passing it directly as a parameter.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
---
 tools/testing/selftests/resctrl/cache.c         |  5 +++--
 tools/testing/selftests/resctrl/cat_test.c      | 13 +++++++------
 tools/testing/selftests/resctrl/cmt_test.c      | 11 ++++++-----
 tools/testing/selftests/resctrl/mbm_test.c      |  5 ++---
 tools/testing/selftests/resctrl/resctrl.h       |  8 ++++----
 tools/testing/selftests/resctrl/resctrl_tests.c |  9 ++++-----
 6 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index d3cbb829ff6a..a0318bd3a63d 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -205,10 +205,11 @@ int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
  * cache_val:		execute benchmark and measure LLC occupancy resctrl
  * and perf cache miss for the benchmark
  * @param:		parameters passed to cache_val()
+ * @span:		buffer size for the benchmark
  *
  * Return:		0 on success. non-zero on failure.
  */
-int cat_val(struct resctrl_val_param *param)
+int cat_val(struct resctrl_val_param *param, size_t span)
 {
 	int memflush = 1, operation = 0, ret = 0;
 	char *resctrl_val = param->resctrl_val;
@@ -245,7 +246,7 @@ int cat_val(struct resctrl_val_param *param)
 		if (ret)
 			break;
 
-		if (run_fill_buf(param->span, memflush, operation, true)) {
+		if (run_fill_buf(span, memflush, operation, true)) {
 			fprintf(stderr, "Error-running fill buffer\n");
 			ret = -1;
 			goto pe_close;
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 3848dfb46aba..97b87285ab2a 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -41,7 +41,7 @@ static int cat_setup(struct resctrl_val_param *p)
 	return ret;
 }
 
-static int check_results(struct resctrl_val_param *param)
+static int check_results(struct resctrl_val_param *param, size_t span)
 {
 	char *token_array[8], temp[512];
 	unsigned long sum_llc_perf_miss = 0;
@@ -76,7 +76,7 @@ static int check_results(struct resctrl_val_param *param)
 	fclose(fp);
 	no_of_bits = count_bits(param->mask);
 
-	return show_cache_info(sum_llc_perf_miss, no_of_bits, param->span / 64,
+	return show_cache_info(sum_llc_perf_miss, no_of_bits, span / 64,
 			       MAX_DIFF, MAX_DIFF_PERCENT, runs - 1,
 			       get_vendor() == ARCH_INTEL, false);
 }
@@ -96,6 +96,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	char cbm_mask[256];
 	int count_of_bits;
 	char pipe_message;
+	size_t span;
 
 	/* Get default cbm mask for L3/L2 cache */
 	ret = get_cbm_mask(cache_type, cbm_mask);
@@ -140,7 +141,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	/* Set param values for parent thread which will be allocated bitmask
 	 * with (max_bits - n) bits
 	 */
-	param.span = cache_size * (count_of_bits - n) / count_of_bits;
+	span = cache_size * (count_of_bits - n) / count_of_bits;
 	strcpy(param.ctrlgrp, "c2");
 	strcpy(param.mongrp, "m2");
 	strcpy(param.filename, RESULT_FILE_NAME2);
@@ -162,7 +163,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		param.mask = l_mask_1;
 		strcpy(param.ctrlgrp, "c1");
 		strcpy(param.mongrp, "m1");
-		param.span = cache_size * n / count_of_bits;
+		span = cache_size * n / count_of_bits;
 		strcpy(param.filename, RESULT_FILE_NAME1);
 		param.num_of_runs = 0;
 		param.cpu_no = sibling_cpu_no;
@@ -176,9 +177,9 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 
 	remove(param.filename);
 
-	ret = cat_val(&param);
+	ret = cat_val(&param, span);
 	if (ret == 0)
-		ret = check_results(&param);
+		ret = check_results(&param, span);
 
 	if (bm_pid == 0) {
 		/* Tell parent that child is ready */
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index cb2197647c6c..9d8e38e995ef 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -27,7 +27,7 @@ static int cmt_setup(struct resctrl_val_param *p)
 	return 0;
 }
 
-static int check_results(struct resctrl_val_param *param, int no_of_bits)
+static int check_results(struct resctrl_val_param *param, size_t span, int no_of_bits)
 {
 	char *token_array[8], temp[512];
 	unsigned long sum_llc_occu_resc = 0;
@@ -58,7 +58,7 @@ static int check_results(struct resctrl_val_param *param, int no_of_bits)
 	}
 	fclose(fp);
 
-	return show_cache_info(sum_llc_occu_resc, no_of_bits, param->span,
+	return show_cache_info(sum_llc_occu_resc, no_of_bits, span,
 			       MAX_DIFF, MAX_DIFF_PERCENT, runs - 1,
 			       true, true);
 }
@@ -74,6 +74,7 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 	unsigned long long_mask;
 	char cbm_mask[256];
 	int count_of_bits;
+	size_t span;
 	int ret;
 
 	if (!validate_resctrl_feature_request(CMT_STR))
@@ -105,13 +106,13 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 		.cpu_no		= cpu_no,
 		.filename	= RESULT_FILE_NAME,
 		.mask		= ~(long_mask << n) & long_mask,
-		.span		= cache_size * n / count_of_bits,
 		.num_of_runs	= 0,
 		.setup		= cmt_setup,
 	};
 
+	span = cache_size * n / count_of_bits;
 	if (strcmp(benchmark_cmd[0], "fill_buf") == 0)
-		sprintf(benchmark_cmd[1], "%zu", param.span);
+		sprintf(benchmark_cmd[1], "%zu", span);
 
 	remove(RESULT_FILE_NAME);
 
@@ -119,7 +120,7 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 	if (ret)
 		goto out;
 
-	ret = check_results(&param, n);
+	ret = check_results(&param, span, n);
 
 out:
 	cmt_test_cleanup();
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 3e4a800e0e40..b830fc84338b 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -109,13 +109,12 @@ void mbm_test_cleanup(void)
 	remove(RESULT_FILE_NAME);
 }
 
-int mbm_bw_change(size_t span, int cpu_no, char **benchmark_cmd)
+int mbm_bw_change(int cpu_no, char **benchmark_cmd)
 {
 	struct resctrl_val_param param = {
 		.resctrl_val	= MBM_STR,
 		.ctrlgrp	= "c1",
 		.mongrp		= "m1",
-		.span		= span,
 		.cpu_no		= cpu_no,
 		.filename	= RESULT_FILE_NAME,
 		.bw_report	= "reads",
@@ -129,7 +128,7 @@ int mbm_bw_change(size_t span, int cpu_no, char **benchmark_cmd)
 	if (ret)
 		goto out;
 
-	ret = check_results(span);
+	ret = check_results(DEFAULT_SPAN);
 
 out:
 	mbm_test_cleanup();
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index f3446ac664c2..bcd0d2060f81 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -38,6 +38,8 @@
 
 #define END_OF_TESTS	1
 
+#define DEFAULT_SPAN		(250 * MB)
+
 #define PARENT_EXIT(err_msg)			\
 	do {					\
 		perror(err_msg);		\
@@ -52,7 +54,6 @@
  * @ctrlgrp:		Name of the control monitor group (con_mon grp)
  * @mongrp:		Name of the monitor group (mon grp)
  * @cpu_no:		CPU number to which the benchmark would be binded
- * @span:		Memory bytes accessed in each benchmark iteration
  * @filename:		Name of file to which the o/p should be written
  * @bw_report:		Bandwidth report type (reads vs writes)
  * @setup:		Call back function to setup test environment
@@ -62,7 +63,6 @@ struct resctrl_val_param {
 	char		ctrlgrp[64];
 	char		mongrp[64];
 	int		cpu_no;
-	size_t		span;
 	char		filename[64];
 	char		*bw_report;
 	unsigned long	mask;
@@ -98,7 +98,7 @@ int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 		    int group_fd, unsigned long flags);
 int run_fill_buf(size_t span, int memflush, int op, bool once);
 int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param);
-int mbm_bw_change(size_t span, int cpu_no, char **benchmark_cmd);
+int mbm_bw_change(int cpu_no, char **benchmark_cmd);
 void tests_cleanup(void);
 void mbm_test_cleanup(void);
 int mba_schemata_change(int cpu_no, char **benchmark_cmd);
@@ -108,7 +108,7 @@ int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size);
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int signal_handler_register(void);
 void signal_handler_unregister(void);
-int cat_val(struct resctrl_val_param *param);
+int cat_val(struct resctrl_val_param *param, size_t span);
 void cat_test_cleanup(void);
 int cat_perf_miss_val(int cpu_no, int no_of_bits, char *cache_type);
 int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 7028ff1b8f41..89decda09487 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -70,7 +70,7 @@ void tests_cleanup(void)
 	cat_test_cleanup();
 }
 
-static void run_mbm_test(char **benchmark_cmd, size_t span, int cpu_no)
+static void run_mbm_test(char **benchmark_cmd, int cpu_no)
 {
 	int res;
 
@@ -87,7 +87,7 @@ static void run_mbm_test(char **benchmark_cmd, size_t span, int cpu_no)
 		goto umount;
 	}
 
-	res = mbm_bw_change(span, cpu_no, benchmark_cmd);
+	res = mbm_bw_change(cpu_no, benchmark_cmd);
 	ksft_test_result(!res, "MBM: bw change\n");
 	if ((get_vendor() == ARCH_INTEL) && res)
 		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
@@ -177,7 +177,6 @@ int main(int argc, char **argv)
 	int c, cpu_no = 1, argc_new = argc, i, no_of_bits = 0;
 	char *benchmark_cmd[BENCHMARK_ARGS];
 	int ben_ind, ben_count, tests = 0;
-	size_t span = 250 * MB;
 	bool cat_test = true;
 
 	for (i = 0; i < argc; i++) {
@@ -271,7 +270,7 @@ int main(int argc, char **argv)
 			benchmark_cmd[i] = benchmark_cmd_area[i];
 
 		strcpy(benchmark_cmd[0], "fill_buf");
-		sprintf(benchmark_cmd[1], "%zu", span);
+		sprintf(benchmark_cmd[1], "%u", DEFAULT_SPAN);
 		strcpy(benchmark_cmd[2], "1");
 		strcpy(benchmark_cmd[3], "0");
 		strcpy(benchmark_cmd[4], "false");
@@ -289,7 +288,7 @@ int main(int argc, char **argv)
 	ksft_set_plan(tests ? : 4);
 
 	if (mbm_test)
-		run_mbm_test(benchmark_cmd, span, cpu_no);
+		run_mbm_test(benchmark_cmd, cpu_no);
 
 	if (mba_test)
 		run_mba_test(benchmark_cmd, cpu_no);
-- 
2.30.2

