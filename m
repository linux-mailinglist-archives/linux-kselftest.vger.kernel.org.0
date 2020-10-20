Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C664294586
	for <lists+linux-kselftest@lfdr.de>; Wed, 21 Oct 2020 01:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410710AbgJTXvb (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 20 Oct 2020 19:51:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:63669 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2439354AbgJTXva (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 20 Oct 2020 19:51:30 -0400
IronPort-SDR: WN9RnGLLvEsWwP4KOzv5fG2xpn52z31lS42T0xMmV4mVVGha7EwN1j8SUSvhfSH3BiP2w9sIst
 LBapcSeMrqDQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9780"; a="184942258"
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="184942258"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2020 16:51:29 -0700
IronPort-SDR: 9KZ1pfm29Jm/Xi5q0ky1DQG8YJGK6vv9AXRsU1vNvOxzp5Z9/4w5bx31v3n8lvBeTFW79uDjIh
 8aq32KKnSd8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,399,1596524400"; 
   d="scan'208";a="320833816"
Received: from otcwcpicx6.sc.intel.com ([172.25.55.29])
  by orsmga006.jf.intel.com with ESMTP; 20 Oct 2020 16:51:29 -0700
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
Subject: [PATCH v3 02/21] selftests/resctrl: Fix typo
Date:   Tue, 20 Oct 2020 23:51:07 +0000
Message-Id: <20201020235126.1871815-3-fenghua.yu@intel.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201020235126.1871815-1-fenghua.yu@intel.com>
References: <20201020235126.1871815-1-fenghua.yu@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

From: Reinette Chatre <reinette.chatre@intel.com>

The format "%sok" is used to print results of a test. If the test passes,
the empty string is printed and if the test fails "not " is printed. This
results in output of "ok" when test passes and "not ok"
when test fails.

Fix one instance where "not" (without a space) is printed on test
failure resulting in output of "notok" on test failure.

Fixes: 78941183d1b1 ("selftests/resctrl: Add Cache QoS Monitoring (CQM) selftest")
Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
---
 tools/testing/selftests/resctrl/cmt_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/resctrl/cmt_test.c b/tools/testing/selftests/resctrl/cmt_test.c
index 13b01e010238..6ffb56c6a1e2 100644
--- a/tools/testing/selftests/resctrl/cmt_test.c
+++ b/tools/testing/selftests/resctrl/cmt_test.c
@@ -58,7 +58,7 @@ static void show_cache_info(unsigned long sum_llc_occu_resc, int no_of_bits,
 	else
 		res = false;
 
-	printf("%sok CMT: diff within %d, %d\%%\n", res ? "" : "not",
+	printf("%sok CMT: diff within %d, %d\%%\n", res ? "" : "not ",
 	       MAX_DIFF, (int)MAX_DIFF_PERCENT);
 
 	printf("# diff: %ld\n", avg_diff);
-- 
2.29.0

