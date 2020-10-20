Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4DE294587
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 01:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410717AbgJTXvb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Oct 2020 19:51:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:63667 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2410707AbgJTXvb (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Oct 2020 19:51:31 -0400
IronPort-SDR: GyL8bzwSKiLp5PXA8hgsQLafPmZ9QQnHE5J8wsZx/6H8asqJOde1P2BQdIb9aa5Z0+oe9D+5AY
 8UIaFODcvEcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="184942260"
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="184942260"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 16:51:30 -0700
IronPort-SDR: 6HJuakSKekhfC//zPXe1PWYwjNaWg1dXHcBlZ4RHyb5eWqMurFcDVihpJUwcn7nJqAz4ioH/KQ
 GN/YUG8Ra+yQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="320833826"
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
Subject: [PATCH v3 05/21] selftests/resctrl: Return if resctrl file system is not supported
Date:   Tue, 20 Oct 2020 23:51:10 +0000
Message-Id: <20201020235126.1871815-6-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201020235126.1871815-1-fenghua.yu@intel.com>
References: <20201020235126.1871815-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

check_resctrlfs_support() checks if the platform supports resctrl file
system or not by looking for resctrl in /proc/filesystems and returns a
boolean value. The main function of resctrl test suite calls
check_resctrlfs_support() but forgets to check for it's return value. This
means that resctrl test suite will attempt to run resctrl tests (like CMT,
CAT, MBM and MBA) even if the platform doesn't support resctrl file system.

Fix this by checking for the return value of check_resctrlfs_support() in
the main function. If resctrl file system isn't supported on the platform
then exit the test suite gracefully without attempting to run any of
resctrl unit tests.

Fixes: ecdbb911f22d ("selftests/resctrl: Add MBM test")
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index b2a560c0c5dc..d24de546d4ef 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -155,7 +155,11 @@ int main(int argc, char **argv)
 	sprintf(bw_report, "reads");
 	sprintf(bm_type, "fill_buf");
 
-	check_resctrlfs_support();
+	if (!check_resctrlfs_support()) {
+		printf("Bail out! resctrl FS does not exist\n");
+		goto out;
+	}
+
 	filter_dmesg();
 
 	if (!is_amd && mbm_test) {
@@ -196,6 +200,7 @@ int main(int argc, char **argv)
 		cat_test_cleanup();
 	}
 
+out:
 	printf("1..%d\n", tests_run);
 
 	return 0;
-- 
2.29.0

