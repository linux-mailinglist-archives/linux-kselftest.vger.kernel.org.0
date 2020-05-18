Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3175F1D8A7F
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 May 2020 00:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgERWOB (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 May 2020 18:14:01 -0400
Received: from mga01.intel.com ([192.55.52.88]:46558 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgERWOB (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 May 2020 18:14:01 -0400
IronPort-SDR: uIGBovb8h3eamXCyI7FDFuiAMvcE9Xf+EEILqG7r1O2QCtvFD/O38CzopC2M2/kb0KMB7MnONl
 /yZsrPq5/FXg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 15:14:01 -0700
IronPort-SDR: NK4AfQISXkWshGuJ8s6hlRH/OMb0yzVxqOBWR6KGNquh1mixXlSRb2MEs58FWqQcGhg3Wpjkg8
 0MAB6KMrKJzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="411420408"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by orsmga004.jf.intel.com with ESMTP; 18 May 2020 15:14:00 -0700
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     shuah@kernel.org, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, reinette.chatre@intel.com, babu.moger@amd.com,
        james.morse@arm.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel,
        dan.carpenter@oracle.com, dcb314@hotmail.com,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH V2 14/19] selftests/resctrl: Skip the test if requested resctrl feature is not supported
Date:   Mon, 18 May 2020 15:08:34 -0700
Message-Id: <485f834d4f1188056b306263d800bffbc0c43430.1589835155.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
References: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Presently, if a requested resctrl feature is not supported by H/W or is
disabled by user through kernel command line, the test suite treats it as
an error and hence would print something like "not ok MBA: schemata
change". But, not supporting a feature isn't a test error and hence
shouldn't printed as a failure.

So, instead of treating it as an error, use the SKIP directive of TAP
protocol and print it as below i.e. don't report it as test failure.

Sample o/p if CAT isn't supported:
"ok CAT # SKIP Hardware does not support CAT or CAT is disabled"

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c    |  3 ---
 tools/testing/selftests/resctrl/cmt_test.c    |  3 ---
 tools/testing/selftests/resctrl/mba_test.c    |  3 ---
 tools/testing/selftests/resctrl/mbm_test.c    |  3 ---
 .../testing/selftests/resctrl/resctrl_tests.c | 19 +++++++++++++++++++
 5 files changed, 19 insertions(+), 12 deletions(-)

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
index fb7703413be7..d45ae004ed77 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -170,6 +170,10 @@ int main(int argc, char **argv)
 
 	if (!is_amd && mbm_test) {
 		printf("# Starting MBM BW change ...\n");
+		if (!validate_resctrl_feature_request("mbm")) {
+			printf("ok MBM # SKIP Hardware does not support MBM or MBM is disabled\n");
+			goto test_mba;
+		}
 		if (!has_ben)
 			sprintf(benchmark_cmd[5], "%s", "mba");
 		res = mbm_bw_change(span, cpu_no, bw_report, benchmark_cmd);
@@ -178,8 +182,13 @@ int main(int argc, char **argv)
 		tests_run++;
 	}
 
+test_mba:
 	if (!is_amd && mba_test) {
 		printf("# Starting MBA Schemata change ...\n");
+		if (!validate_resctrl_feature_request("mba")) {
+			printf("ok MBA # SKIP Hardware does not support MBA or MBA is disabled\n");
+			goto test_cmt;
+		}
 		if (!has_ben)
 			sprintf(benchmark_cmd[1], "%d", span);
 		res = mba_schemata_change(cpu_no, bw_report, benchmark_cmd);
@@ -188,8 +197,13 @@ int main(int argc, char **argv)
 		tests_run++;
 	}
 
+test_cmt:
 	if (cmt_test) {
 		printf("# Starting CMT test ...\n");
+		if (!validate_resctrl_feature_request("cmt")) {
+			printf("ok CMT # SKIP Hardware does not support CMT or CMT is disabled\n");
+			goto test_cat;
+		}
 		if (!has_ben)
 			sprintf(benchmark_cmd[5], "%s", "cmt");
 		res = cmt_resctrl_val(cpu_no, 5, benchmark_cmd);
@@ -198,8 +212,13 @@ int main(int argc, char **argv)
 		tests_run++;
 	}
 
+test_cat:
 	if (cat_test) {
 		printf("# Starting CAT test ...\n");
+		if (!validate_resctrl_feature_request("cat")) {
+			printf("ok CAT # SKIP Hardware does not support CAT or CAT is disabled\n");
+			goto out;
+		}
 		res = cat_perf_miss_val(cpu_no, no_of_bits, "L3");
 		printf("%sok CAT: test\n", res ? "not " : "");
 		tests_run++;
-- 
2.19.1

