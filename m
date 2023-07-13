Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A010752380
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 15:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235201AbjGMNV4 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 09:21:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234839AbjGMNV1 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 09:21:27 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A8035AD;
        Thu, 13 Jul 2023 06:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689254461; x=1720790461;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/q4GY8rhp2G88sSlAlKWw7Agjaw1iIMrjHxhCLVPXWA=;
  b=KpIZ/UCsakfhSsNc9tsIzcG7EqNc3GxmknsexERIFtoA2J+BPh7UkyU1
   0VFLwOse8jAM9P68ieTkhDHqKIy8666/95vPSJbeTbqf5iwDbI7NGpjAf
   IbbGnT3btdFkTpEI0Z127roONC5dT/SeoIeWDvvPtPMc6kLItB4TdJdJg
   MZoY0SLtrRQQO5CitzTeciTwPwQUJkm+JIxuoba13Oth8Ao3CV+JW9GPh
   SpprhK2fgiNNBLKm/NK16cjHz+Dl3mw+ONJ9zr3X9M9v0AYxl5xHQqdtc
   23joolTZKl9HU6PLtX1bN1eo1F7lASKENE6Jjr95k7zUxTxvMbVvbsHPQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="345496837"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="345496837"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 06:20:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="968615885"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="968615885"
Received: from ijarvine-mobl2.ger.corp.intel.com ([10.251.222.39])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 06:20:55 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 12/19] selftests/resctrl: Remove "malloc_and_init_memory" param from run_fill_buf()
Date:   Thu, 13 Jul 2023 16:19:25 +0300
Message-Id: <20230713131932.133258-13-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

run_fill_buf()'s malloc_and_init_memory parameter is always 1. There's
also duplicated memory init code for malloc_and_init_memory == 0 case
in fill_buf() which is unused.

Remove the malloc_and_init_memory parameter and the duplicated mem init
code.

