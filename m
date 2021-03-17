Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A342833E6D1
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Mar 2021 03:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230398AbhCQCZA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Mar 2021 22:25:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:55652 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230448AbhCQCYf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Mar 2021 22:24:35 -0400
IronPort-SDR: XYcoO2DzSnoo3nO9+P+/xZvAvObSzzItg4EfeIu1KB3C6hvp4hgNfgnGSHl+7vSMKotjsV8cuV
 sWvWEfADqaDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="209328715"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="209328715"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 19:24:34 -0700
IronPort-SDR: cdoR3FI1ypjhpfp/U36WJOxW9HvmGPuGL47op6oyxh7F9wbK8W9bWjNRLDIPCOe7GE3UDrrYiq
 J6RGx1h5CAyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="440290273"
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
Subject: [PATCH v6 12/21] selftests/resctrl: Check for resctrl mount point only if resctrl FS is supported
Date:   Wed, 17 Mar 2021 02:22:46 +0000
Message-Id: <20210317022255.2536745-13-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210317022255.2536745-1-fenghua.yu@intel.com>
References: <20210317022255.2536745-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

check_resctrlfs_support() does the following
1. Checks if the platform supports resctrl file system or not by looking
   for resctrl in /proc/filesystems
2. Calls opendir() on default resctrl file system path
   (i.e. /sys/fs/resctrl)
3. Checks if resctrl file system is mounted or not by looking at
   /proc/mounts

Steps 2 and 3 will fail if the platform does not support resctrl file
system. So, there is no need to check for them if step 1 fails.

Fix this by returning immediately if the platform does not support
resctrl file system.

Tested-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/resctrlfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 6b22a186790a..87195eb78356 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -570,6 +570,9 @@ bool check_resctrlfs_support(void)
 	ksft_print_msg("%s kernel supports resctrl filesystem\n",
 		       ret ? "Pass:" : "Fail:");
 
+	if (!ret)
+		return ret;
+
 	dp = opendir(RESCTRL_PATH);
 	ksft_print_msg("%s resctrl mountpoint \"%s\" exists\n",
 		       dp ? "Pass:" : "Fail:", RESCTRL_PATH);
-- 
2.31.0

