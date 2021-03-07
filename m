Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C1E330249
	for <lists+linux-kselftest@lfdr.de>; Sun,  7 Mar 2021 15:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbhCGOzc (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 7 Mar 2021 09:55:32 -0500
Received: from mga17.intel.com ([192.55.52.151]:5871 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231629AbhCGOzL (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 7 Mar 2021 09:55:11 -0500
IronPort-SDR: oL24jkDint6auxykFFKKWM8YwiO2wWczLzIcSd/ueOePb0JaiD0ptF6frv4LWNfXiAeN/Hkkzx
 A7uMAr4g0ySQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9916"; a="167813505"
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="167813505"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2021 06:55:10 -0800
IronPort-SDR: fwW5S3cUTDdX33uTNCgGOLMQk2a7a6MjgKUgXiq0nbLnTzF4LeYkQe9/KPwI+v512bhCFtmAsO
 KvP2uGx+bdvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,230,1610438400"; 
   d="scan'208";a="437189141"
Received: from otcwcpicx3.sc.intel.com ([172.25.55.73])
  by FMSMGA003.fm.intel.com with ESMTP; 07 Mar 2021 06:55:10 -0800
From:   Fenghua Yu <fenghua.yu@intel.com>
To:     "Shuah Khan" <shuah@kernel.org>, "Tony Luck" <tony.luck@intel.com>,
        "Reinette Chatre" <reinette.chatre@intel.com>,
        "Babu Moger" <babu.moger@amd.com>
Cc:     "linux-kselftest" <linux-kselftest@vger.kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>
Subject: [PATCH v5 18/21] selftests/resctrl: Fix unmount resctrl FS
Date:   Sun,  7 Mar 2021 14:54:59 +0000
Message-Id: <20210307145502.2916364-19-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210307145502.2916364-1-fenghua.yu@intel.com>
References: <20210307145502.2916364-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

umount_resctrlfs() directly attempts to unmount resctrl file system without
checking if resctrl FS is already mounted or not. It returns 0 on success
and on failure it prints an error message and returns an error status.
Calling umount_resctrlfs() when resctrl FS isn't mounted will return an
error status.

There could be situations where-in the caller might not know if resctrl
FS is already mounted or not and the caller might still want to unmount
resctrl FS if it's already mounted (For example during teardown).

To support above use cases, change umount_resctrlfs() such that it now
first checks if resctrl FS is already mounted or not and unmounts resctrl
FS only if it's already mounted.

unmount resctrl FS upon exit. For example, running only mba test on a
Broadwell (BDW) machine (MBA isn't supported on BDW CPU).

This happens because validate_resctrl_feature_request() would mount resctrl
FS to check if mba is enabled on the platform or not and finds that the H/W
doesn't support mba and hence will return false to run_mba_test(). This in
turn makes the main() function return without unmounting resctrl FS.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 2 ++
 tools/testing/selftests/resctrl/resctrlfs.c     | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index fa4c5f5075dd..6204ede25ad1 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -253,5 +253,7 @@ int main(int argc, char **argv)
 	if (cat_test)
 		run_cat_test(cpu_no, no_of_bits);
 
+	umount_resctrlfs();
+
 	return ksft_exit_pass();
 }
diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 0c23514760dd..cb52d0ad4be2 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -82,6 +82,9 @@ int remount_resctrlfs(bool mum_resctrlfs)
 
 int umount_resctrlfs(void)
 {
+	if (find_resctrl_mount(NULL))
+		return 0;
+
 	if (umount(RESCTRL_PATH)) {
 		perror("# Unable to umount resctrl");
 
-- 
2.30.1

