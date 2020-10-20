Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08A5329458C
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 01:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439391AbgJTXvi (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Oct 2020 19:51:38 -0400
Received: from mga07.intel.com ([134.134.136.100]:11167 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439384AbgJTXvi (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Oct 2020 19:51:38 -0400
IronPort-SDR: wh+UwQ7YhNvwlHvxKfpF7lM6mzimvLntiT5SM1qYhzmtG+w7FIahRBZRq2HA5NqdWE/eXbgAeH
 xMjKS7dVtttw==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="231486365"
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="231486365"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 16:51:32 -0700
IronPort-SDR: muGKTsd+g7WL1zwRJ4sJo4sXh7g95/4q+IUEnAxlZRXU0NBAHGI3rSuRiwmk+TVqpABq0FGMTI
 XlKL09KE22BA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="320833862"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by orsmga006.jf.intel.com with ESMTP; 20 Oct 2020 16:51:32 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Tony Luck" <tony.luck@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "James Morse" <james.morse@arm.com>,
        "Borislav Petkov" <bp@alien8.de>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kselftest" <linux-kselftest@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v3 14/21] selftests/resctrl: Modularize resctrl test suite main() function
Date:   Tue, 20 Oct 2020 23:51:19 +0000
Message-Id: <20201020235126.1871815-15-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201020235126.1871815-1-fenghua.yu@intel.com>
References: <20201020235126.1871815-1-fenghua.yu@intel.com>
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

Fixes: 01fee6b4d1f9 ("selftests/resctrl: Add MBA test")
Fixes: ecdbb911f22d ("selftests/resctrl: Add MBM test")
Fixes: 78941183d1b15 ("selftests/resctrl: Add Cache QoS Monitoring (CQM) selftest")
Fixes: 790bf585b0eee ("selftests/resctrl: Add Cache Allocation Technology (CAT) selftest")
Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 .../testing/selftests/resctrl/resctrl_tests.c | 96 ++++++++++++-------
 1 file changed, 61 insertions(+), 35 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 5c217d0228f4..be7cd57efca8 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -54,10 +54,62 @@ void tests_cleanup(void)
 	cat_test_cleanup();
 }
 
+static void run_mbm_test(bool has_ben, char **benchmark_cmd, int span,
+			 int cpu_no, char *bw_report)
+{
+	int res;
+
+	printf("# Starting MBM BW change ...\n");
+	if (!has_ben)
+		sprintf(benchmark_cmd[5], "%s", "mba");
+	res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
+	printf("%sok MBM: bw change\n", res ? "not " : "");
+	mbm_test_cleanup();
+	tests_run++;
+}
+
+static void run_mba_test(bool has_ben, char **benchmark_cmd, int span,
+			 int cpu_no, char *bw_report)
+{
+	int res;
+
+	printf("# Starting MBA Schemata change ...\n");
+	if (!has_ben)
+		sprintf(benchmark_cmd[1], "%d", span);
+	res = mba_schemata_change(cpu_no, bw_report, benchmark_cmd);
+	printf("%sok MBA: schemata change\n", res ? "not " : "");
+	mba_test_cleanup();
+	tests_run++;
+}
+
+static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
+{
+	int res;
+
+	printf("# Starting CMT test ...\n");
+	if (!has_ben)
+		sprintf(benchmark_cmd[5], "%s", "cmt");
+	res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
+	printf("%sok CMT: test\n", res ? "not " : "");
+	cmt_test_cleanup();
+	tests_run++;
+}
+
+static void run_cat_test(int cpu_no, int no_of_bits)
+{
+	int res;
+
+	printf("# Starting CAT test ...\n");
+	res = cat_perf_miss_val(cpu_no, no_of_bits, "L3");
+	printf("%sok CAT: test\n", res ? "not " : "");
+	tests_run++;
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
 	int ben_ind, ben_count;
@@ -168,43 +220,17 @@ int main(int argc, char **argv)
 
 	filter_dmesg();
 
-	if (!is_amd && mbm_test) {
-		printf("# Starting MBM BW change ...\n");
-		if (!has_ben)
-			sprintf(benchmark_cmd[5], "%s", "mba");
-		res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
-		printf("%sok MBM: bw change\n", res ? "not " : "");
-		mbm_test_cleanup();
-		tests_run++;
-	}
+	if (!is_amd && mbm_test)
+		run_mbm_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
 
-	if (!is_amd && mba_test) {
-		printf("# Starting MBA Schemata change ...\n");
-		if (!has_ben)
-			sprintf(benchmark_cmd[1], "%d", span);
-		res = mba_schemata_change(cpu_no, bw_report, benchmark_cmd);
-		printf("%sok MBA: schemata change\n", res ? "not " : "");
-		mba_test_cleanup();
-		tests_run++;
-	}
+	if (!is_amd && mba_test)
+		run_mba_test(has_ben, benchmark_cmd, span, cpu_no, bw_report);
 
-	if (cmt_test) {
-		printf("# Starting CMT test ...\n");
-		if (!has_ben)
-			sprintf(benchmark_cmd[5], "%s", "cmt");
-		res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
-		printf("%sok CMT: test\n", res ? "not " : "");
-		cmt_test_cleanup();
-		tests_run++;
-	}
+	if (cmt_test)
+		run_cmt_test(has_ben, benchmark_cmd, cpu_no);
 
-	if (cat_test) {
-		printf("# Starting CAT test ...\n");
-		res = cat_perf_miss_val(cpu_no, no_of_bits, "L3");
-		printf("%sok CAT: test\n", res ? "not " : "");
-		tests_run++;
-		cat_test_cleanup();
-	}
+	if (cat_test)
+		run_cat_test(cpu_no, no_of_bits);
 
 out:
 	printf("1..%d\n", tests_run);
-- 
2.29.0

