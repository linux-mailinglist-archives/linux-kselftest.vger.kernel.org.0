Return-Path: <linux-kselftest+bounces-315-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A52C7F119D
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 12:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D5601C20DD7
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 11:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7191413AFF;
	Mon, 20 Nov 2023 11:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e9Pa3ajo"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 903831FEB;
	Mon, 20 Nov 2023 03:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700479005; x=1732015005;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P+dk+mm+GrimIYLcKEV5c9KU0roEdXldktTCbjWtTYA=;
  b=e9Pa3ajoWpve5Un/WXbQgCpNNlNCfUJGL+A8ygexXGgptKpuyRnO3gJP
   UrrOLlldAhHfIuNbdCTwAXqOaJ2zzu0HeHeX1qj7hGs+xWHVxtKn1LCg6
   Wy4nVPNzpA10rlmGIoUFqt+JPBvBOxiapwwb5S709c2T4QZBdaQhNey+0
   a97dZypO+/VNveikE8Fp/iCz3iGAxrxoSwquJF79T17TedcFL8DoXbb+5
   Uj4gJCfjNL2a0MzmKW535bBuC2pHwZbolxUNlSh1n0OjebPy0e6CxL+ru
   2u/Zc0Ai+5mOcoyksdbcTQit9N58NazV70JqSjWzmRizYNnfIISwesTpX
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="394447312"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="394447312"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:16:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="7681750"
Received: from sc9itsct4906.amr.corp.intel.com (HELO localhost) ([10.249.46.107])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:16:39 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 20/26] selftests/resctrl: Create struct for input parameters
Date: Mon, 20 Nov 2023 13:13:34 +0200
Message-Id: <20231120111340.7805-21-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
References: <20231120111340.7805-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

resctrl_tests reads a set of parameters and passes them individually
for each tests which causes variations in the call signature between
the tests.

Add struct input_params to hold all input parameters. It can be easily
passed to every test without varying the call signature.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c    | 20 +++---
 tools/testing/selftests/resctrl/cmt_test.c    | 16 ++---
 tools/testing/selftests/resctrl/mba_test.c    |  9 ++-
 tools/testing/selftests/resctrl/mbm_test.c    |  9 ++-
 tools/testing/selftests/resctrl/resctrl.h     | 28 ++++++---
 .../testing/selftests/resctrl/resctrl_tests.c | 61 +++++++++++--------
 tools/testing/selftests/resctrl/resctrl_val.c | 21 ++++---
 7 files changed, 93 insertions(+), 71 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 4169b17b8f91..3cc75ca74036 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -134,6 +134,7 @@ void cat_test_cleanup(void)
 
 /*
  * cat_test - Execute CAT benchmark and measure cache misses
+ * @uparams:		User supplied parameters
  * @param:		Parameters passed to cat_test()
  * @span:		Buffer size for the benchmark
  * @current_mask	Start mask for the first iteration
@@ -150,7 +151,8 @@ void cat_test_cleanup(void)
  *
  * Return:		0 on success. Non-zero on failure.
  */
