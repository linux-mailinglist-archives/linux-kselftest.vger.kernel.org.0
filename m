Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D178579C095
	for <lists+linux-kselftest@lfdr.de>; Tue, 12 Sep 2023 02:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345361AbjIKVTq (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 11 Sep 2023 17:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236748AbjIKLT7 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 11 Sep 2023 07:19:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FAC3CE5;
        Mon, 11 Sep 2023 04:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694431195; x=1725967195;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w2mPsgC7tONPxyqh+KEqCWAT/oSiN0XNkLZZwVw4ZhA=;
  b=cCjLb/IOwEC3U1T1ooupJhjJt1n0/MhVbQHM3QddvDQ3nEBx0zZxZhYK
   f0ekDdSrx4QWFebHgN0sdf2ZKl7FP6k2OiBAtNo/DQKGH4vQTbzqTvQBt
   Vu50eq9mZ0s13E9FktDsXW4fgVKCK44Apizec0ILD0cybGS9F3j0OsoJb
   UKzALpNdfrYbN+myxpVgf/PJJjx2/O6/S2AqOfUGbX4ntMA+RKiM4VJDb
   K27ywqnJNU+H3sKYPmZPWurU79aQvYU/UppyG44hFueUPczKWpfUCUADA
   YExVLHZzYGDDFdSid07uAp3gbyPpo2N6FUku5a2nMOsyuylws1jOLU1La
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="464428620"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="464428620"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 04:19:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="916990564"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="916990564"
Received: from mzarkov-mobl3.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.36.200])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 04:19:52 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        =?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
Cc:     linux-kernel@vger.kernel.org,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 3/5] selftests/resctrl: Refactor feature check to use resource and feature name
Date:   Mon, 11 Sep 2023 14:19:28 +0300
Message-Id: <20230911111930.16088-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230911111930.16088-1-ilpo.jarvinen@linux.intel.com>
References: <20230911111930.16088-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Feature check in validate_resctrl_feature_request() takes in the test
name string and maps that to what to check per test.

Pass resource and feature names to validate_resctrl_feature_request()
directly rather than deriving them from the test name inside the
function which makes the feature check easier to extend for new test
cases.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: <stable@vger.kernel.org>
---
 tools/testing/selftests/resctrl/resctrl.h     |  6 +-
 .../testing/selftests/resctrl/resctrl_tests.c | 10 +--
 tools/testing/selftests/resctrl/resctrlfs.c   | 69 ++++++++-----------
 3 files changed, 34 insertions(+), 51 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index dd07463cdf48..89ced4152933 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -28,10 +28,6 @@
 #define RESCTRL_PATH		"/sys/fs/resctrl"
 #define PHYS_ID_PATH		"/sys/devices/system/cpu/cpu"
 #define INFO_PATH		"/sys/fs/resctrl/info"
-#define L3_PATH			"/sys/fs/resctrl/info/L3"
-#define MB_PATH			"/sys/fs/resctrl/info/MB"
-#define L3_MON_PATH		"/sys/fs/resctrl/info/L3_MON"
-#define L3_MON_FEATURES_PATH	"/sys/fs/resctrl/info/L3_MON/mon_features"
 
 #define ARCH_INTEL     1
 #define ARCH_AMD       2
@@ -88,7 +84,7 @@ int get_resource_id(int cpu_no, int *resource_id);
 int mount_resctrlfs(void);
 int umount_resctrlfs(void);
 int validate_bw_report_request(char *bw_report);
-bool validate_resctrl_feature_request(const char *resctrl_val);
+bool validate_resctrl_feature_request(const char *resource, const char *feature);
 char *fgrep(FILE *inf, const char *str);
 int taskset_benchmark(pid_t bm_pid, int cpu_no);
 void run_benchmark(int signum, siginfo_t *info, void *ucontext);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 3d66fbdc2df3..3052394ca884 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -84,7 +84,9 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
 		return;
 	}
 
-	if (!validate_resctrl_feature_request(MBM_STR) || (get_vendor() != ARCH_INTEL)) {
+	if (!validate_resctrl_feature_request("L3_MON", "mbm_total_bytes") ||
+	    !validate_resctrl_feature_request("L3_MON", "mbm_local_bytes") ||
+	    (get_vendor() != ARCH_INTEL)) {
 		ksft_test_result_skip("Hardware does not support MBM or MBM is disabled\n");
 		goto umount;
 	}
@@ -116,7 +118,7 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
 		return;
 	}
 
