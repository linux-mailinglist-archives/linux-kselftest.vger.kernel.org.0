Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868F929459A
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 01:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439404AbgJTXvj (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Oct 2020 19:51:39 -0400
Received: from mga07.intel.com ([134.134.136.100]:11172 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439393AbgJTXvj (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Oct 2020 19:51:39 -0400
IronPort-SDR: PoXjpDQkWip98lnLnT88RjKUJspluMJ0i5Kb5r6sjkk4P8Y8XW+0xj86St190hjP2ax48uaK+N
 fgTFpqh8pTtw==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="231486368"
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="231486368"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 16:51:33 -0700
IronPort-SDR: yIzvBCaW+hcymhJzp6YspDY9aYHm0U4M9bjCk/WSY7TJpWf5ycw8slybrX6IQjKDKEJjCH7GfJ
 LizHxsYXmMug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="320833886"
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
Subject: [PATCH v3 17/21] selftests/resctrl: Unmount resctrl FS after running all tests
Date:   Tue, 20 Oct 2020 23:51:22 +0000
Message-Id: <20201020235126.1871815-18-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201020235126.1871815-1-fenghua.yu@intel.com>
References: <20201020235126.1871815-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Resctrl test suite is expected to unmount the resctrl file system upon
exit. But there are few scenarios where resctrl test suite might forget to
unmount resctrl FS upon exit. For example, running only mba test on a
Broadwell (BDW) machine (MBA isn't supported on BDW CPU).

This happens because validate_resctrl_feature_request() would mount resctrl
FS to check if mba is enabled on the platform or not and finds that the H/W
doesn't support mba and hence will return false to run_mba_test(). This in
turn makes the main() function return without unmounting resctrl FS.

Fix this by calling umount_resctrlfs() before returning from main()
function, so that the resctrl FS will always be unmounted upon exit.

Fixes: ecdbb911f22d ("selftests/resctrl: Add MBM test")
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index a22dc96c0b43..fb66da65b373 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -257,6 +257,7 @@ int main(int argc, char **argv)
 		run_cat_test(cpu_no, no_of_bits);
 
 out:
+	umount_resctrlfs();
 	printf("1..%d\n", tests_run);
 
 	return 0;
-- 
2.29.0

