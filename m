Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 299B333E6DD
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Mar 2021 03:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231129AbhCQCZE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Mar 2021 22:25:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:55651 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230467AbhCQCYg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Mar 2021 22:24:36 -0400
IronPort-SDR: kVHZs742h7a6y2DQZaNIQ7Teu36BeU2TBFAEe5mVYbvQW8POO3zKZBQ6Hno6gIDEmYQ7lKEFy4
 oWVjd/rf4hFQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="209328720"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="209328720"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 19:24:34 -0700
IronPort-SDR: lwEifyRuiQffJPTZg65FsqPGGslMkWJFRBz61SGJRiRMH65LaiiV4S1cmH9Q93Pt+0EqhoTpU+
 0xi0hxh5ssVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="440290288"
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
Subject: [PATCH v6 17/21] selftests/resctrl: Skip the test if requested resctrl feature is not supported
Date:   Wed, 17 Mar 2021 02:22:51 +0000
Message-Id: <20210317022255.2536745-18-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210317022255.2536745-1-fenghua.yu@intel.com>
References: <20210317022255.2536745-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There could be two reasons why a resctrl feature might not be enabled on
the platform
1. H/W might not support the feature
2. Even if the H/W supports it, the user might have disabled the feature
   through kernel command line arguments

Hence, any resctrl unit test (like cmt, cat, mbm and mba) before starting
the test will first check if the feature is enabled on the platform or not.
If the feature isn't enabled, then the test returns with an error status.
For example, if MBA isn't supported on a platform and if the user tries to
run MBA, the output will look like this

ok mounting resctrl to "/sys/fs/resctrl"
not ok MBA: schemata change

But, not supporting a feature isn't a test failure. So, instead of treating
it as an error, use the SKIP directive of the TAP protocol. With the
change, the output will look as below

ok MBA # SKIP Hardware does not support MBA or MBA is disabled

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
Change Log:
v6:
- Replace "cat" by CAT_STR and so on (Babu).

 tools/testing/selftests/resctrl/cat_test.c    |  3 ---
 tools/testing/selftests/resctrl/mba_test.c    |  3 ---
 tools/testing/selftests/resctrl/mbm_test.c    |  3 ---
 .../testing/selftests/resctrl/resctrl_tests.c | 23 +++++++++++++++++++
 4 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 04d706b4f10e..cd4f68388e0f 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -111,9 +111,6 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	if (ret)
 		return ret;
 
-	if (!validate_resctrl_feature_request("cat"))
-		return -1;
-
 	/* Get default cbm mask for L3/L2 cache */
 	ret = get_cbm_mask(cache_type, cbm_mask);
 	if (ret)
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index 8842d379e886..26f12ad4c663 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -158,9 +158,6 @@ int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd)
 
 	remove(RESULT_FILE_NAME);
 
-	if (!validate_resctrl_feature_request("mba"))
-		return -1;
-
 	ret = resctrl_val(benchmark_cmd, &param);
 	if (ret)
 		return ret;
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 651d4ac15986..02b1ed03f1e5 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -131,9 +131,6 @@ int mbm_bw_change(int span, int cpu_no, char *bw_report, char **benchmark_cmd)
 
 	remove(RESULT_FILE_NAME);
 
-	if (!validate_resctrl_feature_request("mbm"))
-		return -1;
-
 	ret = resctrl_val(benchmark_cmd, &param);
 	if (ret)
 		return ret;
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index e63e0d8764ef..fb246bc41f47 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -60,6 +60,12 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, int span,
 	int res;
 
 	ksft_print_msg("Starting MBM BW change ...\n");
+
+	if (!validate_resctrl_feature_request(MBM_STR)) {
+		ksft_test_result_skip("Hardware does not support MBM or MBM is disabled\n");
+		return;
+	}
+
 	if (!has_ben)
 		sprintf(benchmark_cmd[5], "%s", MBA_STR);
 	res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
@@ -73,6 +79,12 @@ static void run_mba_test(bool has_ben, char **benchmark_cmd, int span,
 	int res;
 
 	ksft_print_msg("Starting MBA Schemata change ...\n");
+
+	if (!validate_resctrl_feature_request(MBA_STR)) {
+		ksft_test_result_skip("Hardware does not support MBA or MBA is disabled\n");
+		return;
+	}
+
 	if (!has_ben)
 		sprintf(benchmark_cmd[1], "%d", span);
 	res = mba_schemata_change(cpu_no, bw_report, benchmark_cmd);
@@ -85,6 +97,11 @@ static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
 	int res;
 
 	ksft_print_msg("Starting CMT test ...\n");
+	if (!validate_resctrl_feature_request(CMT_STR)) {
+		ksft_test_result_skip("Hardware does not support CMT or CMT is disabled\n");
+		return;
+	}
+
 	if (!has_ben)
 		sprintf(benchmark_cmd[5], "%s", CMT_STR);
 	res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
@@ -97,6 +114,12 @@ static void run_cat_test(int cpu_no, int no_of_bits)
 	int res;
 
 	ksft_print_msg("Starting CAT test ...\n");
+
+	if (!validate_resctrl_feature_request(CAT_STR)) {
+		ksft_test_result_skip("Hardware does not support CAT or CAT is disabled\n");
+		return;
+	}
+
 	res = cat_perf_miss_val(cpu_no, no_of_bits, "L3");
 	ksft_test_result(!res, "CAT: test\n");
 	cat_test_cleanup();
-- 
2.31.0

