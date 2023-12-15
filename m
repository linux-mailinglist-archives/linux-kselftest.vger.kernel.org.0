Return-Path: <linux-kselftest+bounces-2060-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F06814B55
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 16:11:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D181928ABCA
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 15:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038373A8C9;
	Fri, 15 Dec 2023 15:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QRlXiDQv"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E315E3FE43;
	Fri, 15 Dec 2023 15:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702652954; x=1734188954;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eba6jR0NTVAAqah4Ka1IihPesj4STMtaUmXU2ATgFgY=;
  b=QRlXiDQvDk5G2JBAyNxvtGJKBos0FIzI4+Y+sJQf6naLD1FvUmVtdbHm
   nhCUSLxnfC5avSXXR/DX7UcsKeIF6A4KFX/YTqiRZNasVyjCxAoXaE5+1
   W0F+TTa+HWWgUyhlhy0ObpjljZhOwnyFWdfSmaKLB3eFMpl9dV+bbVqSJ
   viYQTEvBW8E+pdg2G8kvxNhlzQPn8o7BWpegez6YeRCyejoZ9+LOiqfQA
   lI+O0d4oL5Wbmu8p6MoRz0Ptwz3focc7h9p+57vPU03uUbzfrwSVKZaqQ
   5XLbcHr/L1a6maqfS8co73ceqeOskTyuCTRLirpM+QBxQ1ZUMksu8x7DM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="392461714"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="392461714"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:09:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="1106151058"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="1106151058"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.49.116])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:09:10 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 24/29] selftests/resctrl: Create struct for input parameters
Date: Fri, 15 Dec 2023 17:05:10 +0200
Message-Id: <20231215150515.36983-25-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231215150515.36983-1-ilpo.jarvinen@linux.intel.com>
References: <20231215150515.36983-1-ilpo.jarvinen@linux.intel.com>
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
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---

v3:
- Move uparams clear into init function
---
 tools/testing/selftests/resctrl/cat_test.c    | 20 +++---
 tools/testing/selftests/resctrl/cmt_test.c    | 16 ++---
 tools/testing/selftests/resctrl/mba_test.c    |  9 ++-
 tools/testing/selftests/resctrl/mbm_test.c    |  9 ++-
 tools/testing/selftests/resctrl/resctrl.h     | 28 ++++++---
 .../testing/selftests/resctrl/resctrl_tests.c | 63 +++++++++++--------
 tools/testing/selftests/resctrl/resctrl_val.c | 21 ++++---
 7 files changed, 95 insertions(+), 71 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index fa95433297c9..272132ff7337 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -135,6 +135,7 @@ void cat_test_cleanup(void)
 
 /*
  * cat_test - Execute CAT benchmark and measure cache misses
+ * @uparams:		User supplied parameters
  * @param:		Parameters passed to cat_test()
  * @span:		Buffer size for the benchmark
  * @current_mask	Start mask for the first iteration
@@ -151,7 +152,8 @@ void cat_test_cleanup(void)
  *
  * Return:		0 when the test was run, < 0 on error.
  */
