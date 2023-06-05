Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45EF722E2B
	for <lists+linux-kselftest@lfdr.de>; Mon,  5 Jun 2023 20:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235125AbjFESCk (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 5 Jun 2023 14:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234995AbjFESCc (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 5 Jun 2023 14:02:32 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF104100;
        Mon,  5 Jun 2023 11:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685988145; x=1717524145;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8OshzN+NZ7thIMcFVOb/IWor20ob/nSgjx3NSLzz3Fc=;
  b=COTaOf5cGOWogRzhFr9ar3dzo0Ettl4SRJlfPKg30rCzCO+LAGUHdqYx
   8ZUSIjXhJoDi9OXHJ8EWMNFVBTgxPgJdC9KsFErdKodH4sUmSeBEBvLhg
   WNgHVCUQQacorHrPG7apTTETJtusuas94FuX2d2I1dU3NO+4CStmnoM2A
   nmxHk0tIBsv957jFk0yApMiaiJH/Pfr1MvJo/43SS0wOX2Ub2gyWGG61F
   X1YwhESE5rbshNfBR1myFS7fNzM7SBDTU5syFxcscPAFWCra5sr8Rl7qQ
   S5aY704d0ILAPWdJGbpvUo4PpTWdeap+9mq/+uiKeMYKlxCm8sefIY54M
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="442814931"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="442814931"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 11:02:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="821274046"
X-IronPort-AV: E=Sophos;i="6.00,218,1681196400"; 
   d="scan'208";a="821274046"
Received: from gfittedx-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.47.115])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2023 11:02:12 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 05/19] selftests/resctrl: Unmount resctrl FS before starting the first test
Date:   Mon,  5 Jun 2023 21:01:31 +0300
Message-Id: <20230605180145.112924-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230605180145.112924-1-ilpo.jarvinen@linux.intel.com>
References: <20230605180145.112924-1-ilpo.jarvinen@linux.intel.com>
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
index 9b9751206e1c..6fcf8fc3cfc0 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -223,6 +223,8 @@ int main(int argc, char **argv)
 	if (geteuid() != 0)
 		return ksft_exit_skip("Not running as root. Skipping...\n");
 
+	umount_resctrlfs();
+
 	if (has_ben) {
 		/* Extract benchmark command from command line. */
 		for (i = ben_ind; i < argc; i++) {
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

