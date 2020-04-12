Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 941481A5EE4
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Apr 2020 16:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgDLOL0 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Apr 2020 10:11:26 -0400
Received: from mga07.intel.com ([134.134.136.100]:57266 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbgDLOL0 (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Apr 2020 10:11:26 -0400
IronPort-SDR: 7jqYE0Hh2SrjJnTWDHl1/XOTjdYluOn4wHPcNMqQ83w0r72Z6+RNIqej9IIeUoUrfKnyb/vmN4
 mEI1eBOZ9Utg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2020 07:11:23 -0700
IronPort-SDR: YcF9grRNMDlNiy+jJV6ObXJCi7szAvUALbUtLto5Lo6282uVrQe3ew4QxGUyba7qEbbivq1+ls
 5wT6Yk3yOGKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,374,1580803200"; 
   d="scan'208";a="287651096"
Received: from apresura-mobl.ger.corp.intel.com (HELO localhost) ([10.252.61.246])
  by fmsmga002.fm.intel.com with ESMTP; 12 Apr 2020 07:11:21 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Nikita Sobolev <Nikita.Sobolev@synopsys.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] selftests/tpm: Fix runtime error
Date:   Sun, 12 Apr 2020 17:11:17 +0300
Message-Id: <20200412141118.70688-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

There is some random clutter in test_smoke.sh:

  ./test_smoke.sh: line 3: self.flags: command not found

Remove it.

Fixes: b32694cd0724 ("Kernel selftests: tpm2: check for tpm support")
Cc: Nikita Sobolev <Nikita.Sobolev@synopsys.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
I rely on these tests and this was not even cc'd to me and obviously
was untested. There is neither reviewed-by nor tested-by tags in the
commit (not to mention some cosmetic things like short summary
formatted wrong and the extra newline character).

Please do not do this next time. Thanks.
 tools/testing/selftests/tpm2/test_smoke.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/tools/testing/selftests/tpm2/test_smoke.sh b/tools/testing/selftests/tpm2/test_smoke.sh
index b630c7b5950a..e55d3e400666 100755
--- a/tools/testing/selftests/tpm2/test_smoke.sh
+++ b/tools/testing/selftests/tpm2/test_smoke.sh
@@ -1,11 +1,9 @@
 #!/bin/bash
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
-self.flags = flags
 
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 
-
 if [ -f /dev/tpm0 ] ; then
 	python -m unittest -v tpm2_tests.SmokeTest
 	python -m unittest -v tpm2_tests.AsyncTest
-- 
2.25.1

