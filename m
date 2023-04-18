Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A136E602E
	for <lists+linux-kselftest@lfdr.de>; Tue, 18 Apr 2023 13:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjDRLpu (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 18 Apr 2023 07:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbjDRLpq (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 18 Apr 2023 07:45:46 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42DEA8694;
        Tue, 18 Apr 2023 04:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681818340; x=1713354340;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Uf3vHyHTkkipMIet9UuxLalFY0HOARu70226ErvP9Bw=;
  b=m1Ln5/dhg41NVQ6N32n60hlymuISzv/aSjqNfcipzY2tve4uz6diXMay
   hFI45P2cMSYqR9/7QlDF7iguZN3M17nhatyfF8VrFqKwECf+ra3ExGTEr
   YIUeeMwR0KaY6L86bmGgQ69S3TAeBebLlJsZWIsBW/RbTrZ05A3DGkAal
   9Kza676oTZ3uhj3xtjWYDNdMze1YtYQLHrKpvruta/teBHnKduUlPlP6d
   8zahVhKyqx9b/7PASQoVKHfO5fiMz0CByvrk1kGxmyiht3lRu24wx+Euz
   Ms8qisGikrt6ZXqHt6kp3mW2wJ6jamHm4fzJ/HORhV70eRjkZt2pGqNxz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="346994304"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="346994304"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:45:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10683"; a="723601560"
X-IronPort-AV: E=Sophos;i="5.99,207,1677571200"; 
   d="scan'208";a="723601560"
Received: from yvolokit-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.213.103])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2023 04:45:37 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 04/24] selftests/resctrl: Remove mum_resctrlfs
Date:   Tue, 18 Apr 2023 14:44:46 +0300
Message-Id: <20230418114506.46788-5-ilpo.jarvinen@linux.intel.com>
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

Resctrl FS mount/umount are now cleanly paired.

Removed mum_resctrlfs that is what is left of the earlier remount
trickery to make the code cleaner. Rename remount_resctrlfs() to
mount_resctrlfs() to match the reduced functionality.

While at it, group the mount/umount prototypes in the header.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/cat_test.c    |  1 -
 tools/testing/selftests/resctrl/cmt_test.c    |  1 -
 tools/testing/selftests/resctrl/mba_test.c    |  1 -
 tools/testing/selftests/resctrl/mbm_test.c    |  1 -
 tools/testing/selftests/resctrl/resctrl.h     |  4 +---
 .../testing/selftests/resctrl/resctrl_tests.c |  8 ++++----
 tools/testing/selftests/resctrl/resctrlfs.c   | 20 +++++--------------
 7 files changed, 10 insertions(+), 26 deletions(-)

diff --git a/tools/testing/selftests/resctrl/cat_test.c b/tools/testing/selftests/resctrl/cat_test.c
index dec3151cf888..86c62dfd8e78 100644
--- a/tools/testing/selftests/resctrl/cat_test.c
+++ b/tools/testing/selftests/resctrl/cat_test.c
@@ -140,7 +140,6 @@ int cat_perf_miss_val(int cpu_no, int n, char *cache_type)
 	struct resctrl_val_param param = {
 		.resctrl_val	= CAT_STR,
 		.cpu_no		= cpu_no,
-		.mum_resctrlfs	= false,
 		.setup		= cat_setup,
 	};
 
diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 426d11189a99..d31e28416bb7 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -113,7 +113,6 @@ int cmt_resctrl_val(int cpu_no, int n, char **benchmark_cmd)
 		.ctrlgrp	= "c1",
 		.mongrp		= "m1",
 		.cpu_no		= cpu_no,
-		.mum_resctrlfs	= false,
 		.filename	= RESULT_FILE_NAME,
 		.mask		= ~(long_mask << n) & long_mask,
 		.span		= cache_size * n / count_of_bits,
diff --git a/tools/testing/selftests/resctrl/mba_test.c b/tools/testing/selftests/resctrl/mba_test.c
index cde3781a9ab0..3d53c6c9b9ce 100644
--- a/tools/testing/selftests/resctrl/mba_test.c
+++ b/tools/testing/selftests/resctrl/mba_test.c
@@ -154,7 +154,6 @@ int mba_schemata_change(int cpu_no, char *bw_report, char **benchmark_cmd)
 		.ctrlgrp	= "c1",
 		.mongrp		= "m1",
 		.cpu_no		= cpu_no,
-		.mum_resctrlfs	= true,
 		.filename	= RESULT_FILE_NAME,
 		.bw_report	= bw_report,
 		.setup		= mba_setup
