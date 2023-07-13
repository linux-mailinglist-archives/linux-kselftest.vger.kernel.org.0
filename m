Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 007C4752370
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 15:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235168AbjGMNV0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 09:21:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234513AbjGMNUy (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 09:20:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B712D48;
        Thu, 13 Jul 2023 06:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689254447; x=1720790447;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=e4ibwDjlAb+ZjhQ1AfFhannM0naGZnGDFIvVBzF6V0E=;
  b=KD9pu+h2bBpgF0TToczU3XXHfFRGVQKK0J0iB+rTAqX+mR2KqxcPJoxL
   /ycCGEeD/ubM4slf4jQ2v7OtdspoCoavc19CZ/YAHo6m2iLTnEnv7Z3hh
   /Yk7nBo6Env7irD1SDC81iNrPpEaczn8kHYW9QGso37igcmiQE6vkbVRn
   /rjoRNUT8tiI+C0kiJU5RDqVryzvQGc1ouOGFzPtsditXRcycXHMWV7+H
   zfDK0ZnZTe2sFaQ4T3MZTOM4wIstEoUE8EZI1Wf0qRjKTZd3EmgDb4sVk
   OVSO1kmc/DpCMw+GOEg+55XsmO89H+ohChyGG5SrTuytaHXzE87mhhdee
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="345496707"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="345496707"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 06:20:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="968615827"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="968615827"
Received: from ijarvine-mobl2.ger.corp.intel.com ([10.251.222.39])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 06:20:38 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 07/19] selftests/resctrl: Refactor remount_resctrl(bool mum_resctrlfs) to mount_resctrl()
Date:   Thu, 13 Jul 2023 16:19:20 +0300
Message-Id: <20230713131932.133258-8-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
References: <20230713131932.133258-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 .../testing/selftests/resctrl/resctrl_tests.c |  8 ++++----
 tools/testing/selftests/resctrl/resctrlfs.c   | 20 +++++--------------
 3 files changed, 10 insertions(+), 20 deletions(-)

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
index a421d045de08..3f26d2279f75 100644
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
index b3a05488d360..f622245adafe 100644
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

