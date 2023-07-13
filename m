Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6737A752368
	for <lists+linux-kselftest@lfdr.de>; Thu, 13 Jul 2023 15:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbjGMNVJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 13 Jul 2023 09:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234495AbjGMNUo (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 13 Jul 2023 09:20:44 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CA72721;
        Thu, 13 Jul 2023 06:20:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689254434; x=1720790434;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hn0fYehjq6FV6t/LfA0e2GwEyK8XmldiekSokujXnRI=;
  b=TkKRkp6OFw7a7CyfCqDPaxrYgI6Z8DKzZLRzZa2oHJhSJLnkO5oUMCAE
   wN0u6UPB27Dky6CgkIcv01CiDU8GmjzQmrwd5ndnafgAlVDklbSIDfCDE
   /eTUiUn9CG34ncpTH7eky8luDvsZTK2XQNH+jWNc2jfOQTmZCuiazOXro
   bVSJvUCdpktJVtGVw8e+pYMZR1Ly2kHi/UxmJ3JX+RppqaypPnlyDcqSS
   NUa4v3iDFAGaWq7C1hQV5m8KM8UNTg94THaOHzpCk1SK3LCC17OISt0Ja
   /2nzopszEQh9l869vaQAIQpl0YUi9kouUxGnMqxEyAaXTflZ+Gkw/ccn7
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="345496617"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="345496617"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 06:20:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="968615793"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="968615793"
Received: from ijarvine-mobl2.ger.corp.intel.com ([10.251.222.39])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 06:20:32 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 05/19] selftests/resctrl: Unmount resctrl FS before starting the first test
Date:   Thu, 13 Jul 2023 16:19:18 +0300
Message-Id: <20230713131932.133258-6-ilpo.jarvinen@linux.intel.com>
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

Resctrl FS mount/remount/umount code is hard to track. Better approach
is to use mount/umount pair for each test but that assumes resctrl FS
is not mounted beforehand.

Change umount_resctrlfs() so that it can unmount resctrl FS from any
path, and enable further simplifications into mount/remount/umount
logic by unmounting resctrl FS at the start if a pre-existing
mountpoint is found.

Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 2 ++
 tools/testing/selftests/resctrl/resctrlfs.c     | 6 ++++--
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 9b9751206e1c..b1b2d28b52f7 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -250,6 +250,8 @@ int main(int argc, char **argv)
 	if (!check_resctrlfs_support())
 		return ksft_exit_skip("resctrl FS does not exist. Enable X86_CPU_RESCTRL config option.\n");
 
+	umount_resctrlfs();
+
 	filter_dmesg();
 
 	ksft_set_plan(tests ? : 4);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index fb00245dee92..23f75aeaa198 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -82,10 +82,12 @@ int remount_resctrlfs(bool mum_resctrlfs)
 
 int umount_resctrlfs(void)
 {
-	if (find_resctrl_mount(NULL))
+	char mountpoint[256];
+
+	if (find_resctrl_mount(mountpoint))
 		return 0;
 
-	if (umount(RESCTRL_PATH)) {
+	if (umount(mountpoint)) {
 		perror("# Unable to umount resctrl");
 
 		return errno;
-- 
2.30.2

