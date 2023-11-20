Return-Path: <linux-kselftest+bounces-318-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8087F11A5
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 12:17:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F25451C210E5
	for <lists+linux-kselftest@lfdr.de>; Mon, 20 Nov 2023 11:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473B814004;
	Mon, 20 Nov 2023 11:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PXPPIeth"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D3E0CF;
	Mon, 20 Nov 2023 03:17:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700479041; x=1732015041;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=1J/v7XS88ukjtSY/kMlzRId/xPkhPhbNfJpgq3MC56A=;
  b=PXPPIethCyaws1PAv9K5OkRKlgwrKKEu4FHnrjD1vsNKkPabJxVnjXoZ
   VE/RTJgLHE07TzQ7r6VslbqbUVOZjS2yWB6d0VbFOk3G9NDmu7ysvdgXt
   aHiNMuUlrGZKNjZbLDCujfg/ah2z+99Sw1ydQlSCyuSwhngUjAQFXnDPK
   c4nNDr8gqLMv8Hyl83avtavVLDH6XRXVrOCq18XTXP02AnLwDcqq/M/Rw
   0vS53Z1uAXHQstttoI1RC61oIV7EIlkvCvTso/vL54e2AbnGMHvr3sBb7
   4+ln7tQdWSD+AmgMX90z7vFJHFGnOX3cy0XF3Ruw+Wpt1TCfxeA2klatc
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="13152191"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="13152191"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:17:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="832238679"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; 
   d="scan'208";a="832238679"
Received: from sc9itsct4906.amr.corp.intel.com (HELO localhost) ([10.249.46.107])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2023 03:16:55 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 22/26] selftests/resctrl: Pass write_schemata() resource instead of test name
Date: Mon, 20 Nov 2023 13:13:36 +0200
Message-Id: <20231120111340.7805-23-ilpo.jarvinen@linux.intel.com>
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

write_schemata() takes the test name as an argument and determines the
relevant resource based on the test name. Such mapping from name to
resource does not really belong to resctrlfs.c that should provide
only generic, test-independent functions.

Pass the resource stored in the test information structure to
write_schemata() instead of the test name. The new API is also more
flexible as it enables to use write_schemata() for more than one
resource within a test.

While touching the sprintf(), move the unnecessary %c that is always
'=' directly into the format string.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c    | 11 ++++++----
 tools/testing/selftests/resctrl/cmt_test.c    |  6 +++--
 tools/testing/selftests/resctrl/mba_test.c    |  9 ++++----
 tools/testing/selftests/resctrl/mbm_test.c    |  9 ++++----
 tools/testing/selftests/resctrl/resctrl.h     | 10 +++++----
 tools/testing/selftests/resctrl/resctrl_val.c |  7 ++++--
 tools/testing/selftests/resctrl/resctrlfs.c   | 22 +++++--------------
 7 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 4b034850603e..293b42ccd39f 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -134,6 +134,7 @@ void cat_test_cleanup(void)
 
 /*
  * cat_test - Execute CAT benchmark and measure cache misses
+ * @test:		Test information structure
  * @uparams:		User supplied parameters
  * @param:		Parameters passed to cat_test()
  * @span:		Buffer size for the benchmark
@@ -151,7 +152,9 @@ void cat_test_cleanup(void)
  *
  * Return:		0 on success. Non-zero on failure.
  */
