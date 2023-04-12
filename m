Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEE96DF6FF
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 15:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230007AbjDLNXd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 09:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjDLNXP (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 09:23:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848E1AD07;
        Wed, 12 Apr 2023 06:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681305768; x=1712841768;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v4QSfgm5ssb+0BWfSMGbHbevOrxP3fBmhG1mtfeJpbE=;
  b=Veq9xXFaR4NDfADuIxIl9e3wXMOPO6GK2VCoo7q0VLYQxf7Qww0cqOUj
   LaESRtQLxwmrq1WphrgGZDfyu90EkaBoN7i8cYhYEP/z99YPinRUgmd2F
   LywgE6E7lcjbSf/8+5lVgfW32LvpXeHWzUlPjNoMqnelZOlmwGIodau/U
   F29HSnFumXQWIfkXvtkq8bywvoeiQcPpCjDHJTC+f3/+8aPuL1lHk/9kY
   cvvnDAlPVesmULelATsZpmOylB9RR3vsdBKWAtpS3B0tlwgYCSK+JkR4H
   XsdxlmSeskiyLaAat8yFXIuQfeZHLnJBiHEZG6XXg0NkPRCOM5MxD1xdG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332590147"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332590147"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:22:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="639230072"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="639230072"
Received: from chanse1-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.80])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:22:14 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 10/22] selftests/resctrl: Don't pass test name to fill_buf
Date:   Wed, 12 Apr 2023 16:21:10 +0300
Message-Id: <20230412132122.29452-11-ilpo.jarvinen@linux.intel.com>
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

Test name is passed to fill_buf functions so that they can loop around
buffer only once. This is required for CAT test case.

To loop around buffer only once, we don't need to let fill_buf know
which test case it is. Instead, use a boolean argument 'once' which
makes fill_buf more generic.

As the benchmark_cmd no longer needs to include the test name, a few
test running functions can be simplified to not write the test name
into the default benchmark_cmd which allows dropping has_ben argument
from the functions too.

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cache.c       |  3 +--
 tools/testing/selftests/resctrl/fill_buf.c    | 22 +++++++++----------
 tools/testing/selftests/resctrl/resctrl.h     |  4 ++--
 .../testing/selftests/resctrl/resctrl_tests.c | 14 +++++-------
 tools/testing/selftests/resctrl/resctrlfs.c   | 11 +++++++---
 5 files changed, 27 insertions(+), 27 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index ed5ec8a78c30..a15f1f2715cd 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -249,8 +249,7 @@ int cat_val(struct resctrl_val_param *param)
 			if (ret)
 				break;
 
-			if (run_fill_buf(param->span, memflush, operation,
-					 resctrl_val)) {
+			if (run_fill_buf(param->span, memflush, operation, true)) {
 				fprintf(stderr, "Error-running fill buffer\n");
 				ret = -1;
 				break;
diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index c815c80f7a0c..f5ca0c573891 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -116,14 +116,14 @@ void fill_one_span_write(unsigned char *start_ptr, unsigned char *end_ptr)
 }
 
 static int fill_cache_read(unsigned char *start_ptr, unsigned char *end_ptr,
-			   char *resctrl_val)
+			   bool once)
 {
 	int ret = 0;
 	FILE *fp;
 
 	while (1) {
 		ret = fill_one_span_read(start_ptr, end_ptr);
-		if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)))
+		if (once)
 			break;
 	}
 
@@ -140,11 +140,11 @@ static int fill_cache_read(unsigned char *start_ptr, unsigned char *end_ptr,
 }
 
 static int fill_cache_write(unsigned char *start_ptr, unsigned char *end_ptr,
-			    char *resctrl_val)
+			    bool once)
 {
 	while (1) {
 		fill_one_span_write(start_ptr, end_ptr);
-		if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)))
+		if (once)
 			break;
 	}
 
@@ -164,16 +164,16 @@ int alloc_buffer(unsigned long long buf_size, int memflush)
 	return 0;
 }
 
-int use_buffer(unsigned long long buf_size, int op, char *resctrl_val)
+int use_buffer(unsigned long long buf_size, int op, bool once)
 {
 	unsigned char *end_ptr;
 	int ret;
 
 	end_ptr = startptr + buf_size;
 	if (op == 0)
-		ret = fill_cache_read(startptr, end_ptr, resctrl_val);
+		ret = fill_cache_read(startptr, end_ptr, once);
 	else
-		ret = fill_cache_write(startptr, end_ptr, resctrl_val);
+		ret = fill_cache_write(startptr, end_ptr, once);
 
 	if (ret)
 		printf("\n Error in fill cache read/write...\n");
@@ -182,7 +182,7 @@ int use_buffer(unsigned long long buf_size, int op, char *resctrl_val)
 }
 
 static int
-fill_cache(unsigned long long buf_size, int memflush, int op, char *resctrl_val)
+fill_cache(unsigned long long buf_size, int memflush, int op, bool once)
 {
 	int ret;
 
@@ -190,13 +190,13 @@ fill_cache(unsigned long long buf_size, int memflush, int op, char *resctrl_val)
 	if (ret)
 		return ret;
 
-	ret = use_buffer(buf_size, op, resctrl_val);
+	ret = use_buffer(buf_size, op, once);
 	free_buffer();
 
 	return ret;
 }
 
