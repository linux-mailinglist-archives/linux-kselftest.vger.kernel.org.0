Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AC4756423
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 15:16:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231441AbjGQNQZ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 09:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbjGQNP5 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 09:15:57 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E47AB1BDA;
        Mon, 17 Jul 2023 06:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689599745; x=1721135745;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/1/VJsytpG9ab8tNQhkRW6NqEkFFS16dN1lelPWiwFU=;
  b=CJjf36mL4LGZBHkCaBvLOVAEjhPOzv2h4xnLwBMn//Yezcd7hOq/P5/z
   JkdTwaHyY6QngVzRO0BwrmsWRiBXe/InwAt32xW9HVstfaPQZJMNzJ7FV
   7dH7N4wNBSOKPqoEHnZGvFGV+0kkMaAWyiSUegV7hKlOCx3dg0Qs5yqR2
   grQrN7gdfvRg8gvMXbEtExnHHDVc94146/U644fchBPt4XWwg2+FIqTiq
   x+DbVM3f0YcA5qytyCfwevU3HqawJA2HbeCRtYGttRN7jGDgWCzeHT9ec
   O5AvnyuLtNfmBSiBibUp2XtxXKn4WwUMQVnUyrhfKoLwfWSvTjtkZ5Hg6
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="368568907"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="368568907"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:15:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="793246780"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="793246780"
Received: from dkravtso-mobl1.ccr.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.45.233])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:15:41 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 07/19] selftests/resctrl: Refactor remount_resctrl(bool mum_resctrlfs) to mount_resctrl()
Date:   Mon, 17 Jul 2023 16:14:55 +0300
Message-Id: <20230717131507.32420-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230717131507.32420-1-ilpo.jarvinen@linux.intel.com>
References: <20230717131507.32420-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Mount/umount of the resctrl FS is now paired nicely per test.

Rename remount_resctrl(bool mum_resctrlfs) to mount_resctrl(). Make
it unconditionally try to mount the resctrl FS and return error if
resctrl FS was mounted already.

While at it, group the mount/umount prototypes in the header.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/resctrl.h     |  2 +-
 .../testing/selftests/resctrl/resctrl_tests.c |  8 +++----
 tools/testing/selftests/resctrl/resctrlfs.c   | 23 ++++++-------------
 3 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl.h b/tools/testing/selftests/resctrl/resctrl.h
index f455f0b7e314..23af3fb73cb4 100644
--- a/tools/testing/selftests/resctrl/resctrl.h
+++ b/tools/testing/selftests/resctrl/resctrl.h
@@ -85,8 +85,8 @@ extern char llc_occup_path[1024];
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
index 6bf4ead74496..0363c4b607d2 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -77,7 +77,7 @@ static void run_mbm_test(bool has_ben, char **benchmark_cmd, int span,
 
 	ksft_print_msg("Starting MBM BW change ...\n");
 
-	res = remount_resctrlfs(true);
+	res = mount_resctrlfs();
 	if (res) {
 		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
 		return;
@@ -106,7 +106,7 @@ static void run_mba_test(bool has_ben, char **benchmark_cmd, int span,
 
 	ksft_print_msg("Starting MBA Schemata change ...\n");
 
-	res = remount_resctrlfs(true);
+	res = mount_resctrlfs();
 	if (res) {
 		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
 		return;
@@ -132,7 +132,7 @@ static void run_cmt_test(bool has_ben, char **benchmark_cmd, int cpu_no)
 
 	ksft_print_msg("Starting CMT test ...\n");
 
-	res = remount_resctrlfs(true);
+	res = mount_resctrlfs();
 	if (res) {
 		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
 		return;
@@ -160,7 +160,7 @@ static void run_cat_test(int cpu_no, int no_of_bits)
 
 	ksft_print_msg("Starting CAT test ...\n");
 
-	res = remount_resctrlfs(true);
+	res = mount_resctrlfs();
 	if (res) {
 		ksft_exit_fail_msg("Failed to mount resctrl FS\n");
 		return;
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index edc3f92b11b1..c45666942439 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -48,29 +48,20 @@ static int find_resctrl_mount(char *buffer)
 }
 
 /*
- * remount_resctrlfs - Remount resctrl FS at /sys/fs/resctrl
- * @mum_resctrlfs:	Should the resctrl FS be remounted?
+ * mount_resctrlfs - Mount resctrl FS at /sys/fs/resctrl
  *
- * If not mounted, mount it.
- * If mounted and mum_resctrlfs then remount resctrl FS.
- * If mounted and !mum_resctrlfs then noop
+ * Mounts resctrl FS. Fails if resctrl FS is already mounted to avoid
+ * pre-existing settings interfering with the test results.
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
+	if (ret != -ENOENT)
+		return -1;
 
 	ksft_print_msg("Mounting resctrl to \"%s\"\n", RESCTRL_PATH);
 	ret = mount("resctrl", RESCTRL_PATH, "resctrl", 0, NULL);
-- 
2.30.2

