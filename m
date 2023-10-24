Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D299F7D4C5A
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 11:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbjJXJal (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 05:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbjJXJaL (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 05:30:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25741BFE;
        Tue, 24 Oct 2023 02:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698139760; x=1729675760;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PNbEoz6PsZZon68ieYxIqS4az+Y7/8ZTMsZomZlq2P0=;
  b=GvGdPVOriRysUx3pMchhVFGlnlnp8qA7U+8gOQhYOXJ89uaSDKEYwlXr
   gqWjXuQF+O9n2jAtAcA8nhdQIuSRkC9XTTCp4YamPkTVdaOCO4LQn9nu9
   49xTywhKv5wPHvLT1L4x2PQV2bWv7JFU8uInnfQDXySQmFywXExb4N0D5
   AN+w1Eis4Ke123qSAQLI6T6B7x9HK9HBQ0nggnt0ElJcT/wTxsASlCf0b
   DBSyjBWIg+cv5qGNywo1Ed+ycMCnj6V4c1sgI5GKm6JYCYDx1JlPqko4o
   bPnKt4QMmj5t0cIHVlmm3m2PZ1QY2T6V6B4wcaH7E0CvJpjL8adx+bcl7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="386829675"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="386829675"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:29:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="793425148"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="793425148"
Received: from hprosing-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.219])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:29:16 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 18/24] selftests/resctrl: Introduce generalized test framework
Date:   Tue, 24 Oct 2023 12:26:28 +0300
Message-Id: <20231024092634.7122-19-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Each test currently has a "run test" function in per test file and
another resctrl_tests.c. The functions in resctrl_tests.c are almost
identical.

Generalize the one in resctrl_tests.c such that it can be shared
between all of the tests. It makes adding new tests easier and removes
the per test if () forests.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c    |  18 +-
 tools/testing/selftests/resctrl/cmt_test.c    |  17 +-
 tools/testing/selftests/resctrl/mba_test.c    |  16 +-
 tools/testing/selftests/resctrl/mbm_test.c    |  18 +-
 tools/testing/selftests/resctrl/resctrl.h     |  31 +++-
 .../testing/selftests/resctrl/resctrl_tests.c | 160 ++++++------------
 tools/testing/selftests/resctrl/resctrlfs.c   |   5 +
 7 files changed, 144 insertions(+), 121 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 1a70c69e5f7c..aa16fb36d0d4 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -218,7 +218,7 @@ static int cat_test(struct resctrl_val_param *param, size_t span, unsigned long
 	goto free_buf;
 }
 
-int cat_perf_miss_val(const struct user_params *uparams, char *cache_type)
+static int cat_run_test(const struct resctrl_test *test, const struct user_params *uparams)
 {
 	unsigned long long_mask, start_mask, full_cache_mask;
 	unsigned long cache_total_size = 0;
@@ -229,16 +229,16 @@ int cat_perf_miss_val(const struct user_params *uparams, char *cache_type)
 	int ret;
 
 	/* Get default cbm mask for L3/L2 cache */
-	ret = get_cbm_mask(cache_type, &full_cache_mask);
+	ret = get_cbm_mask(test->resource, &full_cache_mask);
 	if (ret)
 		return ret;
 	/* Get the exclusive portion of the cache */
-	ret = get_mask_no_shareable(cache_type, &long_mask);
+	ret = get_mask_no_shareable(test->resource, &long_mask);
 	if (ret)
 		return ret;
 
 	/* Get L3/L2 cache size */
-	ret = get_cache_size(uparams->cpu, cache_type, &cache_total_size);
+	ret = get_cache_size(uparams->cpu, test->resource, &cache_total_size);
 	if (ret)
 		return ret;
 	ksft_print_msg("Cache size :%lu\n", cache_total_size);
@@ -272,9 +272,17 @@ int cat_perf_miss_val(const struct user_params *uparams, char *cache_type)
 	if (ret)
 		goto out;
 
-	ret = check_results(&param, cache_type, cache_total_size, full_cache_mask, start_mask);
+	ret = check_results(&param, test->resource,
+			    cache_total_size, full_cache_mask, start_mask);
 out:
 	cat_test_cleanup();
 
 	return ret;
 }
