Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D39329459E
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 01:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439491AbgJTXwJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Oct 2020 19:52:09 -0400
Received: from mga07.intel.com ([134.134.136.100]:11167 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439389AbgJTXvj (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Oct 2020 19:51:39 -0400
IronPort-SDR: GokqX+YSaVwTiE3nmfmxY/Ndt4fZT4nxqx3hwm8boJG/fYnYPWRzdFGeY3XJT4LuWyMmNKwrnz
 EXCAbInEyHQg==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="231486366"
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="231486366"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 16:51:32 -0700
IronPort-SDR: Wn+3VXrCIewVyoO0fAd1GrMg+HQE9+evazolLwy3o5M8vf+MsVTkPervSsrFmwf+uO258CHKxg
 dNHJ8/gIFPFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="320833871"
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
Subject: [PATCH v3 15/21] selftests/resctrl: Skip the test if requested resctrl feature is not supported
Date:   Tue, 20 Oct 2020 23:51:20 +0000
Message-Id: <20201020235126.1871815-16-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201020235126.1871815-1-fenghua.yu@intel.com>
References: <20201020235126.1871815-1-fenghua.yu@intel.com>
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

Fixes: 01fee6b4d1f9 ("selftests/resctrl: Add MBA test")
Fixes: ecdbb911f22d ("selftests/resctrl: Add MBM test")
Fixes: 78941183d1b15 ("selftests/resctrl: Add Cache QoS Monitoring (CQM) selftest")
Fixes: 790bf585b0eee ("selftests/resctrl: Add Cache Allocation Technology (CAT) selftest")
Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c    |  3 ---
 tools/testing/selftests/resctrl/cmt_test.c    |  3 ---
 tools/testing/selftests/resctrl/mba_test.c    |  3 ---
 tools/testing/selftests/resctrl/mbm_test.c    |  3 ---
 .../testing/selftests/resctrl/resctrl_tests.c | 24 +++++++++++++++++++
 5 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 1bce84e23783..a18a37ce626c 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -132,9 +132,6 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	if (ret)
 		return ret;
 
-	if (!validate_resctrl_feature_request("cat"))
-		return -1;
-
 	/* Get default cbm mask for L3/L2 cache */
 	ret = get_cbm_mask(cache_type);
 	if (ret)
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 282ba7fcf17c..119ae65abec7 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -122,9 +122,6 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 	if (ret)
 		return ret;
 
-	if (!validate_resctrl_feature_request("cmt"))
-		return -1;
-
 	ret = get_cbm_mask("L3");
 	if (ret)
 		return ret;
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index ba0234d4829e..6f09d46a5424 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -156,9 +156,6 @@ int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd)
 
 	remove(RESULT_FILE_NAME);
 
-	if (!validate_resctrl_feature_request("mba"))
-		return -1;
-
 	ret = resctrl_val(benchmark_cmd, &param);
 	if (ret)
 		return ret;
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index ca610c3ebc8c..cb3113cb3b10 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -129,9 +129,6 @@ int mbm_bw_change(int span, int cpu_no, char *bw_report, char **benchmark_cmd)
 
 	remove(RESULT_FILE_NAME);
 
-	if (!validate_resctrl_feature_request("mbm"))
-		return -1;
-
 	ret = resctrl_val(benchmark_cmd, &param);
 	if (ret)
 		return ret;
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index be7cd57efca8..a22dc96c0b43 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -60,6 +60,12 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, int span,
 	int res;
 
 	printf("# Starting MBM BW change ...\n");
+
+	if (!validate_resctrl_feature_request("mbm")) {
+		printf("ok MBM # SKIP Hardware does not support MBM or MBM is disabled\n");
+		return;
+	}
+
 	if (!has_ben)
 		sprintf(benchmark_cmd[5], "%s", "mba");
 	res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
@@ -74,6 +80,12 @@ static void run_mba_test(bool has_ben, char **benchmark_cmd, int span,
 	int res;
 
 	printf("# Starting MBA Schemata change ...\n");
+
+	if (!validate_resctrl_feature_request("mba")) {
+		printf("ok MBA # SKIP Hardware does not support MBA or MBA is disabled\n");
+		return;
+	}
+
 	if (!has_ben)
 		sprintf(benchmark_cmd[1], "%d", span);
 	res = mba_schemata_change(cpu_no, bw_report, benchmark_cmd);
@@ -87,6 +99,12 @@ static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
 	int res;
 
 	printf("# Starting CMT test ...\n");
+
+	if (!validate_resctrl_feature_request("cmt")) {
+		printf("ok CMT # SKIP Hardware does not support CMT or CMT is disabled\n");
+		return;
+	}
+
 	if (!has_ben)
 		sprintf(benchmark_cmd[5], "%s", "cmt");
 	res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
@@ -100,6 +118,12 @@ static void run_cat_test(int cpu_no, int no_of_bits)
 	int res;
 
 	printf("# Starting CAT test ...\n");
+
+	if (!validate_resctrl_feature_request("cat")) {
+		printf("ok CAT # SKIP Hardware does not support CAT or CAT is disabled\n");
+		return;
+	}
+
 	res = cat_perf_miss_val(cpu_no, no_of_bits, "L3");
 	printf("%sok CAT: test\n", res ? "not " : "");
 	tests_run++;
-- 
2.29.0