diff --git a/tools/testing/selftests/resctrl/mbm_test.c b/tools/testing/selftests/resctrl/mbm_test.c
index 538d35a6485a..24326cb7bc21 100644
--- a/tools/testing/selftests/resctrl/mbm_test.c
+++ b/tools/testing/selftests/resctrl/mbm_test.c
@@ -123,7 +123,6 @@ int mbm_bw_change(int span, int cpu_no, char *bw_report, char **benchmark_cmd)
 		.mongrp		= "m1",
 		.span		= span,
 		.cpu_no		= cpu_no,
-		.mum_resctrlfs	= true,
 		.filename	= RESULT_FILE_NAME,
 		.bw_report	=  bw_report,
 		.setup		= mbm_setup
diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index 87e39456dee0..c737eb47eacc 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -53,7 +53,6 @@
  * @mongrp:		Name of the monitor group (mon grp)
  * @cpu_no:		CPU number to which the benchmark would be binded
  * @span:		Memory bytes accessed in each benchmark iteration
- * @mum_resctrlfs:	Should the resctrl FS be remounted?
  * @filename:		Name of file to which the o/p should be written
  * @bw_report:		Bandwidth report type (reads vs writes)
  * @setup:		Call back function to setup test environment
@@ -64,7 +63,6 @@ struct resctrl_val_param {
 	char		mongrp[64];
 	int		cpu_no;
 	unsigned long	span;
-	bool		mum_resctrlfs;
 	char		filename[64];
 	char		*bw_report;
 	unsigned long	mask;
@@ -84,8 +82,8 @@ extern char llc_occup_path[1024];
 int get_vendor(void);
 bool check_resctrlfs_support(void);
 int filter_dmesg(void);
-int remount_resctrlfs(bool mum_resctrlfs);
 int get_resource_id(int cpu_no, int *resource_id);
+int mount_resctrlfs(void);
 int umount_resctrlfs(void);
 int validate_bw_report_request(char *bw_report);
 bool validate_resctrl_feature_request(const char *resctrl_val);
diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 5c9ed52b69f2..f3303459136d 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -77,7 +77,7 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, int span,
 
 	ksft_print_msg("Starting MBM BW change ...\n");
 
-	res = remount_resctrlfs(false);
+	res = mount_resctrlfs();
 	if (res) {
 		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
 		return;
@@ -106,7 +106,7 @@ static void run_mba_test(bool has_ben, char **benchmark_cmd, int span,
 
 	ksft_print_msg("Starting MBA Schemata change ...\n");
 
-	res = remount_resctrlfs(false);
+	res = mount_resctrlfs();
 	if (res) {
 		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
 		return;
@@ -132,7 +132,7 @@ static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
 
 	ksft_print_msg("Starting CMT test ...\n");
 
-	res = remount_resctrlfs(false);
+	res = mount_resctrlfs();
 	if (res) {
 		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
 		return;
@@ -160,7 +160,7 @@ static void run_cat_test(int cpu_no, int no_of_bits)
 
 	ksft_print_msg("Starting CAT test ...\n");
 
-	res = remount_resctrlfs(false);
+	res = mount_resctrlfs();
 	if (res) {
 		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
 		return;
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 42f547a81e25..45f785213143 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -48,29 +48,19 @@ static int find_resctrl_mount(char *buffer)
 }
 
 /*
- * remount_resctrlfs - Remount resctrl FS at /sys/fs/resctrl
- * @mum_resctrlfs:	Should the resctrl FS be remounted?
+ * mount_resctrlfs - Mount resctrl FS at /sys/fs/resctrl
  *
  * If not mounted, mount it.
- * If mounted and mum_resctrlfs then remount resctrl FS.
- * If mounted and !mum_resctrlfs then noop
  *
  * Return: 0 on success, non-zero on failure
  */
-int remount_resctrlfs(bool mum_resctrlfs)
+int mount_resctrlfs(void)
 {
-	char mountpoint[256];
 	int ret;
 
-	ret = find_resctrl_mount(mountpoint);
-	if (ret)
-		strcpy(mountpoint, RESCTRL_PATH);
-
-	if (!ret && mum_resctrlfs && umount(mountpoint))
-		ksft_print_msg("Fail: unmounting \"%s\"\n", mountpoint);
-
-	if (!ret && !mum_resctrlfs)
-		return 0;
+	ret = find_resctrl_mount(NULL);
+	if (!ret)
+		return -1;
 
 	ksft_print_msg("Mounting resctrl to \"%s\"\n", RESCTRL_PATH);
 	ret = mount("resctrl", RESCTRL_PATH, "resctrl", 0, NULL);
-- 
2.30.2

