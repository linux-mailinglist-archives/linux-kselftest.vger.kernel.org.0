Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB19A7A22D2
	for <lists+linux-kselftest@lfdr.de>; Fri, 15 Sep 2023 17:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbjIOPps (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 15 Sep 2023 11:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236235AbjIOPpV (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 15 Sep 2023 11:45:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 343BFE6D;
        Fri, 15 Sep 2023 08:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694792716; x=1726328716;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ex2MQ21l01Q/4c3TuXPDqbGcgN/ilOQy9XmeMo6Wzq4=;
  b=mQ5HkQDZ9qDOn/kAyCCfmv+8XhxFaJfLJI9UxM/VuFttEeWIPsJlFiLI
   j8uBeulp0Ad1CIquqULKx+tCec/VW+9POdotjQKYVnhz6vcXlertgqdGY
   SBe8aJ8gxEVStF3+AZP4m7ESBCEYmzxgUQtW/4MR4JAdKVaUxtOCyAxMO
   Nxy/VWp1bgKOoRvnmnEtTVrsnKi70UisGM+TyuibfbN5GU6Vm+rHMAq9w
   rNsltz6oeX3vRGJt6XCdgKjUnrclJOmB/mm1rzTnVr3rJxJxSnrO2UJRk
   QwKwA80o2uOjfqoeYaRUL7VIZZ8tkQc/Eju6Bkqc/1dDOaIkP/mfI0Qcm
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="443338366"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="443338366"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 08:45:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="991879041"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="991879041"
Received: from srdoo-mobl1.ger.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.38.99])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 08:45:12 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kselftest@vger.kernel.org,
        =?UTF-8?q?Maciej=20Wiecz=C3=B3r-Retman?= 
        <maciej.wieczor-retman@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        stable@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 4/6] selftests/resctrl: Refactor feature check to use resource and feature name
Date:   Fri, 15 Sep 2023 18:44:36 +0300
Message-Id: <20230915154438.82931-5-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230915154438.82931-1-ilpo.jarvinen@linux.intel.com>
References: <20230915154438.82931-1-ilpo.jarvinen@linux.intel.com>
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
index 524ba83d7568..b13aee5dffb9 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -99,7 +99,9 @@ static void run_mbm_test(const char * const *benchmark_cmd, int cpu_no)
 	if (test_prepare())
 		return;
 
-	if (!validate_resctrl_feature_request(MBM_STR) || (get_vendor() != ARCH_INTEL)) {
+	if (!validate_resctrl_feature_request("L3_MON", "mbm_total_bytes") ||
+	    !validate_resctrl_feature_request("L3_MON", "mbm_local_bytes") ||
+	    (get_vendor() != ARCH_INTEL)) {
 		ksft_test_result_skip("Hardware does not support MBM or MBM is disabled\n");
 		goto cleanup;
 	}
@@ -122,7 +124,7 @@ static void run_mba_test(const char * const *benchmark_cmd, int cpu_no)
 	if (test_prepare())
 		return;
 
-	if (!validate_resctrl_feature_request(MBA_STR) || (get_vendor() != ARCH_INTEL)) {
+	if (!validate_resctrl_feature_request("MB", NULL) || (get_vendor() != ARCH_INTEL)) {
 		ksft_test_result_skip("Hardware does not support MBA or MBA is disabled\n");
 		goto cleanup;
 	}
@@ -143,7 +145,7 @@ static void run_cmt_test(const char * const *benchmark_cmd, int cpu_no)
 	if (test_prepare())
 		return;
 
-	if (!validate_resctrl_feature_request(CMT_STR)) {
+	if (!validate_resctrl_feature_request("L3_MON", "llc_occupancy")) {
 		ksft_test_result_skip("Hardware does not support CMT or CMT is disabled\n");
 		goto cleanup;
 	}
@@ -166,7 +168,7 @@ static void run_cat_test(int cpu_no, int no_of_bits)
 	if (test_prepare())
 		return;
 
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

