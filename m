Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDF733E6DB
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Mar 2021 03:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbhCQCZE (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Mar 2021 22:25:04 -0400
Received: from mga01.intel.com ([192.55.52.88]:55651 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230429AbhCQCYe (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Mar 2021 22:24:34 -0400
IronPort-SDR: 2XdlR4XSZ8y8WlaIzQcFDbrqyk6rlaeFDcqefsqXjEYUwdx279aMdGnHh/8j42DXSerqXfWtXb
 L0rFhUHTUhpw==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="209328704"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="209328704"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 19:24:33 -0700
IronPort-SDR: aFy54vb0uY48wGkwR1OGOzNZ9DolMGhMsbJrApTNqpCi7A7xEUkP+kmxss6X+wLkOIHUy2bSVZ
 CX3wuFMI82uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="440290241"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Mar 2021 19:24:33 -0700
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Babu Moger" <babu.moger@amd.com>,
        "Ravi V Shankar" <ravi.v.shankar@intel.com>
Cc:     "linux-kselftest" <linux-kselftest@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v6 02/21] selftests/resctrl: Fix compilation issues for global variables
Date:   Wed, 17 Mar 2021 02:22:36 +0000
Message-Id: <20210317022255.2536745-3-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210317022255.2536745-1-fenghua.yu@intel.com>
References: <20210317022255.2536745-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Reinette reported following compilation issue on Fedora 32, gcc version
10.1.1

/usr/bin/ld: cqm_test.o:<src_dir>/cqm_test.c:22: multiple definition of
`cache_size'; cat_test.o:<src_dir>/cat_test.c:23: first defined here

The same issue is reported for long_mask, cbm_mask, count_of_bits etc
variables as well. Compiler isn't happy because these variables are
defined globally in two .c files namely cqm_test.c and cat_test.c and
the compiler during compilation finds that the variable is already
defined (multiple definition error).

Taking a closer look at the usage of these variables reveals that these
variables are used only locally in functions such as cqm_resctrl_val()
(defined in cqm_test.c) and cat_perf_miss_val() (defined in cat_test.c).
These variables are not shared between those functions. So, there is no
need for these variables to be global. Hence, fix this issue by making
them static variables.

Reported-by: Reinette Chatre <reinette.chatre@intel.com>
Tested-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
Change Log:
v5:
- Define long_mask, cbm_mask, count_of_bits etc as static variables
  (Shuah).
- Split this patch into patch 2 and 3 (Shuah).

 tools/testing/selftests/resctrl/cat_test.c  | 10 +++++-----
 tools/testing/selftests/resctrl/cqm_test.c  | 10 +++++-----
 tools/testing/selftests/resctrl/resctrl.h   |  2 +-
 tools/testing/selftests/resctrl/resctrlfs.c | 10 +++++-----
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index 5da43767b973..bdeeb5772592 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -17,10 +17,10 @@
 #define MAX_DIFF_PERCENT	4
 #define MAX_DIFF		1000000
 
-int count_of_bits;
-char cbm_mask[256];
-unsigned long long_mask;
-unsigned long cache_size;
+static int count_of_bits;
+static char cbm_mask[256];
+static unsigned long long_mask;
+static unsigned long cache_size;
 
 /*
  * Change schemata. Write schemata to specified
@@ -136,7 +136,7 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 		return -1;
 
 	/* Get default cbm mask for L3/L2 cache */
-	ret = get_cbm_mask(cache_type);
+	ret = get_cbm_mask(cache_type, cbm_mask);
 	if (ret)
 		return ret;
 
diff --git a/tools/testing/selftests/resctrl/cqm_test.c b/tools/testing/selftests/resctrl/cqm_test.c
index 5e7308ac63be..de33d1c0466e 100644
--- a/tools/testing/selftests/resctrl/cqm_test.c
+++ b/tools/testing/selftests/resctrl/cqm_test.c
@@ -16,10 +16,10 @@
 #define MAX_DIFF		2000000
 #define MAX_DIFF_PERCENT	15
 
-int count_of_bits;
-char cbm_mask[256];
-unsigned long long_mask;
-unsigned long cache_size;
+static int count_of_bits;
+static char cbm_mask[256];
+static unsigned long long_mask;
+static unsigned long cache_size;
 
 static int cqm_setup(int num, ...)
 {
@@ -125,7 +125,7 @@ int cqm_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 	if (!validate_resctrl_feature_request("cqm"))
 		return -1;
 
-	ret = get_cbm_mask("L3");
+	ret = get_cbm_mask("L3", cbm_mask);
 	if (ret)
 		return ret;
 
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 39bf59c6b9c5..959c71e39bdc 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -92,7 +92,7 @@ void tests_cleanup(void);
 void mbm_test_cleanup(void);
 int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd);
 void mba_test_cleanup(void);
-int get_cbm_mask(char *cache_type);
+int get_cbm_mask(char *cache_type, char *cbm_mask);
 int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size);
 void ctrlc_handler(int signum, siginfo_t *info, void *ptr);
 int cat_val(struct resctrl_val_param *param);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 19c0ec4045a4..2a16100c9c3f 100644
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
@@ -205,16 +203,18 @@ int get_cache_size(int cpu_no, char *cache_type, unsigned long *cache_size)
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
2.31.0

