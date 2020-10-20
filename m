Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0212945A0
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 01:52:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439506AbgJTXwQ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Oct 2020 19:52:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:11170 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439371AbgJTXvj (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Oct 2020 19:51:39 -0400
IronPort-SDR: OBxOXe1fspo77PIRjBqvNHj6RNVw55PvRbeeE46WlAHhKzPtV7m6rM8HlKnsYDlH3X1U4/XgIp
 nhvS7pBHC74w==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="231486367"
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="231486367"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 16:51:32 -0700
IronPort-SDR: Gj0V3H8OMq4j1jt7W0ZQKk8t7HQLhwbDMfoGr0C+fKzJKZDyJPyF4z5lMGPoDQnb/Xw2a8Y+ZF
 vzdXK2kNSSoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="320833880"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by orsmga006.jf.intel.com with ESMTP; 20 Oct 2020 16:51:32 -0700
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
Subject: [PATCH v3 16/21] selftests/resctrl: Umount resctrl FS only if mounted
Date:   Tue, 20 Oct 2020 23:51:21 +0000
Message-Id: <20201020235126.1871815-17-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201020235126.1871815-1-fenghua.yu@intel.com>
References: <20201020235126.1871815-1-fenghua.yu@intel.com>
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

Fixes: 591a6e8588fc ("selftests/resctrl: Add basic resctrl file system operations and data")
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/resctrlfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/resctrl/resctrlfs.c b/tools/testing/selftests/resctrl/resctrlfs.c
index 05956319d9ce..21281fd895b7 100644
--- a/tools/testing/selftests/resctrl/resctrlfs.c
+++ b/tools/testing/selftests/resctrl/resctrlfs.c
@@ -92,6 +92,9 @@ int remount_resctrlfs(bool mum_resctrlfs)
 
 int umount_resctrlfs(void)
 {
+	if (find_resctrl_mount(NULL))
+		return 0;
+
 	if (umount(RESCTRL_PATH)) {
 		perror("# Unable to umount resctrl");
 
-- 
2.29.0

