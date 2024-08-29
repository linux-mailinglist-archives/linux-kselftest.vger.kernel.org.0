Return-Path: <linux-kselftest+bounces-16747-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F339C965330
	for <lists+linux-kselftest@lfdr.de>; Fri, 30 Aug 2024 00:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2D41F213AA
	for <lists+linux-kselftest@lfdr.de>; Thu, 29 Aug 2024 22:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D053E1BE859;
	Thu, 29 Aug 2024 22:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S8elLQgz"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5DAF1BE23C;
	Thu, 29 Aug 2024 22:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724971964; cv=none; b=d+Q2x3iv7FQoOEo9n8uBA6JXRgo9dRJxwkasaqyw68pz2ZGzLo+UK6JpE2RuH25pKvP6QhraeBbrz1HvdxzcBKI2W1cmgM/gEkcxIr5ZKR7g9aM7lrrk65R19NiS769ZAej4Jgy5kkpxN7ruL9VpACXMTAfCVXfwX614tAT3Ovk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724971964; c=relaxed/simple;
	bh=aqlSuxz4AFaQXCpMSDXNV0hpsqTQBg2lF8eW+Et3apw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJ1Qphum2bBUt8F6bDGqEENZeVL0CKUyVjD6YyzDeA4pSCF8sFasAlohebbfKJnbWxAai34PJesw0bsjDAPpjQjg8noWpL5WlsEqYtWXoqxmLF5+vltqyWnJerc1J3MMHH2hpx0tptyW/TgVJTmpaTEP7ouREAi0SXJF+cqRD0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S8elLQgz; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724971963; x=1756507963;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aqlSuxz4AFaQXCpMSDXNV0hpsqTQBg2lF8eW+Et3apw=;
  b=S8elLQgzisJYV6G7Hm0Cr9/tCytOtaMaC6uw9FS6qY/s0VlKcet6D+WN
   rxQEXp93groEgXFzZQgnpaapkwjqDhd/psFVCXB4ahIdDFruYNZKtVcK3
   OyekL4E7ukbGSK/KkAUvFsLUlXziFfnsZQEVMo/cMS7ErchIC2gIb/5lQ
   BaCX6M9RYAeGg+XAPWLrCvoyjVsnzaSmgiscHZ9guOjX2V0IA0BFEzeDz
   1PaPY29+Cb2YmesBgz7bEQUUviVIAVG8XHo09T+unULk4DQlk3f7Fg77W
   WKZ3YT+xzijEe/RxE2rsSM+cEMIAtwrtZiqvTqll0pmzAXQMgG1DDWKXJ
   w==;
X-CSE-ConnectionGUID: 7ZENxrSHTU6XR+VUnDwlWQ==
X-CSE-MsgGUID: 7EfpcUh4SMmuq9TluBvUrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="27479164"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="27479164"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 15:52:40 -0700
X-CSE-ConnectionGUID: PZB3zBKERJeCE8hBoWxD2Q==
X-CSE-MsgGUID: oI2Ya5xYS52NSPtxITApjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="63415135"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO rchatre-mobl4.intel.com) ([10.125.111.220])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 15:52:39 -0700
From: Reinette Chatre <reinette.chatre@intel.com>
To: fenghua.yu@intel.com,
	shuah@kernel.org,
	tony.luck@intel.com,
	peternewman@google.com,
	babu.moger@amd.com,
	ilpo.jarvinen@linux.intel.com
Cc: maciej.wieczor-retman@intel.com,
	reinette.chatre@intel.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] selftests/resctrl: Simplify benchmark parameter passing
Date: Thu, 29 Aug 2024 15:52:29 -0700
Message-ID: <fdedc12d44db62d85d1345e35a133983ed0af1ac.1724970211.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1724970211.git.reinette.chatre@intel.com>
References: <cover.1724970211.git.reinette.chatre@intel.com>
Precedence: bulk
X-Mailing-List: linux-kselftest@vger.kernel.org
List-Id: <linux-kselftest.vger.kernel.org>
List-Subscribe: <mailto:linux-kselftest+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kselftest+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The benchmark used during the CMT, MBM, and MBA tests can be provided by
the user via (-b) parameter to the tests, if not provided the default
"fill_buf" benchmark is used.