+
+struct resctrl_test l3_cat_test = {
+	.name = "CAT",
+	.resource = "L3",
+	.feature_check = test_resource_feature_check,
+	.run_test = cat_run_test,
+};
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index f5561b79629f..353c4bae2cfe 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -94,7 +94,7 @@ void cmt_test_cleanup(void)
 	remove(RESULT_FILE_NAME);
 }
 
-int cmt_resctrl_val(const struct user_params *uparams)
+static int cmt_run_test(const struct resctrl_test *test, const struct user_params *uparams)
 {
 	const char * const *cmd = uparams->benchmark_cmd;
 	const char *new_cmd[BENCHMARK_ARGS];
@@ -156,6 +156,8 @@ int cmt_resctrl_val(const struct user_params *uparams)
 		goto out;
 
 	ret = check_results(&param, span, n);
+	if (ret && (get_vendor() == ARCH_INTEL))
+		ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
 
 out:
 	cmt_test_cleanup();
@@ -163,3 +165,16 @@ int cmt_resctrl_val(const struct user_params *uparams)
 
 	return ret;
 }
+
+static bool cmt_feature_check(const struct resctrl_test *test)
+{
+	return validate_resctrl_feature_request("L3_MON", "llc_occupancy") &&
+	       validate_resctrl_feature_request("L3", NULL);
+}
+
+struct resctrl_test cmt_test = {
+	.name = "CMT",
+	.resource = "L3",
+	.feature_check = cmt_feature_check,
+	.run_test = cmt_run_test,
+};
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 5157a3f74fee..722f94013cb9 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -141,7 +141,7 @@ void mba_test_cleanup(void)
 	remove(RESULT_FILE_NAME);
 }
 
-int mba_schemata_change(const struct user_params *uparams)
+static int mba_run_test(const struct resctrl_test *test, const struct user_params *uparams)
 {
 	struct resctrl_val_param param = {
 		.resctrl_val	= MBA_STR,
@@ -167,3 +167,17 @@ int mba_schemata_change(const struct user_params *uparams)
 
 	return ret;
 }
+
+static bool mba_feature_check(const struct resctrl_test *test)
+{
+	return test_resource_feature_check(test) &&
+	       validate_resctrl_feature_request("L3_MON", "mbm_local_bytes");
+}
+
+struct resctrl_test mba_test = {
+	.name = "MBA",
+	.resource = "MB",
+	.vendor_specific = ARCH_INTEL,
+	.feature_check = mba_feature_check,
+	.run_test = mba_run_test,
+};
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 98df9d151941..943f4f14a499 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -109,7 +109,7 @@ void mbm_test_cleanup(void)
 	remove(RESULT_FILE_NAME);
 }
 
