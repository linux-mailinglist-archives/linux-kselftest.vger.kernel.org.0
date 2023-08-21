Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8F57826FE
	for <lists+linux-kselftest@lfdr.de>; Mon, 21 Aug 2023 12:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234663AbjHUKX4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 21 Aug 2023 06:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbjHUKXz (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 21 Aug 2023 06:23:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A31C1FB;
        Mon, 21 Aug 2023 03:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692613426; x=1724149426;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CCEPWuSxPIvdA3U493LPMOyY+lyqcltxLvRmyUZtZL0=;
  b=cx4YSXQHGT/EiOUWMhnglupRgM/9D4fcL2ls9Sl/RuUr2naMa9jR4TQU
   kb6EwBtWdMXsvF9fvqVsIk9WN1lfGrhRJRKOeSrTQYK7GquQz1Zr/C2/r
   ZBtYwDr6YlPz7rM9K2eSnSdDvfEvv8ytU8s77lv/VGAR2Ka1Jhxhkvy1a
   qNwucu9A74TvG5OimyjXY2eoTSbslR/SfMw0oNMtSuQE7GNit1Yr5AjCj
   wEbPOMP61pzWFQ6wcFXZkeIdsJ+p+IcIpElxAtg+YXLG7V55WdYiROwLb
   lfoh8noSXF5RsP2x76mOLLq9HImEmgrW36caMIRmZWeLAWuG6vHLJe+pm
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="358530367"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="358530367"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 03:23:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="735798139"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="735798139"
Received: from nsnaveen-mobl.gar.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.54.252])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 03:23:23 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 5/7] selftests/resctrl: Make benchmark command const and build it with pointers
Date:   Mon, 21 Aug 2023 13:22:43 +0300
Message-Id: <20230821102245.14430-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230821102245.14430-1-ilpo.jarvinen@linux.intel.com>
References: <20230821102245.14430-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Benchmark command is used in multiple tests so it should not be
mutated by the tests but CMT test alters span argument. Due to the
order of tests (CMT test runs last), mutating the span argument in CMT
test does not trigger any real problems currently.

Mark benchmark_cmd strings as const and setup the benchmark command
using pointers. Because the benchmark command becomes const, the input
arguments can be used directly. Besides being simpler, using the input
arguments directly also removes the internal size restriction.

CMT test has to create a copy of the benchmark command before altering
the benchmark command.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cmt_test.c    | 25 ++++++--
 tools/testing/selftests/resctrl/mba_test.c    |  2 +-
 tools/testing/selftests/resctrl/mbm_test.c    |  2 +-
 tools/testing/selftests/resctrl/resctrl.h     | 13 +++--
 .../testing/selftests/resctrl/resctrl_tests.c | 58 +++++++++++--------
 tools/testing/selftests/resctrl/resctrl_val.c | 10 +++-
 6 files changed, 72 insertions(+), 38 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 9d8e38e995ef..cf2f5e92dea6 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -68,14 +68,17 @@ void cmt_test_cleanup(void)
 	remove(RESULT_FILE_NAME);
 }
 
-int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
+int cmt_resctrl_val(int cpu_no, int n, const char * const *benchmark_cmd)
 {
+	const char * const *cmd = benchmark_cmd;
+	const char *new_cmd[BENCHMARK_ARGS];
 	unsigned long cache_size = 0;
 	unsigned long long_mask;
+	char *span_str = NULL;
 	char cbm_mask[256];
 	int count_of_bits;
 	size_t span;
-	int ret;
+	int ret, i;
 
 	if (!validate_resctrl_feature_request(CMT_STR))
 		return -1;
@@ -111,12 +114,23 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 	};
 
 	span = cache_size * n / count_of_bits;
-	if (strcmp(benchmark_cmd[0], "fill_buf") == 0)
-		sprintf(benchmark_cmd[1], "%zu", span);
+
+	if (strcmp(cmd[0], "fill_buf") == 0) {
+		/* Duplicate the command to be able to replace span in it */
+		for (i = 0; benchmark_cmd[i]; i++)
+			new_cmd[i] = benchmark_cmd[i];
+		new_cmd[i] = NULL;
+
+		ret = asprintf(&span_str, "%zu", span);
+		if (ret < 0)
+			return -1;
+		new_cmd[1] = span_str;
+		cmd = new_cmd;
+	}
 
 	remove(RESULT_FILE_NAME);
 
