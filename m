Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED8C7D4C4B
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 11:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234323AbjJXJ3p (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 05:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbjJXJ31 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 05:29:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFE12127;
        Tue, 24 Oct 2023 02:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698139726; x=1729675726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oOoE9qnQgl0vvUYTiHnIQ0tgq/pyCy/rUFRqG5gIceQ=;
  b=RGv06/RbvmSrMuXdBq0Ei1EYmiA0Tm1ZM2eMGbaHBRDS5HihlUia4FJU
   y3lvQTHXl3AwrZtGe16+HWBh3eswrN0+5qoOpFe+LXdxEwCN4RxM5PYU/
   +DWZfD4GaEqiNDKZx1kyGHnP3d5frq6hXNnmxSu5CL5xESwDx7p/Vv2vy
   wzVajT7YOpjUTXHvLmhugDZk7I5VqMkBbus9ilXJcAAsRdEdcfcbpAPNj
   i4v1KTszbiEJHCNSky9UM0Nc1m6suakuW0k8Fw88Uvp3Ydw6obXd5P2I0
   /+HNLmtLjRs2ceUkIHENTDTyuZBE/L+Kd9J3cNOoUl6C5oEmISBSNfZm1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="384218894"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="384218894"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:28:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="6397763"
Received: from hprosing-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.219])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:28:36 -0700
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
Subject: [PATCH 14/24] selftests/resctrl: Move cat_val() to cat_test.c and rename to cat_test()
Date:   Tue, 24 Oct 2023 12:26:24 +0300
Message-Id: <20231024092634.7122-15-ilpo.jarvinen@linux.intel.com>
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

The main CAT test function is called cat_val() and resides in cache.c
which is illogical.

Rename the function to cat_test() and move it into cat_test.c.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c    | 90 ++--------------------
 tools/testing/selftests/resctrl/cat_test.c | 73 +++++++++++++++++-
 tools/testing/selftests/resctrl/resctrl.h  | 14 +++-
 3 files changed, 90 insertions(+), 87 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index a65e2e35c33c..c4cb3cb8c2c9 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -3,16 +3,9 @@
 #include <stdint.h>
 #include "resctrl.h"
 
-struct perf_event_read {
-	__u64 nr;			/* The number of events */
-	struct {
-		__u64 value;		/* The value of the event */
-	} values[2];
-};
-
 char llc_occup_path[1024];
 