-int mbm_bw_change(const struct user_params *uparams)
+static int mbm_run_test(const struct resctrl_test *test, const struct user_params *uparams)
 {
 	struct resctrl_val_param param = {
 		.resctrl_val	= MBM_STR,
@@ -129,9 +129,25 @@ int mbm_bw_change(const struct user_params *uparams)
 		goto out;
 
 	ret = check_results(DEFAULT_SPAN);
+	if (ret && (get_vendor() == ARCH_INTEL))
+		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
 
 out:
 	mbm_test_cleanup();
 
 	return ret;
 }
+
+static bool mbm_feature_check(const struct resctrl_test *test)
+{
+	return validate_resctrl_feature_request("L3_MON", "mbm_total_bytes") &&
+	       validate_resctrl_feature_request("L3_MON", "mbm_local_bytes");
+}
+
+struct resctrl_test mbm_test = {
+	.name = "MBM",
+	.resource = "MB",
+	.vendor_specific = ARCH_INTEL,
+	.feature_check = mbm_feature_check,
+	.run_test = mbm_run_test,
+};
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index ec6efd36f60a..e017adf1390d 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -37,6 +37,8 @@
 
 #define DEFAULT_SPAN		(250 * MB)
 
+#define ARRAY_SIZE(arr)		(sizeof(arr) / sizeof((arr)[0]))
+
 #define PARENT_EXIT(err_msg)			\
 	do {					\
 		perror(err_msg);		\
@@ -57,6 +59,25 @@ struct user_params {
 	const char *benchmark_cmd[BENCHMARK_ARGS];
 };
 
+/*
+ * resctrl_test:	resctrl test definition
+ * @name:		Test name
+ * @resource:		Resource to test (e.g., MB, L3, L2, etc.)
+ * @vendor_specific:	Bitmask for vendor-specific tests (can be 0 for universal tests)
+ * @disabled:		Test is disabled
+ * @feature_check:	Callback to check required resctrl features
+ * @run_test:		Callback to run the test
+ */
+struct resctrl_test {
+	const char	*name;
+	const char	*resource;
+	unsigned int	vendor_specific;
+	bool		disabled;
+	bool		(*feature_check)(const struct resctrl_test *test);
+	int		(*run_test)(const struct resctrl_test *test,
+				    const struct user_params *uparams);
+};
+
 /*
  * resctrl_val_param:	resctrl test parameters
  * @resctrl_val:	Resctrl feature (Eg: mbm, mba.. etc)
@@ -103,6 +124,7 @@ int mount_resctrlfs(void);
 int umount_resctrlfs(void);
 int validate_bw_report_request(char *bw_report);
 bool validate_resctrl_feature_request(const char *resource, const char *feature);
+bool test_resource_feature_check(const struct resctrl_test *test);
 char *fgrep(FILE *inf, const char *str);
 int taskset_benchmark(pid_t bm_pid, int cpu_no);
 int write_schemata(char *ctrlgrp, char *schemata, int cpu_no,
@@ -116,10 +138,8 @@ void mem_flush(unsigned char *buf, size_t buf_size);
 int fill_cache_read(unsigned char *buf, size_t buf_size, bool once);
 int run_fill_buf(size_t buf_size, int memflush, int op, bool once);
 int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *param);
-int mbm_bw_change(const struct user_params *uparams);
 void tests_cleanup(void);
 void mbm_test_cleanup(void);
-int mba_schemata_change(const struct user_params *uparams);
 void mba_test_cleanup(void);
 unsigned long create_bit_mask(unsigned int start, unsigned int len);
 unsigned int count_contiguous_bits(unsigned long val, unsigned int *start);
@@ -131,8 +151,6 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int signal_handler_register(void);
 void signal_handler_unregister(void);
 void cat_test_cleanup(void);
-int cat_perf_miss_val(const struct user_params *uparams, char *cache_type);
-int cmt_resctrl_val(const struct user_params *uparams);
 unsigned int count_bits(unsigned long n);
 void cmt_test_cleanup(void);
 
@@ -158,4 +176,9 @@ static inline int cache_size(unsigned long cache_size, unsigned long mask,
 	return cache_size * count_bits(mask) / count_bits(cache_mask);
 }
 
+extern struct resctrl_test mbm_test;
+extern struct resctrl_test mba_test;
+extern struct resctrl_test cmt_test;
+extern struct resctrl_test l3_cat_test;
+
 #endif /* RESCTRL_H */
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 8e00ccc2b2f6..7846260e3f68 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -10,6 +10,13 @@
  */
 #include "resctrl.h"
 
+static struct resctrl_test *resctrl_tests[] = {
+	&mbm_test,
+	&mba_test,
+	&cmt_test,
+	&l3_cat_test,
+};
+
 static int detect_vendor(void)
 {
 	FILE *inf = fopen("/proc/cpuinfo", "r");
@@ -49,11 +56,16 @@ int get_vendor(void)
 
 static void cmd_help(void)
 {
+	int i;
+
 	printf("usage: resctrl_tests [-h] [-t test list] [-n no_of_bits] [-b benchmark_cmd [option]...]\n");
 	printf("\t-b benchmark_cmd [option]...: run specified benchmark for MBM, MBA and CMT\n");
 	printf("\t   default benchmark is builtin fill_buf\n");
 	printf("\t-t test list: run tests specified in the test list, ");
 	printf("e.g. -t mbm,mba,cmt,cat\n");
+	printf("\t\tSupported tests:\n");
+	for (i = 0; i < ARRAY_SIZE(resctrl_tests); i++)
+		printf("\t\t\t%s\n", resctrl_tests[i]->name);
 	printf("\t-n no_of_bits: run cache tests using specified no of bits in cache bit mask\n");
 	printf("\t-p cpu_no: specify CPU number to run the test. 1 is default\n");
 	printf("\t-h: help\n");
@@ -92,102 +104,41 @@ static void test_cleanup(void)
 	signal_handler_unregister();
 }
 
-static void run_mbm_test(const struct user_params *uparams)
+static bool test_vendor_specific_check(const struct resctrl_test *test)
 {
-	int res;
-
-	ksft_print_msg("Starting MBM BW change ...\n");
-
-	if (test_prepare()) {
-		ksft_exit_fail_msg("Abnormal failure when preparing for the test\n");
-		return;
-	}
-
-	if (!validate_resctrl_feature_request("L3_MON", "mbm_total_bytes") ||
-	    !validate_resctrl_feature_request("L3_MON", "mbm_local_bytes") ||
-	    (get_vendor() != ARCH_INTEL)) {
-		ksft_test_result_skip("Hardware does not support MBM or MBM is disabled\n");
-		goto cleanup;
-	}
-
-	res = mbm_bw_change(uparams);
-	ksft_test_result(!res, "MBM: bw change\n");
-	if ((get_vendor() == ARCH_INTEL) && res)
-		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
+	if (!test->vendor_specific)
+		return true;
 
-cleanup:
-	test_cleanup();
+	return get_vendor() & test->vendor_specific;
 }
 
-static void run_mba_test(const struct user_params *uparams)
+static void run_single_test(const struct resctrl_test *test, const struct user_params *uparams)
 {
-	int res;
-
-	ksft_print_msg("Starting MBA Schemata change ...\n");
+	int ret;
 
-	if (test_prepare()) {
-		ksft_exit_fail_msg("Abnormal failure when preparing for the test\n");
+	if (test->disabled)
 		return;
-	}
 
-	if (!validate_resctrl_feature_request("MB", NULL) ||
-	    !validate_resctrl_feature_request("L3_MON", "mbm_local_bytes") ||
-	    (get_vendor() != ARCH_INTEL)) {
-		ksft_test_result_skip("Hardware does not support MBA or MBA is disabled\n");
-		goto cleanup;
-	}
-
-	res = mba_schemata_change(uparams);
-	ksft_test_result(!res, "MBA: schemata change\n");
-
-cleanup:
-	test_cleanup();
-}
-
-static void run_cmt_test(const struct user_params *uparams)
-{
-	int res;
-
-	ksft_print_msg("Starting CMT test ...\n");
-
-	if (test_prepare()) {
-		ksft_exit_fail_msg("Abnormal failure when preparing for the test\n");
+	if (!test_vendor_specific_check(test)) {
+		ksft_test_result_skip("Hardware does not support %s\n", test->name);
 		return;
 	}
 
-	if (!validate_resctrl_feature_request("L3_MON", "llc_occupancy") ||
-	    !validate_resctrl_feature_request("L3", NULL)) {
-		ksft_test_result_skip("Hardware does not support CMT or CMT is disabled\n");
-		goto cleanup;
-	}
-
-	res = cmt_resctrl_val(uparams);
-	ksft_test_result(!res, "CMT: test\n");
-	if ((get_vendor() == ARCH_INTEL) && res)
-		ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
-
-cleanup:
-	test_cleanup();
-}
-
-static void run_cat_test(const struct user_params *uparams)
-{
-	int res;
-
-	ksft_print_msg("Starting CAT test ...\n");
+	ksft_print_msg("Starting %s test ...\n", test->name);
 
 	if (test_prepare()) {
 		ksft_exit_fail_msg("Abnormal failure when preparing for the test\n");
 		return;
 	}
 
-	if (!validate_resctrl_feature_request("L3", NULL)) {
-		ksft_test_result_skip("Hardware does not support CAT or CAT is disabled\n");
+	if (!test->feature_check(test)) {
+		ksft_test_result_skip("Hardware does not support %s or %s is disabled\n",
+				      test->name, test->name);
 		goto cleanup;
 	}
 
-	res = cat_perf_miss_val(uparams, "L3");
-	ksft_test_result(!res, "CAT: test\n");
+	ret = test->run_test(test, uparams);
+	ksft_test_result(!ret, "%s: test\n", test->name);
 
 cleanup:
 	test_cleanup();
@@ -201,11 +152,10 @@ static void init_user_params(struct user_params *uparams)
 
 int main(int argc, char **argv)
 {
-	bool mbm_test = true, mba_test = true, cmt_test = true;
+	int tests = ARRAY_SIZE(resctrl_tests);
 	struct user_params uparams = {};
+	bool test_param_seen = false;
 	char *span_str = NULL;
-	bool cat_test = true;
-	int tests = 0;
 	int ret, c, i;
 
 	init_user_params(&uparams);
@@ -233,25 +183,26 @@ int main(int argc, char **argv)
 		case 't':
 			token = strtok(optarg, ",");
 
-			mbm_test = false;
-			mba_test = false;
-			cmt_test = false;
-			cat_test = false;
+			if (!test_param_seen) {
+				for (i = 0; i < ARRAY_SIZE(resctrl_tests); i++)
+					resctrl_tests[i]->disabled = true;
+				tests = 0;
+				test_param_seen = true;
+			}
 			while (token) {
-				if (!strncmp(token, MBM_STR, sizeof(MBM_STR))) {
-					mbm_test = true;
-					tests++;
-				} else if (!strncmp(token, MBA_STR, sizeof(MBA_STR))) {
-					mba_test = true;
-					tests++;
-				} else if (!strncmp(token, CMT_STR, sizeof(CMT_STR))) {
-					cmt_test = true;
-					tests++;
-				} else if (!strncmp(token, CAT_STR, sizeof(CAT_STR))) {
-					cat_test = true;
-					tests++;
-				} else {
-					printf("invalid argument\n");
+				bool found = false;
+
+				for (i = 0; i < ARRAY_SIZE(resctrl_tests); i++) {
+					if (!strcasecmp(token, resctrl_tests[i]->name)) {
+						if (resctrl_tests[i]->disabled)
+							tests++;
+						resctrl_tests[i]->disabled = false;
+						found = true;
+					}
+				}
+
+				if (!found) {
+					printf("invalid test: %s\n", token);
 
 					return -1;
 				}
@@ -311,19 +262,10 @@ int main(int argc, char **argv)
 		uparams.benchmark_cmd[5] = NULL;
 	}
 
-	ksft_set_plan(tests ? : 4);
-
-	if (mbm_test)
-		run_mbm_test(&uparams);
-
-	if (mba_test)
-		run_mba_test(&uparams);
-
-	if (cmt_test)
-		run_cmt_test(&uparams);
+	ksft_set_plan(tests);
 
-	if (cat_test)
-		run_cat_test(&uparams);
+	for (i = 0; i < ARRAY_SIZE(resctrl_tests); i++)
+		run_single_test(resctrl_tests[i], &uparams);
 
 	free(span_str);
 	ksft_finished();
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index c8fbbd96311d..2851ffe64b56 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -673,6 +673,11 @@ bool validate_resctrl_feature_request(const char *resource, const char *feature)
 	return !!res;
 }
 
+bool test_resource_feature_check(const struct resctrl_test *test)
+{
+	return validate_resctrl_feature_request(test->resource, NULL);
+}
+
 int filter_dmesg(void)
 {
 	char line[1024];
-- 
2.30.2

