Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 276A17B4F75
	for <lists+linux-kselftest@lfdr.de>; Mon,  2 Oct 2023 11:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236208AbjJBJt0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 2 Oct 2023 05:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236112AbjJBJt0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 2 Oct 2023 05:49:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10D8591;
        Mon,  2 Oct 2023 02:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696240163; x=1727776163;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gtwyZgytTIaaChtlJoTwXsMFAKDmK3uaauBiKS3o2Es=;
  b=gugDNUAXOEb2meHw1eB3tCY5DIHVVxgFuUGF8tRBfWqfuHAJqtNod31w
   nb5bhg+DUQJmrSb2b7vxhPIhgMImo2d49LOHpLGm/N5uqS15UBSEMT5n7
   NZ7u+Xh0J8rGwIKm+DjcSKFhWm0tPopBciKea+GkOKR54PlHep7LADAwn
   c/mZcQb7+kQvLl+bZCK7GcF951r+R7Nht8A6UwL1gE6Eyql9t6sdOJdnb
   h32UftlYLpcsFvELYeISB1tpxeK97qau90ECYN3V3ZnSfnH5Nadk5i8Vv
   bV6wpUr33GBCdbVa71iywqMfQ5T9uIreey90BqhlIpOYZoGH7Bv2o7ODw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="372960649"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="372960649"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:49:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10850"; a="754005522"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="754005522"
Received: from aanantha-mobl.gar.corp.intel.com (HELO localhost) ([10.251.221.191])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 02:49:18 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Reinette Chatre <reinette.chatre@intel.com>,
        =?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 5/7] selftests/resctrl: Refactor feature check to use resource and feature name
Date:   Mon,  2 Oct 2023 12:48:11 +0300
Message-Id: <20231002094813.6633-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231002094813.6633-1-ilpo.jarvinen@linux.intel.com>
References: <20231002094813.6633-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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

Use !! in the return statement to make the boolean conversion more
obvious even if it is not strictly necessary from correctness point of
view (to avoid it looking like the function is returning a freed
pointer).

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Tested-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>
Cc: <stable@vger.kernel.org> # selftests/resctrl: Remove duplicate feature check from CMT test
Cc: <stable@vger.kernel.org> # selftests/resctrl: Move _GNU_SOURCE define into Makefile
---
 tools/testing/selftests/resctrl/resctrl.h     |  6 +-
 .../testing/selftests/resctrl/resctrl_tests.c | 10 +--
 tools/testing/selftests/resctrl/resctrlfs.c   | 69 ++++++++-----------
 3 files changed, 34 insertions(+), 51 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index d9b5df95849d..8578a8b4e145 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -27,10 +27,6 @@
 #define RESCTRL_PATH		"/sys/fs/resctrl"
 #define PHYS_ID_PATH		"/sys/devices/system/cpu/cpu"
 #define INFO_PATH		"/sys/fs/resctrl/info"
-#define L3_PATH			"/sys/fs/resctrl/info/L3"
-#define MB_PATH			"/sys/fs/resctrl/info/MB"
-#define L3_MON_PATH		"/sys/fs/resctrl/info/L3_MON"
-#define L3_MON_FEATURES_PATH	"/sys/fs/resctrl/info/L3_MON/mon_features"
 
 #define ARCH_INTEL     1
 #define ARCH_AMD       2
@@ -87,7 +83,7 @@ int get_resource_id(int cpu_no, int *resource_id);
 int mount_resctrlfs(void);
 int umount_resctrlfs(void);
 int validate_bw_report_request(char *bw_report);
-bool validate_resctrl_feature_request(const char *resctrl_val);
+bool validate_resctrl_feature_request(const char *resource, const char *feature);
 char *fgrep(FILE *inf, const char *str);
 int taskset_benchmark(pid_t bm_pid, int cpu_no);
 void run_benchmark(int signum, siginfo_t *info, void *ucontext);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 495aeee5b734..a19dcc3f8fb0 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -103,7 +103,9 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
 		return;
 	}
 
-	if (!validate_resctrl_feature_request(MBM_STR) || (get_vendor() != ARCH_INTEL)) {
+	if (!validate_resctrl_feature_request("L3_MON", "mbm_total_bytes") ||
+	    !validate_resctrl_feature_request("L3_MON", "mbm_local_bytes") ||
+	    (get_vendor() != ARCH_INTEL)) {
 		ksft_test_result_skip("Hardware does not support MBM or MBM is disabled\n");
 		goto cleanup;
 	}
@@ -128,7 +130,7 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
 		return;
 	}
 
-	if (!validate_resctrl_feature_request(MBA_STR) || (get_vendor() != ARCH_INTEL)) {
+	if (!validate_resctrl_feature_request("MB", NULL) || (get_vendor() != ARCH_INTEL)) {
 		ksft_test_result_skip("Hardware does not support MBA or MBA is disabled\n");
 		goto cleanup;
 	}
@@ -151,7 +153,7 @@ static void run_cmt_test(const char * const *benchmark_cmd, int cpu_no)
 		return;
 	}
 
-	if (!validate_resctrl_feature_request(CMT_STR)) {
+	if (!validate_resctrl_feature_request("L3_MON", "llc_occupancy")) {
 		ksft_test_result_skip("Hardware does not support CMT or CMT is disabled\n");
 		goto cleanup;
 	}
@@ -176,7 +178,7 @@ static void run_cat_test(int cpu_no, int no_of_bits)
 		return;
 	}
 
-	if (!validate_resctrl_feature_request(CAT_STR)) {
+	if (!validate_resctrl_feature_request("L3", NULL)) {
 		ksft_test_result_skip("Hardware does not support CAT or CAT is disabled\n");
 		goto cleanup;
 	}
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index bd36ee206602..3a8111362d26 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -8,6 +8,8 @@
  *    Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>,
  *    Fenghua Yu <fenghua.yu@intel.com>
  */
+#include <limits.h>
+
 #include "resctrl.h"
 
 static int find_resctrl_mount(char *buffer)
@@ -604,63 +606,46 @@ char *fgrep(FILE *inf, const char *str)
 
 /*
  * validate_resctrl_feature_request - Check if requested feature is valid.
- * @resctrl_val:	Requested feature
+ * @resource:	Required resource (e.g., MB, L3, L2, L3_MON, etc.)
+ * @feature:	Required monitor feature (in mon_features file). Can only be
+ *		set for L3_MON. Must be NULL for all other resources.
  *
- * Return: True if the feature is supported, else false. False is also
- *         returned if resctrl FS is not mounted.
+ * Return: True if the resource/feature is supported, else false. False is
+ *         also returned if resctrl FS is not mounted.
  */
-bool validate_resctrl_feature_request(const char *resctrl_val)
+bool validate_resctrl_feature_request(const char *resource, const char *feature)
 {
+	char res_path[PATH_MAX];
 	struct stat statbuf;
-	bool found = false;
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
+	return !!res;
 }
 
 int filter_dmesg(void)
-- 
2.30.2

