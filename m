Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 011DE75641E
	for <lists+linux-kselftest@lfdr.de>; Mon, 17 Jul 2023 15:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjGQNQG (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 17 Jul 2023 09:16:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjGQNPu (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 17 Jul 2023 09:15:50 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4F21985;
        Mon, 17 Jul 2023 06:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689599737; x=1721135737;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gxILP+jHMTJazW2ff4rfv0rjrW3z2H5FuwKbGzXQHQg=;
  b=XEfhWMWWsFteQpffFEDpLJu6QfSvcVj7wJA06wZh2lO2c25E2cgblJJg
   R8MgizwCR4k6LkkN+Aug5noof5yyJQi9+rsC9hL9gO697wqf7H9VRZazQ
   PsXaZ0uuQ64B4jbWzrhjZxEoOlRsXcCwwe93n9N64w0TeJG1VXGPKClL8
   4Q6T4zSvKjZBUxuRVvcdeco12rHIcO9Bd8107YP0KE+Nd+hViRY29GGM0
   KHkfjadHcM0urjv86VGfsByT6IpNQ3b0vcMYn+Mfp8gXt0jjo2EuF2bow
   BdHDTdG4VnCQIyNci6nyygV1jCkL7YllI3J4mbLOkem2eVA+pVglSkuUy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="368568868"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="368568868"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:15:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="793246758"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="793246758"
Received: from dkravtso-mobl1.ccr.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.45.233])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 06:15:34 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-kselftest@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>,
        Shaopeng Tan <tan.shaopeng@jp.fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 05/19] selftests/resctrl: Unmount resctrl FS before starting the first test
Date:   Mon, 17 Jul 2023 16:14:53 +0300
Message-Id: <20230717131507.32420-6-ilpo.jarvinen@linux.intel.com>
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
 tools/testing/selftests/resctrl/resctrl_tests.c |  3 +++
 tools/testing/selftests/resctrl/resctrlfs.c     | 10 ++++++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index 9b9751206e1c..61c3882a26c8 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -250,6 +250,9 @@ int main(int argc, char **argv)
 	if (!check_resctrlfs_support())
 		return ksft_exit_skip("resctrl FS does not exist. Enable X86_CPU_RESCTRL config option.\n");
 
+	if (umount_resctrlfs())
+		return ksft_exit_skip("resctrl FS unmount failed.\n");
+
 	filter_dmesg();
 
 	ksft_set_plan(tests ? : 4);
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index fb00245dee92..cf0c8dd34b8b 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -82,10 +82,16 @@ int remount_resctrlfs(bool mum_resctrlfs)
 
 int umount_resctrlfs(void)
 {
-	if (find_resctrl_mount(NULL))
+	char mountpoint[256];
+	int ret;
+
+	ret = find_resctrl_mount(mountpoint);
+	if (ret == -ENOENT)
 		return 0;
+	if (ret)
+		return ret;
 
-	if (umount(RESCTRL_PATH)) {
+	if (umount(mountpoint)) {
 		perror("# Unable to umount resctrl");
 
 		return errno;
-- 
2.30.2

