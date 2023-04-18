Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 734B66E6041
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 13:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjDRLrF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 07:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjDRLrC (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 07:47:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562EFAF0D;
        Tue, 18 Apr 2023 04:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681818389; x=1713354389;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2cJvkLl7uJW3RSLVTBlhZ4q2eZfLppbJ88qjoc9yDa0=;
  b=Q7nGJCAgfkHihVbT/A7NtW5YJMlBa50WI7X9dtDsYYXSUQL0uywAbKRm
   WyOA1S0YSEoWci1oLwMc9Fll/7NgDWV2qARISGCUDjMjGg8T5YWFqiaOO
   l3FaHUynWlzxr7h1bMv+RXeqvCOr8JNO1/cEu4Wt/siinhh0p800xNcaN
   hZDyMfDXSRpOKdxFkJSyI35degQRmQHcfersQMfY9GQPXZ+iFaimDc+6D
   A29YxQnsp9sDQxinDHSsg2T9qU7Ahfc2fh8ZdWmuM0grCzxdOkm8ktxzu
   Adhf7XTFpee9D5eNYkuCEgolyxOu6SXb0ZVD6VHdNm6yWxxNbPexPMtKV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="346994375"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="346994375"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:46:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="723601690"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="723601690"
Received: from yvolokit-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.103])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:46:01 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 12/24] selftests/resctrl: Don't pass test name to fill_buf
Date:   Tue, 18 Apr 2023 14:44:54 +0300
Message-Id: <20230418114506.46788-13-ilpo.jarvinen@linux.intel.com>
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
index 3a10b554d778..677e1a113629 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -108,14 +108,14 @@ void fill_one_span_write(unsigned char *start_ptr, unsigned char *end_ptr)
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
 
@@ -132,11 +132,11 @@ static int fill_cache_read(unsigned char *start_ptr, unsigned char *end_ptr,
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
 
@@ -156,16 +156,16 @@ int alloc_buffer(unsigned long long buf_size, int memflush)
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
@@ -174,7 +174,7 @@ int use_buffer(unsigned long long buf_size, int op, char *resctrl_val)
 }
 
 static int
-fill_cache(unsigned long long buf_size, int memflush, int op, char *resctrl_val)
+fill_cache(unsigned long long buf_size, int memflush, int op, bool once)
 {
 	int ret;
 
@@ -182,18 +182,18 @@ fill_cache(unsigned long long buf_size, int memflush, int op, char *resctrl_val)
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
 
-	ret = fill_cache(cache_size, memflush, op, resctrl_val);
+	ret = fill_cache(cache_size, memflush, op, once);
 	if (ret) {
 		printf("\n Error in fill cache\n");
 		return -1;
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 75bfa2b2746d..8748121345f3 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -97,8 +97,8 @@ int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
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
index ef2977b5ecd4..6e710989f368 100644
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
@@ -88,8 +88,6 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, unsigned long span,
 		goto umount;
 	}
 
-	if (!has_ben)
-		sprintf(benchmark_cmd[4], "%s", MBA_STR);
 	res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
 	ksft_test_result(!res, "MBM: bw change\n");
 	if ((get_vendor() == ARCH_INTEL) && res)
@@ -124,7 +122,7 @@ static void run_mba_test(char **benchmark_cmd, unsigned long span, int cpu_no,
 	umount_resctrlfs();
 }
 
-static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
+static void run_cmt_test(char **benchmark_cmd, int cpu_no)
 {
 	int res;
 
@@ -141,8 +139,6 @@ static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
 		goto umount;
 	}
 
-	if (!has_ben)
-		sprintf(benchmark_cmd[4], "%s", CMT_STR);
 	res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
 	ksft_test_result(!res, "CMT: test\n");
 	if ((get_vendor() == ARCH_INTEL) && res)
@@ -276,7 +272,7 @@ int main(int argc, char **argv)
 		sprintf(benchmark_cmd[1], "%lu", span);
 		strcpy(benchmark_cmd[2], "1");
 		strcpy(benchmark_cmd[3], "0");
-		strcpy(benchmark_cmd[4], "");
+		strcpy(benchmark_cmd[4], "false");
 		benchmark_cmd[5] = NULL;
 	}
 
@@ -291,13 +287,13 @@ int main(int argc, char **argv)
 	ksft_set_plan(tests ? : 4);
 
 	if (mbm_test)
-		run_mbm_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
+		run_mbm_test(benchmark_cmd, span, cpu_no, bw_report);
 
 	if (mba_test)
 		run_mba_test(benchmark_cmd, span, cpu_no, bw_report);
 
 	if (cmt_test)
-		run_cmt_test(has_ben, benchmark_cmd, cpu_no);
+		run_cmt_test(benchmark_cmd, cpu_no);
 
 	if (cat_test)
 		run_cat_test(cpu_no, no_of_bits);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 79e030065da8..7fef9068d7fd 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -298,7 +298,7 @@ void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 	int operation, ret, memflush;
 	unsigned long span;
 	char **benchmark_cmd;
-	char resctrl_val[64];
+	bool once;
 	FILE *fp;
 
 	benchmark_cmd = info->si_ptr;
@@ -316,9 +316,14 @@ void run_benchmark(int signum, siginfo_t *info, void *ucontext)
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

