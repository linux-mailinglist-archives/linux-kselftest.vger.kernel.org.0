Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 462AC6E605D
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 13:49:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjDRLtN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 07:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjDRLtE (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 07:49:04 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC4883D4;
        Tue, 18 Apr 2023 04:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681818513; x=1713354513;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=tJ4gjGRf43MnpoYHW8bPtBTaG6etTX3413E6p2EHI74=;
  b=BO88OQHGoEixC5ovDq56i780n7ZOLCEdyo1czhALB9AgYD9sYvzkAOVF
   oDCB+LBqggUUWkjEZGgLqW5OgMOj6/9hvFZcR9A4yj7apxkP3VJi2cSyh
   qUJqprbIh6KQW8kSSXMQG5f2FDfW1jdtiIoNfQefWYPUE7q4hxVAqxqc5
   bz3j+/LK/cdwtBNldZM0Anm597fyU8ccBqOX1ymrz9eNfnNHUgJWM41wE
   3hzVY+OVdeg6YVuZLAoTKOhzfbywrVBo+xvUi9o2Hf9FEGktDAQVsoFga
   UlPe7ROetUR35cJ4FVcGZwoGG9P/XWWsz5+HCDWg4CZ9T7Gr0XPZyFtER
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="346994522"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="346994522"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:46:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="723601908"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="723601908"
Received: from yvolokit-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.103])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:46:37 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 24/24] selftests/resctrl: Rewrite Cache Allocation Technology (CAT) test
Date:   Tue, 18 Apr 2023 14:45:06 +0300
Message-Id: <20230418114506.46788-25-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
References: <20230418114506.46788-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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

Rewrite the CAT test to allocated a buffer sized to half of LLC. Then
perform a sequence of tests with different LLC alloc sizes starting
from half of the CBM bits down to 1-bit CBM. Flush the buffer before
each test and read the buffer twice. Observe the LLC misses on the
second read through the buffer. As the allocated LLC block gets smaller
and smaller, the LLC misses will become larger and larger giving a
strong signal on CAT working properly.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c    |  20 +-
 tools/testing/selftests/resctrl/cat_test.c | 204 +++++++++------------
 2 files changed, 97 insertions(+), 127 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 7970239413da..64f08ba5edc2 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -224,10 +224,10 @@ int measure_llc_resctrl(struct resctrl_val_param *param, int bm_pid)
  */
 int cat_val(struct resctrl_val_param *param)
 {
-	int memflush = 1, operation = 0, ret = 0;
 	char *resctrl_val = param->resctrl_val;
 	unsigned long llc_perf_miss = 0;
 	pid_t bm_pid;
+	int ret;
 
 	if (strcmp(param->filename, "") == 0)
 		sprintf(param->filename, "stdio");
@@ -245,6 +245,10 @@ int cat_val(struct resctrl_val_param *param)
 	if (ret)
 		return ret;
 
+	ret = alloc_buffer(param->span, 1);
+	if (ret)
+		return ret;
+
 	initialize_llc_perf();
 
 	/* Test runs until the callback setup() tells the test to stop. */
@@ -256,17 +260,15 @@ int cat_val(struct resctrl_val_param *param)
 		}
 		if (ret < 0)
 			break;
+
+		flush_buffer(param->span);
+		use_buffer(param->span, 0, true);
+
 		ret = reset_enable_llc_perf(bm_pid, param->cpu_no);
 		if (ret)
 			break;
 
-		if (run_fill_buf(param->span, memflush, operation, true)) {
-			fprintf(stderr, "Error-running fill buffer\n");
-			ret = -1;
-			break;
-		}
-
-		sleep(1);
+		use_buffer(param->span, 0, true);
 
 		/* Measure cache miss from perf */
 		ret = get_llc_perf(&llc_perf_miss);
@@ -279,6 +281,8 @@ int cat_val(struct resctrl_val_param *param)
 			break;
 	}
 
