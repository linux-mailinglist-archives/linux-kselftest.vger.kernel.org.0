Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB2AC1D8A7C
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 May 2020 00:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728151AbgERWOA (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 May 2020 18:14:00 -0400
Received: from mga01.intel.com ([192.55.52.88]:46557 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728129AbgERWOA (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 May 2020 18:14:00 -0400
IronPort-SDR: AZ4Ec6wNo4rn7Xmd2+BC94DJriipvoosVvemnwkw/f3Z2PGyrQbBBH9oPHnmTYikMpfHxNgnPr
 fXquHki48BkQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2020 15:13:59 -0700
IronPort-SDR: zFzF7zh0Z8MBwFDjsmPyaHhwaGwCX/27alClOgyDIS0xeiaM9H4rIADBXFF6rCHnHIFy1ArHNc
 eVIXXcV2YHsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,407,1583222400"; 
   d="scan'208";a="411420381"
Received: from sai-dev-mach.sc.intel.com ([143.183.140.153])
  by orsmga004.jf.intel.com with ESMTP; 18 May 2020 15:13:58 -0700
From:   Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
To:     shuah@kernel.org, skhan@linuxfoundation.org,
        linux-kselftest@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        tony.luck@intel.com, reinette.chatre@intel.com, babu.moger@amd.com,
        james.morse@arm.com, ravi.v.shankar@intel.com,
        fenghua.yu@intel.com, x86@kernel.org, linux-kernel@vger.kernel,
        dan.carpenter@oracle.com, dcb314@hotmail.com,
        Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
Subject: [PATCH V2 11/19] selftests/resctrl: Abort running tests if not root user
Date:   Mon, 18 May 2020 15:08:31 -0700
Message-Id: <e8bed1e4ec3b294926670190beb863b1caa3fceb.1589835155.git.sai.praneeth.prakhya@intel.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
References: <cover.1589835155.git.sai.praneeth.prakhya@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Running resctrl selftest requires the test to write to resctrl file system
and only root user has permission to do so. Hence, abort the test suite if
the user is not running the test with root user privileges.

Fixes: ecdbb911f22d ("selftests/resctrl: Add MBM test")
Signed-off-by: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
---
 tools/testing/selftests/resctrl/resctrl_tests.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/resctrl/resctrl_tests.c b/tools/testing/selftests/resctrl/resctrl_tests.c
index cab69ed8c67d..f005ba2b41ec 100644
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
+		return -1;
+	}
 
 	/* Detect AMD vendor */
 	detect_amd();
-- 
2.19.1

