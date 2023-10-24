Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8768A7D4C5D
	for <lists+linux-kselftest@lfdr.de>; Tue, 24 Oct 2023 11:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234300AbjJXJbB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 24 Oct 2023 05:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234390AbjJXJab (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 24 Oct 2023 05:30:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ACF51FD3;
        Tue, 24 Oct 2023 02:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698139770; x=1729675770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bsQLK+vSeD8JEj8tn54DGxbsLyoZN/n1gbL0pSe8EwU=;
  b=G6Z0RHh/Yc/1WKcN+tIrKXmXEVyqVnaB+MFGVcTedvF7huNyGOqY2maC
   ZFWy0W7ce0dV/vwN4Zd6zfga6/qjvJG4RlaXFVQ4CgQoJRdPgHjplo+zM
   0dfRz5zT0K6TOYe9I6bZ+E5wTHOGg4GLgPpHZi7m+QsRmLfpVtTx0SgQb
   9ch0TKartHfMcesrV7PFfXaCkrcCuepIuFqDXZulxpXqlxpExShYskL5z
   uip60/od0TAWidssWH6rDPs2V+YzcSi818pJLKwzcDg3IIYYX/xDBbakd
   9F5sPRv/rR4QjBUBZg1gnYC7Lp4T8Lyzy3PTrIoLwXzZKN/QkXjUMtOHO
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="418145170"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="418145170"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:29:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="734972516"
X-IronPort-AV: E=Sophos;i="6.03,247,1694761200"; 
   d="scan'208";a="734972516"
Received: from hprosing-mobl.ger.corp.intel.com (HELO localhost) ([10.249.40.219])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 02:28:59 -0700
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
Subject: [PATCH 16/24] selftests/resctrl: Rewrite Cache Allocation Technology (CAT) test
Date:   Tue, 24 Oct 2023 12:26:26 +0300
Message-Id: <20231024092634.7122-17-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
References: <20231024092634.7122-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

CAT test spawns two processes into two different control groups with
exclusive schemata. Both the processes alloc a buffer from memory
matching their allocated LLC block size and flush the entire buffer out
of caches. Since the processes are reading through the buffer only once
during the measurement and initially all the buffer was flushed, the
test isn't testing CAT.

Rewrite the CAT test to allocate a buffer sized to half of LLC. Then
perform a sequence of tests with different LLC alloc sizes starting
from half of the CBM bits down to 1-bit CBM. Flush the buffer before
each test and read the buffer twice. Observe the LLC misses on the
second read through the buffer. As the allocated LLC block gets smaller
and smaller, the LLC misses will become larger and larger giving a
strong signal on CAT working properly.

The new CAT test is using only a single process because it relies on
measured effect against another run of itself rather than another
process adding noise. The rest of the system is allocated the CBM bits
not used by the CAT test to keep the test isolated.

Replace count_bits() with count_contiguous_bits() to get the first bit
position in order to be able to calculate masks based on it.

This change has been tested with a number of systems from different
generations.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c  | 286 +++++++++-----------
 tools/testing/selftests/resctrl/fill_buf.c  |   6 +-
 tools/testing/selftests/resctrl/resctrl.h   |   5 +-
 tools/testing/selftests/resctrl/resctrlfs.c |  44 +--
 4 files changed, 137 insertions(+), 204 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index e71690a9bbb3..7518c520c5cc 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -11,65 +11,68 @@
 #include "resctrl.h"
 #include <unistd.h>
 
-#define RESULT_FILE_NAME1	"result_cat1"
-#define RESULT_FILE_NAME2	"result_cat2"
+#define RESULT_FILE_NAME	"result_cat"
 #define NUM_OF_RUNS		5
-#define MAX_DIFF_PERCENT	4
-#define MAX_DIFF		1000000
 
 /*
- * Change schemata. Write schemata to specified
- * con_mon grp, mon_grp in resctrl FS.
- * Run 5 times in order to get average values.
+ * Minimum difference in LLC misses between a test with n+1 bits CBM mask to
+ * the test with n bits. With e.g. 5 vs 4 bits in the CBM mask, the minimum
+ * difference must be at least MIN_DIFF_PERCENT_PER_BIT * (4 - 1) = 3 percent.
+ *
+ * The relationship between number of used CBM bits and difference in LLC
+ * misses is not expected to be linear. With a small number of bits, the
+ * margin is smaller than with larger number of bits. For selftest purposes,
+ * however, linear approach is enough because ultimately only pass/fail
+ * decision has to be made and distinction between strong and stronger
+ * signal is irrelevant.
  */
-static int cat_setup(struct resctrl_val_param *p)
-{
-	char schemata[64];
-	int ret = 0;
-
-	/* Run NUM_OF_RUNS times */
-	if (p->num_of_runs >= NUM_OF_RUNS)
-		return END_OF_TESTS;
-
-	if (p->num_of_runs == 0) {
-		sprintf(schemata, "%lx", p->mask);
-		ret = write_schemata(p->ctrlgrp, schemata, p->cpu_no,
-				     p->resctrl_val);
-	}
-	p->num_of_runs++;
-
-	return ret;
-}
+#define MIN_DIFF_PERCENT_PER_BIT	1
 
 static int show_results_info(__u64 sum_llc_val, int no_of_bits,
-			     unsigned long cache_span, unsigned long max_diff,
-			     unsigned long max_diff_percent, unsigned long num_of_runs,
-			     bool platform)
+			     unsigned long cache_span, long min_diff_percent,
+			     unsigned long num_of_runs, bool platform,
+			     __s64 *prev_avg_llc_val)
 {
 	__u64 avg_llc_val = 0;
-	float diff_percent;
-	int ret;
+	float avg_diff;
+	int ret = 0;
 
 	avg_llc_val = sum_llc_val / num_of_runs;
-	diff_percent = ((float)cache_span - avg_llc_val) / cache_span * 100;
+	if (*prev_avg_llc_val) {
+		float delta = (__s64)(avg_llc_val - *prev_avg_llc_val);
 
-	ret = platform && abs((int)diff_percent) > max_diff_percent;
+		avg_diff = delta / *prev_avg_llc_val;
+		ret = platform && (avg_diff * 100) < (float)min_diff_percent;
 
-	ksft_print_msg("%s Check cache miss rate within %lu%%\n",
-		       ret ? "Fail:" : "Pass:", max_diff_percent);
+		ksft_print_msg("%s Check cache miss rate changed more than %.1f%%\n",
+			       ret ? "Fail:" : "Pass:", (float)min_diff_percent);
 
-	ksft_print_msg("Percent diff=%d\n", abs((int)diff_percent));
+		ksft_print_msg("Percent diff=%.1f\n", avg_diff * 100);
+	}
+	*prev_avg_llc_val = avg_llc_val;
 
 	show_cache_info(no_of_bits, avg_llc_val, cache_span, true);
 
 	return ret;
 }
 