While at it, fix also a typo in run_fill_buf() prototype's argument.

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c       |  6 ++--
 tools/testing/selftests/resctrl/fill_buf.c    | 28 +++----------------
 tools/testing/selftests/resctrl/resctrl.h     |  3 +-
 .../testing/selftests/resctrl/resctrl_tests.c | 13 ++++-----
 tools/testing/selftests/resctrl/resctrlfs.c   | 12 ++++----
 5 files changed, 19 insertions(+), 43 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index f2c7d322bd76..0db97b6a542f 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -211,7 +211,7 @@ int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
  */
 int cat_val(struct resctrl_val_param *param)
 {
-	int malloc_and_init_memory = 1, memflush = 1, operation = 0, ret = 0;
+	int memflush = 1, operation = 0, ret = 0;
 	char *resctrl_val = param->resctrl_val;
 	pid_t bm_pid;
 
@@ -248,8 +248,8 @@ int cat_val(struct resctrl_val_param *param)
 			if (ret)
 				break;
 
-			if (run_fill_buf(param->span, malloc_and_init_memory,
-					 memflush, operation, resctrl_val)) {
+			if (run_fill_buf(param->span, memflush, operation,
+					 resctrl_val)) {
 				fprintf(stderr, "Error-running fill buffer\n");
 				ret = -1;
 				close(fd_lm);
diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 785cbd8d0148..d8f5505eb9e6 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -138,36 +138,18 @@ static int fill_cache_write(unsigned char *start_ptr, unsigned char *end_ptr,
 	return 0;
 }
 
-static int
-fill_cache(size_t buf_size, int malloc_and_init, int memflush,
-	   int op, char *resctrl_val)
+static int fill_cache(size_t buf_size, int memflush, int op, char *resctrl_val)
 {
 	unsigned char *start_ptr, *end_ptr;
-	unsigned long long i;
 	int ret;
 
-	if (malloc_and_init)
-		start_ptr = malloc_and_init_memory(buf_size);
-	else
-		start_ptr = malloc(buf_size);
-
+	start_ptr = malloc_and_init_memory(buf_size);
 	if (!start_ptr)
 		return -1;
 
 	startptr = start_ptr;
 	end_ptr = start_ptr + buf_size;
 
-	/*
-	 * It's better to touch the memory once to avoid any compiler
-	 * optimizations
-	 */
-	if (!malloc_and_init) {
-		for (i = 0; i < buf_size; i++)
-			*start_ptr++ = (unsigned char)rand();
-	}
-
-	start_ptr = startptr;
-
 	/* Flush the memory before using to avoid "cache hot pages" effect */
 	if (memflush)
 		mem_flush(start_ptr, buf_size);
@@ -188,14 +170,12 @@ fill_cache(size_t buf_size, int malloc_and_init, int memflush,
 	return 0;
 }
 
-int run_fill_buf(size_t span, int malloc_and_init_memory, int memflush, int op,
-		 char *resctrl_val)
+int run_fill_buf(size_t span, int memflush, int op, char *resctrl_val)
 {
 	size_t cache_size = span;
 	int ret;
 
-	ret = fill_cache(cache_size, malloc_and_init_memory, memflush, op,
-			 resctrl_val);
+	ret = fill_cache(cache_size, memflush, op, resctrl_val);
 	if (ret) {
 		printf("\n Error in fill cache\n");
 		return -1;
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 52068ceea956..3054cc4ef0e3 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -97,8 +97,7 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
 			    char *resctrl_val);
 int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 		    int group_fd, unsigned long flags);
-int run_fill_buf(size_t span, int malloc_and_init_memory, int memflush, int op,
-		 char *resctrl_va);
+int run_fill_buf(size_t span, int memflush, int op, char *resctrl_val);
 int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param);
 int mbm_bw_change(size_t span, int cpu_no, char *bw_report, char **benchmark_cmd);
 void tests_cleanup(void);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 6e693f381a6e..0c313054326d 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -89,7 +89,7 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, size_t span,
 	}
 
 	if (!has_ben)
-		sprintf(benchmark_cmd[5], "%s", MBA_STR);
+		sprintf(benchmark_cmd[4], "%s", MBA_STR);
 	res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
 	ksft_test_result(!res, "MBM: bw change\n");
 	if ((get_vendor() == ARCH_INTEL) && res)
@@ -141,7 +141,7 @@ static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
 	}
 
 	if (!has_ben)
-		sprintf(benchmark_cmd[5], "%s", CMT_STR);
+		sprintf(benchmark_cmd[4], "%s", CMT_STR);
 	res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
 	ksft_test_result(!res, "CMT: test\n");
 	if ((get_vendor() == ARCH_INTEL) && res)
@@ -267,16 +267,15 @@ int main(int argc, char **argv)
 		benchmark_cmd[ben_count] = NULL;
 	} else {
 		/* If no benchmark is given by "-b" argument, use fill_buf. */
-		for (i = 0; i < 6; i++)
+		for (i = 0; i < 5; i++)
 			benchmark_cmd[i] = benchmark_cmd_area[i];
 
 		strcpy(benchmark_cmd[0], "fill_buf");
 		sprintf(benchmark_cmd[1], "%zu", span);
 		strcpy(benchmark_cmd[2], "1");
-		strcpy(benchmark_cmd[3], "1");
-		strcpy(benchmark_cmd[4], "0");
-		strcpy(benchmark_cmd[5], "");
-		benchmark_cmd[6] = NULL;
+		strcpy(benchmark_cmd[3], "0");
+		strcpy(benchmark_cmd[4], "");
+		benchmark_cmd[5] = NULL;
 	}
 
 	sprintf(bw_report, "reads");
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 847e0a80c6cd..5f41ce03c470 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -297,7 +297,7 @@ int taskset_benchmark(pid_t bm_pid, int cpu_no)
  */
 void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 {
-	int operation, ret, malloc_and_init_memory, memflush;
+	int operation, ret, memflush;
 	char **benchmark_cmd;
 	char resctrl_val[64];
 	size_t span;
@@ -316,13 +316,11 @@ void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 	if (strcmp(benchmark_cmd[0], "fill_buf") == 0) {
 		/* Execute default fill_buf benchmark */
 		span = strtoul(benchmark_cmd[1], NULL, 10);
-		malloc_and_init_memory = atoi(benchmark_cmd[2]);
-		memflush =  atoi(benchmark_cmd[3]);
-		operation = atoi(benchmark_cmd[4]);
-		sprintf(resctrl_val, "%s", benchmark_cmd[5]);
+		memflush =  atoi(benchmark_cmd[2]);
+		operation = atoi(benchmark_cmd[3]);
+		sprintf(resctrl_val, "%s", benchmark_cmd[4]);
 
-		if (run_fill_buf(span, malloc_and_init_memory, memflush,
-				 operation, resctrl_val))
+		if (run_fill_buf(span, memflush, operation, resctrl_val))
 			fprintf(stderr, "Error in running fill buffer\n");
 	} else {
 		/* Execute specified benchmark */
-- 
2.30.2

