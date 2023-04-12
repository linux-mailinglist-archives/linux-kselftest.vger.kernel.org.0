Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062A56DF6F8
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 15:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjDLNXD (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 09:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230403AbjDLNWs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 09:22:48 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A85B100;
        Wed, 12 Apr 2023 06:22:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681305746; x=1712841746;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5LdqeCjlUNN//g8wQKDBwpqlqMzd6xip8HIfAleJhmY=;
  b=al235j+vB58+940KetJVVRf6+LN0GgS0wylHuirN/mDF4RAj/NU4F5Nz
   PVZ+i1bl9KkoyAA/KHPGsTmVJWzAJjLG8FIvKubK7eYd6Cd0TWVQxEKqy
   fAzu6cBPG4XuN7YSNJ1aREMxMPqaxALtU0xyHMoxB+u4F6evJRuChxQir
   C01YjaprF/de/SoY+x2iVduxh+/MChHo2Azj7v91Vqt/2Y/MwVzxa84M+
   AxKswpdml345P93jyqOmcdzbZ5c4MoCPd9Dctfe0sth9nj/DPwFjiqwvL
   Gnys2wAliGd68vACJjBPoUTYJXYiesPTQ4nLfV4OW3ef3oJw3LUwVxIsP
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332590102"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332590102"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:22:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="639230063"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="639230063"
Received: from chanse1-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.80])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:21:59 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 07/22] selftests/resctrl: Remove "malloc_and_init_memory" param from run_fill_buf()
Date:   Wed, 12 Apr 2023 16:21:07 +0300
Message-Id: <20230412132122.29452-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230412132122.29452-1-ilpo.jarvinen@linux.intel.com>
References: <20230412132122.29452-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
 tools/testing/selftests/resctrl/cache.c       |  6 ++---
 tools/testing/selftests/resctrl/fill_buf.c    | 27 +++----------------
 tools/testing/selftests/resctrl/resctrl.h     |  3 +--
 .../testing/selftests/resctrl/resctrl_tests.c | 13 +++++----
 tools/testing/selftests/resctrl/resctrlfs.c   | 12 ++++-----
 5 files changed, 19 insertions(+), 42 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 11105ba30eff..ed5ec8a78c30 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -212,7 +212,7 @@ int measure_cache_vals(struct resctrl_val_param *param, int bm_pid)
  */
 int cat_val(struct resctrl_val_param *param)
 {
-	int malloc_and_init_memory = 1, memflush = 1, operation = 0, ret = 0;
+	int memflush = 1, operation = 0, ret = 0;
 	char *resctrl_val = param->resctrl_val;
 	pid_t bm_pid;
 
@@ -249,8 +249,8 @@ int cat_val(struct resctrl_val_param *param)
 			if (ret)
 				break;
 
-			if (run_fill_buf(param->span, malloc_and_init_memory,
-					 memflush, operation, resctrl_val)) {
+			if (run_fill_buf(param->span, memflush, operation,
+					 resctrl_val)) {
 				fprintf(stderr, "Error-running fill buffer\n");
 				ret = -1;
 				break;
diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 3cd0b337eae5..b1e883ecbd60 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -147,35 +147,18 @@ static int fill_cache_write(unsigned char *start_ptr, unsigned char *end_ptr,
 }
 
 static int
-fill_cache(unsigned long long buf_size, int malloc_and_init, int memflush,
-	   int op, char *resctrl_val)
+fill_cache(unsigned long long buf_size, int memflush, int op, char *resctrl_val)
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
@@ -195,8 +178,7 @@ fill_cache(unsigned long long buf_size, int malloc_and_init, int memflush,
 	return 0;
 }
 
-int run_fill_buf(unsigned long span, int malloc_and_init_memory,
-		 int memflush, int op, char *resctrl_val)
+int run_fill_buf(unsigned long span, int memflush, int op, char *resctrl_val)
 {
 	unsigned long long cache_size = span;
 	int ret;
@@ -207,8 +189,7 @@ int run_fill_buf(unsigned long span, int malloc_and_init_memory,
 	if (signal(SIGHUP, ctrl_handler) == SIG_ERR)
 		printf("Failed to catch SIGHUP!\n");
 
-	ret = fill_cache(cache_size, malloc_and_init_memory, memflush, op,
-			 resctrl_val);
+	ret = fill_cache(cache_size, memflush, op, resctrl_val);
 	if (ret) {
 		printf("\n Error in fill cache\n");
 		return -1;
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 1d80cd76c24a..037c6914d27a 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -97,8 +97,7 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
 			    char *resctrl_val);
 int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 		    int group_fd, unsigned long flags);
-int run_fill_buf(unsigned long span, int malloc_and_init_memory, int memflush,
-		 int op, char *resctrl_va);
+int run_fill_buf(unsigned long span, int memflush, int op, char *resctrl_val);
 int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param);
 int mbm_bw_change(unsigned long span, int cpu_no, char *bw_report, char **benchmark_cmd);
 void tests_cleanup(void);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 3ca6f09f5195..c80783ca5be3 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -83,7 +83,7 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, unsigned long span,
 	}
 
 	if (!has_ben)
-		sprintf(benchmark_cmd[5], "%s", MBA_STR);
+		sprintf(benchmark_cmd[4], "%s", MBA_STR);
 	res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
 	ksft_test_result(!res, "MBM: bw change\n");
 	if ((get_vendor() == ARCH_INTEL) && res)
@@ -119,7 +119,7 @@ static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
 	}
 
 	if (!has_ben)
-		sprintf(benchmark_cmd[5], "%s", CMT_STR);
+		sprintf(benchmark_cmd[4], "%s", CMT_STR);
 	res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
 	ksft_test_result(!res, "CMT: test\n");
 	if ((get_vendor() == ARCH_INTEL) && res)
@@ -235,16 +235,15 @@ int main(int argc, char **argv)
 		benchmark_cmd[ben_count] = NULL;
 	} else {
 		/* If no benchmark is given by "-b" argument, use fill_buf. */
-		for (i = 0; i < 6; i++)
+		for (i = 0; i < 5; i++)
 			benchmark_cmd[i] = benchmark_cmd_area[i];
 
 		strcpy(benchmark_cmd[0], "fill_buf");
 		sprintf(benchmark_cmd[1], "%lu", span);
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
index 9a58db077be6..1864911c2556 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -305,7 +305,7 @@ int taskset_benchmark(pid_t bm_pid, int cpu_no)
  */
 void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 {
-	int operation, ret, malloc_and_init_memory, memflush;
+	int operation, ret, memflush;
 	unsigned long span;
 	char **benchmark_cmd;
 	char resctrl_val[64];
@@ -324,13 +324,11 @@ void run_benchmark(int signum, siginfo_t *info, void *ucontext)
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