-static int check_results(struct resctrl_val_param *param, size_t span)
+/* Remove one bit from the consecutive cbm mask */
+static unsigned long next_mask(unsigned long current_mask)
+{
+	return current_mask & (current_mask >> 1);
+}
+
+static int check_results(struct resctrl_val_param *param, const char *cache_type,
+			 unsigned long cache_total_size, unsigned long full_cache_mask,
+			 unsigned long current_mask)
 {
 	char *token_array[8], temp[512];
 	__u64 sum_llc_perf_miss = 0;
-	int runs = 0, no_of_bits = 0;
+	unsigned long alloc_size;
+	__s64 prev_avg_llc_val = 0;
+	int runs = 0;
+	int fail = 0;
+	int ret;
 	FILE *fp;
 
 	ksft_print_msg("Checking for pass/fail\n");
@@ -83,49 +86,71 @@ static int check_results(struct resctrl_val_param *param, size_t span)
 	while (fgets(temp, sizeof(temp), fp)) {
 		char *token = strtok(temp, ":\t");
 		int fields = 0;
+		int bits;
 
 		while (token) {
 			token_array[fields++] = token;
 			token = strtok(NULL, ":\t");
 		}
-		/*
-		 * Discard the first value which is inaccurate due to monitoring
-		 * setup transition phase.
-		 */
-		if (runs > 0)
-			sum_llc_perf_miss += strtoull(token_array[3], NULL, 0);
+
+		sum_llc_perf_miss += strtoull(token_array[3], NULL, 0);
 		runs++;
+
+		if (runs < NUM_OF_RUNS)
+			continue;
+
+		if (!current_mask) {
+			ksft_print_msg("Unexpected empty cache mask\n");
+			break;
+		}
+
+		alloc_size = cache_size(cache_total_size, current_mask, full_cache_mask);
+
+		bits = count_bits(current_mask);
+
+		ret = show_results_info(sum_llc_perf_miss, bits,
+					alloc_size / 64,
+					MIN_DIFF_PERCENT_PER_BIT * (bits - 1), runs,
+					get_vendor() == ARCH_INTEL,
+					&prev_avg_llc_val);
+		if (ret)
+			fail = 1;
+
+		runs = 0;
+		sum_llc_perf_miss = 0;
+		current_mask = next_mask(current_mask);
 	}
 
 	fclose(fp);
-	no_of_bits = count_bits(param->mask);
 
-	return show_results_info(sum_llc_perf_miss, no_of_bits, span / 64,
-				 MAX_DIFF, MAX_DIFF_PERCENT, runs - 1,
-				 get_vendor() == ARCH_INTEL);
+	return fail;
 }
 
 void cat_test_cleanup(void)
 {
-	remove(RESULT_FILE_NAME1);
-	remove(RESULT_FILE_NAME2);
+	remove(RESULT_FILE_NAME);
 }
 
 /*
  * cat_test:	execute CAT benchmark and measure LLC cache misses
  * @param:	parameters passed to cat_test()
  * @span:	buffer size for the benchmark
+ * @current_mask	start mask for the first iteration
+ *
+ * Run CAT test, bits are removed one-by-one from the current_mask for each
+ * subsequent test.
  *
- * Return:	0 on success. non-zero on failure.
+ * Return:		0 on success. non-zero on failure.
  */
