Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF03033E6D2
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Mar 2021 03:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhCQCZA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Mar 2021 22:25:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:55653 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230452AbhCQCYf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Mar 2021 22:24:35 -0400
IronPort-SDR: MHhWO2NZWHrMiUZpVW0VdKs+S4SZ22epzfxcqz2ACM+QyaFBABFjZyKnKNuVF2MBqyb9oPQT60
 l4ccEK+A+lAw==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="209328716"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="209328716"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 19:24:34 -0700
IronPort-SDR: kc8Cdu0j8NxZyL7yMC/mWRFvzdl3iVhROAZGM+lE2J3RcOAUphZ9L/yZ/zFr85/g5hjZ1kDQuA
 nw5i2N896e3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="440290276"
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
Subject: [PATCH v6 13/21] selftests/resctrl: Use resctrl/info for feature detection
Date:   Wed, 17 Mar 2021 02:22:47 +0000
Message-Id: <20210317022255.2536745-14-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210317022255.2536745-1-fenghua.yu@intel.com>
References: <20210317022255.2536745-1-fenghua.yu@intel.com>
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

Reported-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/resctrl.h   |  6 ++-
 tools/testing/selftests/resctrl/resctrlfs.c | 52 ++++++++++++++++-----
 2 files changed, 46 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 81f322245ef7..1ad10c47e31d 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -29,6 +29,10 @@
 #define RESCTRL_PATH		"/sys/fs/resctrl"
 #define PHYS_ID_PATH		"/sys/devices/system/cpu/cpu"
 #define CBM_MASK_PATH		"/sys/fs/resctrl/info"
+#define L3_PATH			"/sys/fs/resctrl/info/L3"
+#define MB_PATH			"/sys/fs/resctrl/info/MB"
+#define L3_MON_PATH		"/sys/fs/resctrl/info/L3_MON"
+#define L3_MON_FEATURES_PATH	"/sys/fs/resctrl/info/L3_MON/mon_features"
 
 #define PARENT_EXIT(err_msg)			\
 	do {					\
@@ -79,7 +83,7 @@ int remount_resctrlfs(bool mum_resctrlfs);
 int get_resource_id(int cpu_no, int *resource_id);
 int umount_resctrlfs(void);
 int validate_bw_report_request(char *bw_report);
-bool validate_resctrl_feature_request(char *resctrl_val);
+bool validate_resctrl_feature_request(const char *resctrl_val);
 char *fgrep(FILE *inf, const char *str);
 int taskset_benchmark(pid_t bm_pid, int cpu_no);
 void run_benchmark(int signum, siginfo_t *info, void *ucontext);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 87195eb78356..26563175acf6 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -606,26 +606,56 @@ char *fgrep(FILE *inf, const char *str)
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
+	if (!strncmp(resctrl_val, CAT_STR, sizeof(CAT_STR))) {
+		if (!stat(L3_PATH, &statbuf))
+			return true;
+	} else if (!strncmp(resctrl_val, MBA_STR, sizeof(MBA_STR))) {
+		if (!stat(MB_PATH, &statbuf))
+			return true;
+	} else if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR)) ||
+		   !strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
+		if (!stat(L3_MON_PATH, &statbuf)) {
+			inf = fopen(L3_MON_FEATURES_PATH, "r");
+			if (!inf)
+				return false;
+
+			if (!strncmp(resctrl_val, CMT_STR, sizeof(CMT_STR))) {
+				res = fgrep(inf, "llc_occupancy");
+				if (res) {
+					found = true;
+					free(res);
+				}
+			}
+
+			if (!strncmp(resctrl_val, MBM_STR, sizeof(MBM_STR))) {
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
2.31.0

