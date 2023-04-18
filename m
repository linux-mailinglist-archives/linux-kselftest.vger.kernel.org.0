Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0156E603A
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 13:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjDRLqh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 07:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjDRLq3 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 07:46:29 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178A29747;
        Tue, 18 Apr 2023 04:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681818361; x=1713354361;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XHJ2GUd5k0MdI2CtmQnbJhZrefndWCwGDZ1J6X0FNXE=;
  b=lMOLZCZPbE7v5TiIBTfBrvQhHWBdMToUY9WqGHnBKEifie3BrWeJOmbI
   KpjqmOqbN43zF3EDwi3ehtrBh4sOfslOIyAFZXNN7DJlBuXYC9LYBRsOY
   SeR6YYucazJdbPhJUhQzx9FtsYtwpWEQ7Qesj1ulLyo7Ecq3rjyiEweMP
   9YUMMDf60mCrv6lhWoZwmv/LpsLgXO7V8SosbhvQhEIEyckvKAufPDvae
   qW+wAKE0t3Rc7P1BRjNzq5mWaSYVisxSrOiqubpVarX+aGS14dL8o6IyP
   dMjnQR3PzNC0ZQqMDVrdK6eTKd0ROZYEgNpJGnwMkRpuJgpg2xGwjN3YJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="346994346"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="346994346"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:45:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="723601636"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="723601636"
Received: from yvolokit-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.103])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:45:52 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 09/24] selftests/resctrl: Remove "malloc_and_init_memory" param from run_fill_buf()
Date:   Tue, 18 Apr 2023 14:44:51 +0300
Message-Id: <20230418114506.46788-10-ilpo.jarvinen@linux.intel.com>
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
index 341cc93ca84c..5cdb421a2f6c 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -139,35 +139,18 @@ static int fill_cache_write(unsigned char *start_ptr, unsigned char *end_ptr,
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
@@ -187,14 +170,12 @@ fill_cache(unsigned long long buf_size, int malloc_and_init, int memflush,
 	return 0;
 }
 
-int run_fill_buf(unsigned long span, int malloc_and_init_memory,
-		 int memflush, int op, char *resctrl_val)
+int run_fill_buf(unsigned long span, int memflush, int op, char *resctrl_val)
 {
 	unsigned long long cache_size = span;
 	int ret;
 
-	ret = fill_cache(cache_size, malloc_and_init_memory, memflush, op,
-			 resctrl_val);
+	ret = fill_cache(cache_size, memflush, op, resctrl_val);
 	if (ret) {
 		printf("\n Error in fill cache\n");
 		return -1;
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 4fd2eaf641e0..574adac8932d 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -95,8 +95,7 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
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
index 3c8ec68eb507..ef2977b5ecd4 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -89,7 +89,7 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, unsigned long span,
 	}
 
 	if (!has_ben)
-		sprintf(benchmark_cmd[5], "%s", MBA_STR);
+		sprintf(benchmark_cmd[4], "%s", MBA_STR);
 	res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
 	ksft_test_result(!res, "MBM: bw change\n");
 	if ((get_vendor() == ARCH_INTEL) && res)
@@ -142,7 +142,7 @@ static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
 	}
 
 	if (!has_ben)
-		sprintf(benchmark_cmd[5], "%s", CMT_STR);
+		sprintf(benchmark_cmd[4], "%s", CMT_STR);
 	res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
 	ksft_test_result(!res, "CMT: test\n");
 	if ((get_vendor() == ARCH_INTEL) && res)
@@ -269,16 +269,15 @@ int main(int argc, char **argv)
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
index 09e0a69c81c4..79e030065da8 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -295,7 +295,7 @@ int taskset_benchmark(pid_t bm_pid, int cpu_no)
  */
 void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 {
-	int operation, ret, malloc_and_init_memory, memflush;
+	int operation, ret, memflush;
 	unsigned long span;
 	char **benchmark_cmd;
 	char resctrl_val[64];
@@ -314,13 +314,11 @@ void run_benchmark(int signum, siginfo_t *info, void *ucontext)
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

