Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 528B233E6E3
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Mar 2021 03:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhCQCZH (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Mar 2021 22:25:07 -0400
Received: from mga01.intel.com ([192.55.52.88]:55653 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230458AbhCQCYf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Mar 2021 22:24:35 -0400
IronPort-SDR: G4czPOVdOrr4Zsepaky0CHEHx/ByA5IUguEZVMKHLBJVgbbe5pQvSyXN0W5CfAgt3nrx2dsUOF
 X6NEKU94pwAA==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="209328719"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="209328719"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 19:24:34 -0700
IronPort-SDR: MRLu6W4mPbhQ4RMhoSH6dvBTlE06V/Uzf0hN1YTnLcQXrISsF5Op2W2LGz5GzDJpVjwqQPufZ/
 bnbHXC9FJpNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="440290285"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Mar 2021 19:24:34 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kselftest" <linux-kselftest@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v6 16/21] selftests/resctrl: Modularize resctrl test suite main() function
Date:   Wed, 17 Mar 2021 02:22:50 +0000
Message-Id: <20210317022255.2536745-17-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210317022255.2536745-1-fenghua.yu@intel.com>
References: <20210317022255.2536745-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Resctrl test suite main() function does the following things
1. Parses command line arguments passed by user
2. Some setup checks
3. Logic that calls into each unit test
4. Print result and clean up after running each unit test

Introduce wrapper functions for steps 3 and 4 to modularize the main()
function. Adding these wrapper functions makes it easier to add any logic
to each individual test.

Please note that this is a preparatory patch for the next one and no
functional changes are intended.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 .../testing/selftests/resctrl/resctrl_tests.c | 88 ++++++++++++-------
 1 file changed, 57 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 2ace464b96d1..e63e0d8764ef 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -54,10 +54,58 @@ void tests_cleanup(void)
 	cat_test_cleanup();
 }
 
+static void run_mbm_test(bool has_ben, char **benchmark_cmd, int span,
+			 int cpu_no, char *bw_report)
+{
+	int res;
+
+	ksft_print_msg("Starting MBM BW change ...\n");
+	if (!has_ben)
+		sprintf(benchmark_cmd[5], "%s", MBA_STR);
+	res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
+	ksft_test_result(!res, "MBM: bw change\n");
+	mbm_test_cleanup();
+}
+
+static void run_mba_test(bool has_ben, char **benchmark_cmd, int span,
+			 int cpu_no, char *bw_report)
+{
+	int res;
+
+	ksft_print_msg("Starting MBA Schemata change ...\n");
+	if (!has_ben)
+		sprintf(benchmark_cmd[1], "%d", span);
+	res = mba_schemata_change(cpu_no, bw_report, benchmark_cmd);
+	ksft_test_result(!res, "MBA: schemata change\n");
+	mba_test_cleanup();
+}
+
+static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
+{
+	int res;
+
+	ksft_print_msg("Starting CMT test ...\n");
+	if (!has_ben)
+		sprintf(benchmark_cmd[5], "%s", CMT_STR);
+	res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
+	ksft_test_result(!res, "CMT: test\n");
+	cmt_test_cleanup();
+}
+
+static void run_cat_test(int cpu_no, int no_of_bits)
+{
+	int res;
+
+	ksft_print_msg("Starting CAT test ...\n");
+	res = cat_perf_miss_val(cpu_no, no_of_bits, "L3");
+	ksft_test_result(!res, "CAT: test\n");
+	cat_test_cleanup();
+}
+
 int main(int argc, char **argv)
 {
 	bool has_ben = false, mbm_test = true, mba_test = true, cmt_test = true;
-	int res, c, cpu_no = 1, span = 250, argc_new = argc, i, no_of_bits = 0;
+	int c, cpu_no = 1, span = 250, argc_new = argc, i, no_of_bits = 0;
 	char *benchmark_cmd[BENCHMARK_ARGS], bw_report[64], bm_type[64];
 	char benchmark_cmd_area[BENCHMARK_ARGS][BENCHMARK_ARG_SIZE];
 	int ben_ind, ben_count, tests = 0;
@@ -170,39 +218,17 @@ int main(int argc, char **argv)
 
 	ksft_set_plan(tests ? : 4);
 
-	if (!is_amd && mbm_test) {
-		ksft_print_msg("Starting MBM BW change ...\n");
-		if (!has_ben)
-			sprintf(benchmark_cmd[5], "%s", MBA_STR);
-		res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
-		ksft_test_result(!res, "MBM: bw change\n");
-		mbm_test_cleanup();
-	}
+	if (!is_amd && mbm_test)
+		run_mbm_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
 
-	if (!is_amd && mba_test) {
-		ksft_print_msg("Starting MBA Schemata change ...\n");
-		if (!has_ben)
-			sprintf(benchmark_cmd[1], "%d", span);
-		res = mba_schemata_change(cpu_no, bw_report, benchmark_cmd);
-		ksft_test_result(!res, "MBA: schemata change\n");
-		mba_test_cleanup();
-	}
+	if (!is_amd && mba_test)
+		run_mba_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
 
-	if (cmt_test) {
-		ksft_print_msg("Starting CMT test ...\n");
-		if (!has_ben)
-			sprintf(benchmark_cmd[5], "%s", CMT_STR);
-		res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
-		ksft_test_result(!res, "CMT: test\n");
-		cmt_test_cleanup();
-	}
+	if (cmt_test)
+		run_cmt_test(has_ben, benchmark_cmd, cpu_no);
 
-	if (cat_test) {
-		ksft_print_msg("Starting CAT test ...\n");
-		res = cat_perf_miss_val(cpu_no, no_of_bits, "L3");
-		ksft_test_result(!res, "CAT: test\n");
-		cat_test_cleanup();
-	}
+	if (cat_test)
+		run_cat_test(cpu_no, no_of_bits);
 
 	return ksft_exit_pass();
 }
-- 
2.31.0

