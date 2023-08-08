Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4DF773F4D
	for <lists+linux-kselftest@lfdr.de>; Tue,  8 Aug 2023 18:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbjHHQpe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 8 Aug 2023 12:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233001AbjHHQoh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 8 Aug 2023 12:44:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F86616BE4;
        Tue,  8 Aug 2023 08:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691510169; x=1723046169;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vDNYF1pTdox6T78UoolEmRMtPll4mXCUdly9alu6HsQ=;
  b=mGZ+88lsw19tyUBM4vkYNnccSWlhqe/VPDyQcYkL6pwCS7D1t/S9vT0Z
   JojRl70hC2nkXy7a8AsmdyJvtN3YrJy5c1mp4ks/0TVXg2713gcrvcNDj
   1VxR+e+ZqqQlrsoF8Wj+Sa5nYuaKqfHBnuOMNL6s+fMD+VJ31f0vGaNGM
   qV4hXNWnf/76z2OEOfNOghONbt/0h3Ta07lzMFxU2J6Sw4FsJbv7HsWbK
   93WefD5dymYk9fQK+gtc298AhY9idAOxrJB28du8s6yRPEbmz11t42ymq
   oBoH5xLbSIUbkJ+eWK2helO54eVu57T42cZ0mZiQhFB+s+x1OleIBCCt5
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="437097925"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="437097925"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 02:17:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="977776949"
X-IronPort-AV: E=Sophos;i="6.01,263,1684825200"; 
   d="scan'208";a="977776949"
Received: from mtofeni-mobl.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.48.21])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 02:17:00 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-kernel@vger.kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 5/7] selftests/resctrl: Use pointers to build benchmark cmd and make it const
Date:   Tue,  8 Aug 2023 12:16:23 +0300
Message-Id: <20230808091625.12760-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230808091625.12760-1-ilpo.jarvinen@linux.intel.com>
References: <20230808091625.12760-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Benchmark parameter uses fixed-size buffers in stack which is slightly
dangerous. As benchmark command is used in multiple tests, it should
not be mutated by the tests. Due to the order of tests, mutating the
span argument in CMT test does not trigger any real problems currently.

Mark benchmark_cmd strings as const and setup the benchmark command
using pointers. As span is constant in main(), just provide the default
span also as string to be used in setting up the default fill_buf
argument so no malloc() is required for it.

CMT test has to create a copy of the benchmark command before altering
the benchmark command.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cmt_test.c    | 23 ++++++++++---
 tools/testing/selftests/resctrl/mba_test.c    |  2 +-
 tools/testing/selftests/resctrl/mbm_test.c    |  2 +-
 tools/testing/selftests/resctrl/resctrl.h     | 16 ++++++---
 .../testing/selftests/resctrl/resctrl_tests.c | 33 ++++++++-----------
 tools/testing/selftests/resctrl/resctrl_val.c | 10 ++++--
 6 files changed, 54 insertions(+), 32 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 9d8e38e995ef..a40e12c3b1a7 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -68,14 +68,16 @@ void cmt_test_cleanup(void)
 	remove(RESULT_FILE_NAME);
 }
 
-int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
+int cmt_resctrl_val(int cpu_no, int n, const char * const *benchmark_cmd)
 {
+	const char *cmd[BENCHMARK_ARGS];
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
@@ -111,12 +113,22 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 	};
 
 	span = cache_size * n / count_of_bits;
-	if (strcmp(benchmark_cmd[0], "fill_buf") == 0)
-		sprintf(benchmark_cmd[1], "%zu", span);
+	/* Duplicate the command to be able to replace span in it */
+	for (i = 0; benchmark_cmd[i]; i++)
+		cmd[i] = benchmark_cmd[i];
+	cmd[i] = NULL;
+
+	if (strcmp(cmd[0], "fill_buf") == 0) {
+		span_str = malloc(SIZE_MAX_DECIMAL_SIZE);
+		if (!span_str)
+			return -1;
+		snprintf(span_str, SIZE_MAX_DECIMAL_SIZE, "%zu", span);
+		cmd[1] = span_str;
+	}
 
 	remove(RESULT_FILE_NAME);
 
-	ret = resctrl_val(benchmark_cmd, &param);
+	ret = resctrl_val(cmd, &param);
 	if (ret)
 		goto out;
 
@@ -124,6 +136,7 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 
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
index bcd0d2060f81..ddb1e83a3a64 100644
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
@@ -38,7 +39,14 @@
 
 #define END_OF_TESTS	1
 
+#define BENCHMARK_ARGS		64
+
+/* Approximate %zu max length */
+#define SIZE_MAX_DECIMAL_SIZE	(sizeof(SIZE_MAX) * 8 / 3 + 2)
+
+/* Define default span both as integer and string, these should match */
 #define DEFAULT_SPAN		(250 * MB)
+#define DEFAULT_SPAN_STR	"262144000"
 
 #define PARENT_EXIT(err_msg)			\
 	do {					\
@@ -97,11 +105,11 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
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
@@ -111,7 +119,7 @@ void signal_handler_unregister(void);
 int cat_val(struct resctrl_val_param *param, size_t span);
 void cat_test_cleanup(void);
 int cat_perf_miss_val(int cpu_no, int no_of_bits, char *cache_type);
-int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd);
+int cmt_resctrl_val(int cpu_no, int n, const char * const *benchmark_cmd);
 unsigned int count_bits(unsigned long n);
 void cmt_test_cleanup(void);
 int get_core_sibling(int cpu_no);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 903167a192d7..74a10abeb01d 100644
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
 
@@ -173,9 +174,8 @@ static void run_cat_test(int cpu_no, int no_of_bits)
 int main(int argc, char **argv)
 {
 	bool has_ben = false, mbm_test = true, mba_test = true, cmt_test = true;
-	char benchmark_cmd_area[BENCHMARK_ARGS][BENCHMARK_ARG_SIZE];
 	int c, cpu_no = 1, argc_new = argc, i, no_of_bits = 0;
-	char *benchmark_cmd[BENCHMARK_ARGS];
+	const char *benchmark_cmd[BENCHMARK_ARGS];
 	int ben_ind, ben_count, tests = 0;
 	bool cat_test = true;
 
@@ -257,21 +257,16 @@ int main(int argc, char **argv)
 			ksft_exit_fail_msg("Too long benchmark command");
 
 		/* Extract benchmark command from command line. */
-		for (i = ben_ind; i < argc; i++) {
-			benchmark_cmd[i - ben_ind] = benchmark_cmd_area[i];
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
-		sprintf(benchmark_cmd[1], "%zu", (size_t)DEFAULT_SPAN);
-		strcpy(benchmark_cmd[2], "1");
-		strcpy(benchmark_cmd[3], "0");
-		strcpy(benchmark_cmd[4], "false");
+		benchmark_cmd[0] = "fill_buf";
+		benchmark_cmd[1] = DEFAULT_SPAN_STR;
+		benchmark_cmd[2] = "1";
+		benchmark_cmd[3] = "0";
+		benchmark_cmd[4] = "false";
 		benchmark_cmd[5] = NULL;
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

