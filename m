Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3495B7D4C54
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 11:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234034AbjJXJa2 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 05:30:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbjJXJ3z (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 05:29:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A3719AB;
        Tue, 24 Oct 2023 02:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698139751; x=1729675751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XAy9JLZLFdPN+zWsbpxTCeTUfVLXEcxxERlTjO5oCI0=;
  b=nARDwO7Kbl1QDFr6yAFOnp8ml4+gvF8rp/o3hqyodJROS51qZDmqj+Cc
   MxGP4oSmGbc16R25na/9BAEx7pRhGqFnd8jnAft3QoBsPbrKtdSsoSaz1
   aP8IoJP4CaQXHfAOzT857pTf/CU3g2J6FqJQbTR38o7U907RuY1fV0u5E
   QMuuIfmfyXs5jOCNTc26ZuXh3TjKK2tfiN0003hkM7pdEil3fRLNIt0Nm
   /U/j5f8AswCp6r7aOhk2jsCxzlwBQbeTzymCh+lIUS+HLFzjcMtUk37cC
   KyWzyiEn3k189N/AAJYwqDf2IlB3zfaYgxncxas+jbsRNTT4bTM0gb3oE
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="384218933"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="384218933"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:29:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="6397892"
Received: from hprosing-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.219])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:29:01 -0700
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
Subject: [PATCH 17/24] selftests/resctrl: Create struct for input parameter
Date:   Tue, 24 Oct 2023 12:26:27 +0300
Message-Id: <20231024092634.7122-18-ilpo.jarvinen@linux.intel.com>
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

resctrl_tests reads a set of parameters and passes them individually
for each tests. The way the parameters passed varies between tests.

Add struct input_params to hold are input parameters. It can be easily
passed to every test without varying the call signature.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c    |  7 ++-
 tools/testing/selftests/resctrl/cmt_test.c    | 13 ++--
 tools/testing/selftests/resctrl/mba_test.c    |  6 +-
 tools/testing/selftests/resctrl/mbm_test.c    |  6 +-
 tools/testing/selftests/resctrl/resctrl.h     | 20 ++++--
 .../testing/selftests/resctrl/resctrl_tests.c | 61 +++++++++++--------
 6 files changed, 67 insertions(+), 46 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 7518c520c5cc..1a70c69e5f7c 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -218,10 +218,11 @@ static int cat_test(struct resctrl_val_param *param, size_t span, unsigned long
 	goto free_buf;
 }
 