-static int cat_test(const struct user_params *uparams, struct resctrl_val_param *param,
+static int cat_test(const struct resctrl_test *test,
+		    const struct user_params *uparams,
+		    struct resctrl_val_param *param,
 		    size_t span, unsigned long current_mask)
 {
 	char *resctrl_val = param->resctrl_val;
@@ -192,11 +195,11 @@ static int cat_test(const struct user_params *uparams, struct resctrl_val_param
 
 	while (current_mask) {
 		snprintf(schemata, sizeof(schemata), "%lx", param->mask & ~current_mask);
-		ret = write_schemata("", schemata, uparams->cpu, param->resctrl_val);
+		ret = write_schemata("", schemata, uparams->cpu, test->resource);
 		if (ret)
 			goto free_buf;
 		snprintf(schemata, sizeof(schemata), "%lx", current_mask);
-		ret = write_schemata(param->ctrlgrp, schemata, uparams->cpu, param->resctrl_val);
+		ret = write_schemata(param->ctrlgrp, schemata, uparams->cpu, test->resource);
 		if (ret)
 			goto free_buf;
 
@@ -273,7 +276,7 @@ static int cat_run_test(const struct resctrl_test *test, const struct user_param
 
 	remove(param.filename);
 
-	ret = cat_test(uparams, &param, span, start_mask);
+	ret = cat_test(test, uparams, &param, span, start_mask);
 	if (ret)
 		goto out;
 
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 89e1928761f3..312dd93f8ec7 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -16,7 +16,9 @@
 #define MAX_DIFF		2000000
 #define MAX_DIFF_PERCENT	15
 
-static int cmt_setup(const struct user_params *uparams, struct resctrl_val_param *p)
+static int cmt_setup(const struct resctrl_test *test,
+		     const struct user_params *uparams,
+		     struct resctrl_val_param *p)
 {
 	/* Run NUM_OF_RUNS times */
 	if (p->num_of_runs >= NUM_OF_RUNS)
@@ -150,7 +152,7 @@ static int cmt_run_test(const struct resctrl_test *test, const struct user_param
 
 	remove(RESULT_FILE_NAME);
 
-	ret = resctrl_val(uparams, cmd, &param);
+	ret = resctrl_val(test, uparams, cmd, &param);
 	if (ret)
 		goto out;
 
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index e4870f96d7ea..85d3c24e4976 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -22,7 +22,9 @@
  * con_mon grp, mon_grp in resctrl FS.
  * For each allocation, run 5 times in order to get average values.
  */
-static int mba_setup(const struct user_params *uparams, struct resctrl_val_param *p)
+static int mba_setup(const struct resctrl_test *test,
+		     const struct user_params *uparams,
+		     struct resctrl_val_param *p)
 {
 	static int runs_per_allocation, allocation = 100;
 	char allocation_str[64];
@@ -40,8 +42,7 @@ static int mba_setup(const struct user_params *uparams, struct resctrl_val_param
 
 	sprintf(allocation_str, "%d", allocation);
 
-	ret = write_schemata(p->ctrlgrp, allocation_str, uparams->cpu,
-			     p->resctrl_val);
+	ret = write_schemata(p->ctrlgrp, allocation_str, uparams->cpu, test->resource);
 	if (ret < 0)
 		return ret;
 
@@ -155,7 +156,7 @@ static int mba_run_test(const struct resctrl_test *test, const struct user_param
 
 	remove(RESULT_FILE_NAME);
 
-	ret = resctrl_val(uparams, uparams->benchmark_cmd, &param);
+	ret = resctrl_val(test, uparams, uparams->benchmark_cmd, &param);
 	if (ret)
 		goto out;
 
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 2274a5eebbca..e3c3fc8fed8d 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -86,7 +86,9 @@ static int check_results(size_t span)
 	return ret;
 }
 
-static int mbm_setup(const struct user_params *uparams, struct resctrl_val_param *p)
+static int mbm_setup(const struct resctrl_test *test,
+		     const struct user_params *uparams,
+		     struct resctrl_val_param *p)
 {
 	int ret = 0;
 
@@ -96,8 +98,7 @@ static int mbm_setup(const struct user_params *uparams, struct resctrl_val_param
 
 	/* Set up shemata with 100% allocation on the first run. */
 	if (p->num_of_runs == 0 && validate_resctrl_feature_request("MB", NULL))
-		ret = write_schemata(p->ctrlgrp, "100", uparams->cpu,
-				     p->resctrl_val);
+		ret = write_schemata(p->ctrlgrp, "100", uparams->cpu, test->resource);
 
 	p->num_of_runs++;
 
@@ -123,7 +124,7 @@ static int mbm_run_test(const struct resctrl_test *test, const struct user_param
 
 	remove(RESULT_FILE_NAME);
 
-	ret = resctrl_val(uparams, uparams->benchmark_cmd, &param);
+	ret = resctrl_val(test, uparams, uparams->benchmark_cmd, &param);
 	if (ret)
 		goto out;
 
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index d92663593850..ed7a69578daf 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -93,7 +93,8 @@ struct resctrl_val_param {
 	char		*bw_report;
 	unsigned long	mask;
 	int		num_of_runs;
-	int		(*setup)(const struct user_params *uparams,
+	int		(*setup)(const struct resctrl_test *test,
+				 const struct user_params *uparams,
 				 struct resctrl_val_param *param);
 };
 
@@ -131,8 +132,7 @@ bool validate_resctrl_feature_request(const char *resource, const char *feature)
 bool test_resource_feature_check(const struct resctrl_test *test);
 char *fgrep(FILE *inf, const char *str);
 int taskset_benchmark(pid_t bm_pid, int cpu_no);
-int write_schemata(char *ctrlgrp, char *schemata, int cpu_no,
-		   char *resctrl_val);
+int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, const char *resource);
 int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
 			    char *resctrl_val);
 int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
@@ -141,7 +141,9 @@ unsigned char *alloc_buffer(size_t buf_size, int memflush);
 void mem_flush(unsigned char *buf, size_t buf_size);
 void fill_cache_read(unsigned char *buf, size_t buf_size, bool once);
 int run_fill_buf(size_t buf_size, int memflush, int op, bool once);
-int resctrl_val(const struct user_params *uparams, const char * const *benchmark_cmd,
+int resctrl_val(const struct resctrl_test *test,
+		const struct user_params *uparams,
+		const char * const *benchmark_cmd,
 		struct resctrl_val_param *param);
 void tests_cleanup(void);
 void mbm_test_cleanup(void);
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 24bf91cfdb21..4e0c356b7f18 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -679,13 +679,16 @@ static void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 /*
  * resctrl_val:	execute benchmark and measure memory bandwidth on
  *			the benchmark
+ * @test:		test information structure
  * @uparams:		user supplied parameters
  * @benchmark_cmd:	benchmark command and its arguments
  * @param:		parameters passed to resctrl_val()
  *
  * Return:		0 on success. non-zero on failure.
  */
-int resctrl_val(const struct user_params *uparams, const char * const *benchmark_cmd,
+int resctrl_val(const struct resctrl_test *test,
+		const struct user_params *uparams,
+		const char * const *benchmark_cmd,
 		struct resctrl_val_param *param)
 {
 	char *resctrl_val = param->resctrl_val;
@@ -818,7 +821,7 @@ int resctrl_val(const struct user_params *uparams, const char * const *benchmark
 
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
-		ret = param->setup(uparams, param);
+		ret = param->setup(test, uparams, param);
 		if (ret == END_OF_TESTS) {
 			ret = 0;
 			break;
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index b711326b2141..fda5ad812faa 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -502,23 +502,17 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
  * @ctrlgrp:		Name of the con_mon grp
  * @schemata:		Schemata that should be updated to
  * @cpu_no:		CPU number that the benchmark PID is binded to
- * @resctrl_val:	Resctrl feature (Eg: mbm, mba.. etc)
+ * @resource:		Resctrl resource (Eg: MB, L3, L2, etc.)
  *
  * Update schemata of a con_mon grp *only* if requested resctrl feature is
  * allocation type
  *
  * Return: 0 on success, non-zero on failure
  */
-int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
+int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, const char *resource)
 {
 	char controlgroup[1024], reason[128], schema[1024] = {};
-	int resource_id, fd, schema_len = -1, ret = 0;
-
-	if (strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) &&
-	    strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) &&
-	    strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)) &&
-	    strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
-		return -ENOENT;
+	int resource_id, fd, schema_len, ret = 0;
 
 	if (!schemata) {
 		ksft_print_msg("Skipping empty schemata update\n");
@@ -538,14 +532,8 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
 	else
 		sprintf(controlgroup, "%s/schemata", RESCTRL_PATH);
 
-	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)) ||
-	    !strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR)))
-		schema_len = snprintf(schema, sizeof(schema), "%s%d%c%s\n",
-				      "L3:", resource_id, '=', schemata);
-	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) ||
-	    !strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)))
-		schema_len = snprintf(schema, sizeof(schema), "%s%d%c%s\n",
-				      "MB:", resource_id, '=', schemata);
+	schema_len = snprintf(schema, sizeof(schema), "%s:%d=%s\n",
+			      resource, resource_id, schemata);
 	if (schema_len < 0 || schema_len >= sizeof(schema)) {
 		snprintf(reason, sizeof(reason),
 			 "snprintf() failed with return value : %d", schema_len);
-- 
2.30.2


