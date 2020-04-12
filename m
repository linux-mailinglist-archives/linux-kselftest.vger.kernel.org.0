Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 436021A5EF6
	for <lists+linux-kselftest@lfdr.de>; Sun, 12 Apr 2020 16:23:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbgDLOXN (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 12 Apr 2020 10:23:13 -0400
Received: from mga04.intel.com ([192.55.52.120]:51666 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726139AbgDLOXN (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 12 Apr 2020 10:23:13 -0400
IronPort-SDR: 9BpPFnrHh5P2D0/N1FnwLv7VNQ9310bOcQLELLUN4L7DOVJ/9J5IgdWwsunqYmc5gfE/Lyx9d7
 ivI0QCi1jC/Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2020 07:23:13 -0700
IronPort-SDR: n/4R9XDXbPL3hBrh/oePya4+o7HKtnhjPshKn1Lk+zGbax/ynxVAFG8Mk9b44IUKaaCBgfyM07
 CKWTAfrFjXBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,374,1580803200"; 
   d="scan'208";a="243338088"
Received: from apresura-mobl.ger.corp.intel.com (HELO localhost) ([10.252.61.246])
  by fmsmga007.fm.intel.com with ESMTP; 12 Apr 2020 07:23:11 -0700
From:   Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, linux-integrity@vger.kernel.org,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Nikita Sobolev <Nikita.Sobolev@synopsys.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] Revert "Kernel selftests: tpm2: check for tpm support"
Date:   Sun, 12 Apr 2020 17:23:07 +0300
Message-Id: <20200412142309.71807-1-jarkko.sakkinen@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

This reverts commit b32694cd0724d4ceca2c62cc7c3d3a8d1ffa11fc.

The original comment was neither reviewed nor tested. Thus, this the
*only* possible action to take.

Cc: Nikita Sobolev <Nikita.Sobolev@synopsys.com>
Signed-off-by: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
---
 tools/testing/selftests/tpm2/test_smoke.sh | 13 ++-----------
 tools/testing/selftests/tpm2/test_space.sh |  9 +--------
 2 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/tpm2/test_smoke.sh b/tools/testing/selftests/tpm2/test_smoke.sh
index b630c7b5950a..8155c2ea7ccb 100755
--- a/tools/testing/selftests/tpm2/test_smoke.sh
+++ b/tools/testing/selftests/tpm2/test_smoke.sh
@@ -1,17 +1,8 @@
 #!/bin/bash
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
-self.flags = flags
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
-
-if [ -f /dev/tpm0 ] ; then
-	python -m unittest -v tpm2_tests.SmokeTest
-	python -m unittest -v tpm2_tests.AsyncTest
-else
-	exit $ksft_skip
-fi
+python -m unittest -v tpm2_tests.SmokeTest
+python -m unittest -v tpm2_tests.AsyncTest
 
 CLEAR_CMD=$(which tpm2_clear)
 if [ -n $CLEAR_CMD ]; then
diff --git a/tools/testing/selftests/tpm2/test_space.sh b/tools/testing/selftests/tpm2/test_space.sh
index 180b469c53b4..a6f5e346635e 100755
--- a/tools/testing/selftests/tpm2/test_space.sh
+++ b/tools/testing/selftests/tpm2/test_space.sh
@@ -1,11 +1,4 @@
 #!/bin/bash
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 
-# Kselftest framework requirement - SKIP code is 4.
-ksft_skip=4
-
-if [ -f /dev/tpmrm0 ] ; then
-	python -m unittest -v tpm2_tests.SpaceTest
-else
-	exit $ksft_skip
-fi
+python -m unittest -v tpm2_tests.SpaceTest
-- 
2.25.1