-static int cat_test(struct resctrl_val_param *param, size_t span)
+static int cat_test(struct resctrl_val_param *param, size_t span, unsigned long current_mask)
 {
-	int memflush = 1, operation = 0, ret = 0;
 	char *resctrl_val = param->resctrl_val;
 	static struct perf_event_read pe_read;
 	struct perf_event_attr pea;
+	unsigned char *buf;
+	char schemata[64];
+	int ret, i, pe_fd;
 	pid_t bm_pid;
-	int pe_fd;
 
 	if (strcmp(param->filename, "") == 0)
 		sprintf(param->filename, "stdio");
@@ -143,54 +168,64 @@ static int cat_test(struct resctrl_val_param *param, size_t span)
 	if (ret)
 		return ret;
 
+	buf = alloc_buffer(span, 1);
+	if (buf == NULL)
+		return -1;
+
 	perf_event_attr_initialize(&pea, PERF_COUNT_HW_CACHE_MISSES);
 	perf_event_initialize_read_format(&pe_read);
 
-	/* Test runs until the callback setup() tells the test to stop. */
-	while (1) {
-		ret = param->setup(param);
-		if (ret == END_OF_TESTS) {
-			ret = 0;
-			break;
-		}
-		if (ret < 0)
-			break;
-		pe_fd = perf_event_reset_enable(&pea, bm_pid, param->cpu_no);
-		if (pe_fd < 0) {
-			ret = -1;
-			break;
-		}
+	while (current_mask) {
+		snprintf(schemata, sizeof(schemata), "%lx", param->mask & ~current_mask);
+		ret = write_schemata("", schemata, param->cpu_no, param->resctrl_val);
+		if (ret)
+			goto free_buf;
+		snprintf(schemata, sizeof(schemata), "%lx", current_mask);
+		ret = write_schemata(param->ctrlgrp, schemata, param->cpu_no, param->resctrl_val);
+		if (ret)
+			goto free_buf;
+
+		for (i = 0; i < NUM_OF_RUNS; i++) {
+			mem_flush(buf, span);
+			ret = fill_cache_read(buf, span, true);
+			if (ret)
+				goto free_buf;
+
+			pe_fd = perf_event_reset_enable(&pea, bm_pid, param->cpu_no);
+			if (pe_fd < 0) {
+				ret = -1;
+				goto free_buf;
+			}
 
-		if (run_fill_buf(span, memflush, operation, true)) {
-			fprintf(stderr, "Error-running fill buffer\n");
-			ret = -1;
-			goto pe_close;
-		}
+			fill_cache_read(buf, span, true);
 
-		sleep(1);
-		ret = perf_event_measure(pe_fd, &pe_read, param, bm_pid);
-		if (ret)
-			goto pe_close;
+			ret = perf_event_measure(pe_fd, &pe_read, param, bm_pid);
+			if (ret)
+				goto pe_close;
 
-		close(pe_fd);
+			close(pe_fd);
+		}
+		current_mask = next_mask(current_mask);
 	}
 
+free_buf:
+	free(buf);
+
 	return ret;
 
 pe_close:
 	close(pe_fd);
-	return ret;
+	goto free_buf;
 }
 
 int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 {
-	unsigned long l_mask, l_mask_1;
-	int ret, pipefd[2], sibling_cpu_no;
+	unsigned long long_mask, start_mask, full_cache_mask;
 	unsigned long cache_total_size = 0;
-	unsigned long full_cache_mask, long_mask;
+	unsigned int start;
 	int count_of_bits;
-	char pipe_message;
 	size_t span;
+	int ret;
 
 	/* Get default cbm mask for L3/L2 cache */
 	ret = get_cbm_mask(cache_type, &full_cache_mask);
@@ -207,8 +242,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		return ret;
 	ksft_print_msg("Cache size :%lu\n", cache_total_size);
 
-	/* Get max number of bits from default-cabm mask */
-	count_of_bits = count_bits(long_mask);
+	count_of_bits = count_contiguous_bits(long_mask, &start);
 
 	if (!n)
 		n = count_of_bits / 2;
@@ -219,88 +253,26 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 			       count_of_bits - 1);
 		return -1;
 	}
