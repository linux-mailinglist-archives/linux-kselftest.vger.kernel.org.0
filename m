Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E156DF6F0
	for <lists+linux-kselftest@lfdr.de>; Wed, 12 Apr 2023 15:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231410AbjDLNWh (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Wed, 12 Apr 2023 09:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230520AbjDLNWX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Wed, 12 Apr 2023 09:22:23 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A21A2709;
        Wed, 12 Apr 2023 06:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681305728; x=1712841728;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9POIHqZashIOVUjEArOS78ZYDsxl4MiOrY4j8O/Kheg=;
  b=dmBgGVGflAFLev4LCrDpCbQ/k0QZ7+xmOj5mwFNlqg7F+sKZgySl4n2Q
   U/0Pw4wM5kcl2nMDYJm8E+2Ds3ae2XGA6IUVOHGu5ShUx0PWmFSVBhnki
   7ipw+XU6Hyr+Cl9JqGAb6QTTWKkgK+YspmaO3VZrdMZA7k+8jqOIx57i6
   4jdnuwAjK+CUOgT64QmlrbWZH62q2+ydIthIQdFPsiIU3dmDzTt/PDzWi
   E7xrTr47caVPTeUs3y/cM2pIUeEW0tZtBgkfP9jIrivAcwc/CyxwL+4do
   vcv/6+fuyTQOdFRcs+3gw14+4tGpSPRYdOuqSRUVv5t9RQ2XA2ir7rA2o
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="332590044"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="332590044"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:21:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10678"; a="639230043"
X-IronPort-AV: E=Sophos;i="5.98,339,1673942400"; 
   d="scan'208";a="639230043"
Received: from chanse1-mobl2.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.80])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2023 06:21:44 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 03/22] selftests/resctrl: Make span unsigned long everywhere
Date:   Wed, 12 Apr 2023 16:21:03 +0300
Message-Id: <20230412132122.29452-4-ilpo.jarvinen@linux.intel.com>
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

fill_buf(), show_bw_info(), and resctrl_val_param.span define span as
unsigned long.

Consistently use unsigned long elsewhere too for span parameters.

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/mbm_test.c      |  8 ++++----
 tools/testing/selftests/resctrl/resctrl.h       |  2 +-
 tools/testing/selftests/resctrl/resctrl_tests.c | 11 ++++++-----
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index c9dfa54af42f..b28e68ac5fea 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -15,7 +15,7 @@
 #define NUM_OF_RUNS		5
 
 static int
-show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, int span)
+show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, unsigned long span)
 {
 	unsigned long avg_bw_imc = 0, avg_bw_resc = 0;
 	unsigned long sum_bw_imc = 0, sum_bw_resc = 0;
@@ -40,14 +40,14 @@ show_bw_info(unsigned long *bw_imc, unsigned long *bw_resc, int span)
 	ksft_print_msg("%s Check MBM diff within %d%%\n",
 		       ret ? "Fail:" : "Pass:", MAX_DIFF_PERCENT);
 	ksft_print_msg("avg_diff_per: %d%%\n", avg_diff_per);
-	ksft_print_msg("Span (MB): %d\n", span);
+	ksft_print_msg("Span (MB): %lu\n", span);
 	ksft_print_msg("avg_bw_imc: %lu\n", avg_bw_imc);
 	ksft_print_msg("avg_bw_resc: %lu\n", avg_bw_resc);
 
 	return ret;
 }
 
-static int check_results(int span)
+static int check_results(unsigned long span)
 {
 	unsigned long bw_imc[NUM_OF_RUNS], bw_resc[NUM_OF_RUNS];
 	char temp[1024], *token_array[8];
@@ -114,7 +114,7 @@ void mbm_test_cleanup(void)
 	remove(RESULT_FILE_NAME);
 }
 
-int mbm_bw_change(int span, int cpu_no, char *bw_report, char **benchmark_cmd)
+int mbm_bw_change(unsigned long span, int cpu_no, char *bw_report, char **benchmark_cmd)
 {
 	struct resctrl_val_param param = {
 		.resctrl_val	= MBM_STR,
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 9555a6f683f7..ffa2d1e51c67 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -101,7 +101,7 @@ int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 int run_fill_buf(unsigned long span, int malloc_and_init_memory, int memflush,
 		 int op, char *resctrl_va);
 int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param);
-int mbm_bw_change(int span, int cpu_no, char *bw_report, char **benchmark_cmd);
+int mbm_bw_change(unsigned long span, int cpu_no, char *bw_report, char **benchmark_cmd);
 void tests_cleanup(void);
 void mbm_test_cleanup(void);
 int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index df0d8d8526fc..60b225e15cff 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -70,7 +70,7 @@ void tests_cleanup(void)
 	cat_test_cleanup();
 }
 
-static void run_mbm_test(bool has_ben, char **benchmark_cmd, int span,
+static void run_mbm_test(bool has_ben, char **benchmark_cmd, unsigned long span,
 			 int cpu_no, char *bw_report)
 {
 	int res;
@@ -91,7 +91,7 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, int span,
 	mbm_test_cleanup();
 }
 
-static void run_mba_test(bool has_ben, char **benchmark_cmd, int span,
+static void run_mba_test(bool has_ben, char **benchmark_cmd, unsigned long span,
 			 int cpu_no, char *bw_report)
 {
 	int res;
@@ -104,7 +104,7 @@ static void run_mba_test(bool has_ben, char **benchmark_cmd, int span,
 	}
 
 	if (!has_ben)
-		sprintf(benchmark_cmd[1], "%d", span);
+		sprintf(benchmark_cmd[1], "%lu", span);
 	res = mba_schemata_change(cpu_no, bw_report, benchmark_cmd);
 	ksft_test_result(!res, "MBA: schemata change\n");
 	mba_test_cleanup();
@@ -148,9 +148,10 @@ static void run_cat_test(int cpu_no, int no_of_bits)
 int main(int argc, char **argv)
 {
 	bool has_ben = false, mbm_test = true, mba_test = true, cmt_test = true;
-	int c, cpu_no = 1, span = 250, argc_new = argc, i, no_of_bits = 0;
 	char *benchmark_cmd[BENCHMARK_ARGS], bw_report[64], bm_type[64];
 	char benchmark_cmd_area[BENCHMARK_ARGS][BENCHMARK_ARG_SIZE];
+	int c, cpu_no = 1, argc_new = argc, i, no_of_bits = 0;
+	unsigned long span = 250;
 	int ben_ind, ben_count, tests = 0;
 	bool cat_test = true;
 
@@ -240,7 +241,7 @@ int main(int argc, char **argv)
 			benchmark_cmd[i] = benchmark_cmd_area[i];
 
 		strcpy(benchmark_cmd[0], "fill_buf");
-		sprintf(benchmark_cmd[1], "%d", span);
+		sprintf(benchmark_cmd[1], "%lu", span);
 		strcpy(benchmark_cmd[2], "1");
 		strcpy(benchmark_cmd[3], "1");
 		strcpy(benchmark_cmd[4], "0");
-- 
2.30.2

