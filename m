Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C14EC33E6DF
	for <lists+linux-kselftest@lfdr.de>; Wed, 17 Mar 2021 03:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhCQCZF (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 16 Mar 2021 22:25:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:55653 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230464AbhCQCYg (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 16 Mar 2021 22:24:36 -0400
IronPort-SDR: j7BJskKbx5syTaRopnO6XqJx4vgcxNujdmi2y+T+BFcRRsju/uA0ejCQmnjaOcJNvQCGKIOb92
 NUpcBXSoSPHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9925"; a="209328721"
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="209328721"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2021 19:24:34 -0700
IronPort-SDR: JwA1GPzqCVw5brevRPuPjw0ErIFdvolvI9MiXHVsp4dHJyG+V26yGowz89gvNcZyXCzfmVUt6K
 6J8ntjgNLvLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,254,1610438400"; 
   d="scan'208";a="440290292"
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
Subject: [PATCH v6 18/21] selftests/resctrl: Fix unmount resctrl FS
Date:   Wed, 17 Mar 2021 02:22:52 +0000
Message-Id: <20210317022255.2536745-19-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210317022255.2536745-1-fenghua.yu@intel.com>
References: <20210317022255.2536745-1-fenghua.yu@intel.com>
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

Tested-by: Babu Moger <babu.moger@amd.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 2 ++
 tools/testing/selftests/resctrl/resctrlfs.c     | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index fb246bc41f47..f51b5fc066a3 100644
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
index 26563175acf6..ade5f2b8b843 100644
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
2.31.0