-
-	/* Get core id from same socket for running another thread */
-	sibling_cpu_no = get_core_sibling(cpu_no);
-	if (sibling_cpu_no < 0)
-		return -1;
+	start_mask = create_bit_mask(start, n);
 
 	struct resctrl_val_param param = {
 		.resctrl_val	= CAT_STR,
 		.cpu_no		= cpu_no,
-		.setup		= cat_setup,
+		.ctrlgrp	= "c1",
+		.filename	= RESULT_FILE_NAME,
+		.num_of_runs	= 0,
 	};
-
-	l_mask = long_mask >> n;
-	l_mask_1 = ~l_mask & long_mask;
-
-	/* Set param values for parent thread which will be allocated bitmask
-	 * with (max_bits - n) bits
-	 */
-	span = cache_size(cache_total_size, l_mask, full_cache_mask);
-	strcpy(param.ctrlgrp, "c2");
-	strcpy(param.mongrp, "m2");
-	strcpy(param.filename, RESULT_FILE_NAME2);
-	param.mask = l_mask;
-	param.num_of_runs = 0;
-
-	if (pipe(pipefd)) {
-		perror("# Unable to create pipe");
-		return errno;
-	}
-
-	fflush(stdout);
-	bm_pid = fork();
-
-	/* Set param values for child thread which will be allocated bitmask
-	 * with n bits
-	 */
-	if (bm_pid == 0) {
-		param.mask = l_mask_1;
-		strcpy(param.ctrlgrp, "c1");
-		strcpy(param.mongrp, "m1");
-		span = cache_size(cache_total_size, l_mask_1, full_cache_mask);
-		strcpy(param.filename, RESULT_FILE_NAME1);
-		param.num_of_runs = 0;
-		param.cpu_no = sibling_cpu_no;
-	}
+	param.mask = long_mask;
+	span = cache_size(cache_total_size, start_mask, full_cache_mask);
 
 	remove(param.filename);
 
-	ret = cat_test(&param, span);
-	if (ret == 0)
-		ret = check_results(&param, span);
-
-	if (bm_pid == 0) {
-		/* Tell parent that child is ready */
-		close(pipefd[0]);
-		pipe_message = 1;
-		if (write(pipefd[1], &pipe_message, sizeof(pipe_message)) <
-		    sizeof(pipe_message))
-			/*
-			 * Just print the error message.
-			 * Let while(1) run and wait for itself to be killed.
-			 */
-			perror("# failed signaling parent process");
-
-		close(pipefd[1]);
-		while (1)
-			;
-	} else {
-		/* Parent waits for child to be ready. */
-		close(pipefd[1]);
-		pipe_message = 0;
-		while (pipe_message != 1) {
-			if (read(pipefd[0], &pipe_message,
-				 sizeof(pipe_message)) < sizeof(pipe_message)) {
-				perror("# failed reading from child process");
-				break;
-			}
-		}
-		close(pipefd[0]);
-		kill(bm_pid, SIGKILL);
-	}
+	ret = cat_test(&param, span, start_mask);
+	if (ret)
+		goto out;
 
+	ret = check_results(&param, cache_type, cache_total_size, full_cache_mask, start_mask);
+out:
 	cat_test_cleanup();
 
 	return ret;
diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 326d530425d0..3dbb71371715 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -38,7 +38,7 @@ static void cl_flush(void *p)
 #endif
 }
 
-static void mem_flush(unsigned char *buf, size_t buf_size)
+void mem_flush(unsigned char *buf, size_t buf_size)
 {
 	unsigned char *cp = buf;
 	size_t i = 0;
@@ -100,7 +100,7 @@ static void fill_one_span_write(unsigned char *buf, size_t buf_size)
 	}
 }
 
