Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C6DD294591
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 01:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439410AbgJTXvm (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Oct 2020 19:51:42 -0400
Received: from mga07.intel.com ([134.134.136.100]:11170 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439408AbgJTXvk (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Oct 2020 19:51:40 -0400
IronPort-SDR: 2NjDcXx9c9YXvtHvLx8i1aD12V4eWTQxBmnDcL35kDfVldTyovEgIUO4jRWBRObaDt/Je54gaa
 ZynMcvvHCpnQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="231486373"
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="231486373"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 16:51:34 -0700
IronPort-SDR: UTZd5P1nura7GF2szGIcSqWtC0LeH0+kaKvklBOW/iLDlXUKBGDbyZuIL6tyihGebpSjc8Rmo4
 8/QQ2NB/JVcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="320833905"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by orsmga006.jf.intel.com with ESMTP; 20 Oct 2020 16:51:33 -0700
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
Subject: [PATCH v3 21/21] selftests/resctrl: Don't use global variable for capacity bitmask (CBM)
Date:   Tue, 20 Oct 2020 23:51:26 +0000
Message-Id: <20201020235126.1871815-22-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201020235126.1871815-1-fenghua.yu@intel.com>
References: <20201020235126.1871815-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Reinette reported following compilation issue on Fedora 32, gcc version
10.1.1

/usr/bin/ld: cmt_test.o:<src_dir>/cmt_test.c:19: multiple definition of
`cbm_mask'; cat_test.o:<src_dir>/cat_test.c:20: first defined here
/usr/bin/ld: resctrlfs.o:<src_dir>/resctrlfs.c:52: multiple definition of
`cbm_mask'; cat_test.o:<src_dir>/cat_test.c:20: first defined here

Compiler throws an error because cbm_mask is defined as a global
variable in three different .c files, namely resctrlfs.c, cat_test.c and
cmt_test.c.

cbm_mask is a global variable that is supposed to hold the capacity
bitmask (CBM) value read from resctrl/info directory. This is done by
get_cbm_mask() function which then sets the global variable.

To reduce the use of global variables (thereby improving readability and
maintainability) change get_cbm_mask() implementation such that it now
accepts a reference to a string. Upon success, get_cbm_mask() populates the
string with CBM value read from resctrl/info directory and returns 0 and on
failure, returns -1.

Please note that this change to get_cbm_mask() fixes the issue reported by
Reinette because cbm_mask isn't a global variable anymore.

Fixes: 78941183d1b15 ("selftests/resctrl: Add Cache QoS Monitoring (CQM) selftest")
Fixes: 790bf585b0eee ("selftests/resctrl: Add Cache Allocation Technology (CAT) selftest")
Reported-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c  |  5 ++---
 tools/testing/selftests/resctrl/cmt_test.c  |  5 ++---
 tools/testing/selftests/resctrl/resctrl.h   |  2 +-
 tools/testing/selftests/resctrl/resctrlfs.c | 10 +++++-----
 4 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index e518f8f7b4d8..60b31b85b484 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -17,8 +17,6 @@
 #define MAX_DIFF_PERCENT	4
 #define MAX_DIFF		1000000
 
-char cbm_mask[256];
-
 /*
  * Change schemata. Write schemata to specified
  * con_mon grp, mon_grp in resctrl FS.
@@ -120,6 +118,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 {
 	unsigned long l_mask, l_mask_1, long_mask, cache_size;
 	int ret, pipefd[2], sibling_cpu_no, count_of_bits;
+	char cbm_mask[256];
 	char pipe_message;
 	pid_t bm_pid;
 
@@ -130,7 +129,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		return ret;
 
 	/* Get default cbm mask for L3/L2 cache */
-	ret = get_cbm_mask(cache_type);
+	ret = get_cbm_mask(cache_type, cbm_mask);
 	if (ret)
 		return ret;
 
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index f0cb441cca9f..0bee3e6480a3 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -16,8 +16,6 @@
 #define MAX_DIFF		2000000
 #define MAX_DIFF_PERCENT	15
 
-char cbm_mask[256];
-
 static int cmt_setup(int num, ...)
 {
 	struct resctrl_val_param *p;
@@ -112,6 +110,7 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 {
 	int ret, mum_resctrlfs, count_of_bits;
 	unsigned long long_mask, cache_size;
+	char cbm_mask[256];
 
 	cache_size = 0;
 	mum_resctrlfs = 1;
@@ -120,7 +119,7 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 	if (ret)
 		return ret;
 
-	ret = get_cbm_mask("L3");
+	ret = get_cbm_mask("L3", cbm_mask);
 	if (ret)
 		return ret;
 
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 65ca24bf3eac..2546435864d0 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -96,7 +96,7 @@ void tests_cleanup(void);
 void mbm_test_cleanup(void);
 int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd);
 void mba_test_cleanup(void);
-int get_cbm_mask(char *cache_type);
+int get_cbm_mask(char *cache_type, char *cbm_mask);
 int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size);
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int cat_val(struct resctrl_val_param *param);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 21281fd895b7..a07118e01590 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -49,8 +49,6 @@ static int find_resctrl_mount(char *buffer)
 	return -ENOENT;
 }
 
-char cbm_mask[256];
-
 /*
  * remount_resctrlfs - Remount resctrl FS at /sys/fs/resctrl
  * @mum_resctrlfs:	Should the resctrl FS be remounted?
@@ -208,16 +206,18 @@ int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size)
 /*
  * get_cbm_mask - Get cbm mask for given cache
  * @cache_type:	Cache level L2/L3
- *
- * Mask is stored in cbm_mask which is global variable.
+ * @cbm_mask:	cbm_mask returned as a string
  *
  * Return: = 0 on success, < 0 on failure.
  */
-int get_cbm_mask(char *cache_type)
+int get_cbm_mask(char *cache_type, char *cbm_mask)
 {
 	char cbm_mask_path[1024];
 	FILE *fp;
 
+	if (!cbm_mask)
+		return -1;
+
 	sprintf(cbm_mask_path, "%s/%s/cbm_mask", CBM_MASK_PATH, cache_type);
 
 	fp = fopen(cbm_mask_path, "r");
-- 
2.29.0