The "fill_buf" benchmark requires parameters and these are managed as
an array of strings.

Using an array of strings to manage the "fill_buf" parameters is
complex because it requires transformations to/from strings at every
producer and consumer. This is made worse for the individual tests
where the default benchmark parameters values may not be appropriate and
additional data wrangling is required. For example, the CMT test
duplicates the entire array of strings in order to replace one of
the parameters.

Replace the "array of strings" parameters used for "fill_buf" with a
struct that contains the "fill_buf" parameters that can be used directly
without transformations to/from strings. Make these parameters
part of the parameters associated with each test so that each test can
set benchmark parameters that are appropriate for it.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/resctrl/cmt_test.c    | 28 +++--------
 tools/testing/selftests/resctrl/mba_test.c    |  7 ++-
 tools/testing/selftests/resctrl/mbm_test.c    |  9 +++-
 tools/testing/selftests/resctrl/resctrl.h     | 49 +++++++++++++------
 .../testing/selftests/resctrl/resctrl_tests.c | 15 +-----
 tools/testing/selftests/resctrl/resctrl_val.c | 38 +++++---------
 6 files changed, 69 insertions(+), 77 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 0c045080d808..f09d5dfab38c 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -116,15 +116,12 @@ static void cmt_test_cleanup(void)
 
 static int cmt_run_test(const struct resctrl_test *test, const struct user_params *uparams)
 {
-	const char * const *cmd = uparams->benchmark_cmd;
-	const char *new_cmd[BENCHMARK_ARGS];
 	unsigned long cache_total_size = 0;
 	int n = uparams->bits ? : 5;
 	unsigned long long_mask;
-	char *span_str = NULL;
 	int count_of_bits;
 	size_t span;
-	int ret, i;
+	int ret;
 
 	ret = get_full_cbm("L3", &long_mask);
 	if (ret)
@@ -155,32 +152,21 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
 
 	span = cache_portion_size(cache_total_size, param.mask, long_mask);
 
-	if (strcmp(cmd[0], "fill_buf") == 0) {
-		/* Duplicate the command to be able to replace span in it */
-		for (i = 0; uparams->benchmark_cmd[i]; i++)
-			new_cmd[i] = uparams->benchmark_cmd[i];
-		new_cmd[i] = NULL;
-
-		ret = asprintf(&span_str, "%zu", span);
-		if (ret < 0)
-			return -1;
-		new_cmd[1] = span_str;
-		cmd = new_cmd;
-	}
+	param.fill_buf.buf_size = span;
+	param.fill_buf.memflush = 1;
+	param.fill_buf.operation = 0;
+	param.fill_buf.once = false;
 
 	remove(RESULT_FILE_NAME);
 
-	ret = resctrl_val(test, uparams, cmd, &param);
+	ret = resctrl_val(test, uparams, &param);
 	if (ret)
-		goto out;
+		return ret;
 
 	ret = check_results(&param, span, n);
 	if (ret && (get_vendor() == ARCH_INTEL))
 		ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
 
-out:
-	free(span_str);
-
 	return ret;
 }
 
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index ab8496a4925b..8ad433495f61 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -174,7 +174,12 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
 
 	remove(RESULT_FILE_NAME);
 
-	ret = resctrl_val(test, uparams, uparams->benchmark_cmd, &param);
+	param.fill_buf.buf_size = DEFAULT_SPAN;
+	param.fill_buf.memflush = 1;
+	param.fill_buf.operation = 0;
+	param.fill_buf.once = false;
+
+	ret = resctrl_val(test, uparams, &param);
 	if (ret)
 		return ret;
 
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 6b5a3b52d861..b6883f274c74 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -142,11 +142,16 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
 
 	remove(RESULT_FILE_NAME);
 