-static int fill_cache_read(unsigned char *buf, size_t buf_size, bool once)
+int fill_cache_read(unsigned char *buf, size_t buf_size, bool once)
 {
 	int ret = 0;
 	FILE *fp;
@@ -134,7 +134,7 @@ static int fill_cache_write(unsigned char *buf, size_t buf_size, bool once)
 	return 0;
 }
 
-static unsigned char *alloc_buffer(size_t buf_size, int memflush)
+unsigned char *alloc_buffer(size_t buf_size, int memflush)
 {
 	void *p = NULL;
 	uint64_t *p64;
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index ee3cee74a69c..927f696e0ab7 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -99,6 +99,9 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
 			    char *resctrl_val);
 int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 		    int group_fd, unsigned long flags);
+unsigned char *alloc_buffer(size_t buf_size, int memflush);
+void mem_flush(unsigned char *buf, size_t buf_size);
+int fill_cache_read(unsigned char *buf, size_t buf_size, bool once);
 int run_fill_buf(size_t buf_size, int memflush, int op, bool once);
 int resctrl_val(const char * const *benchmark_cmd, struct resctrl_val_param *param);
 int mbm_bw_change(int cpu_no, const char * const *benchmark_cmd);
@@ -107,6 +110,7 @@ void mbm_test_cleanup(void);
 int mba_schemata_change(int cpu_no, const char * const *benchmark_cmd);
 void mba_test_cleanup(void);
 unsigned long create_bit_mask(unsigned int start, unsigned int len);
+unsigned int count_contiguous_bits(unsigned long val, unsigned int *start);
 int get_cbm_mask(const char *cache_type, unsigned long *mask);
 int get_shareable_mask(const char *cache_type, unsigned long *shareable_mask);
 int get_mask_no_shareable(const char *cache_type, unsigned long *mask);
@@ -119,7 +123,6 @@ int cat_perf_miss_val(int cpu_no, int no_of_bits, char *cache_type);
 int cmt_resctrl_val(int cpu_no, int n, const char * const *benchmark_cmd);
 unsigned int count_bits(unsigned long n);
 void cmt_test_cleanup(void);
-int get_core_sibling(int cpu_no);
 
 void perf_event_attr_initialize(struct perf_event_attr *pea, __u64 config);
 void perf_event_initialize_read_format(struct perf_event_read *pe_read);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 02b04878121f..c8fbbd96311d 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -245,7 +245,7 @@ unsigned long create_bit_mask(unsigned int start, unsigned int len)
  *
  * Return:	The length of the contiguous bits in the longest train of bits
  */
-static unsigned int count_contiguous_bits(unsigned long val, unsigned int *start)
+unsigned int count_contiguous_bits(unsigned long val, unsigned int *start)
 {
 	unsigned long last_val;
 	int count = 0;
@@ -337,48 +337,6 @@ int get_mask_no_shareable(const char *cache_type, unsigned long *mask)
 	return 0;
 }
 
-/*
- * get_core_sibling - Get sibling core id from the same socket for given CPU
- * @cpu_no:	CPU number
- *
- * Return:	> 0 on success, < 0 on failure.
- */
-int get_core_sibling(int cpu_no)
-{
-	char core_siblings_path[1024], cpu_list_str[64];
-	int sibling_cpu_no = -1;
-	FILE *fp;
-
-	sprintf(core_siblings_path, "%s%d/topology/core_siblings_list",
-		CORE_SIBLINGS_PATH, cpu_no);
-
-	fp = fopen(core_siblings_path, "r");
-	if (!fp) {
-		perror("Failed to open core siblings path");
-
-		return -1;
-	}
-	if (fscanf(fp, "%s", cpu_list_str) <= 0) {
-		perror("Could not get core_siblings list");
-		fclose(fp);
-
-		return -1;
-	}
-	fclose(fp);
-
-	char *token = strtok(cpu_list_str, "-,");
-
-	while (token) {
-		sibling_cpu_no = atoi(token);
-		/* Skipping core 0 as we don't want to run test on core 0 */
-		if (sibling_cpu_no != 0 && sibling_cpu_no != cpu_no)
-			break;
-		token = strtok(NULL, "-,");
-	}
-
-	return sibling_cpu_no;
-}
-
 /*
  * taskset_benchmark - Taskset PID (i.e. benchmark) to a specified cpu
  * @bm_pid:	PID that should be binded
-- 
2.30.2

