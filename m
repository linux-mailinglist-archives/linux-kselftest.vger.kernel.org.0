Return-Path: <linux-kselftest+bounces-1551-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FBA780C996
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 13:22:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9643280C31
	for <lists+linux-kselftest@lfdr.de>; Mon, 11 Dec 2023 12:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF133B288;
	Mon, 11 Dec 2023 12:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gZb+Ex8q"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D1DD6F;
	Mon, 11 Dec 2023 04:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702297344; x=1733833344;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vjiP6DLv4Vp8sJiXFdGKHVUL0g+gUtxR/SG6H8XLHOA=;
  b=gZb+Ex8qAzk9zy9ovv9A/E73tkpL1bwLIyMwyBcLRhGut1e9APjAE0+Q
   eJ0gujIIl4LJ2p7QezQpyIEU5y60O4jenSnPhAmCxi/B6TMBNihp41cwG
   8SeVe1aEcqcR6tC5zNWytV1akBdDnERwCTQ7CjmJMxB58qZ388h+xBGAm
   6Y0mLUDIb347MfIgsUp3ritJN91PrCn7gJAmKQidC5I0lXVOKGdVyBVZ9
   apq/Yh1xi42zQPoHXocmsNmJG6pNaVxWw0lBDKmondfnz8tQPlU/RE8q0
   v5bbCSiqG8uqh9H/Smie/WHkIMquIHANlsncf2WouM2hXa6qNp9nWQYUS
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="7992662"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="7992662"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:22:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="843494699"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; 
   d="scan'208";a="843494699"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.50.188])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2023 04:22:20 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 25/29] selftests/resctrl: Introduce generalized test framework
Date: Mon, 11 Dec 2023 14:18:22 +0200
Message-Id: <20231211121826.14392-26-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
References: <20231211121826.14392-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Each test currently has a "run test" function in per test file and
another resctrl_tests.c. The functions in resctrl_tests.c are almost
identical.

Generalize the one in resctrl_tests.c such that it can be shared
between all of the tests. It makes adding new tests easier and removes
the per test if () forests.

Also add comment to CPU vendor IDs that they must be defined as bits
for a bitmask.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---

v3:
- Add CPU vendor ID bitmask comment
- Use test_resource_feature_check(test) in CMT
---
 tools/testing/selftests/resctrl/cat_test.c    |  18 +-
 tools/testing/selftests/resctrl/cmt_test.c    |  17 +-
 tools/testing/selftests/resctrl/mba_test.c    |  16 +-
 tools/testing/selftests/resctrl/mbm_test.c    |  18 +-
 tools/testing/selftests/resctrl/resctrl.h     |  35 +++-
 .../testing/selftests/resctrl/resctrl_tests.c | 160 ++++++------------
 tools/testing/selftests/resctrl/resctrlfs.c   |   5 +
 7 files changed, 148 insertions(+), 121 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 272132ff7337..a9b4583620d0 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -231,7 +231,7 @@ static int cat_test(const struct user_params *uparams, struct resctrl_val_param
 	return ret;
 }
 
-int cat_perf_miss_val(const struct user_params *uparams, char *cache_type)
+static int cat_run_test(const struct resctrl_test *test, const struct user_params *uparams)
 {
 	unsigned long long_mask, start_mask, full_cache_mask;
 	unsigned long cache_total_size = 0;
@@ -241,16 +241,16 @@ int cat_perf_miss_val(const struct user_params *uparams, char *cache_type)
 	size_t span;
 	int ret;
 
-	ret = get_full_cbm(cache_type, &full_cache_mask);
+	ret = get_full_cbm(test->resource, &full_cache_mask);
 	if (ret)
 		return ret;
 	/* Get the largest contiguous exclusive portion of the cache */
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
@@ -283,9 +283,17 @@ int cat_perf_miss_val(const struct user_params *uparams, char *cache_type)
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
index a5d0c0878c42..c01980039118 100644
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
@@ -155,6 +155,8 @@ int cmt_resctrl_val(const struct user_params *uparams)
 		goto out;
 
 	ret = check_results(&param, span, n);
+	if (ret && (get_vendor() == ARCH_INTEL))
+		ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
 
 out:
 	cmt_test_cleanup();
@@ -162,3 +164,16 @@ int cmt_resctrl_val(const struct user_params *uparams)
 
 	return ret;
 }