+	free_buffer();
+
 	return ret;
 }
 
diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 4b505fdb35d7..85053829b9c5 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -11,11 +11,12 @@
 #include "resctrl.h"
 #include <unistd.h>
 
-#define RESULT_FILE_NAME1	"result_cat1"
-#define RESULT_FILE_NAME2	"result_cat2"
-#define NUM_OF_RUNS		5
-#define MAX_DIFF_PERCENT	4
-#define MAX_DIFF		1000000
+#define RESULT_FILE_NAME		"result_cat"
+#define NUM_OF_RUNS			5
+#define MIN_DIFF_PERCENT_PER_BIT	2
+
+static unsigned long current_mask;
+static long prev_avg_llc_val;
 
 /*
  * Change schemata. Write schemata to specified
@@ -28,13 +29,24 @@ static int cat_setup(struct resctrl_val_param *p)
 	int ret = 0;
 
 	/* Run NUM_OF_RUNS times */
-	if (p->num_of_runs >= NUM_OF_RUNS)
-		return END_OF_TESTS;
+	if (p->num_of_runs >= NUM_OF_RUNS) {
+		/* Remove one bit from the consecutive block */
+		current_mask &= current_mask >> 1;
+		if (!current_mask)
+			return END_OF_TESTS;
+
+		p->num_of_runs = 0;
+	}
 
 	if (p->num_of_runs == 0) {
-		sprintf(schemata, "%lx", p->mask);
-		ret = write_schemata(p->ctrlgrp, schemata, p->cpu_no,
-				     p->resctrl_val);
+		snprintf(schemata, sizeof(schemata), "%lx", p->mask & ~current_mask);
+		ret = write_schemata("", schemata, p->cpu_no, p->resctrl_val);
+		if (ret)
+			return ret;
+		snprintf(schemata, sizeof(schemata), "%lx", current_mask);
+		ret = write_schemata(p->ctrlgrp, schemata, p->cpu_no, p->resctrl_val);
+		if (ret)
+			return ret;
 	}
 	p->num_of_runs++;
 
@@ -42,34 +54,41 @@ static int cat_setup(struct resctrl_val_param *p)
 }
 
 static int show_results_info(unsigned long sum_llc_val, int no_of_bits,
-			     unsigned long cache_span, unsigned long max_diff,
-			     unsigned long max_diff_percent, unsigned long num_of_runs,
-			     bool platform)
+			     unsigned long cache_span, long min_diff_percent,
+			     unsigned long num_of_runs, bool platform)
 {
-	unsigned long avg_llc_val = 0;
-	float diff_percent;
-	int ret;
+	long avg_llc_val = 0;
+	int avg_diff_per;
+	float avg_diff;
+	int ret = 0;
 
 	avg_llc_val = sum_llc_val / num_of_runs;
-	diff_percent = ((float)cache_span - avg_llc_val) / cache_span * 100;
+	avg_diff = (float)(avg_llc_val - prev_avg_llc_val) / prev_avg_llc_val;
+	avg_diff_per = (int)(avg_diff * 100);
 
-	ret = platform && abs((int)diff_percent) > max_diff_percent;
+	if (prev_avg_llc_val) {
+		ret = platform && avg_diff_per < min_diff_percent;
 
-	ksft_print_msg("%s Check cache miss rate within %d%%\n",
-		       ret ? "Fail:" : "Pass:", max_diff_percent);
+		ksft_print_msg("%s Check cache miss rate changed more than %d%%\n",
+			       ret ? "Fail:" : "Pass:", min_diff_percent);
 
-	ksft_print_msg("Percent diff=%d\n", abs((int)diff_percent));
+		ksft_print_msg("Percent diff=%d\n", avg_diff_per);
+	}
+	prev_avg_llc_val = avg_llc_val;
 
 	show_cache_info(no_of_bits, avg_llc_val, cache_span, true);
 
 	return ret;
 }
 