-	ret = resctrl_val(benchmark_cmd, &param);
+	ret = resctrl_val(cmd, &param);
 	if (ret)
 		goto out;
 
@@ -124,6 +138,7 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 
 out:
 	cmt_test_cleanup();
+	free(span_str);
 
 	return ret;
 }
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 094424d835d0..cf8284dadcb2 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -141,7 +141,7 @@ void mba_test_cleanup(void)
 	remove(RESULT_FILE_NAME);
 }
 
-int mba_schemata_change(int cpu_no, char **benchmark_cmd)
+int mba_schemata_change(int cpu_no, const char * const *benchmark_cmd)
 {
 	struct resctrl_val_param param = {
 		.resctrl_val	= MBA_STR,
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index b830fc84338b..1ae131a2e246 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -109,7 +109,7 @@ void mbm_test_cleanup(void)
 	remove(RESULT_FILE_NAME);
 }
 
-int mbm_bw_change(int cpu_no, char **benchmark_cmd)
+int mbm_bw_change(int cpu_no, const char * const *benchmark_cmd)
 {
 	struct resctrl_val_param param = {
 		.resctrl_val	= MBM_STR,
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index bcd0d2060f81..76168a76f831 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -6,6 +6,7 @@
 #include <math.h>
 #include <errno.h>
 #include <sched.h>
+#include <stdint.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <string.h>
@@ -38,7 +39,11 @@
 
 #define END_OF_TESTS	1
 
+#define BENCHMARK_ARGS		64
+
+/* Define default span both as integer and string, these should match */
 #define DEFAULT_SPAN		(250 * MB)
+#define DEFAULT_SPAN_STR	"262144000"
 
 #define PARENT_EXIT(err_msg)			\
 	do {					\
@@ -97,11 +102,11 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
 int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 		    int group_fd, unsigned long flags);
 int run_fill_buf(size_t span, int memflush, int op, bool once);
-int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param);
-int mbm_bw_change(int cpu_no, char **benchmark_cmd);
+int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *param);
+int mbm_bw_change(int cpu_no, const char * const *benchmark_cmd);
 void tests_cleanup(void);
 void mbm_test_cleanup(void);
-int mba_schemata_change(int cpu_no, char **benchmark_cmd);
+int mba_schemata_change(int cpu_no, const char *const *benchmark_cmd);
 void mba_test_cleanup(void);
 int get_cbm_mask(char *cache_type, char *cbm_mask);
 int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size);
@@ -111,7 +116,7 @@ void signal_handler_unregister(void);
 int cat_val(struct resctrl_val_param *param, size_t span);
 void cat_test_cleanup(void);
 int cat_perf_miss_val(int cpu_no, int no_of_bits, char *cache_type);
-int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd);
+int cmt_resctrl_val(int cpu_no, int n, const char * const *benchmark_cmd);
 unsigned int count_bits(unsigned long n);
 void cmt_test_cleanup(void);
 int get_core_sibling(int cpu_no);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index d4ce8592466c..9b582da6f986 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -10,8 +10,9 @@
  */
 #include "resctrl.h"
 
-#define BENCHMARK_ARGS		64
-#define BENCHMARK_ARG_SIZE	64
+/* Define default span both as integer and string, these should match */
+#define DEFAULT_SPAN		(250 * MB)
+#define DEFAULT_SPAN_STR	"262144000"
 
 static int detect_vendor(void)
 {
@@ -70,7 +71,7 @@ void tests_cleanup(void)
 	cat_test_cleanup();
 }
 
-static void run_mbm_test(char **benchmark_cmd, int cpu_no)
+static void run_mbm_test(const char **benchmark_cmd, int cpu_no)
 {
 	int res;
 
@@ -96,7 +97,7 @@ static void run_mbm_test(char **benchmark_cmd, int cpu_no)
 	umount_resctrlfs();
 }
 
-static void run_mba_test(char **benchmark_cmd, int cpu_no)
+static void run_mba_test(const char **benchmark_cmd, int cpu_no)
 {
 	int res;
 
@@ -120,7 +121,7 @@ static void run_mba_test(char **benchmark_cmd, int cpu_no)
 	umount_resctrlfs();
 }
 