-	ret = resctrl_val(test, uparams, uparams->benchmark_cmd, &param);
+	param.fill_buf.buf_size = DEFAULT_SPAN;
+	param.fill_buf.memflush = 1;
+	param.fill_buf.operation = 0;
+	param.fill_buf.once = false;
+
+	ret = resctrl_val(test, uparams, &param);
 	if (ret)
 		return ret;
 
-	ret = check_results(DEFAULT_SPAN);
+	ret = check_results(param.fill_buf.buf_size);
 	if (ret && (get_vendor() == ARCH_INTEL))
 		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
 
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 0afbc4dd18e4..0e5456165a6a 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -79,6 +79,26 @@ struct resctrl_test {
 	void		(*cleanup)(void);
 };
 
+/*
+ * fill_buf_param:	"fill_buf" benchmark parameters
+ * @buf_size:		Size (in bytes) of buffer used in benchmark.
+ *			"fill_buf" allocates and initializes buffer of
+ *			@buf_size.
+ * @operation:		If 0, then only read operations are performed on
+ *			the buffer, if 1 then only write operations are
+ *			performed on the buffer.
+ * @memflush:		1 if buffer should be flushed after
+ *			allocation and initialization.
+ * @once:		Benchmark will perform @operation once if true,
+ *			infinitely (until terminated) if false.
+ */
+struct fill_buf_param {
+	size_t		buf_size;
+	int		operation;
+	int		memflush;
+	int		once;
+};
+
 /*
  * resctrl_val_param:	resctrl test parameters
  * @ctrlgrp:		Name of the control monitor group (con_mon grp)
@@ -87,21 +107,23 @@ struct resctrl_test {
  * @init:		Callback function to initialize test environment
  * @setup:		Callback function to setup per test run environment
  * @measure:		Callback that performs the measurement (a single test)
+ * @fill_buf:		Parameters for default "fill_buf" benchmark
  */
 struct resctrl_val_param {
-	const char	*ctrlgrp;
-	const char	*mongrp;
-	char		filename[64];
-	unsigned long	mask;
-	int		num_of_runs;
-	int		(*init)(const struct resctrl_val_param *param,
-				int domain_id);
-	int		(*setup)(const struct resctrl_test *test,
-				 const struct user_params *uparams,
-				 struct resctrl_val_param *param);
-	int		(*measure)(const struct user_params *uparams,
-				   struct resctrl_val_param *param,
-				   pid_t bm_pid);
+	const char		*ctrlgrp;
+	const char		*mongrp;
+	char			filename[64];
+	unsigned long		mask;
+	int			num_of_runs;
+	int			(*init)(const struct resctrl_val_param *param,
+					int domain_id);
+	int			(*setup)(const struct resctrl_test *test,
+					 const struct user_params *uparams,
+					 struct resctrl_val_param *param);
+	int			(*measure)(const struct user_params *uparams,
+					   struct resctrl_val_param *param,
+					   pid_t bm_pid);
+	struct fill_buf_param	fill_buf;
 };
 
 struct perf_event_read {
@@ -151,7 +173,6 @@ void initialize_mem_bw_resctrl(const struct resctrl_val_param *param,
 			       int domain_id);
 int resctrl_val(const struct resctrl_test *test,
 		const struct user_params *uparams,
-		const char * const *benchmark_cmd,
 		struct resctrl_val_param *param);
 unsigned long create_bit_mask(unsigned int start, unsigned int len);
 unsigned int count_contiguous_bits(unsigned long val, unsigned int *start);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index ecbb7605a981..ce8fcc769d57 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -162,7 +162,7 @@ int main(int argc, char **argv)
 	bool test_param_seen = false;
 	struct user_params uparams;
 	char *span_str = NULL;
-	int ret, c, i;
+	int c, i;
 
 	init_user_params(&uparams);
 
@@ -257,19 +257,6 @@ int main(int argc, char **argv)
 
 	filter_dmesg();
 
-	if (!uparams.benchmark_cmd[0]) {
-		/* If no benchmark is given by "-b" argument, use fill_buf. */
-		uparams.benchmark_cmd[0] = "fill_buf";
-		ret = asprintf(&span_str, "%u", DEFAULT_SPAN);
-		if (ret < 0)
-			ksft_exit_fail_msg("Out of memory!\n");
-		uparams.benchmark_cmd[1] = span_str;
-		uparams.benchmark_cmd[2] = "1";
-		uparams.benchmark_cmd[3] = "0";
-		uparams.benchmark_cmd[4] = "false";
-		uparams.benchmark_cmd[5] = NULL;
-	}
-
 	ksft_set_plan(tests);
 
 	for (i = 0; i < ARRAY_SIZE(resctrl_tests); i++)
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 574b72604f95..9a5a9a67e059 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -612,21 +612,17 @@ int measure_mem_bw(const struct user_params *uparams,
  *			the benchmark
  * @test:		test information structure
  * @uparams:		user supplied parameters
- * @benchmark_cmd:	benchmark command and its arguments
  * @param:		parameters passed to resctrl_val()
  *
  * Return:		0 when the test was run, < 0 on error.
  */
 int resctrl_val(const struct resctrl_test *test,
 		const struct user_params *uparams,
-		const char * const *benchmark_cmd,
 		struct resctrl_val_param *param)
 {
-	int domain_id, operation = 0, memflush = 1;
-	size_t span = DEFAULT_SPAN;
 	unsigned char *buf = NULL;
 	cpu_set_t old_affinity;
-	bool once = false;
+	int domain_id;
 	int ret = 0;
 	pid_t ppid;
 
@@ -666,21 +662,9 @@ int resctrl_val(const struct resctrl_test *test,
 	 * how this impacts "write" benchmark, but no test currently
 	 * uses this.
 	 */
-	if (strcmp(benchmark_cmd[0], "fill_buf") == 0) {
-		span = strtoul(benchmark_cmd[1], NULL, 10);
-		memflush =  atoi(benchmark_cmd[2]);
-		operation = atoi(benchmark_cmd[3]);
-		if (!strcmp(benchmark_cmd[4], "true")) {
-			once = true;
-		} else if (!strcmp(benchmark_cmd[4], "false")) {
-			once = false;
-		} else {
-			ksft_print_msg("Invalid once parameter\n");
-			ret = -EINVAL;
-			goto reset_affinity;
-		}
-
-		buf = alloc_buffer(span, memflush);
+	if (!uparams->benchmark_cmd[0]) {
+		buf = alloc_buffer(param->fill_buf.buf_size,
+				   param->fill_buf.memflush);
 		if (!buf) {
 			ret = -ENOMEM;
 			goto reset_affinity;
@@ -699,13 +683,17 @@ int resctrl_val(const struct resctrl_test *test,
 	 * terminated.
 	 */
 	if (bm_pid == 0) {
-		if (strcmp(benchmark_cmd[0], "fill_buf") == 0) {
-			if (operation == 0)
-				fill_cache_read(buf, span, once);
+		if (!uparams->benchmark_cmd[0]) {
+			if (param->fill_buf.operation == 0)
+				fill_cache_read(buf,
+						param->fill_buf.buf_size,
+						param->fill_buf.once);
 			else
-				fill_cache_write(buf, span, once);
+				fill_cache_write(buf,
+						 param->fill_buf.buf_size,
+						 param->fill_buf.once);
 		} else {
-			execvp(benchmark_cmd[0], (char **)benchmark_cmd);
+			execvp(uparams->benchmark_cmd[0], (char **)uparams->benchmark_cmd);
 		}
 		exit(EXIT_SUCCESS);
 	}
-- 
2.46.0


