Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2720375643F
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 15:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjGQNSK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 09:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjGQNRd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 09:17:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13DB35A4;
        Mon, 17 Jul 2023 06:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689599809; x=1721135809;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eM7kiPjmTLQio1i2Y+4XMgthvj6f/Qoaha85fysez6A=;
  b=hnmYm43gcfZ/+CdyaXr0bph6AGwH/LZ+4cPcffC1aoTXPZkjxcW65L29
   2Nl2kgT55IWm5Gj6ByHwZNF4qR8XfqatJEjdxJUI9hfDwDXbSxfTviwdW
   ri0fXLtWJ4MLD7iiSEw8ChwZmbH2c1TFk8+i7DaqdzjqtL7QWSX1p4dIL
   2gMIJMdTt2IajSezKg1VVsSUnZmi3bF0Tc6SrnWWnEfucCr5XvWY1ocpy
   nFR/ONdmUFd4CVzmowNWVsFu5oAjPo3Q2ZZdS2/ZCTVYsUKJAyQK/rhYu
   CTtI3gPWj2s4zj53G8ZyFu4Alfg1WS1iheqOuH+oH5mifiOWSgvOTzl3R
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="368569149"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="368569149"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:16:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="793247156"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="793247156"
Received: from dkravtso-mobl1.ccr.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.45.233])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:16:35 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 15/19] selftests/resctrl: Don't pass test name to fill_buf
Date:   Mon, 17 Jul 2023 16:15:03 +0300
Message-Id: <20230717131507.32420-16-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230717131507.32420-1-ilpo.jarvinen@linux.intel.com>
References: <20230717131507.32420-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Test name is passed to fill_buf functions so that they can loop around
buffer only once. This is required for CAT test case.

To loop around buffer only once, caller doesn't need to let fill_buf
know which test case it is. Instead, pass a boolean argument 'once'
which makes fill_buf more generic.

As run_benchmark() no longer needs to pass the test name to
run_fill_buf(), a few test running functions can be simplified to not
write the test name into the default benchmark_cmd. The has_ben
argument can also be removed now from those test running functions.

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
---
 tools/testing/selftests/resctrl/cache.c       |  3 +--
 tools/testing/selftests/resctrl/fill_buf.c    | 20 +++++++++----------
 tools/testing/selftests/resctrl/resctrl.h     |  2 +-
 .../testing/selftests/resctrl/resctrl_tests.c | 14 +++++--------
 tools/testing/selftests/resctrl/resctrlfs.c   | 11 +++++++---
 5 files changed, 24 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cache.c b/tools/testing/selftests/resctrl/cache.c
index 63b551c44f1d..8ae9ac150fd3 100644
--- a/tools/testing/selftests/resctrl/cache.c
+++ b/tools/testing/selftests/resctrl/cache.c
@@ -247,8 +247,7 @@ int cat_val(struct resctrl_val_param *param)
 			if (ret)
 				break;
 
-			if (run_fill_buf(param->span, memflush, operation,
-					 resctrl_val)) {
+			if (run_fill_buf(param->span, memflush, operation, true)) {
 				fprintf(stderr, "Error-running fill buffer\n");
 				ret = -1;
 				goto pe_close;
diff --git a/tools/testing/selftests/resctrl/fill_buf.c b/tools/testing/selftests/resctrl/fill_buf.c
index 5f16c4f5dfbf..0d425f26583a 100644
--- a/tools/testing/selftests/resctrl/fill_buf.c
+++ b/tools/testing/selftests/resctrl/fill_buf.c
@@ -101,15 +101,14 @@ static void fill_one_span_write(unsigned char *buf, size_t buf_size)
 	}
 }
 
-static int fill_cache_read(unsigned char *buf, size_t buf_size,
-			   char *resctrl_val)
+static int fill_cache_read(unsigned char *buf, size_t buf_size, bool once)
 {
 	int ret = 0;
 	FILE *fp;
 
 	while (1) {
 		ret = fill_one_span_read(buf, buf_size);
-		if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)))
+		if (once)
 			break;
 	}
 
@@ -125,19 +124,18 @@ static int fill_cache_read(unsigned char *buf, size_t buf_size,
 	return 0;
 }
 
-static int fill_cache_write(unsigned char *buf, size_t buf_size,
-			    char *resctrl_val)
+static int fill_cache_write(unsigned char *buf, size_t buf_size, bool once)
 {
 	while (1) {
 		fill_one_span_write(buf, buf_size);
-		if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR)))
+		if (once)
 			break;
 	}
 
 	return 0;
 }
 