-static int cat_test(struct resctrl_val_param *param, size_t span, unsigned long current_mask)
+static int cat_test(const struct user_params *uparams, struct resctrl_val_param *param,
+		    size_t span, unsigned long current_mask)
 {
 	char *resctrl_val = param->resctrl_val;
 	struct perf_event_read pe_read;
@@ -168,7 +170,7 @@ static int cat_test(struct resctrl_val_param *param, size_t span, unsigned long
 	bm_pid = getpid();
 
 	/* Taskset benchmark to specified cpu */
-	ret = taskset_benchmark(bm_pid, param->cpu_no, &old_affinity);
+	ret = taskset_benchmark(bm_pid, uparams->cpu, &old_affinity);
 	if (ret)
 		return ret;
 
@@ -180,7 +182,7 @@ static int cat_test(struct resctrl_val_param *param, size_t span, unsigned long
 
 	perf_event_attr_initialize(&pea, PERF_COUNT_HW_CACHE_MISSES);
 	perf_event_initialize_read_format(&pe_read);
-	pe_fd = perf_open(&pea, bm_pid, param->cpu_no);
+	pe_fd = perf_open(&pea, bm_pid, uparams->cpu);
 	if (pe_fd < 0) {
 		ret = -1;
 		goto reset_affinity;
@@ -194,11 +196,11 @@ static int cat_test(struct resctrl_val_param *param, size_t span, unsigned long
 
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
 
@@ -229,10 +231,11 @@ static int cat_test(struct resctrl_val_param *param, size_t span, unsigned long
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
@@ -247,7 +250,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		return ret;
 
 	/* Get L3/L2 cache size */
-	ret = get_cache_size(cpu_no, cache_type, &cache_total_size);
+	ret = get_cache_size(uparams->cpu, cache_type, &cache_total_size);
 	if (ret)
 		return ret;
 	ksft_print_msg("Cache size :%lu\n", cache_total_size);
@@ -267,7 +270,6 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 
 	struct resctrl_val_param param = {
 		.resctrl_val	= CAT_STR,
-		.cpu_no		= cpu_no,
 		.ctrlgrp	= "c1",
 		.filename	= RESULT_FILE_NAME,
 		.num_of_runs	= 0,
@@ -277,7 +279,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 
 	remove(param.filename);
 
-	ret = cat_test(&param, span, start_mask);
+	ret = cat_test(uparams, &param, span, start_mask);
 	if (ret)
 		goto out;
 
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 604690cd8b3e..a5d0c0878c42 100644
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
index e907adf7cd25..8e54bc508a75 100644
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
index 721b3ecbc158..ea951cfae5fe 100644
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
index 94347acafe55..199ba91a78f7 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -44,12 +44,23 @@
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
@@ -58,12 +69,12 @@ struct resctrl_val_param {
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
@@ -125,8 +137,8 @@ void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
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
index f0d573aa363b..3059a124ac59 100644
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
 
@@ -190,22 +190,31 @@ static void run_cat_test(int cpu_no, int no_of_bits)
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
+	memset(uparams, 0, sizeof(*uparams));
+
+	uparams->cpu = 1;
+	uparams->bits = 0;
+}
+
 int main(int argc, char **argv)
 {
 	bool mbm_test = true, mba_test = true, cmt_test = true;
-	const char *benchmark_cmd[BENCHMARK_ARGS] = {};
-	int c, cpu_no = 1, i, no_of_bits = 0;
+	struct user_params uparams;
 	char *span_str = NULL;
 	bool cat_test = true;
 	int tests = 0;
-	int ret;
+	int ret, c, i;
+
+	init_user_params(&uparams);
 
 	while ((c = getopt(argc, argv, "ht:b:n:p:")) != -1) {
 		char *token;
@@ -223,8 +232,8 @@ int main(int argc, char **argv)
 
 			/* Extract benchmark command from command line. */
 			for (i = 0; i < argc - optind; i++)
-				benchmark_cmd[i] = argv[i + optind];
-			benchmark_cmd[i] = NULL;
+				uparams.benchmark_cmd[i] = argv[i + optind];
+			uparams.benchmark_cmd[i] = NULL;
 
 			goto last_arg;
 		case 't':
@@ -256,11 +265,11 @@ int main(int argc, char **argv)
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
@@ -295,32 +304,32 @@ int main(int argc, char **argv)
 
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
index 6574a13f3919..6d0a35e8bd02 100644
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
 
@@ -683,12 +684,14 @@ static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 /*
  * resctrl_val:	execute benchmark and measure memory bandwidth on
  *			the benchmark
+ * @uparams:		user supplied parameters
  * @benchmark_cmd:	benchmark command and its arguments
  * @param:		parameters passed to resctrl_val()
  *
  * Return:		0 when the test was run, < 0 on error.
  */
-int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *param)
+int resctrl_val(const struct user_params *uparams, const char * const *benchmark_cmd,
+		struct resctrl_val_param *param)
 {
 	char *resctrl_val = param->resctrl_val;
 	unsigned long bw_resc_start = 0;
@@ -777,7 +780,7 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
 	value.sival_ptr = (void *)benchmark_cmd;
 
 	/* Taskset benchmark to specified cpu */
-	ret = taskset_benchmark(bm_pid, param->cpu_no, NULL);
+	ret = taskset_benchmark(bm_pid, uparams->cpu, NULL);
 	if (ret)
 		goto out;
 
@@ -794,10 +797,10 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
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
@@ -823,7 +826,7 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
 
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
-		ret = param->setup(param);
+		ret = param->setup(uparams, param);
 		if (ret == END_OF_TESTS) {
 			ret = 0;
 			break;
@@ -833,7 +836,7 @@ int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *par
 
 		if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
 		    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
-			ret = measure_vals(param, &bw_resc_start);
+			ret = measure_vals(uparams, param, &bw_resc_start);
 			if (ret)
 				break;
 		} else if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
-- 
2.30.2


