Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E986E602C
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 13:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbjDRLpq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 07:45:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231537AbjDRLpk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 07:45:40 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7FF55AC;
        Tue, 18 Apr 2023 04:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681818337; x=1713354337;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/lNNQ1ryS2nUiXdhxYrGQzDTl9xz2Ge6O9SJ7c4eETs=;
  b=OGV41f/5jAd9wQpL0H5MWBSJgmksXMTwZI8+QJLtL6iX73tfCOkPKOuV
   ENneDoo1DAh5zxmaB244XqMD9Act1ntSGI6gykPtJt/5gaMomvEchd8nb
   pYR4ayIyJ+OS9fhldM7bUMUFWV3PBSddDWCWyipLvL+HuimbdaG7mc5e0
   7+9t1od4vEee/6z9KKGR3svMDXjW3llHP0geOq0/q9pz1SJpa2yRoXwrZ
   1NxKRDa8vlm/Yyv4vLFO44lv9n5upeh+qf7n2MVDhEjkxEjDOEGB/7hj6
   HOw6yt71jc/g4eHV7kBCpb2n9fCPliCUsZl+C8ckXZYgIIUkD7uM8kDnq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="346994297"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="346994297"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:45:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="723601542"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="723601542"
Received: from yvolokit-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.103])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:45:33 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
        Babu Moger <babu.moger@amd.com>, linux-kernel@vger.kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 03/24] selftests/resctrl: Move resctrl FS mount/umount to higher level
Date:   Tue, 18 Apr 2023 14:44:45 +0300
Message-Id: <20230418114506.46788-4-ilpo.jarvinen@linux.intel.com>
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

A few places currently lack umounting resctrl FS on error paths.

Each and every test does require resctrl FS to be present already for
feature check. Thus, it makes sense to just mount it on higher level in
resctrl_tests.c.

Move resctrl FS mount/unmount into each test function in
resctrl_tests.c. Make feature validation to simply check that resctrl
FS is mounted.

Fixes: 790bf585b0ee ("selftests/resctrl: Add Cache Allocation Technology (CAT) selftest")
Fixes: 78941183d1b1 ("selftests/resctrl: Add Cache QoS Monitoring (CQM) selftest")
Fixes: f1dd71982d19 ("selftests/resctrl: Skip the test if requested resctrl feature is not supported")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c    |  6 ---
 tools/testing/selftests/resctrl/cmt_test.c    |  4 --
 .../testing/selftests/resctrl/resctrl_tests.c | 48 ++++++++++++++++---
 tools/testing/selftests/resctrl/resctrl_val.c |  5 --
 tools/testing/selftests/resctrl/resctrlfs.c   |  7 ++-
 5 files changed, 47 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 722c9cd4120d..dec3151cf888 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -106,10 +106,6 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 
 	cache_size = 0;
 
-	ret = remount_resctrlfs(true);
-	if (ret)
-		return ret;
-
 	/* Get default cbm mask for L3/L2 cache */
 	ret = get_cbm_mask(cache_type, cbm_mask);
 	if (ret)
@@ -227,8 +223,6 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 
 out:
 	cat_test_cleanup();
-	if (bm_pid)
-		umount_resctrlfs();
 
 	return ret;
 }
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index af71b2141271..426d11189a99 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -86,10 +86,6 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 
 	cache_size = 0;
 
-	ret = remount_resctrlfs(true);
-	if (ret)
-		return ret;
-
 	if (!validate_resctrl_feature_request(CMT_STR))
 		return -1;
 
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 9b9751206e1c..5c9ed52b69f2 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -77,9 +77,15 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, int span,
 
 	ksft_print_msg("Starting MBM BW change ...\n");
 
+	res = remount_resctrlfs(false);
+	if (res) {
+		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
+		return;
+	}
+
 	if (!validate_resctrl_feature_request(MBM_STR) || (get_vendor() != ARCH_INTEL)) {
 		ksft_test_result_skip("Hardware does not support MBM or MBM is disabled\n");
-		return;
+		goto umount;
 	}
 
 	if (!has_ben)
