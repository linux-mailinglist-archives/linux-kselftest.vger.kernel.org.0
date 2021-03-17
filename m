Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC56F33E6D9
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Mar 2021 03:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhCQCZD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Mar 2021 22:25:03 -0400
Received: from mga01.intel.com ([192.55.52.88]:55651 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230112AbhCQCYf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Mar 2021 22:24:35 -0400
IronPort-SDR: twI3LN7atCvzUlVIwuyqZ62phJ0owIKvxILNvF55WkrdUOUT0COlFzetW0ENp6clmDAsTK3ugz
 OvSPyMsI3dbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="209328706"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="209328706"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 19:24:33 -0700
IronPort-SDR: YH205W3gtcYW0X8rpnNTkWwLOKP+ki9UUfBcJGhQpjMZp9LImlrv6hEBgf1uyIqDjZr4CXIWaM
 gZNYkAd52JQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="440290248"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Mar 2021 19:24:33 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kselftest" <linux-kselftest@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v6 04/21] selftests/resctrl: Clean up resctrl features check
Date:   Wed, 17 Mar 2021 02:22:38 +0000
Message-Id: <20210317022255.2536745-5-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210317022255.2536745-1-fenghua.yu@intel.com>
References: <20210317022255.2536745-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Checking resctrl features call strcmp() to compare feature strings
(e.g. "mba", "cat" etc). The checkings are error prone and don't have
good coding style. Define the constant strings in macros and call
strncmp() to solve the potential issues.

Suggested-by: Shuah Khan <shuah@kernel.org>
Tested-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
Change Log:
v5:
- Remove is_cat() etc functions and directly call strncmp() to check
  the features (Shuah).

 tools/testing/selftests/resctrl/cache.c       |  8 +++----
 tools/testing/selftests/resctrl/cat_test.c    |  2 +-
 tools/testing/selftests/resctrl/cqm_test.c    |  2 +-
 tools/testing/selftests/resctrl/fill_buf.c    |  4 ++--
 tools/testing/selftests/resctrl/mba_test.c    |  2 +-
 tools/testing/selftests/resctrl/mbm_test.c    |  2 +-
 tools/testing/selftests/resctrl/resctrl.h     |  5 +++++
 .../testing/selftests/resctrl/resctrl_tests.c | 12 +++++-----
 tools/testing/selftests/resctrl/resctrl_val.c | 22 +++++++++----------
 tools/testing/selftests/resctrl/resctrlfs.c   | 17 +++++++-------
 10 files changed, 41 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 38dbf4962e33..5922cc1b0386 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -182,7 +182,7 @@ int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
 	/*
 	 * Measure cache miss from perf.
 	 */
-	if (!strcmp(param->resctrl_val, "cat")) {
+	if (!strncmp(param->resctrl_val, CAT_STR, sizeof(CAT_STR))) {
 		ret = get_llc_perf(&llc_perf_miss);
 		if (ret < 0)
 			return ret;
@@ -192,7 +192,7 @@ int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
 	/*
 	 * Measure llc occupancy from resctrl.
 	 */
-	if (!strcmp(param->resctrl_val, "cqm")) {
+	if (!strncmp(param->resctrl_val, CQM_STR, sizeof(CQM_STR))) {
 		ret = get_llc_occu_resctrl(&llc_occu_resc);
 		if (ret < 0)
 			return ret;
@@ -234,7 +234,7 @@ int cat_val(struct resctrl_val_param *param)
 	if (ret)
 		return ret;
 
-	if ((strcmp(resctrl_val, "cat") == 0)) {
+	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR))) {
 		ret = initialize_llc_perf();
 		if (ret)
 			return ret;
@@ -242,7 +242,7 @@ int cat_val(struct resctrl_val_param *param)
 
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
-		if (strcmp(resctrl_val, "cat") == 0) {
+		if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR))) {
 			ret = param->setup(1, param);
 			if (ret) {
 				ret = 0;
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index bdeeb5772592..20823725daca 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -164,7 +164,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		return -1;
 
 	struct resctrl_val_param param = {
-		.resctrl_val	= "cat",
+		.resctrl_val	= CAT_STR,
 		.cpu_no		= cpu_no,
 		.mum_resctrlfs	= 0,
 		.setup		= cat_setup,
diff --git a/tools/testing/selftests/resctrl/cqm_test.c b/tools/testing/selftests/resctrl/cqm_test.c
index de33d1c0466e..271752e9ef5b 100644
--- a/tools/testing/selftests/resctrl/cqm_test.c
+++ b/tools/testing/selftests/resctrl/cqm_test.c
@@ -145,7 +145,7 @@ int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 	}
 
 	struct resctrl_val_param param = {
-		.resctrl_val	= "cqm",
+		.resctrl_val	= CQM_STR,
 		.ctrlgrp	= "c1",
 		.mongrp		= "m1",
 		.cpu_no		= cpu_no,
diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 79c611c99a3d..51e5cf22632f 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -115,7 +115,7 @@ static int fill_cache_read(unsigned char *start_ptr, unsigned char *end_ptr,
 
 	while (1) {
 		ret = fill_one_span_read(start_ptr, end_ptr);
-		if (!strcmp(resctrl_val, "cat"))
+		if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)))
 			break;
 	}
 
@@ -134,7 +134,7 @@ static int fill_cache_write(unsigned char *start_ptr, unsigned char *end_ptr,
 {
 	while (1) {
 		fill_one_span_write(start_ptr, end_ptr);
-		if (!strcmp(resctrl_val, "cat"))
+		if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)))
 			break;
 	}
 
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 7bf8eaa6204b..6449fbd96096 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -141,7 +141,7 @@ void mba_test_cleanup(void)
 int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd)
 {
 	struct resctrl_val_param param = {
-		.resctrl_val	= "mba",
+		.resctrl_val	= MBA_STR,
 		.ctrlgrp	= "c1",
 		.mongrp		= "m1",
 		.cpu_no		= cpu_no,
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 4700f7453f81..ec6cfe01c9c2 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -114,7 +114,7 @@ void mbm_test_cleanup(void)
 int mbm_bw_change(int span, int cpu_no, char *bw_report, char **benchmark_cmd)
 {
 	struct resctrl_val_param param = {
-		.resctrl_val	= "mbm",
+		.resctrl_val	= MBM_STR,
 		.ctrlgrp	= "c1",
 		.mongrp		= "m1",
 		.span		= span,
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 12b77182cb44..36da6136af96 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -62,6 +62,11 @@ struct resctrl_val_param {
 	int		(*setup)(int num, ...);
 };
 
+#define MBM_STR			"mbm"
+#define MBA_STR			"mba"
+#define CQM_STR			"cqm"
+#define CAT_STR			"cat"
+
 extern pid_t bm_pid, ppid;
 extern int tests_run;
 
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 425cc85ac883..4b109a59f72d 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -85,13 +85,13 @@ int main(int argc, char **argv)
 			cqm_test = false;
 			cat_test = false;
 			while (token) {
-				if (!strcmp(token, "mbm")) {
+				if (!strncmp(token, MBM_STR, sizeof(MBM_STR))) {
 					mbm_test = true;
-				} else if (!strcmp(token, "mba")) {
+				} else if (!strncmp(token, MBA_STR, sizeof(MBA_STR))) {
 					mba_test = true;
-				} else if (!strcmp(token, "cqm")) {
+				} else if (!strncmp(token, CQM_STR, sizeof(CQM_STR))) {
 					cqm_test = true;
-				} else if (!strcmp(token, "cat")) {
+				} else if (!strncmp(token, CAT_STR, sizeof(CAT_STR))) {
 					cat_test = true;
 				} else {
 					printf("invalid argument\n");
@@ -161,7 +161,7 @@ int main(int argc, char **argv)
 	if (!is_amd && mbm_test) {
 		printf("# Starting MBM BW change ...\n");
 		if (!has_ben)
-			sprintf(benchmark_cmd[5], "%s", "mba");
+			sprintf(benchmark_cmd[5], "%s", MBA_STR);
 		res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
 		printf("%sok MBM: bw change\n", res ? "not " : "");
 		mbm_test_cleanup();
@@ -181,7 +181,7 @@ int main(int argc, char **argv)
 	if (cqm_test) {
 		printf("# Starting CQM test ...\n");
 		if (!has_ben)
-			sprintf(benchmark_cmd[5], "%s", "cqm");
+			sprintf(benchmark_cmd[5], "%s", CQM_STR);
 		res = cqm_resctrl_val(cpu_no, no_of_bits, benchmark_cmd);
 		printf("%sok CQM: test\n", res ? "not " : "");
 		cqm_test_cleanup();
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index 520fea3606d1..aed71fd0713b 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -397,10 +397,10 @@ static void initialize_mem_bw_resctrl(const char *ctrlgrp, const char *mongrp,
 		return;
 	}
 
-	if (strcmp(resctrl_val, "mbm") == 0)
+	if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)))
 		set_mbm_path(ctrlgrp, mongrp, resource_id);
 
-	if ((strcmp(resctrl_val, "mba") == 0)) {
+	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
 		if (ctrlgrp)
 			sprintf(mbm_total_path, CON_MBM_LOCAL_BYTES_PATH,
 				RESCTRL_PATH, ctrlgrp, resource_id);
@@ -524,7 +524,7 @@ static void initialize_llc_occu_resctrl(const char *ctrlgrp, const char *mongrp,
 		return;
 	}
 
-	if (strcmp(resctrl_val, "cqm") == 0)
+	if (!strncmp(resctrl_val, CQM_STR, sizeof(CQM_STR)))
 		set_cqm_path(ctrlgrp, mongrp, resource_id);
 }
 
@@ -579,8 +579,8 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 	if (strcmp(param->filename, "") == 0)
 		sprintf(param->filename, "stdio");
 
-	if ((strcmp(resctrl_val, "mba")) == 0 ||
-	    (strcmp(resctrl_val, "mbm")) == 0) {
+	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) ||
+	    !strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR))) {
 		ret = validate_bw_report_request(param->bw_report);
 		if (ret)
 			return ret;
@@ -674,15 +674,15 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 	if (ret)
 		goto out;
 
-	if ((strcmp(resctrl_val, "mbm") == 0) ||
-	    (strcmp(resctrl_val, "mba") == 0)) {
+	if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
+	    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
 		ret = initialize_mem_bw_imc();
 		if (ret)
 			goto out;
 
 		initialize_mem_bw_resctrl(param->ctrlgrp, param->mongrp,
 					  param->cpu_no, resctrl_val);
-	} else if (strcmp(resctrl_val, "cqm") == 0)
+	} else if (!strncmp(resctrl_val, CQM_STR, sizeof(CQM_STR)))
 		initialize_llc_occu_resctrl(param->ctrlgrp, param->mongrp,
 					    param->cpu_no, resctrl_val);
 
@@ -710,8 +710,8 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 
 	/* Test runs until the callback setup() tells the test to stop. */
 	while (1) {
-		if ((strcmp(resctrl_val, "mbm") == 0) ||
-		    (strcmp(resctrl_val, "mba") == 0)) {
+		if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
+		    !strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
 			ret = param->setup(1, param);
 			if (ret) {
 				ret = 0;
@@ -721,7 +721,7 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 			ret = measure_vals(param, &bw_resc_start);
 			if (ret)
 				break;
-		} else if (strcmp(resctrl_val, "cqm") == 0) {
+		} else if (!strncmp(resctrl_val, CQM_STR, sizeof(CQM_STR))) {
 			ret = param->setup(1, param);
 			if (ret) {
 				ret = 0;
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 2a16100c9c3f..4174e48e06d1 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -334,7 +334,7 @@ void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 		operation = atoi(benchmark_cmd[4]);
 		sprintf(resctrl_val, "%s", benchmark_cmd[5]);
 
-		if (strcmp(resctrl_val, "cqm") != 0)
+		if (strncmp(resctrl_val, CQM_STR, sizeof(CQM_STR)))
 			buffer_span = span * MB;
 		else
 			buffer_span = span;
@@ -459,8 +459,8 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
 		goto out;
 
 	/* Create mon grp and write pid into it for "mbm" and "cqm" test */
-	if ((strcmp(resctrl_val, "cqm") == 0) ||
-	    (strcmp(resctrl_val, "mbm") == 0)) {
+	if (!strncmp(resctrl_val, CQM_STR, sizeof(CQM_STR)) ||
+	    !strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR))) {
 		if (strlen(mongrp)) {
 			sprintf(monitorgroup_p, "%s/mon_groups", controlgroup);
 			sprintf(monitorgroup, "%s/%s", monitorgroup_p, mongrp);
@@ -505,9 +505,9 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
 	int resource_id, ret = 0;
 	FILE *fp;
 
-	if ((strcmp(resctrl_val, "mba") != 0) &&
-	    (strcmp(resctrl_val, "cat") != 0) &&
-	    (strcmp(resctrl_val, "cqm") != 0))
+	if (strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)) &&
+	    strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)) &&
+	    strncmp(resctrl_val, CQM_STR, sizeof(CQM_STR)))
 		return -ENOENT;
 
 	if (!schemata) {
@@ -528,9 +528,10 @@ int write_schemata(char *ctrlgrp, char *schemata, int cpu_no, char *resctrl_val)
 	else
 		sprintf(controlgroup, "%s/schemata", RESCTRL_PATH);
 
-	if (!strcmp(resctrl_val, "cat") || !strcmp(resctrl_val, "cqm"))
+	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)) ||
+	    !strncmp(resctrl_val, CQM_STR, sizeof(CQM_STR)))
 		sprintf(schema, "%s%d%c%s", "L3:", resource_id, '=', schemata);
-	if (strcmp(resctrl_val, "mba") == 0)
+	if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR)))
 		sprintf(schema, "%s%d%c%s", "MB:", resource_id, '=', schemata);
 
 	fp = fopen(controlgroup, "w");
-- 
2.31.0

