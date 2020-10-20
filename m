Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240E62945A2
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 01:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439522AbgJTXwW (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Oct 2020 19:52:22 -0400
Received: from mga07.intel.com ([134.134.136.100]:11170 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439374AbgJTXvh (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Oct 2020 19:51:37 -0400
IronPort-SDR: ZedangiFgTvh7U0OZ9ERVtxJaxr5ZreRlXB2rGnCOIucbWlHBr2F27kRrpScznAafPClK11rks
 PHVIkwEq0UjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="231486362"
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="231486362"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 16:51:31 -0700
IronPort-SDR: ZPrIV9mhEJ9wZLCvMAj1er4fpztWbXAvyqA5mOzBohKDpVoLnD9T3zCPgugdRPPN+Ny3x3rg5w
 6lU6BeuvZYgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="320833846"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by orsmga006.jf.intel.com with ESMTP; 20 Oct 2020 16:51:31 -0700
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
Subject: [PATCH v3 11/21] selftests/resctrl: Abort running tests if not root user
Date:   Tue, 20 Oct 2020 23:51:16 +0000
Message-Id: <20201020235126.1871815-12-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201020235126.1871815-1-fenghua.yu@intel.com>
References: <20201020235126.1871815-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Running any resctrl unit test involves writing to resctrl file system and
only a root user has permission to write to resctrl FS. Resctrl test suite
before running any test checks for the privilege of the user and if it's
not a root user, the test suite prints a warning and continues attempting
to run tests.

Attempting to run any test without root privileges will fail as below

TAP version 13
ok kernel supports resctrl filesystem
.................
not ok mounting resctrl to "/sys/fs/resctrl"
not ok MBA: schemata change

Hence, don't attempt to run any test if the user is not a root user and
change the warning message to a bail out message to comply with TAP 13
standards.

Fixes: ecdbb911f22d ("selftests/resctrl: Add MBM test")
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index cab69ed8c67d..f4867a81eee6 100644
--- a/tools/testing/selftests/resctrl/resctrl_tests.c
+++ b/tools/testing/selftests/resctrl/resctrl_tests.c
@@ -125,8 +125,10 @@ int main(int argc, char **argv)
 	 * 1. We write to resctrl FS
 	 * 2. We execute perf commands
 	 */
-	if (geteuid() != 0)
-		printf("# WARNING: not running as root, tests may fail.\n");
+	if (geteuid() != 0) {
+		printf("Bail out! not running as root, abort testing\n");
+		goto out;
+	}
 
 	/* Detect AMD vendor */
 	detect_amd();
-- 
2.29.0

