Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C666A330250
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Mar 2021 15:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhCGOze (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Mar 2021 09:55:34 -0500
Received: from mga17.intel.com ([192.55.52.151]:5871 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231610AbhCGOzK (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Mar 2021 09:55:10 -0500
IronPort-SDR: WkzpVkxxRbu8DjYlR4ysSX827L4VLx3ddYcizdqZZ78NSTL75QWVi6P7qUrCJElcFiOvYXkLVd
 Wx08VsGbba1g==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="167813499"
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="167813499"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 06:55:10 -0800
IronPort-SDR: Vx6qSN8AQgi/GsEryWleK4q6RwfNZK4RMGvHpOXrYWEpB/sMp7PajFv25vLwsEbjM8H5k0KeZ6
 khv1Xd6CRhfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="437189122"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Mar 2021 06:55:10 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Babu Moger" <babu.moger@amd.com>
Cc:     "linux-kselftest" <linux-kselftest@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v5 12/21] selftests/resctrl: Check for resctrl mount point only if resctrl FS is supported
Date:   Sun,  7 Mar 2021 14:54:53 +0000
Message-Id: <20210307145502.2916364-13-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210307145502.2916364-1-fenghua.yu@intel.com>
References: <20210307145502.2916364-1-fenghua.yu@intel.com>
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

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/resctrlfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index e3d18e113313..10b9292f33e5 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -570,6 +570,9 @@ bool check_resctrlfs_support(void)
 	ksft_print_msg("%s kernel supports resctrl filesystem\n",
 		       ret ? "pass:" : "fail:");
 
+	if (!ret)
+		return ret;
+
 	dp = opendir(RESCTRL_PATH);
 	ksft_print_msg("%s resctrl mountpoint \"%s\" exists\n",
 		       dp ? "pass:" : "fail:", RESCTRL_PATH);
-- 
2.30.1