-	if (!validate_resctrl_feature_request(MBA_STR) || (get_vendor() != ARCH_INTEL)) {
+	if (!validate_resctrl_feature_request("MB", NULL) || (get_vendor() != ARCH_INTEL)) {
 		ksft_test_result_skip("Hardware does not support MBA or MBA is disabled\n");
 		goto umount;
 	}
@@ -146,7 +148,7 @@ static void run_cmt_test(const char * const *benchmark_cmd, int cpu_no)
 		return;
 	}
 
-	if (!validate_resctrl_feature_request(CMT_STR)) {
+	if (!validate_resctrl_feature_request("L3_MON", "llc_occupancy")) {
 		ksft_test_result_skip("Hardware does not support CMT or CMT is disabled\n");
 		goto umount;
 	}
@@ -178,7 +180,7 @@ static void run_cat_test(int cpu_no, int no_of_bits)
 		return;
 	}
 
-	if (!validate_resctrl_feature_request(CAT_STR)) {
+	if (!validate_resctrl_feature_request("L3", NULL)) {
 		ksft_test_result_skip("Hardware does not support CAT or CAT is disabled\n");
 		goto umount;
 	}
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index bd36ee206602..bd547a10791c 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -10,6 +10,8 @@
  */
 #include "resctrl.h"
 
+#include <limits.h>
+
 static int find_resctrl_mount(char *buffer)
 {
 	FILE *mounts;
@@ -604,63 +606,46 @@ char *fgrep(FILE *inf, const char *str)
 
 /*
  * validate_resctrl_feature_request - Check if requested feature is valid.
- * @resctrl_val:	Requested feature
+ * @resource:	Required resource (e.g., MB, L3, L2, L3_MON, etc.)
+ * @feature:	Feature to be checked under resource (can be NULL). This path
+ *		is relative to the resource path.
  *
- * Return: True if the feature is supported, else false. False is also
- *         returned if resctrl FS is not mounted.
+ * Return: True if the resource/feature is supported, else false. False is
+ *         also returned if resctrl FS is not mounted.
  */
-bool validate_resctrl_feature_request(const char *resctrl_val)
+bool validate_resctrl_feature_request(const char *resource, const char *feature)
 {
 	struct stat statbuf;
-	bool found = false;
+	char res_path[PATH_MAX];
 	char *res;
 	FILE *inf;
 	int ret;
 
-	if (!resctrl_val)
+	if (!resource)
 		return false;
 
 	ret = find_resctrl_mount(NULL);
 	if (ret)
 		return false;
 
-	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR))) {
-		if (!stat(L3_PATH, &statbuf))
-			return true;
-	} else if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
-		if (!stat(MB_PATH, &statbuf))
-			return true;
-	} else if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
-		   !strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
-		if (!stat(L3_MON_PATH, &statbuf)) {
-			inf = fopen(L3_MON_FEATURES_PATH, "r");
-			if (!inf)
-				return false;
-
-			if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
-				res = fgrep(inf, "llc_occupancy");
-				if (res) {
-					found = true;
-					free(res);
-				}
-			}
-
-			if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR))) {
-				res = fgrep(inf, "mbm_total_bytes");
-				if (res) {
-					free(res);
-					res = fgrep(inf, "mbm_local_bytes");
-					if (res) {
-						found = true;
-						free(res);
-					}
-				}
-			}
-			fclose(inf);
-		}
-	}
+	snprintf(res_path, sizeof(res_path), "%s/%s", INFO_PATH, resource);
+
+	if (stat(res_path, &statbuf))
+		return false;
+
+	if (!feature)
+		return true;
+
+	snprintf(res_path, sizeof(res_path), "%s/%s/mon_features", INFO_PATH, resource);
+	inf = fopen(res_path, "r");
+	if (!inf)
+		return false;
+
+	res = fgrep(inf, feature);
+	free(res);
+	fclose(inf);
 
-	return found;
+	return res;
 }
 
 int filter_dmesg(void)
-- 
2.30.2

