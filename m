Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3173B791525
	for <lists+linux-kselftest@lfdr.de>; Mon,  4 Sep 2023 11:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349055AbjIDJyd (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 4 Sep 2023 05:54:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352762AbjIDJy0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 4 Sep 2023 05:54:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F2391B8;
        Mon,  4 Sep 2023 02:54:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693821248; x=1725357248;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VpDJk8OGWwBgikn1l89OJeRSEDKB0T5Dw4uS1EK4OZA=;
  b=n2XN4qyE2FizpidQvTju2V+bhyoHi/9/evDMrYVoUaSSlxDajURaPLHY
   ofgLEFJPyhoAms5n5HNF7r/eUdXpGyqh3d9oP+v4NUYSJGsj90MOu1MWm
   YLLL6wOmQplqpTmgZV+Q8X2+ivC1mSBAS/TfKavuK0ulzZvB5UFrRf39d
   d6MSG6gpguMJ7qQ33V/nCLs4HxjFNaOsfhfGKEH44Q7Kfdf9k+WBchhwH
   vEwPkqQFTr/a4C6Uvj5ESntD7CIl3a+xGpZQjZwkx9UpSWFBD41l+qFfN
   Olc5LexBIWTpEo6wdWmfKoPrEz1e+A6ikJ6lpdrwvBIzXYgWZIL+UnwoR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="356880685"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="356880685"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 02:54:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="740700667"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="740700667"
Received: from okozlyk-mobl.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.249.44.17])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 02:54:05 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        =?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Babu Moger <babu.moger@amd.com>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 3/8] selftests/resctrl: Remove bw_report and bm_type from main()
Date:   Mon,  4 Sep 2023 12:53:34 +0300
Message-Id: <20230904095339.11321-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230904095339.11321-1-ilpo.jarvinen@linux.intel.com>
References: <20230904095339.11321-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

bw_report is always set to "reads" and bm_type is set to "fill_buf" but
is never used.

Set bw_report directly to "reads" in MBA/MBM test and remove bm_type.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: "Wieczor-Retman, Maciej" <maciej.wieczor-retman@intel.com>
---
 tools/testing/selftests/resctrl/mba_test.c     |  4 ++--
 tools/testing/selftests/resctrl/mbm_test.c     |  4 ++--
 tools/testing/selftests/resctrl/resctrl.h      |  4 ++--
 .../testing/selftests/resctrl/resctrl_tests.c  | 18 +++++++-----------
 4 files changed, 13 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 4d2f145804b8..094424d835d0 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -141,7 +141,7 @@ void mba_test_cleanup(void)
 	remove(RESULT_FILE_NAME);
 }
 
-int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd)
+int mba_schemata_change(int cpu_no, char **benchmark_cmd)
 {
 	struct resctrl_val_param param = {
 		.resctrl_val	= MBA_STR,
@@ -149,7 +149,7 @@ int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd)
 		.mongrp		= "m1",
 		.cpu_no		= cpu_no,
 		.filename	= RESULT_FILE_NAME,
-		.bw_report	= bw_report,
+		.bw_report	= "reads",
 		.setup		= mba_setup
 	};
 	int ret;
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index c7de6f5977f6..3e4a800e0e40 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -109,7 +109,7 @@ void mbm_test_cleanup(void)
 	remove(RESULT_FILE_NAME);
 }
 
