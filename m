Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A7DD1D8A78
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 May 2020 00:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727831AbgERWN5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 May 2020 18:13:57 -0400
Received: from mga01.intel.com ([192.55.52.88]:46546 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726502AbgERWN4 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 May 2020 18:13:56 -0400
IronPort-SDR: qrcTGnNea+vEpBFoovvqUesGtJ23SzkT5fxPwGiKRGLh+VkdbT7/DBdggD1Dg0hdlwPYVI2CBl
 yT9Zd8eF/kIQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 15:13:56 -0700
IronPort-SDR: Av4G38pSJ9qwle9giEtLeGmo40PMLtOD+ORubTABQCevD/+KKZzRZWPva2dNuitys2hEZURBFm
 V6wllpwtUhJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="411420350"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by orsmga004.jf.intel.com with ESMTP; 18 May 2020 15:13:56 -0700
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     shuah@kernel.org, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, reinette.chatre@intel.com, babu.moger@amd.com,
        james.morse@arm.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel,
        dan.carpenter@oracle.com, dcb314@hotmail.com,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH V2 07/19] selftests/resctrl: Use resctrl/info for feature detection
Date:   Mon, 18 May 2020 15:08:27 -0700
Message-Id: <f314626e53fb97c6cde732a72dc41f9b983fe21e.1589835155.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
References: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

RDT features could be enabled or disabled through kernel command line
parameters. This is not reflected in /proc/cpuinfo i.e. cpuinfo always
shows the features supported by H/W whereas user could selectively enable
or disable some of these features. So, before running a requested test,
/proc/cpuinfo cannot be used to check if the system supports the
requested RDT feature.

A more appropriate place to check for this is resctrl/info. Directories
like L3, MB and L3_MON are populated only if the respective feature is
enabled. Hence, use resctrl/info for feature detection instead of
/proc/cpuinfo.

Please note that, presently, only L3_CAT, L3_CMT, MBA and MBM are
supported. L2 and CDP variants of L3 are not yet supported.

Fixes: 591a6e8588fc ("selftests/resctrl: Add basic resctrl file system operations and data")
Reported-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
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
2.19.1