-int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
+int cat_perf_miss_val(const struct user_params *uparams, char *cache_type)
 {
 	unsigned long long_mask, start_mask, full_cache_mask;
 	unsigned long cache_total_size = 0;
+	int n = uparams->bits;
 	unsigned int start;
 	int count_of_bits;
 	size_t span;
@@ -237,7 +238,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		return ret;
 
 	/* Get L3/L2 cache size */
-	ret = get_cache_size(cpu_no, cache_type, &cache_total_size);
+	ret = get_cache_size(uparams->cpu, cache_type, &cache_total_size);
 	if (ret)
 		return ret;
 	ksft_print_msg("Cache size :%lu\n", cache_total_size);
@@ -257,7 +258,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 
 	struct resctrl_val_param param = {
 		.resctrl_val	= CAT_STR,
-		.cpu_no		= cpu_no,
+		.cpu_no		= uparams->cpu,
 		.ctrlgrp	= "c1",
 		.filename	= RESULT_FILE_NAME,
 		.num_of_runs	= 0,
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 702ea87cd473..f5561b79629f 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -94,11 +94,12 @@ void cmt_test_cleanup(void)
 	remove(RESULT_FILE_NAME);
 }
 
-int cmt_resctrl_val(int cpu_no, int n, const char * const *benchmark_cmd)
+int cmt_resctrl_val(const struct user_params *uparams)
 {
-	const char * const *cmd = benchmark_cmd;
+	const char * const *cmd = uparams->benchmark_cmd;
 	const char *new_cmd[BENCHMARK_ARGS];
 	unsigned long cache_total_size = 0;
+	int n = uparams->bits ? : 5;
 	unsigned long long_mask;
 	char *span_str = NULL;
 	int count_of_bits;
@@ -109,7 +110,7 @@ int cmt_resctrl_val(int cpu_no, int n, const char * const *benchmark_cmd)
 	if (ret)
 		return ret;
 
-	ret = get_cache_size(cpu_no, "L3", &cache_total_size);
+	ret = get_cache_size(uparams->cpu, "L3", &cache_total_size);
 	if (ret)
 		return ret;
 	ksft_print_msg("Cache size :%lu\n", cache_total_size);
@@ -126,7 +127,7 @@ int cmt_resctrl_val(int cpu_no, int n, const char * const *benchmark_cmd)
 		.resctrl_val	= CMT_STR,
 		.ctrlgrp	= "c1",
 		.mongrp		= "m1",
-		.cpu_no		= cpu_no,
+		.cpu_no		= uparams->cpu,
 		.filename	= RESULT_FILE_NAME,
 		.mask		= ~(long_mask << n) & long_mask,
 		.num_of_runs	= 0,
@@ -137,8 +138,8 @@ int cmt_resctrl_val(int cpu_no, int n, const char * const *benchmark_cmd)
 
 	if (strcmp(cmd[0], "fill_buf") == 0) {
 		/* Duplicate the command to be able to replace span in it */
-		for (i = 0; benchmark_cmd[i]; i++)
-			new_cmd[i] = benchmark_cmd[i];
+		for (i = 0; uparams->benchmark_cmd[i]; i++)
+			new_cmd[i] = uparams->benchmark_cmd[i];
 		new_cmd[i] = NULL;
 
 		ret = asprintf(&span_str, "%zu", span);
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index d3bf4368341e..5157a3f74fee 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -141,13 +141,13 @@ void mba_test_cleanup(void)
 	remove(RESULT_FILE_NAME);
 }
 
-int mba_schemata_change(int cpu_no, const char * const *benchmark_cmd)
+int mba_schemata_change(const struct user_params *uparams)
 {
 	struct resctrl_val_param param = {
 		.resctrl_val	= MBA_STR,
 		.ctrlgrp	= "c1",
 		.mongrp		= "m1",
-		.cpu_no		= cpu_no,
+		.cpu_no		= uparams->cpu,
 		.filename	= RESULT_FILE_NAME,
 		.bw_report	= "reads",
 		.setup		= mba_setup
@@ -156,7 +156,7 @@ int mba_schemata_change(int cpu_no, const char * const *benchmark_cmd)
 
 	remove(RESULT_FILE_NAME);
 
-	ret = resctrl_val(benchmark_cmd, &param);
+	ret = resctrl_val(uparams->benchmark_cmd, &param);
 	if (ret)
 		goto out;
 
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 741533f2b075..98df9d151941 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -109,13 +109,13 @@ void mbm_test_cleanup(void)
 	remove(RESULT_FILE_NAME);
 }
 
-int mbm_bw_change(int cpu_no, const char * const *benchmark_cmd)
+int mbm_bw_change(const struct user_params *uparams)
 {
 	struct resctrl_val_param param = {
 		.resctrl_val	= MBM_STR,
 		.ctrlgrp	= "c1",
 		.mongrp		= "m1",
-		.cpu_no		= cpu_no,
+		.cpu_no		= uparams->cpu,
 		.filename	= RESULT_FILE_NAME,
 		.bw_report	= "reads",
 		.setup		= mbm_setup
@@ -124,7 +124,7 @@ int mbm_bw_change(int cpu_no, const char * const *benchmark_cmd)
 
 	remove(RESULT_FILE_NAME);
 
-	ret = resctrl_val(benchmark_cmd, &param);
+	ret = resctrl_val(uparams->benchmark_cmd, &param);
 	if (ret)
 		goto out;
 
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 927f696e0ab7..ec6efd36f60a 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -45,6 +45,18 @@
 		exit(EXIT_FAILURE);		\
 	} while (0)
 
+/*
+ * user_params:		User supplied parameters
+ * @cpu:		CPU number to which the benchmark will be bound to
+ * @bits:		Number of bits used for cache allocation size
+ * @benchmark_cmd:	Benchmark command to run during (some of the) tests
+ */
+struct user_params {
+	int cpu;
+	int bits;
+	const char *benchmark_cmd[BENCHMARK_ARGS];
+};
+
 /*
  * resctrl_val_param:	resctrl test parameters
  * @resctrl_val:	Resctrl feature (Eg: mbm, mba.. etc)
@@ -104,10 +116,10 @@ void mem_flush(unsigned char *buf, size_t buf_size);
 int fill_cache_read(unsigned char *buf, size_t buf_size, bool once);
 int run_fill_buf(size_t buf_size, int memflush, int op, bool once);
 int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *param);
-int mbm_bw_change(int cpu_no, const char * const *benchmark_cmd);
+int mbm_bw_change(const struct user_params *uparams);
 void tests_cleanup(void);
 void mbm_test_cleanup(void);
-int mba_schemata_change(int cpu_no, const char * const *benchmark_cmd);
+int mba_schemata_change(const struct user_params *uparams);
 void mba_test_cleanup(void);
 unsigned long create_bit_mask(unsigned int start, unsigned int len);
 unsigned int count_contiguous_bits(unsigned long val, unsigned int *start);
@@ -119,8 +131,8 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int signal_handler_register(void);
 void signal_handler_unregister(void);
 void cat_test_cleanup(void);
-int cat_perf_miss_val(int cpu_no, int no_of_bits, char *cache_type);
-int cmt_resctrl_val(int cpu_no, int n, const char * const *benchmark_cmd);
+int cat_perf_miss_val(const struct user_params *uparams, char *cache_type);
+int cmt_resctrl_val(const struct user_params *uparams);
 unsigned int count_bits(unsigned long n);
 void cmt_test_cleanup(void);
 
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 2bbe3045a018..8e00ccc2b2f6 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -92,7 +92,7 @@ static void test_cleanup(void)
 	signal_handler_unregister();
 }
 
-static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
+static void run_mbm_test(const struct user_params *uparams)
 {
 	int res;
 
@@ -110,7 +110,7 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
 		goto cleanup;
 	}
 
-	res = mbm_bw_change(cpu_no, benchmark_cmd);
+	res = mbm_bw_change(uparams);
 	ksft_test_result(!res, "MBM: bw change\n");
 	if ((get_vendor() == ARCH_INTEL) && res)
 		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
@@ -119,7 +119,7 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
 	test_cleanup();
 }
 
-static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
+static void run_mba_test(const struct user_params *uparams)
 {
 	int res;
 
@@ -137,14 +137,14 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
 		goto cleanup;
 	}
 
-	res = mba_schemata_change(cpu_no, benchmark_cmd);
+	res = mba_schemata_change(uparams);
 	ksft_test_result(!res, "MBA: schemata change\n");
 
 cleanup:
 	test_cleanup();
 }
 
-static void run_cmt_test(const char * const *benchmark_cmd, int cpu_no)
+static void run_cmt_test(const struct user_params *uparams)
 {
 	int res;
 
@@ -161,7 +161,7 @@ static void run_cmt_test(const char * const *benchmark_cmd, int cpu_no)
 		goto cleanup;
 	}
 
-	res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
+	res = cmt_resctrl_val(uparams);
 	ksft_test_result(!res, "CMT: test\n");
 	if ((get_vendor() == ARCH_INTEL) && res)
 		ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
@@ -170,7 +170,7 @@ static void run_cmt_test(const char * const *benchmark_cmd, int cpu_no)
 	test_cleanup();
 }
 
-static void run_cat_test(int cpu_no, int no_of_bits)
+static void run_cat_test(const struct user_params *uparams)
 {
 	int res;
 
@@ -186,22 +186,29 @@ static void run_cat_test(int cpu_no, int no_of_bits)
 		goto cleanup;
 	}
 
-	res = cat_perf_miss_val(cpu_no, no_of_bits, "L3");
+	res = cat_perf_miss_val(uparams, "L3");
 	ksft_test_result(!res, "CAT: test\n");
 
 cleanup:
 	test_cleanup();
 }
 
+static void init_user_params(struct user_params *uparams)
+{
+	uparams->cpu = 1;
+	uparams->bits = 0;
+}
+
 int main(int argc, char **argv)
 {
 	bool mbm_test = true, mba_test = true, cmt_test = true;
-	const char *benchmark_cmd[BENCHMARK_ARGS] = {};
-	int c, cpu_no = 1, i, no_of_bits = 0;
+	struct user_params uparams = {};
 	char *span_str = NULL;
 	bool cat_test = true;
 	int tests = 0;
-	int ret;
+	int ret, c, i;
+
+	init_user_params(&uparams);
 
 	while ((c = getopt(argc, argv, "ht:b:n:p:")) != -1) {
 		char *token;
@@ -219,8 +226,8 @@ int main(int argc, char **argv)
 
 			/* Extract benchmark command from command line. */
 			for (i = 0; i < argc - optind; i++)
-				benchmark_cmd[i] = argv[i + optind];
-			benchmark_cmd[i] = NULL;
+				uparams.benchmark_cmd[i] = argv[i + optind];
+			uparams.benchmark_cmd[i] = NULL;
 
 			goto last_arg;
 		case 't':
@@ -252,11 +259,11 @@ int main(int argc, char **argv)
 			}
 			break;
 		case 'p':
-			cpu_no = atoi(optarg);
+			uparams.cpu = atoi(optarg);
 			break;
 		case 'n':
-			no_of_bits = atoi(optarg);
-			if (no_of_bits <= 0) {
+			uparams.bits = atoi(optarg);
+			if (uparams.bits <= 0) {
 				printf("Bail out! invalid argument for no_of_bits\n");
 				return -1;
 			}
@@ -291,32 +298,32 @@ int main(int argc, char **argv)
 
 	filter_dmesg();
 
-	if (!benchmark_cmd[0]) {
+	if (!uparams.benchmark_cmd[0]) {
 		/* If no benchmark is given by "-b" argument, use fill_buf. */
-		benchmark_cmd[0] = "fill_buf";
+		uparams.benchmark_cmd[0] = "fill_buf";
 		ret = asprintf(&span_str, "%u", DEFAULT_SPAN);
 		if (ret < 0)
 			ksft_exit_fail_msg("Out of memory!\n");
-		benchmark_cmd[1] = span_str;
-		benchmark_cmd[2] = "1";
-		benchmark_cmd[3] = "0";
-		benchmark_cmd[4] = "false";
-		benchmark_cmd[5] = NULL;
+		uparams.benchmark_cmd[1] = span_str;
+		uparams.benchmark_cmd[2] = "1";
+		uparams.benchmark_cmd[3] = "0";
+		uparams.benchmark_cmd[4] = "false";
+		uparams.benchmark_cmd[5] = NULL;
 	}
 
 	ksft_set_plan(tests ? : 4);
 
 	if (mbm_test)
-		run_mbm_test(benchmark_cmd, cpu_no);
+		run_mbm_test(&uparams);
 
 	if (mba_test)
-		run_mba_test(benchmark_cmd, cpu_no);
+		run_mba_test(&uparams);
 
 	if (cmt_test)
-		run_cmt_test(benchmark_cmd, cpu_no);
+		run_cmt_test(&uparams);
 
 	if (cat_test)
-		run_cat_test(cpu_no, no_of_bits);
+		run_cat_test(&uparams);
 
 	free(span_str);
 	ksft_finished();
-- 
2.30.2

