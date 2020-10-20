Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98676294588
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 01:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410719AbgJTXvc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Oct 2020 19:51:32 -0400
Received: from mga01.intel.com ([192.55.52.88]:63669 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410711AbgJTXvb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Oct 2020 19:51:31 -0400
IronPort-SDR: O2mKKckwCsjDaQte+NxwgrxoCFuCEMQTWfOXpJy3c4qR6WCGYIcRVWoz4HSh4ozq+Y5M5qbcXB
 Apcw8yshognA==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="184942261"
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="184942261"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 16:51:30 -0700
IronPort-SDR: AxdBHfuovxbP4EHBgRKEa27JaykkvvyNS+lMx6IbqNFBy269Evw5YRs1xL6ojhs5gA13F8NF8+
 P9Y7NWm3Pgtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="320833832"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by orsmga006.jf.intel.com with ESMTP; 20 Oct 2020 16:51:30 -0700
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
Subject: [PATCH v3 07/21] selftests/resctrl: Use resctrl/info for feature detection
Date:   Tue, 20 Oct 2020 23:51:12 +0000
Message-Id: <20201020235126.1871815-8-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201020235126.1871815-1-fenghua.yu@intel.com>
References: <20201020235126.1871815-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Resctrl test suite before running any unit test (like cmt, cat, mbm and
mba) should first check if the feature is enabled (by kernel and not just
supported by H/W) on the platform or not.
validate_resctrl_feature_request() is supposed to do that. This function
intends to grep for relevant flags in /proc/cpuinfo but there are several
issues here

1. validate_resctrl_feature_request() calls fgrep() to get flags from
   /proc/cpuinfo. But, fgrep() can only return a string with maximum of 255
   characters and hence the complete cpu flags are never returned.
2. The substring search logic is also busted. If strstr() finds requested
   resctrl feature in the cpu flags, it returns pointer to the first
   occurrence. But, the logic negates the return value of strstr() and
   hence validate_resctrl_feature_request() returns false if the feature is
   present in the cpu flags and returns true if the feature is not present.
3. validate_resctrl_feature_request() checks if a resctrl feature is
   reported in /proc/cpuinfo flags or not. Having a cpu flag means that the
   H/W supports the feature, but it doesn't mean that the kernel enabled
   it. A user could selectively enable only a subset of resctrl features
   using kernel command line arguments. Hence, /proc/cpuinfo isn't a
   reliable source to check if a feature is enabled or not.

The 3rd issue being the major one and fixing it requires changing the way
validate_resctrl_feature_request() works. Since, /proc/cpuinfo isn't the
right place to check if a resctrl feature is enabled or not, a more
appropriate place is /sys/fs/resctrl/info directory. Change
validate_resctrl_feature_request() such that,

1. For cat, check if /sys/fs/resctrl/info/L3 directory is present or not
2. For mba, check if /sys/fs/resctrl/info/MB directory is present or not
3. For cmt, check if /sys/fs/resctrl/info/L3_MON directory is present and
   check if /sys/fs/resctrl/info/L3_MON/mon_features has llc_occupancy
4. For mbm, check if /sys/fs/resctrl/info/L3_MON directory is present and
   check if /sys/fs/resctrl/info/L3_MON/mon_features has
   mbm_<total/local>_bytes

Please note that only L3_CAT, L3_CMT, MBA and MBM are supported. CDP and L2
variants can be added later.

Fixes: 591a6e8588fc ("selftests/resctrl: Add basic resctrl file system operations and data")
Reported-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/resctrl.h   |  6 ++-
 tools/testing/selftests/resctrl/resctrlfs.c | 51 ++++++++++++++++-----
 2 files changed, 45 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 814d0dd517a4..65ca24bf3eac 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -28,6 +28,10 @@
 #define RESCTRL_PATH		"/sys/fs/resctrl"
 #define PHYS_ID_PATH		"/sys/devices/system/cpu/cpu"
 #define CBM_MASK_PATH		"/sys/fs/resctrl/info"
+#define L3_PATH			"/sys/fs/resctrl/info/L3"
+#define MB_PATH			"/sys/fs/resctrl/info/MB"
+#define L3_MON_PATH		"/sys/fs/resctrl/info/L3_MON"
+#define L3_MON_FEATURES_PATH	"/sys/fs/resctrl/info/L3_MON/mon_features"
 
 #define PARENT_EXIT(err_msg)			\
 	do {					\
@@ -74,7 +78,7 @@ int remount_resctrlfs(bool mum_resctrlfs);
 int get_resource_id(int cpu_no, int *resource_id);
 int umount_resctrlfs(void);
 int validate_bw_report_request(char *bw_report);
-bool validate_resctrl_feature_request(char *resctrl_val);
+bool validate_resctrl_feature_request(const char *resctrl_val);
 char *fgrep(FILE *inf, const char *str);
 int taskset_benchmark(pid_t bm_pid, int cpu_no);
 void run_benchmark(int signum, siginfo_t *info, void *ucontext);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index e43ddebd1aa4..67d775d03271 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -618,26 +618,55 @@ char *fgrep(FILE *inf, const char *str)
  * validate_resctrl_feature_request - Check if requested feature is valid.
  * @resctrl_val:	Requested feature
  *
- * Return: 0 on success, non-zero on failure
+ * Return: True if the feature is supported, else false
  */
-bool validate_resctrl_feature_request(char *resctrl_val)
+bool validate_resctrl_feature_request(const char *resctrl_val)
 {
-	FILE *inf = fopen("/proc/cpuinfo", "r");
+	struct stat statbuf;
 	bool found = false;
 	char *res;
+	FILE *inf;
 
-	if (!inf)
+	if (!resctrl_val)
 		return false;
 
-	res = fgrep(inf, "flags");
-
-	if (res) {
-		char *s = strchr(res, ':');
+	if (remount_resctrlfs(false))
+		return false;
 
-		found = s && !strstr(s, resctrl_val);
-		free(res);
+	if (!strcmp(resctrl_val, "cat")) {
+		if (!stat(L3_PATH, &statbuf))
+			return true;
+	} else if (!strcmp(resctrl_val, "mba")) {
+		if (!stat(MB_PATH, &statbuf))
+			return true;
+	} else if (!strcmp(resctrl_val, "mbm") || !strcmp(resctrl_val, "cmt")) {
+		if (!stat(L3_MON_PATH, &statbuf)) {
+			inf = fopen(L3_MON_FEATURES_PATH, "r");
+			if (!inf)
+				return false;
+
+			if (!strcmp(resctrl_val, "cmt")) {
+				res = fgrep(inf, "llc_occupancy");
+				if (res) {
+					found = true;
+					free(res);
+				}
+			}
+
+			if (!strcmp(resctrl_val, "mbm")) {
+				res = fgrep(inf, "mbm_total_bytes");
+				if (res) {
+					free(res);
+					res = fgrep(inf, "mbm_local_bytes");
+					if (res) {
+						found = true;
+						free(res);
+					}
+				}
+			}
+			fclose(inf);
+		}
 	}
-	fclose(inf);
 
 	return found;
 }
-- 
2.29.0

