Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5B4791529
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Sep 2023 11:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352721AbjIDJye (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Sep 2023 05:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244654AbjIDJyb (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 05:54:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4339BCDB;
        Mon,  4 Sep 2023 02:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693821254; x=1725357254;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5hdWz3ATfLSGSA7CNlCv/jGDdSXVG3/TzUC554+/RN0=;
  b=aJbOi1N49LTlP6trwyGRtN+VD9sKpisRymwpYuD1vrdugyBylQ4IkG7l
   +khOuFFKS6BpjPuWUyIw29gg05UztGRscLvWYNXEBofg68W9hY8WHSTg0
   5O8/1wdq9wG9X3KJnPVuHZcKc0Tob5eKO2u2TFJhUcNgn0+b191ojUzdQ
   HHtegRqlgffifwe0+70wTuVNrof9TnyhcMyChwtM4ugpDk+ZtXEIfhsnz
   5GbI/Zv8sB3wrn4NOSRF5HOLR6gt/x/CCBhNcDzRsMxQpbBw3xBCpatKn
   OvJbdIhOrAq+eHZaa07a+gVY8f5MFDRCzQpyZQu5gDNiSm3rQtssHS+0o
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="356880698"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="356880698"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 02:54:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="740700672"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="740700672"
Received: from okozlyk-mobl.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.249.44.17])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 02:54:09 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        =?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 4/8] selftests/resctrl: Simplify span lifetime
Date:   Mon,  4 Sep 2023 12:53:35 +0300
Message-Id: <20230904095339.11321-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230904095339.11321-1-ilpo.jarvinen@linux.intel.com>
References: <20230904095339.11321-1-ilpo.jarvinen@linux.intel.com>
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
Reviewed-by: "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
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
index 7f3c8432ca5c..64e28bde5131 100644
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

