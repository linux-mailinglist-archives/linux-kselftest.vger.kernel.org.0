Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635CA722E2D
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 20:02:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235318AbjFESCp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 14:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235195AbjFESCk (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 14:02:40 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 917FD13A;
        Mon,  5 Jun 2023 11:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685988152; x=1717524152;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2BZJHMvy5Smo9CkdsEnHUm5lhkt7OZqGEDLiRMU2uiE=;
  b=hnX87FGTarewJSxWe7hPu5VR0qPL4f8tWaBP/TUGxcwmubif1pGQzrH2
   iR5pjXqSJKPTF3FCswlVVUtSOMlShZQkbFmDrsm1cCFGB8g04hHEhtkhG
   BblLyparFVaFYVpSdugW4S78kj6mWzLu5+TOGUZ1Eo5yJ4fbpNQ+UmrG1
   nE7rKzfDzOYduQ4Xkz96xh4eUfuPw3jC6vgfR9m6z73QoLRb/mzAiVAYv
   Ug+Y+VBSabqrvpVUkU5dyiSFEYUQSeI1VHQWvS6G8dkUPxFMLiITg6i3s
   dDiiAU+UuwvZ3COyazJWcUGXio9ieb+V+T6c9Nmex4oqPdp86NpMshvyt
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="442814969"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="442814969"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 11:02:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="821274052"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="821274052"
Received: from gfittedx-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.47.115])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 11:02:16 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 06/19] selftests/resctrl: Move resctrl FS mount/umount to higher level
Date:   Mon,  5 Jun 2023 21:01:32 +0300
Message-Id: <20230605180145.112924-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230605180145.112924-1-ilpo.jarvinen@linux.intel.com>
References: <20230605180145.112924-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

A few places currently lack umounting resctrl FS on error paths:
  - cmt_resctrl_val() has multiple error paths with direct return.
  - cat_perf_miss_val() has multiple error paths with direct return.
In addition, validate_resctrl_feature_request() is called by
run_mbm_test() and run_mba_test(). Neither MBA nor MBM test tries to
umount resctrl FS.

Each and every test does require resctrl FS to be present already for
feature check. Thus, it makes sense to just mount it on higher level in
resctrl_tests.c and properly pair it with umount.

Move resctrl FS (re)mount/unmount into each test function in
resctrl_tests.c. Make feature validation to simply check that resctrl
FS is mounted.

Fixes: 91db4fd9019a ("selftests/resctrl: Remove duplicate codes that clear each test result file")
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c    |  6 ---
 tools/testing/selftests/resctrl/cmt_test.c    |  4 --
 .../testing/selftests/resctrl/resctrl_tests.c | 47 ++++++++++++++++---
 tools/testing/selftests/resctrl/resctrl_val.c |  5 --
 tools/testing/selftests/resctrl/resctrlfs.c   |  7 ++-
 5 files changed, 46 insertions(+), 23 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index fb1443f888c4..e1c071dec1b0 100644
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
index 6fcf8fc3cfc0..0ee73e722acc 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -77,9 +77,15 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, int span,
 
 	ksft_print_msg("Starting MBM BW change ...\n");
 
+	res = remount_resctrlfs(true);
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
 
+	res = remount_resctrlfs(true);
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
+	res = remount_resctrlfs(true);
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
@@ -132,13 +160,22 @@ static void run_cat_test(int cpu_no, int no_of_bits)
 
 	ksft_print_msg("Starting CAT test ...\n");
 
+	res = remount_resctrlfs(true);
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
+umount:
+	umount_resctrlfs();
 }
 
 int main(int argc, char **argv)
@@ -268,7 +305,5 @@ int main(int argc, char **argv)
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
index 23f75aeaa198..b3a05488d360 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -613,7 +613,8 @@ char *fgrep(FILE *inf, const char *str)
  * validate_resctrl_feature_request - Check if requested feature is valid.
  * @resctrl_val:	Requested feature
  *
- * Return: True if the feature is supported, else false
+ * Return: True if the feature is supported, else false. False is also
+ *         returned if resctrl FS is not mounted.
  */
 bool validate_resctrl_feature_request(const char *resctrl_val)
 {
@@ -621,11 +622,13 @@ bool validate_resctrl_feature_request(const char *resctrl_val)
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