-int mbm_bw_change(size_t span, int cpu_no, char *bw_report, char **benchmark_cmd)
+int mbm_bw_change(size_t span, int cpu_no, char **benchmark_cmd)
 {
 	struct resctrl_val_param param = {
 		.resctrl_val	= MBM_STR,
@@ -118,7 +118,7 @@ int mbm_bw_change(size_t span, int cpu_no, char *bw_report, char **benchmark_cmd
 		.span		= span,
 		.cpu_no		= cpu_no,
 		.filename	= RESULT_FILE_NAME,
-		.bw_report	=  bw_report,
+		.bw_report	= "reads",
 		.setup		= mbm_setup
 	};
 	int ret;
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 838d1a438f33..f3446ac664c2 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -98,10 +98,10 @@ int perf_event_open(struct perf_event_attr *hw_event, pid_t pid, int cpu,
 		    int group_fd, unsigned long flags);
 int run_fill_buf(size_t span, int memflush, int op, bool once);
 int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param);
-int mbm_bw_change(size_t span, int cpu_no, char *bw_report, char **benchmark_cmd);
+int mbm_bw_change(size_t span, int cpu_no, char **benchmark_cmd);
 void tests_cleanup(void);
 void mbm_test_cleanup(void);
-int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd);
+int mba_schemata_change(int cpu_no, char **benchmark_cmd);
 void mba_test_cleanup(void);
 int get_cbm_mask(char *cache_type, char *cbm_mask);
 int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 53bd2127b7bf..7f3c8432ca5c 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -70,8 +70,7 @@ void tests_cleanup(void)
 	cat_test_cleanup();
 }
 
-static void run_mbm_test(char **benchmark_cmd, size_t span,
-			 int cpu_no, char *bw_report)
+static void run_mbm_test(char **benchmark_cmd, size_t span, int cpu_no)
 {
 	int res;
 
@@ -88,7 +87,7 @@ static void run_mbm_test(char **benchmark_cmd, size_t span,
 		goto umount;
 	}
 
-	res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
+	res = mbm_bw_change(span, cpu_no, benchmark_cmd);
 	ksft_test_result(!res, "MBM: bw change\n");
 	if ((get_vendor() == ARCH_INTEL) && res)
 		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
@@ -97,7 +96,7 @@ static void run_mbm_test(char **benchmark_cmd, size_t span,
 	umount_resctrlfs();
 }
 
-static void run_mba_test(char **benchmark_cmd, int cpu_no, char *bw_report)
+static void run_mba_test(char **benchmark_cmd, int cpu_no)
 {
 	int res;
 
@@ -114,7 +113,7 @@ static void run_mba_test(char **benchmark_cmd, int cpu_no, char *bw_report)
 		goto umount;
 	}
 
-	res = mba_schemata_change(cpu_no, bw_report, benchmark_cmd);
+	res = mba_schemata_change(cpu_no, benchmark_cmd);
 	ksft_test_result(!res, "MBA: schemata change\n");
 
 umount:
@@ -174,9 +173,9 @@ static void run_cat_test(int cpu_no, int no_of_bits)
 int main(int argc, char **argv)
 {
 	bool has_ben = false, mbm_test = true, mba_test = true, cmt_test = true;
-	char *benchmark_cmd[BENCHMARK_ARGS], bw_report[64], bm_type[64];
 	char benchmark_cmd_area[BENCHMARK_ARGS][BENCHMARK_ARG_SIZE];
 	int c, cpu_no = 1, argc_new = argc, i, no_of_bits = 0;
+	char *benchmark_cmd[BENCHMARK_ARGS];
 	int ben_ind, ben_count, tests = 0;
 	size_t span = 250 * MB;
 	bool cat_test = true;
@@ -279,9 +278,6 @@ int main(int argc, char **argv)
 		benchmark_cmd[5] = NULL;
 	}
 
-	sprintf(bw_report, "reads");
-	sprintf(bm_type, "fill_buf");
-
 	if (!check_resctrlfs_support())
 		return ksft_exit_skip("resctrl FS does not exist. Enable X86_CPU_RESCTRL config option.\n");
 
@@ -293,10 +289,10 @@ int main(int argc, char **argv)
 	ksft_set_plan(tests ? : 4);
 
 	if (mbm_test)
-		run_mbm_test(benchmark_cmd, span, cpu_no, bw_report);
+		run_mbm_test(benchmark_cmd, span, cpu_no);
 
 	if (mba_test)
-		run_mba_test(benchmark_cmd, cpu_no, bw_report);
+		run_mba_test(benchmark_cmd, cpu_no);
 
 	if (cmt_test)
 		run_cmt_test(benchmark_cmd, cpu_no);
-- 
2.30.2