-int run_fill_buf(unsigned long span, int memflush, int op, char *resctrl_val)
+int run_fill_buf(unsigned long span, int memflush, int op, bool once)
 {
 	unsigned long long cache_size = span;
 	int ret;
@@ -207,7 +207,7 @@ int run_fill_buf(unsigned long span, int memflush, int op, char *resctrl_val)
 	if (signal(SIGHUP, ctrl_handler) == SIG_ERR)
 		printf("Failed to catch SIGHUP!\n");
 
-	ret = fill_cache(cache_size, memflush, op, resctrl_val);
+	ret = fill_cache(cache_size, memflush, op, once);
 	if (ret) {
 		printf("\n Error in fill cache\n");
 		return -1;
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 16876ac00bf1..968ac2a321ff 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -99,8 +99,8 @@ int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 		    int group_fd, unsigned long flags);
 void free_buffer(void);
 int alloc_buffer(unsigned long long buf_size, int memflush);
-int use_buffer(unsigned long long buf_size, int op, char *resctrl_val);
-int run_fill_buf(unsigned long span, int memflush, int op, char *resctrl_val);
+int use_buffer(unsigned long long buf_size, int op, bool once);
+int run_fill_buf(unsigned long span, int memflush, int op, bool once);
 int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param);
 int mbm_bw_change(unsigned long span, int cpu_no, char *bw_report, char **benchmark_cmd);
 void tests_cleanup(void);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index c80783ca5be3..a967525182d2 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -70,7 +70,7 @@ void tests_cleanup(void)
 	cat_test_cleanup();
 }
 
-static void run_mbm_test(bool has_ben, char **benchmark_cmd, unsigned long span,
+static void run_mbm_test(char **benchmark_cmd, unsigned long span,
 			 int cpu_no, char *bw_report)
 {
 	int res;
@@ -82,8 +82,6 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, unsigned long span,
 		return;
 	}
 
-	if (!has_ben)
-		sprintf(benchmark_cmd[4], "%s", MBA_STR);
 	res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
 	ksft_test_result(!res, "MBM: bw change\n");
 	if ((get_vendor() == ARCH_INTEL) && res)
@@ -108,7 +106,7 @@ static void run_mba_test(char **benchmark_cmd, unsigned long span, int cpu_no,
 	mba_test_cleanup();
 }
 
-static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
+static void run_cmt_test(char **benchmark_cmd, int cpu_no)
 {
 	int res;
 
@@ -118,8 +116,6 @@ static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
 		return;
 	}
 
-	if (!has_ben)
-		sprintf(benchmark_cmd[4], "%s", CMT_STR);
 	res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
 	ksft_test_result(!res, "CMT: test\n");
 	if ((get_vendor() == ARCH_INTEL) && res)
@@ -242,7 +238,7 @@ int main(int argc, char **argv)
 		sprintf(benchmark_cmd[1], "%lu", span);
 		strcpy(benchmark_cmd[2], "1");
 		strcpy(benchmark_cmd[3], "0");
-		strcpy(benchmark_cmd[4], "");
+		strcpy(benchmark_cmd[4], "false");
 		benchmark_cmd[5] = NULL;
 	}
 
@@ -257,13 +253,13 @@ int main(int argc, char **argv)
 	ksft_set_plan(tests ? : 4);
 
 	if ((get_vendor() == ARCH_INTEL) && mbm_test)
-		run_mbm_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
+		run_mbm_test(benchmark_cmd, span, cpu_no, bw_report);
 
 	if ((get_vendor() == ARCH_INTEL) && mba_test)
 		run_mba_test(benchmark_cmd, span, cpu_no, bw_report);
 
 	if (cmt_test)
-		run_cmt_test(has_ben, benchmark_cmd, cpu_no);
+		run_cmt_test(benchmark_cmd, cpu_no);
 
 	if (cat_test)
 		run_cat_test(cpu_no, no_of_bits);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 1864911c2556..a63479f94a3e 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -308,7 +308,7 @@ void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 	int operation, ret, memflush;
 	unsigned long span;
 	char **benchmark_cmd;
-	char resctrl_val[64];
+	bool once;
 	FILE *fp;
 
 	benchmark_cmd = info->si_ptr;
@@ -326,9 +326,14 @@ void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 		span = strtoul(benchmark_cmd[1], NULL, 10);
 		memflush =  atoi(benchmark_cmd[2]);
 		operation = atoi(benchmark_cmd[3]);
-		sprintf(resctrl_val, "%s", benchmark_cmd[4]);
+		if (!strcmp(benchmark_cmd[4], "true"))
+			once = true;
+		else if (!strcmp(benchmark_cmd[4], "false"))
+			once = false;
+		else
+			PARENT_EXIT("Invalid once parameter");
 
-		if (run_fill_buf(span, memflush, operation, resctrl_val))
+		if (run_fill_buf(span, memflush, operation, once))
 			fprintf(stderr, "Error in running fill buffer\n");
 	} else {
 		/* Execute specified benchmark */
-- 
2.30.2

