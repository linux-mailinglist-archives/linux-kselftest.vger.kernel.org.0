Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764442945AD
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 01:52:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439548AbgJTXwf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Oct 2020 19:52:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:54960 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410704AbgJTXvb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Oct 2020 19:51:31 -0400
IronPort-SDR: WR3OaAjctSIo3+lZYN4FAnxOCm5a4/aDqkcRWhE5UxMfXqVgKp/GV9kRzjA3gSCdweimjzhChv
 OrReHFeT3pmw==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="164686724"
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="164686724"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 16:51:30 -0700
IronPort-SDR: oCDWqnbn4hZu67teHVFiI2gNbZpAMO586O16h+arE9CwuDqkuexHlPtoLBcEqr+dO2TDdxYOlY
 MpzQrLjCMdZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="320833829"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by orsmga006.jf.intel.com with ESMTP; 20 Oct 2020 16:51:30 -0700
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
Subject: [PATCH v3 06/21] selftests/resctrl: Check for resctrl mount point only if resctrl FS is supported
Date:   Tue, 20 Oct 2020 23:51:11 +0000
Message-Id: <20201020235126.1871815-7-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201020235126.1871815-1-fenghua.yu@intel.com>
References: <20201020235126.1871815-1-fenghua.yu@intel.com>
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

Fixes: ecdbb911f22d ("selftests/resctrl: Add MBM test")
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/resctrlfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 727e667e2cc9..e43ddebd1aa4 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -581,6 +581,9 @@ bool check_resctrlfs_support(void)
 	printf("%sok kernel supports resctrl filesystem\n", ret ? "" : "not ");
 	tests_run++;
 
+	if (!ret)
+		return ret;
+
 	dp = opendir(RESCTRL_PATH);
 	printf("%sok resctrl mountpoint \"%s\" exists\n",
 	       dp ? "" : "not ", RESCTRL_PATH);
-- 
2.29.0