-static void run_cmt_test(char **benchmark_cmd, int cpu_no)
+static void run_cmt_test(const char **benchmark_cmd, int cpu_no)
 {
 	int res;
 
@@ -173,11 +174,13 @@ static void run_cat_test(int cpu_no, int no_of_bits)
 int main(int argc, char **argv)
 {
 	bool has_ben = false, mbm_test = true, mba_test = true, cmt_test = true;
-	char benchmark_cmd_area[BENCHMARK_ARGS][BENCHMARK_ARG_SIZE];
 	int c, cpu_no = 1, argc_new = argc, i, no_of_bits = 0;
-	char *benchmark_cmd[BENCHMARK_ARGS];
+	const char *benchmark_cmd[BENCHMARK_ARGS];
 	int ben_ind, ben_count, tests = 0;
+	char *span_str = NULL;
 	bool cat_test = true;
+	char *skip_reason;
+	int ret;
 
 	for (i = 0; i < argc; i++) {
 		if (strcmp(argv[i], "-b") == 0) {
@@ -257,31 +260,31 @@ int main(int argc, char **argv)
 			ksft_exit_fail_msg("Too long benchmark command.\n");
 
 		/* Extract benchmark command from command line. */
-		for (i = ben_ind; i < argc; i++) {
-			benchmark_cmd[i - ben_ind] = benchmark_cmd_area[i];
-			if (strlen(argv[i]) >= BENCHMARK_ARG_SIZE - 1)
-				ksft_exit_fail_msg("Too long benchmark command argument.\n");
-			sprintf(benchmark_cmd[i - ben_ind], "%s", argv[i]);
-		}
+		for (i = 0; i < argc - ben_ind; i++)
+			benchmark_cmd[i] = argv[i + ben_ind];
 		benchmark_cmd[ben_count] = NULL;
 	} else {
 		/* If no benchmark is given by "-b" argument, use fill_buf. */
-		for (i = 0; i < 5; i++)
-			benchmark_cmd[i] = benchmark_cmd_area[i];
-
-		strcpy(benchmark_cmd[0], "fill_buf");
-		sprintf(benchmark_cmd[1], "%u", DEFAULT_SPAN);
-		strcpy(benchmark_cmd[2], "1");
-		strcpy(benchmark_cmd[3], "0");
-		strcpy(benchmark_cmd[4], "false");
+		benchmark_cmd[0] = "fill_buf";
+		ret = asprintf(&span_str, "%u", DEFAULT_SPAN);
+		if (ret < 0)
+			ksft_exit_fail_msg("Out of memory!\n");
+		benchmark_cmd[1] = span_str;
+		benchmark_cmd[2] = "1";
+		benchmark_cmd[3] = "0";
+		benchmark_cmd[4] = "false";
 		benchmark_cmd[5] = NULL;
 	}
 
-	if (!check_resctrlfs_support())
-		return ksft_exit_skip("resctrl FS does not exist. Enable X86_CPU_RESCTRL config option.\n");
+	if (!check_resctrlfs_support()) {
+		skip_reason = "resctrl FS does not exist. Enable X86_CPU_RESCTRL config option.\n";
+		goto free_span;
+	}
 
-	if (umount_resctrlfs())
-		return ksft_exit_skip("resctrl FS unmount failed.\n");
+	if (umount_resctrlfs()) {
+		skip_reason = "resctrl FS unmount failed.\n";
+		goto free_span;
+	}
 
 	filter_dmesg();
 
@@ -299,5 +302,10 @@ int main(int argc, char **argv)
 	if (cat_test)
 		run_cat_test(cpu_no, no_of_bits);
 
+	free(span_str);
 	ksft_finished();
+
+free_span:
+	free(span_str);
+	return ksft_exit_skip(skip_reason);
 }
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index f0f6c5f6e98b..51963a6f2186 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -629,7 +629,7 @@ measure_vals(struct resctrl_val_param *param, unsigned long *bw_resc_start)
  *
  * Return:		0 on success. non-zero on failure.
  */
-int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
+int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *param)
 {
 	char *resctrl_val = param->resctrl_val;
 	unsigned long bw_resc_start = 0;
@@ -710,7 +710,13 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 	if (ret)
 		goto out;
 
-	value.sival_ptr = benchmark_cmd;
+	/*
+	 * The cast removes constness but nothing mutates benchmark_cmd within
+	 * the context of this process. At the receiving process, it becomes
+	 * argv, which is mutable, on exec() but that's after fork() so it
+	 * doesn't matter for the process running the tests.
+	 */
+	value.sival_ptr = (void *)benchmark_cmd;
 
 	/* Taskset benchmark to specified cpu */
 	ret = taskset_benchmark(bm_pid, param->cpu_no);
-- 
2.30.2

