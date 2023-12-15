Return-Path: <linux-kselftest+bounces-2055-lists+linux-kselftest=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A55814B4B
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 16:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0554228A437
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Dec 2023 15:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3504358BC;
	Fri, 15 Dec 2023 15:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V0/CqNqS"
X-Original-To: linux-kselftest@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1FC3BB3E;
	Fri, 15 Dec 2023 15:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702652901; x=1734188901;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VXeoUhIafisTzlnFappBvSBsy6oEFAhw5X+ZuJOCfzw=;
  b=V0/CqNqSFpe0FXBPzt4BXxZSFJbaWo4tx9FYdr6VfMWvARwaK+GG0t21
   jB8lrERJ4qNhEqAGLeLdBkLduOXLczDMJYY/TE2f3lK+/JixODwondAfs
   12o4mB33MzQosi20rNqMRmifbe2y2sKq27z1rf8D1LgSsdYP9KISWt5Gy
   G7IU2zbHKc7Ljw9CbOBDPWVYv/HLJkvGivqFyBdmI6DoWppm8hQSIlkdj
   ULjEfUZSSnxcSrtTAuPW7SJUk/R6utUy20QdhqZ7v/jl0Is7VIgoAGVqu
   1BYFGpKAE7ksUmCLePR9+mORurbQZmfK+og4ypj/mDfHQSqdR74M9UQ2K
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="375433484"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="375433484"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:08:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="778289160"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="778289160"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.49.116])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 07:08:17 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-kselftest@vger.kernel.org,
	Reinette Chatre <reinette.chatre@intel.com>,
	Shuah Khan <shuah@kernel.org>,
	Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
	=?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= <maciej.wieczor-retman@intel.com>,
	Fenghua Yu <fenghua.yu@intel.com>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 18/29] selftests/resctrl: Move cat_val() to cat_test.c and rename to cat_test()
Date: Fri, 15 Dec 2023 17:05:04 +0200
Message-Id: <20231215150515.36983-19-ilpo.jarvinen@linux.intel.com>
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

The main CAT test function is called cat_val() and resides in cache.c
which is illogical.

Rename the function to cat_test() and move it into cat_test.c.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/resctrl/cache.c    | 90 ++--------------------
 tools/testing/selftests/resctrl/cat_test.c | 73 +++++++++++++++++-
 tools/testing/selftests/resctrl/resctrl.h  | 14 +++-
 3 files changed, 90 insertions(+), 87 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 335415eaa406..319d0cdd7225 100644
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
@@ -35,13 +28,13 @@ static void perf_event_reset_enable(int pe_fd)
 	ioctl(pe_fd, PERF_EVENT_IOC_ENABLE, 0);
 }
 
-static void perf_event_initialize_read_format(struct perf_event_read *pe_read)
+void perf_event_initialize_read_format(struct perf_event_read *pe_read)
 {
 	memset(pe_read, 0, sizeof(*pe_read));
 	pe_read->nr = 1;
 }
 
-static int perf_open(struct perf_event_attr *pea, pid_t pid, int cpu_no)
+int perf_open(struct perf_event_attr *pea, pid_t pid, int cpu_no)
 {
 	int pe_fd;
 
@@ -130,8 +123,8 @@ static int print_results_cache(const char *filename, int bm_pid, __u64 llc_value
  *
  * Return: =0 on success. <0 on failure.
  */
-static int perf_event_measure(int pe_fd, struct perf_event_read *pe_read,
-			      const char *filename, int bm_pid)
+int perf_event_measure(int pe_fd, struct perf_event_read *pe_read,
+		       const char *filename, int bm_pid)
 {
 	int ret;
 
@@ -169,79 +162,6 @@ int measure_llc_resctrl(const char *filename, int bm_pid)
 	return print_results_cache(filename, bm_pid, llc_occu_resc);
 }
 
-/*
- * cache_val:		execute benchmark and measure LLC occupancy resctrl
- * and perf cache miss for the benchmark
- * @param:		parameters passed to cache_val()
- * @span:		buffer size for the benchmark
- *
- * Return:		0 when the test was run, < 0 on error.
- */
-int cat_val(struct resctrl_val_param *param, size_t span)
-{
-	int memflush = 1, operation = 0, ret = 0;
-	char *resctrl_val = param->resctrl_val;
-	struct perf_event_read pe_read;
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
-		pe_fd = perf_open(&pea, bm_pid, param->cpu_no);
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
-		ret = perf_event_measure(pe_fd, &pe_read, param->filename, bm_pid);
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
  * show_cache_info - Show generic cache test information
  * @no_of_bits:		Number of bits
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 516eaa08e967..bfb607b13491 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -111,6 +111,77 @@ void cat_test_cleanup(void)
 	remove(RESULT_FILE_NAME2);
 }
 
+/*
+ * cat_test - Execute CAT benchmark and measure cache misses
+ * @param:		Parameters passed to cat_test()
+ * @span:		Buffer size for the benchmark
+ *
+ * Return:		0 when the test was run, < 0 on error.
+ */
+static int cat_test(struct resctrl_val_param *param, size_t span)
+{
+	int memflush = 1, operation = 0, ret = 0;
+	char *resctrl_val = param->resctrl_val;
+	struct perf_event_read pe_read;
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
+		pe_fd = perf_open(&pea, bm_pid, param->cpu_no);
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
+		ret = perf_event_measure(pe_fd, &pe_read, param->filename, bm_pid);
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
 	unsigned long full_cache_mask, long_mask;
@@ -194,7 +265,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 
 	remove(param.filename);
 
-	ret = cat_val(&param, span);
+	ret = cat_test(&param, span);
 	if (ret == 0)
 		ret = check_results(&param, span);
 
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index f813fcdcb5e0..4aabf7ac0ab9 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -66,6 +66,13 @@ struct resctrl_val_param {
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
@@ -105,13 +112,18 @@ int get_cache_size(int cpu_no, const char *cache_type, unsigned long *cache_size
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
+int perf_open(struct perf_event_attr *pea, pid_t pid, int cpu_no);
+int perf_event_measure(int pe_fd, struct perf_event_read *pe_read,
+		       const char *filename, int bm_pid);
 int measure_llc_resctrl(const char *filename, int bm_pid);
 void show_cache_info(int no_of_bits, __u64 avg_llc_val, size_t cache_span, bool lines);
 
-- 
2.30.2