+
+static bool cmt_feature_check(const struct resctrl_test *test)
+{
+	return test_resource_feature_check(test) &&
+	       validate_resctrl_feature_request("L3_MON", "llc_occupancy");
+}
+
+struct resctrl_test cmt_test = {
+	.name = "CMT",
+	.resource = "L3",
+	.feature_check = cmt_feature_check,
+	.run_test = cmt_run_test,
+};
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 8e54bc508a75..c218af24f91d 100644
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
@@ -166,3 +166,17 @@ int mba_schemata_change(const struct user_params *uparams)
 
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
index ea951cfae5fe..919b10459c22 100644
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
@@ -128,9 +128,25 @@ int mbm_bw_change(const struct user_params *uparams)
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
index 3155631cd3c6..9a6b304044cc 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -28,6 +28,12 @@
 #define PHYS_ID_PATH		"/sys/devices/system/cpu/cpu"
 #define INFO_PATH		"/sys/fs/resctrl/info"
 
+/*
+ * CPU vendor IDs
+ *
+ * Define as bits because they're used for vendor_specific bitmask in
+ * the struct resctrl_test.
+ */
 #define ARCH_INTEL     1
 #define ARCH_AMD       2
 
@@ -56,6 +62,25 @@ struct user_params {
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
@@ -108,6 +133,7 @@ int mount_resctrlfs(void);
 int umount_resctrlfs(void);
 int validate_bw_report_request(char *bw_report);
 bool validate_resctrl_feature_request(const char *resource, const char *feature);
+bool test_resource_feature_check(const struct resctrl_test *test);
 char *fgrep(FILE *inf, const char *str);
 int taskset_benchmark(pid_t bm_pid, int cpu_no, cpu_set_t *old_affinity);
 int taskset_restore(pid_t bm_pid, cpu_set_t *old_affinity);
@@ -123,10 +149,8 @@ void fill_cache_read(unsigned char *buf, size_t buf_size, bool once);
 int run_fill_buf(size_t buf_size, int memflush, int op, bool once);
 int resctrl_val(const struct user_params *uparams, const char * const *benchmark_cmd,
 		struct resctrl_val_param *param);
-int mbm_bw_change(const struct user_params *uparams);
 void tests_cleanup(void);
 void mbm_test_cleanup(void);
-int mba_schemata_change(const struct user_params *uparams);
 void mba_test_cleanup(void);
 unsigned long create_bit_mask(unsigned int start, unsigned int len);
 unsigned int count_contiguous_bits(unsigned long val, unsigned int *start);
@@ -137,8 +161,6 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int signal_handler_register(void);
 void signal_handler_unregister(void);
 void cat_test_cleanup(void);
-int cat_perf_miss_val(const struct user_params *uparams, char *cache_type);
-int cmt_resctrl_val(const struct user_params *uparams);
 unsigned int count_bits(unsigned long n);
 void cmt_test_cleanup(void);
 
@@ -166,4 +188,9 @@ static inline int cache_portion_size(unsigned long cache_size,
 	return cache_size * count_bits(portion_mask) / count_bits(full_cache_mask);
 }
 
+extern struct resctrl_test mbm_test;
+extern struct resctrl_test mba_test;
+extern struct resctrl_test cmt_test;
+extern struct resctrl_test l3_cat_test;
+
 #endif /* RESCTRL_H */
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 3059a124ac59..75fc49ba3efb 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -14,6 +14,13 @@
 static volatile int sink_target;
 volatile int *value_sink = &sink_target;
 
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
@@ -53,11 +60,16 @@ int get_vendor(void)
 
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
@@ -96,102 +108,41 @@ static void test_cleanup(void)
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
@@ -207,11 +158,10 @@ static void init_user_params(struct user_params *uparams)
 
 int main(int argc, char **argv)
 {
-	bool mbm_test = true, mba_test = true, cmt_test = true;
+	int tests = ARRAY_SIZE(resctrl_tests);
+	bool test_param_seen = false;
 	struct user_params uparams;
 	char *span_str = NULL;
-	bool cat_test = true;
-	int tests = 0;
 	int ret, c, i;
 
 	init_user_params(&uparams);
@@ -239,25 +189,26 @@ int main(int argc, char **argv)
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
@@ -317,19 +268,10 @@ int main(int argc, char **argv)
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
index 97760fadcddf..37ca06f38673 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -706,6 +706,11 @@ bool validate_resctrl_feature_request(const char *resource, const char *feature)
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