-static int check_results(struct resctrl_val_param *param)
+static int check_results(struct resctrl_val_param *param, char *cache_type)
 {
 	char *token_array[8], temp[512];
 	unsigned long sum_llc_perf_miss = 0;
-	int runs = 0, no_of_bits = 0;
+	unsigned long alloc_size;
+	int runs = 0;
+	int fail = 0;
+	int ret;
 	FILE *fp;
 
 	ksft_print_msg("Checking for pass/fail\n");
@@ -83,42 +102,59 @@ static int check_results(struct resctrl_val_param *param)
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
-			sum_llc_perf_miss += strtoul(token_array[3], NULL, 0);
+
+		sum_llc_perf_miss += strtoul(token_array[3], NULL, 0);
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
+		ret = cache_alloc_size(param->cpu_no, cache_type, current_mask, &alloc_size);
+		if (ret)
+			return ret;
+
+		bits = count_bits(current_mask);
+
+		ret = show_results_info(sum_llc_perf_miss, bits,
+					alloc_size / 64,
+					MIN_DIFF_PERCENT_PER_BIT * bits, runs,
+					get_vendor() == ARCH_INTEL);
+		if (ret)
+			fail = 1;
+
+		runs = 0;
+		sum_llc_perf_miss = 0;
+		current_mask &= current_mask >> 1;
 	}
 
 	fclose(fp);
-	no_of_bits = count_consecutive_bits(param->mask, NULL);
 
-	return show_results_info(sum_llc_perf_miss, no_of_bits, param->span / 64,
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
 
 int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 {
-	unsigned long l_mask, l_mask_1;
-	int ret, pipefd[2], sibling_cpu_no;
 	unsigned long cache_size;
 	unsigned long long_mask;
+	unsigned int start;
 	int count_of_bits;
-	char pipe_message;
+	int ret;
 
 	cache_size = 0;
 
@@ -126,7 +162,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	ret = get_mask_no_shareable(cache_type, &long_mask);
 	if (ret)
 		return ret;
-	count_of_bits = count_consecutive_bits(long_mask, NULL);
+	count_of_bits = count_consecutive_bits(long_mask, &start);
 
 	/* Get L3/L2 cache size */
 	ret = get_cache_size(cpu_no, cache_type, &cache_size);
@@ -143,99 +179,29 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 			       count_of_bits - 1);
 		return -1;
 	}
-
-	/* Get core id from same socket for running another thread */
-	sibling_cpu_no = get_core_sibling(cpu_no);
-	if (sibling_cpu_no < 0)
-		return -1;
+	current_mask = create_bit_mask(start, n);
 
 	struct resctrl_val_param param = {
 		.resctrl_val	= CAT_STR,
 		.cpu_no		= cpu_no,
+		.ctrlgrp	= "c1",
 		.setup		= cat_setup,
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
-	ret = cache_alloc_size(cpu_no, cache_type, l_mask, &param.span);
+	param.mask = long_mask;
+	ret = cache_alloc_size(cpu_no, cache_type, current_mask, &param.span);
 	if (ret)
 		return ret;
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
-		ret = cache_alloc_size(cpu_no, cache_type, l_mask_1, &param.span);
-		if (ret)
-			exit(-1);
-		strcpy(param.filename, RESULT_FILE_NAME1);
-		param.num_of_runs = 0;
-		param.cpu_no = sibling_cpu_no;
-	} else {
-		ret = signal_handler_register();
-		if (ret) {
-			kill(bm_pid, SIGKILL);
-			goto out;
-		}
-	}
 
 	remove(param.filename);
 
 	ret = cat_val(&param);
-	if (ret == 0)
-		ret = check_results(&param);
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
-		signal_handler_unregister();
-	}
+	if (ret)
+		goto out;
 
+	current_mask = create_bit_mask(start, n);
+	ret = check_results(&param, cache_type);
 out:
 	cat_test_cleanup();
 
-- 
2.30.2

