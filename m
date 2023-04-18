Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3B396E6030
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 13:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbjDRLqE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 07:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjDRLpv (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 07:45:51 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B84893E8;
        Tue, 18 Apr 2023 04:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681818343; x=1713354343;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uEDV7s33ghMTtcqD+BKI2d0Qj/HCSr2RAHpjP1pxMq8=;
  b=nMZc4pecJ8Yjk7zwNZAepIVOVK16qLG2Wt9ozzdIlxtEQP4yyXxqSs4y
   eUXLtdX+CAIUsKTkmqMC5grrLdN4VY57i7WDDc8fLIaDydfmSL+P9eTC+
   izpUEouUVDnGzAzCJZ9HrPD3hkkhOg4AP4uSUVahgp6G7+oJ2MQIeBoHw
   2EIAvmxZ8axlexUhB7ksprCvHeLG6zzbBPQtoc5RzHhNcqJobapXkmeSM
   irR8iVbqT84VKE8cAOUpuBJ45KpRh/ES/1tNxOdsPqu3IbQWXHsXhc4YD
   7VdaQmXzHRyT+DEVk2O/1URKopvY3XihpA7skYDxfU0XpHX1YySxFxUkd
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="346994316"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="346994316"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:45:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="723601572"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="723601572"
Received: from yvolokit-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.103])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:45:40 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 05/24] selftests/resctrl: Make span unsigned long everywhere
Date:   Tue, 18 Apr 2023 14:44:47 +0300
Message-Id: <20230418114506.46788-6-ilpo.jarvinen@linux.intel.com>
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
index 24326cb7bc21..3c389ccfea41 100644
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
@@ -115,7 +115,7 @@ void mbm_test_cleanup(void)
 	remove(RESULT_FILE_NAME);
 }
 
-int mbm_bw_change(int span, int cpu_no, char *bw_report, char **benchmark_cmd)
+int mbm_bw_change(unsigned long span, int cpu_no, char *bw_report, char **benchmark_cmd)
 {
 	struct resctrl_val_param param = {
 		.resctrl_val	= MBM_STR,
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index c737eb47eacc..fe54c2b4f014 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -99,7 +99,7 @@ int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 int run_fill_buf(unsigned long span, int malloc_and_init_memory, int memflush,
 		 int op, char *resctrl_va);
 int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param);
-int mbm_bw_change(int span, int cpu_no, char *bw_report, char **benchmark_cmd);
+int mbm_bw_change(unsigned long span, int cpu_no, char *bw_report, char **benchmark_cmd);
 void tests_cleanup(void);
 void mbm_test_cleanup(void);
 int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index f3303459136d..6bc0eda25e5d 100644
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
@@ -99,7 +99,7 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, int span,
 	umount_resctrlfs();
 }
 
-static void run_mba_test(bool has_ben, char **benchmark_cmd, int span,
+static void run_mba_test(bool has_ben, char **benchmark_cmd, unsigned long span,
 			 int cpu_no, char *bw_report)
 {
 	int res;
@@ -118,7 +118,7 @@ static void run_mba_test(bool has_ben, char **benchmark_cmd, int span,
 	}
 
 	if (!has_ben)
-		sprintf(benchmark_cmd[1], "%d", span);
+		sprintf(benchmark_cmd[1], "%lu", span);
 	res = mba_schemata_change(cpu_no, bw_report, benchmark_cmd);
 	ksft_test_result(!res, "MBA: schemata change\n");
 
@@ -182,9 +182,10 @@ static void run_cat_test(int cpu_no, int no_of_bits)
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
 
@@ -274,7 +275,7 @@ int main(int argc, char **argv)
 			benchmark_cmd[i] = benchmark_cmd_area[i];
 
 		strcpy(benchmark_cmd[0], "fill_buf");
-		sprintf(benchmark_cmd[1], "%d", span);
+		sprintf(benchmark_cmd[1], "%lu", span);
 		strcpy(benchmark_cmd[2], "1");
 		strcpy(benchmark_cmd[3], "1");
 		strcpy(benchmark_cmd[4], "0");
-- 
2.30.2