-static int fill_cache(size_t buf_size, int memflush, int op, char *resctrl_val)
+static int fill_cache(size_t buf_size, int memflush, int op, bool once)
 {
 	unsigned char *buf;
 	int ret;
@@ -151,9 +149,9 @@ static int fill_cache(size_t buf_size, int memflush, int op, char *resctrl_val)
 		mem_flush(buf, buf_size);
 
 	if (op == 0)
-		ret = fill_cache_read(buf, buf_size, resctrl_val);
+		ret = fill_cache_read(buf, buf_size, once);
 	else
-		ret = fill_cache_write(buf, buf_size, resctrl_val);
+		ret = fill_cache_write(buf, buf_size, once);
 
 	free(buf);
 
@@ -166,12 +164,12 @@ static int fill_cache(size_t buf_size, int memflush, int op, char *resctrl_val)
 	return 0;
 }
 
-int run_fill_buf(size_t span, int memflush, int op, char *resctrl_val)
+int run_fill_buf(size_t span, int memflush, int op, bool once)
 {
 	size_t cache_size = span;
 	int ret;
 
-	ret = fill_cache(cache_size, memflush, op, resctrl_val);
+	ret = fill_cache(cache_size, memflush, op, once);
 	if (ret) {
 		printf("\n Error in fill cache\n");
 		return -1;
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 3054cc4ef0e3..645ad407bd8d 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -97,7 +97,7 @@ int write_bm_pid_to_resctrl(pid_t bm_pid, char *ctrlgrp, char *mongrp,
 			    char *resctrl_val);
 int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 		    int group_fd, unsigned long flags);
-int run_fill_buf(size_t span, int memflush, int op, char *resctrl_val);
+int run_fill_buf(size_t span, int memflush, int op, bool once);
 int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param);
 int mbm_bw_change(size_t span, int cpu_no, char *bw_report, char **benchmark_cmd);
 void tests_cleanup(void);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 125ed0ca11e3..d511daeb6851 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -70,7 +70,7 @@ void tests_cleanup(void)
 	cat_test_cleanup();
 }
 
-static void run_mbm_test(bool has_ben, char **benchmark_cmd, size_t span,
+static void run_mbm_test(char **benchmark_cmd, size_t span,
 			 int cpu_no, char *bw_report)
 {
 	int res;
@@ -88,8 +88,6 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, size_t span,
 		goto umount;
 	}
 
-	if (!has_ben)
-		sprintf(benchmark_cmd[4], "%s", MBA_STR);
 	res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
 	ksft_test_result(!res, "MBM: bw change\n");
 	if ((get_vendor() == ARCH_INTEL) && res)
@@ -123,7 +121,7 @@ static void run_mba_test(char **benchmark_cmd, int cpu_no, char *bw_report)
 	umount_resctrlfs();
 }
 
-static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
+static void run_cmt_test(char **benchmark_cmd, int cpu_no)
 {
 	int res;
 
@@ -140,8 +138,6 @@ static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
 		goto umount;
 	}
 
-	if (!has_ben)
-		sprintf(benchmark_cmd[4], "%s", CMT_STR);
 	res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
 	ksft_test_result(!res, "CMT: test\n");
 	if ((get_vendor() == ARCH_INTEL) && res)
@@ -274,7 +270,7 @@ int main(int argc, char **argv)
 		sprintf(benchmark_cmd[1], "%zu", span);
 		strcpy(benchmark_cmd[2], "1");
 		strcpy(benchmark_cmd[3], "0");
-		strcpy(benchmark_cmd[4], "");
+		strcpy(benchmark_cmd[4], "false");
 		benchmark_cmd[5] = NULL;
 	}
 
@@ -292,13 +288,13 @@ int main(int argc, char **argv)
 	ksft_set_plan(tests ? : 4);
 
 	if (mbm_test)
-		run_mbm_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
+		run_mbm_test(benchmark_cmd, span, cpu_no, bw_report);
 
 	if (mba_test)
 		run_mba_test(benchmark_cmd, cpu_no, bw_report);
 
 	if (cmt_test)
-		run_cmt_test(has_ben, benchmark_cmd, cpu_no);
+		run_cmt_test(benchmark_cmd, cpu_no);
 
 	if (cat_test)
 		run_cat_test(cpu_no, no_of_bits);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 8a66445079f8..bd36ee206602 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -304,8 +304,8 @@ void run_benchmark(int signum, siginfo_t *info, void *ucontext)
 {
 	int operation, ret, memflush;
 	char **benchmark_cmd;
-	char resctrl_val[64];
 	size_t span;
+	bool once;
 	FILE *fp;
 
 	benchmark_cmd = info->si_ptr;
@@ -323,9 +323,14 @@ void run_benchmark(int signum, siginfo_t *info, void *ucontext)
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