@@ -88,6 +94,9 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, int span,
 	ksft_test_result(!res, "MBM: bw change\n");
 	if ((get_vendor() == ARCH_INTEL) && res)
 		ksft_print_msg("Intel MBM may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
+
+umount:
+	umount_resctrlfs();
 }
 
 static void run_mba_test(bool has_ben, char **benchmark_cmd, int span,
@@ -97,15 +106,24 @@ static void run_mba_test(bool has_ben, char **benchmark_cmd, int span,
 
 	ksft_print_msg("Starting MBA Schemata change ...\n");
 
+	res = remount_resctrlfs(false);
+	if (res) {
+		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
+		return;
+	}
+
 	if (!validate_resctrl_feature_request(MBA_STR) || (get_vendor() != ARCH_INTEL)) {
 		ksft_test_result_skip("Hardware does not support MBA or MBA is disabled\n");
-		return;
+		goto umount;
 	}
 
 	if (!has_ben)
 		sprintf(benchmark_cmd[1], "%d", span);
 	res = mba_schemata_change(cpu_no, bw_report, benchmark_cmd);
 	ksft_test_result(!res, "MBA: schemata change\n");
+
+umount:
+	umount_resctrlfs();
 }
 
 static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
@@ -113,9 +131,16 @@ static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
 	int res;
 
 	ksft_print_msg("Starting CMT test ...\n");
+
+	res = remount_resctrlfs(false);
+	if (res) {
+		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
+		return;
+	}
+
 	if (!validate_resctrl_feature_request(CMT_STR)) {
 		ksft_test_result_skip("Hardware does not support CMT or CMT is disabled\n");
-		return;
+		goto umount;
 	}
 
 	if (!has_ben)
@@ -124,6 +149,9 @@ static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
 	ksft_test_result(!res, "CMT: test\n");
 	if ((get_vendor() == ARCH_INTEL) && res)
 		ksft_print_msg("Intel CMT may be inaccurate when Sub-NUMA Clustering is enabled. Check BIOS configuration.\n");
+
+umount:
+	umount_resctrlfs();
 }
 
 static void run_cat_test(int cpu_no, int no_of_bits)
@@ -132,13 +160,23 @@ static void run_cat_test(int cpu_no, int no_of_bits)
 
 	ksft_print_msg("Starting CAT test ...\n");
 
+	res = remount_resctrlfs(false);
+	if (res) {
+		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
+		return;
+	}
+
 	if (!validate_resctrl_feature_request(CAT_STR)) {
 		ksft_test_result_skip("Hardware does not support CAT or CAT is disabled\n");
-		return;
+		goto umount;
 	}
 
 	res = cat_perf_miss_val(cpu_no, no_of_bits, "L3");
 	ksft_test_result(!res, "CAT: test\n");
+
+
+umount:
+	umount_resctrlfs();
 }
 
 int main(int argc, char **argv)
@@ -266,7 +304,5 @@ int main(int argc, char **argv)
 	if (cat_test)
 		run_cat_test(cpu_no, no_of_bits);
 
-	umount_resctrlfs();
-
 	ksft_finished();
 }
diff --git a/tools/testing/selftests/resctrl/resctrl_val.c b/tools/testing/selftests/resctrl/resctrl_val.c
index ab1eab1e7ff6..e8f1e6a59f4a 100644
--- a/tools/testing/selftests/resctrl/resctrl_val.c
+++ b/tools/testing/selftests/resctrl/resctrl_val.c
@@ -648,10 +648,6 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 			return ret;
 	}
 
-	ret = remount_resctrlfs(param->mum_resctrlfs);
-	if (ret)
-		return ret;
-
 	/*
 	 * If benchmark wasn't successfully started by child, then child should
 	 * kill parent, so save parent's pid
@@ -788,7 +784,6 @@ int resctrl_val(char **benchmark_cmd, struct resctrl_val_param *param)
 	signal_handler_unregister();
 out:
 	kill(bm_pid, SIGKILL);
-	umount_resctrlfs();
 
 	return ret;
 }
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index fb00245dee92..42f547a81e25 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -611,7 +611,8 @@ char *fgrep(FILE *inf, const char *str)
  * validate_resctrl_feature_request - Check if requested feature is valid.
  * @resctrl_val:	Requested feature
  *
- * Return: True if the feature is supported, else false
+ * Return: True if the feature is supported, else false. False is also
+ *	   returned if resctrl FS is not mounted.
  */
 bool validate_resctrl_feature_request(const char *resctrl_val)
 {
@@ -619,11 +620,13 @@ bool validate_resctrl_feature_request(const char *resctrl_val)
 	bool found = false;
 	char *res;
 	FILE *inf;
+	int ret;
 
 	if (!resctrl_val)
 		return false;
 
-	if (remount_resctrlfs(false))
+	ret = find_resctrl_mount(NULL);
+	if (ret)
 		return false;
 
 	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR))) {
-- 
2.30.2