-static void perf_event_attr_initialize(struct perf_event_attr *pea, __u64 config)
+void perf_event_attr_initialize(struct perf_event_attr *pea, __u64 config)
 {
 	memset(pea, 0, sizeof(*pea));
 	pea->type = PERF_TYPE_HARDWARE;
@@ -28,13 +21,13 @@ static void perf_event_attr_initialize(struct perf_event_attr *pea, __u64 config
 	pea->config = config;
 }
 
-static void perf_event_initialize_read_format(struct perf_event_read *pe_read)
+void perf_event_initialize_read_format(struct perf_event_read *pe_read)
 {
 	memset(pe_read, 0, sizeof(*pe_read));
 	pe_read->nr = 1;
 }
 
-static int perf_event_reset_enable(struct perf_event_attr *pea, pid_t pid, int cpu_no)
+int perf_event_reset_enable(struct perf_event_attr *pea, pid_t pid, int cpu_no)
 {
 	int pe_fd;
 
@@ -123,8 +116,8 @@ static int print_results_cache(char *filename, int bm_pid, __u64 llc_value)
  *
  * Return: =0 on success.  <0 on failure.
  */
-static int perf_event_measure(int pe_fd, struct perf_event_read *pe_read,
-			      struct resctrl_val_param *param, int bm_pid)
+int perf_event_measure(int pe_fd, struct perf_event_read *pe_read,
+		       struct resctrl_val_param *param, int bm_pid)
 {
 	int ret;
 
@@ -156,79 +149,6 @@ int measure_llc_resctrl(struct resctrl_val_param *param, int bm_pid)
 	return ret;
 }
 
-/*
- * cache_val:		execute benchmark and measure LLC occupancy resctrl
- * and perf cache miss for the benchmark
- * @param:		parameters passed to cache_val()
- * @span:		buffer size for the benchmark
- *
- * Return:		0 on success. non-zero on failure.
- */
-int cat_val(struct resctrl_val_param *param, size_t span)
-{
-	int memflush = 1, operation = 0, ret = 0;
-	char *resctrl_val = param->resctrl_val;
-	static struct perf_event_read pe_read;
-	struct perf_event_attr pea;
-	pid_t bm_pid;
-	int pe_fd;
-
-	if (strcmp(param->filename, "") == 0)
-		sprintf(param->filename, "stdio");
-
-	bm_pid = getpid();
-
-	/* Taskset benchmark to specified cpu */
-	ret = taskset_benchmark(bm_pid, param->cpu_no);
-	if (ret)
-		return ret;
-
-	/* Write benchmark to specified con_mon grp, mon_grp in resctrl FS*/
-	ret = write_bm_pid_to_resctrl(bm_pid, param->ctrlgrp, param->mongrp,
-				      resctrl_val);
-	if (ret)
-		return ret;
-
-	perf_event_attr_initialize(&pea, PERF_COUNT_HW_CACHE_MISSES);
-	perf_event_initialize_read_format(&pe_read);
-
-	/* Test runs until the callback setup() tells the test to stop. */
-	while (1) {
-		ret = param->setup(param);
-		if (ret == END_OF_TESTS) {
-			ret = 0;
-			break;
-		}
-		if (ret < 0)
-			break;
-
-		pe_fd = perf_event_reset_enable(&pea, bm_pid, param->cpu_no);
-		if (pe_fd < 0) {
-			ret = -1;
-			break;
-		}
-
-		if (run_fill_buf(span, memflush, operation, true)) {
-			fprintf(stderr, "Error-running fill buffer\n");
-			ret = -1;
-			goto pe_close;
-		}
-
-		sleep(1);
-		ret = perf_event_measure(pe_fd, &pe_read, param, bm_pid);
-		if (ret)
-			goto pe_close;
-
-		close(pe_fd);
-	}
-
-	return ret;
-
-pe_close:
-	close(pe_fd);
-	return ret;
-}
-
 /*
  * show_cache_info:	show generic cache test information
  * @no_of_bits:		number of bits
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 2106cc3601d9..e71690a9bbb3 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -111,6 +111,77 @@ void cat_test_cleanup(void)
 	remove(RESULT_FILE_NAME2);
 }
 
+/*
+ * cat_test:	execute CAT benchmark and measure LLC cache misses
+ * @param:	parameters passed to cat_test()
+ * @span:	buffer size for the benchmark
+ *
+ * Return:	0 on success. non-zero on failure.
+ */
+static int cat_test(struct resctrl_val_param *param, size_t span)
+{
+	int memflush = 1, operation = 0, ret = 0;
+	char *resctrl_val = param->resctrl_val;
+	static struct perf_event_read pe_read;
+	struct perf_event_attr pea;
+	pid_t bm_pid;
+	int pe_fd;
+
+	if (strcmp(param->filename, "") == 0)
+		sprintf(param->filename, "stdio");
+
+	bm_pid = getpid();
+
+	/* Taskset benchmark to specified cpu */
+	ret = taskset_benchmark(bm_pid, param->cpu_no);
+	if (ret)
+		return ret;
+
+	/* Write benchmark to specified con_mon grp, mon_grp in resctrl FS*/
+	ret = write_bm_pid_to_resctrl(bm_pid, param->ctrlgrp, param->mongrp,
+				      resctrl_val);
+	if (ret)
+		return ret;
+
+	perf_event_attr_initialize(&pea, PERF_COUNT_HW_CACHE_MISSES);
+	perf_event_initialize_read_format(&pe_read);
+
+	/* Test runs until the callback setup() tells the test to stop. */
+	while (1) {
+		ret = param->setup(param);
+		if (ret == END_OF_TESTS) {
+			ret = 0;
+			break;
+		}
+		if (ret < 0)
+			break;
+		pe_fd = perf_event_reset_enable(&pea, bm_pid, param->cpu_no);
+		if (pe_fd < 0) {
+			ret = -1;
+			break;
+		}
+
+		if (run_fill_buf(span, memflush, operation, true)) {
+			fprintf(stderr, "Error-running fill buffer\n");
+			ret = -1;
+			goto pe_close;
+		}
+
+		sleep(1);
+		ret = perf_event_measure(pe_fd, &pe_read, param, bm_pid);
+		if (ret)
+			goto pe_close;
+
+		close(pe_fd);
+	}
+
+	return ret;
+
+pe_close:
+	close(pe_fd);
+	return ret;
+}
+
 int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 {
 	unsigned long l_mask, l_mask_1;
@@ -196,7 +267,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 
 	remove(param.filename);
 
-	ret = cat_val(&param, span);
+	ret = cat_test(&param, span);
 	if (ret == 0)
 		ret = check_results(&param, span);
 
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 033c49784581..ee3cee74a69c 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -67,6 +67,13 @@ struct resctrl_val_param {
 	int		(*setup)(struct resctrl_val_param *param);
 };
 
+struct perf_event_read {
+	__u64 nr;			/* The number of events */
+	struct {
+		__u64 value;		/* The value of the event */
+	} values[2];
+};
+
 #define MBM_STR			"mbm"
 #define MBA_STR			"mba"
 #define CMT_STR			"cmt"
@@ -107,13 +114,18 @@ int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int signal_handler_register(void);
 void signal_handler_unregister(void);
-int cat_val(struct resctrl_val_param *param, size_t span);
 void cat_test_cleanup(void);
 int cat_perf_miss_val(int cpu_no, int no_of_bits, char *cache_type);
 int cmt_resctrl_val(int cpu_no, int n, const char * const *benchmark_cmd);
 unsigned int count_bits(unsigned long n);
 void cmt_test_cleanup(void);
 int get_core_sibling(int cpu_no);
+
+void perf_event_attr_initialize(struct perf_event_attr *pea, __u64 config);
+void perf_event_initialize_read_format(struct perf_event_read *pe_read);
+int perf_event_reset_enable(struct perf_event_attr *pea, pid_t pid, int cpu_no);
+int perf_event_measure(int pe_fd, struct perf_event_read *pe_read,
+		       struct resctrl_val_param *param, int bm_pid);
 int measure_llc_resctrl(struct resctrl_val_param *param, int bm_pid);
 void show_cache_info(int no_of_bits, __u64 avg_llc_val, size_t cache_span, bool lines);
 
-- 
2.30.2