-static int cat_test(struct resctrl_val_param *param, size_t span, unsigned long current_mask)
+static int cat_test(const struct user_params *uparams, struct resctrl_val_param *param,
+		    size_t span, unsigned long current_mask)
 {
 	char *resctrl_val = param->resctrl_val;
 	struct perf_event_read pe_read;
@@ -166,7 +168,7 @@ static int cat_test(struct resctrl_val_param *param, size_t span, unsigned long
 	bm_pid = getpid();
 
 	/* Taskset benchmark to specified cpu */
-	ret = taskset_benchmark(bm_pid, param->cpu_no);
+	ret = taskset_benchmark(bm_pid, uparams->cpu);
 	if (ret)
 		return ret;
 
@@ -178,7 +180,7 @@ static int cat_test(struct resctrl_val_param *param, size_t span, unsigned long
 
 	perf_event_attr_initialize(&pea, PERF_COUNT_HW_CACHE_MISSES);
 	perf_event_initialize_read_format(&pe_read);
-	pe_fd = perf_open(&pea, bm_pid, param->cpu_no);
+	pe_fd = perf_open(&pea, bm_pid, uparams->cpu);
 	if (pe_fd < 0)
 		return pe_fd;
 
@@ -190,11 +192,11 @@ static int cat_test(struct resctrl_val_param *param, size_t span, unsigned long
 
 	while (current_mask) {
 		snprintf(schemata, sizeof(schemata), "%lx", param->mask & ~current_mask);
-		ret = write_schemata("", schemata, param->cpu_no, param->resctrl_val);
+		ret = write_schemata("", schemata, uparams->cpu, param->resctrl_val);
 		if (ret)
 			goto free_buf;
 		snprintf(schemata, sizeof(schemata), "%lx", current_mask);
-		ret = write_schemata(param->ctrlgrp, schemata, param->cpu_no, param->resctrl_val);
+		ret = write_schemata(param->ctrlgrp, schemata, uparams->cpu, param->resctrl_val);
 		if (ret)
 			goto free_buf;
 
@@ -223,10 +225,11 @@ static int cat_test(struct resctrl_val_param *param, size_t span, unsigned long
 	return ret;
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
@@ -241,7 +244,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		return ret;
 
 	/* Get L3/L2 cache size */
-	ret = get_cache_size(cpu_no, cache_type, &cache_total_size);
+	ret = get_cache_size(uparams->cpu, cache_type, &cache_total_size);
 	if (ret)
 		return ret;
 	ksft_print_msg("Cache size :%lu\n", cache_total_size);
@@ -261,7 +264,6 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 
 	struct resctrl_val_param param = {
 		.resctrl_val	= CAT_STR,
-		.cpu_no		= cpu_no,
 		.ctrlgrp	= "c1",
 		.filename	= RESULT_FILE_NAME,
 		.num_of_runs	= 0,
@@ -271,7 +273,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 
 	remove(param.filename);
 
-	ret = cat_test(&param, span, start_mask);
+	ret = cat_test(uparams, &param, span, start_mask);
 	if (ret)
 		goto out;
 
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 4573a99d87b5..73c8f3013235 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -16,7 +16,7 @@
 #define MAX_DIFF		2000000
 #define MAX_DIFF_PERCENT	15
 
-static int cmt_setup(struct resctrl_val_param *p)
+static int cmt_setup(const struct user_params *uparams, struct resctrl_val_param *p)
 {
 	/* Run NUM_OF_RUNS times */
 	if (p->num_of_runs >= NUM_OF_RUNS)
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
@@ -126,7 +127,6 @@ int cmt_resctrl_val(int cpu_no, int n, const char * const *benchmark_cmd)
 		.resctrl_val	= CMT_STR,
 		.ctrlgrp	= "c1",
 		.mongrp		= "m1",
-		.cpu_no		= cpu_no,
 		.filename	= RESULT_FILE_NAME,
 		.mask		= ~(long_mask << n) & long_mask,
 		.num_of_runs	= 0,
@@ -137,8 +137,8 @@ int cmt_resctrl_val(int cpu_no, int n, const char * const *benchmark_cmd)
 
 	if (strcmp(cmd[0], "fill_buf") == 0) {
 		/* Duplicate the command to be able to replace span in it */
-		for (i = 0; benchmark_cmd[i]; i++)
-			new_cmd[i] = benchmark_cmd[i];
+		for (i = 0; uparams->benchmark_cmd[i]; i++)
+			new_cmd[i] = uparams->benchmark_cmd[i];
 		new_cmd[i] = NULL;
 
 		ret = asprintf(&span_str, "%zu", span);
@@ -150,7 +150,7 @@ int cmt_resctrl_val(int cpu_no, int n, const char * const *benchmark_cmd)
 
 	remove(RESULT_FILE_NAME);
 
-	ret = resctrl_val(cmd, &param);
+	ret = resctrl_val(uparams, cmd, &param);
 	if (ret)
 		goto out;
 
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index d3bf4368341e..f669a0d97de8 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -22,7 +22,7 @@
  * con_mon grp, mon_grp in resctrl FS.
  * For each allocation, run 5 times in order to get average values.
  */
-static int mba_setup(struct resctrl_val_param *p)
+static int mba_setup(const struct user_params *uparams, struct resctrl_val_param *p)
 {
 	static int runs_per_allocation, allocation = 100;
 	char allocation_str[64];
@@ -40,7 +40,7 @@ static int mba_setup(struct resctrl_val_param *p)
 
 	sprintf(allocation_str, "%d", allocation);
 
-	ret = write_schemata(p->ctrlgrp, allocation_str, p->cpu_no,
+	ret = write_schemata(p->ctrlgrp, allocation_str, uparams->cpu,
 			     p->resctrl_val);
 	if (ret < 0)
 		return ret;
@@ -141,13 +141,12 @@ void mba_test_cleanup(void)
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
 		.filename	= RESULT_FILE_NAME,
 		.bw_report	= "reads",
 		.setup		= mba_setup
@@ -156,7 +155,7 @@ int mba_schemata_change(int cpu_no, const char * const *benchmark_cmd)
 
 	remove(RESULT_FILE_NAME);
 
-	ret = resctrl_val(benchmark_cmd, &param);
+	ret = resctrl_val(uparams, uparams->benchmark_cmd, &param);
 	if (ret)
 		goto out;
 
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 741533f2b075..7d25ca98c61a 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -86,7 +86,7 @@ static int check_results(size_t span)
 	return ret;
 }
 
-static int mbm_setup(struct resctrl_val_param *p)
+static int mbm_setup(const struct user_params *uparams, struct resctrl_val_param *p)
 {
 	int ret = 0;
 
@@ -96,7 +96,7 @@ static int mbm_setup(struct resctrl_val_param *p)
 
 	/* Set up shemata with 100% allocation on the first run. */
 	if (p->num_of_runs == 0 && validate_resctrl_feature_request("MB", NULL))
-		ret = write_schemata(p->ctrlgrp, "100", p->cpu_no,
+		ret = write_schemata(p->ctrlgrp, "100", uparams->cpu,
 				     p->resctrl_val);
 
 	p->num_of_runs++;
@@ -109,13 +109,12 @@ void mbm_test_cleanup(void)
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
 		.filename	= RESULT_FILE_NAME,
 		.bw_report	= "reads",
 		.setup		= mbm_setup
@@ -124,7 +123,7 @@ int mbm_bw_change(int cpu_no, const char * const *benchmark_cmd)
 
 	remove(RESULT_FILE_NAME);
 
-	ret = resctrl_val(benchmark_cmd, &param);
+	ret = resctrl_val(uparams, uparams->benchmark_cmd, &param);
 	if (ret)
 		goto out;
 
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 0f072a0346d7..e61e11ba6a55 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -45,12 +45,23 @@
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
  * @ctrlgrp:		Name of the control monitor group (con_mon grp)
  * @mongrp:		Name of the monitor group (mon grp)
- * @cpu_no:		CPU number to which the benchmark would be binded
  * @filename:		Name of file to which the o/p should be written
  * @bw_report:		Bandwidth report type (reads vs writes)
  * @setup:		Call back function to setup test environment
@@ -59,12 +70,12 @@ struct resctrl_val_param {
 	char		*resctrl_val;
 	char		ctrlgrp[64];
 	char		mongrp[64];
-	int		cpu_no;
 	char		filename[64];
 	char		*bw_report;
 	unsigned long	mask;
 	int		num_of_runs;
-	int		(*setup)(struct resctrl_val_param *param);
+	int		(*setup)(const struct user_params *uparams,
+				 struct resctrl_val_param *param);
 };
 
 struct perf_event_read {
@@ -110,11 +121,12 @@ unsigned char *alloc_buffer(size_t buf_size, int memflush);
 void mem_flush(unsigned char *buf, size_t buf_size);
 void fill_cache_read(unsigned char *buf, size_t buf_size, bool once);
 int run_fill_buf(size_t buf_size, int memflush, int op, bool once);
-int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *param);
-int mbm_bw_change(int cpu_no, const char * const *benchmark_cmd);
+int resctrl_val(const struct user_params *uparams, const char * const *benchmark_cmd,
+		struct resctrl_val_param *param);
+int mbm_bw_change(const struct user_params *uparams);
 void tests_cleanup(void);
 void mbm_test_cleanup(void);
-int mba_schemata_change(int cpu_no, const char * const *benchmark_cmd);
+int mba_schemata_change(const struct user_params *uparams);
 void mba_test_cleanup(void);
 unsigned long create_bit_mask(unsigned int start, unsigned int len);
 unsigned int count_contiguous_bits(unsigned long val, unsigned int *start);
@@ -126,8 +138,8 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
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
index f0d573aa363b..f7f11415cc85 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -96,7 +96,7 @@ static void test_cleanup(void)
 	signal_handler_unregister();
 }
 
-static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
+static void run_mbm_test(const struct user_params *uparams)
 {
 	int res;
 
@@ -114,7 +114,7 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
 		goto cleanup;
 	}
 
-	res = mbm_bw_change(cpu_no, benchmark_cmd);
+	res = mbm_bw_change(uparams);
 	ksft_test_result(!res, "MBM: bw change\n");
 	if ((get_vendor() == ARCH_INTEL) && res)
 		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
@@ -123,7 +123,7 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
 	test_cleanup();
 }
 
-static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
+static void run_mba_test(const struct user_params *uparams)
 {
 	int res;
 
@@ -141,14 +141,14 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
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
 
@@ -165,7 +165,7 @@ static void run_cmt_test(const char * const *benchmark_cmd, int cpu_no)
 		goto cleanup;
 	}
 
-	res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
+	res = cmt_resctrl_val(uparams);
 	ksft_test_result(!res, "CMT: test\n");
 	if ((get_vendor() == ARCH_INTEL) && res)
 		ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
@@ -174,7 +174,7 @@ static void run_cmt_test(const char * const *benchmark_cmd, int cpu_no)
 	test_cleanup();
 }
 
-static void run_cat_test(int cpu_no, int no_of_bits)
+static void run_cat_test(const struct user_params *uparams)
 {
 	int res;
 
@@ -190,22 +190,29 @@ static void run_cat_test(int cpu_no, int no_of_bits)
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
@@ -223,8 +230,8 @@ int main(int argc, char **argv)
 
 			/* Extract benchmark command from command line. */
 			for (i = 0; i < argc - optind; i++)
-				benchmark_cmd[i] = argv[i + optind];
-			benchmark_cmd[i] = NULL;
+				uparams.benchmark_cmd[i] = argv[i + optind];
+			uparams.benchmark_cmd[i] = NULL;
 
 			goto last_arg;
 		case 't':
@@ -256,11 +263,11 @@ int main(int argc, char **argv)
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
@@ -295,32 +302,32 @@ int main(int argc, char **argv)
 
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
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index a07ba336db48..24bf91cfdb21 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -593,8 +593,9 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
 		set_cmt_path(ctrlgrp, mongrp, resource_id);
 }
 
-static int
-measure_vals(struct resctrl_val_param *param, unsigned long *bw_resc_start)
+static int measure_vals(const struct user_params *uparams,
+			struct resctrl_val_param *param,
+			unsigned long *bw_resc_start)
 {
 	unsigned long bw_resc, bw_resc_end;
 	float bw_imc;
@@ -607,7 +608,7 @@ measure_vals(struct resctrl_val_param *param, unsigned long *bw_resc_start)
 	 * Compare the two values to validate resctrl value.
 	 * It takes 1sec to measure the data.
 	 */
-	ret = get_mem_bw_imc(param->cpu_no, param->bw_report, &bw_imc);
+	ret = get_mem_bw_imc(uparams->cpu, param->bw_report, &bw_imc);
 	if (ret < 0)
 		return ret;
 
@@ -678,12 +679,14 @@ static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 /*
  * resctrl_val:	execute benchmark and measure memory bandwidth on
  *			the benchmark
+ * @uparams:		user supplied parameters
  * @benchmark_cmd:	benchmark command and its arguments
  * @param:		parameters passed to resctrl_val()
  *
  * Return:		0 on success. non-zero on failure.
  */
-int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *param)
+int resctrl_val(const struct user_params *uparams, const char * const *benchmark_cmd,
+		struct resctrl_val_param *param)
 {
 	char *resctrl_val = param->resctrl_val;
 	unsigned long bw_resc_start = 0;
@@ -769,7 +772,7 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
 	value.sival_ptr = (void *)benchmark_cmd;
 
 	/* Taskset benchmark to specified cpu */
-	ret = taskset_benchmark(bm_pid, param->cpu_no);
+	ret = taskset_benchmark(bm_pid, uparams->cpu);
 	if (ret)
 		goto out;
 
@@ -786,10 +789,10 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
 			goto out;
 
 		initialize_mem_bw_resctrl(param->ctrlgrp, param->mongrp,
-					  param->cpu_no, resctrl_val);
+					  uparams->cpu, resctrl_val);
 	} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
 		initialize_llc_occu_resctrl(param->ctrlgrp, param->mongrp,
-					    param->cpu_no, resctrl_val);
+					    uparams->cpu, resctrl_val);
 
 	/* Parent waits for child to be ready. */
 	close(pipefd[1]);
@@ -815,7 +818,7 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
 
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
-		ret = param->setup(param);
+		ret = param->setup(uparams, param);
 		if (ret == END_OF_TESTS) {
 			ret = 0;
 			break;
@@ -825,7 +828,7 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
 
 		if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
 		    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
-			ret = measure_vals(param, &bw_resc_start);
+			ret = measure_vals(uparams, param, &bw_resc_start);
 			if (ret)
 				break;
 		} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
-- 
2.30.2


