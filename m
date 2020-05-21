Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEAD1DD067
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 May 2020 16:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729711AbgEUOn5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 May 2020 10:43:57 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:42918 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728229AbgEUOn4 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 May 2020 10:43:56 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B87DF40933;
        Thu, 21 May 2020 14:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1590072236; bh=rgL44EnEgrpVVzhE3b5dAwCouZZTfZFny+fv4sxR10g=;
        h=From:To:Cc:Subject:Date:From;
        b=MbNJli3rsFLOYILTocxmw4hGxLMGpRQ/dx3kRpIi6AUiLGkOYxMrGRFVubygMVnNs
         2KAdczyTpCjeni42oDinNO8FvMeD/Zt+cWMRnrN4oy2zOS4E+ZVfaB6y7W4AjvpoYy
         uAnbXV4zQviuTIINuXBBEeKCmdQmIV2nn03gG115YXQjXEctreEbGbp5Rdsrh+dC59
         +bPGQYtdTFF+I1iuJv7p95NTHExCLuduYi4c4ZZNQhQ6gpz056DQlTNr7XZQxGz3oC
         mAOycLf+70XNk7YlnT1vUAfC+xstdfiPBm8rYEI7T+m4DlAo2WX9Ah17v/zZWPDcFQ
         RFLNSgfoznnmw==
Received: from ru20arcgnu1.internal.synopsys.com (ru20arcgnu1.internal.synopsys.com [10.121.9.48])
        by mailhost.synopsys.com (Postfix) with ESMTP id CB578A005B;
        Thu, 21 May 2020 14:43:46 +0000 (UTC)
From:   Nikita Sobolev <Nikita.Sobolev@synopsys.com>
To:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>,
        Petr Vorel <petr.vorel@gmail.com>,
        linux-kernel@vger.kernel.org, linux-integrity@vger.kernel.org,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Peter Huewe <peterhuewe@gmx.de>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Nikita Sobolev <Nikita.Sobolev@synopsys.com>
Subject: [PATCH v3] Kernel selftests: Add check if TPM devices are supported
Date:   Thu, 21 May 2020 17:43:44 +0300
Message-Id: <20200521144344.1886-1-Nikita.Sobolev@synopsys.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

TPM2 tests set uses /dev/tpm0 and /dev/tpmrm0 without check if they
are available. In case, when these devices are not available test
fails, but expected behaviour is skipped test.

Signed-off-by: Nikita Sobolev <Nikita.Sobolev@synopsys.com>
---
Changes for v2:
    - Coding Style cleanup

Changes for v3:
    - Commit text message cleanup

 tools/testing/selftests/tpm2/test_smoke.sh | 5 +++++
 tools/testing/selftests/tpm2/test_space.sh | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/tools/testing/selftests/tpm2/test_smoke.sh b/tools/testing/selftests/tpm2/test_smoke.sh
index 8155c2ea7ccb..663062701d5a 100755
--- a/tools/testing/selftests/tpm2/test_smoke.sh
+++ b/tools/testing/selftests/tpm2/test_smoke.sh
@@ -1,6 +1,11 @@
 #!/bin/bash
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+[ -f /dev/tpm0 ] || exit $ksft_skip
+
 python -m unittest -v tpm2_tests.SmokeTest
 python -m unittest -v tpm2_tests.AsyncTest
 
diff --git a/tools/testing/selftests/tpm2/test_space.sh b/tools/testing/selftests/tpm2/test_space.sh
index a6f5e346635e..36c9d030a1c6 100755
--- a/tools/testing/selftests/tpm2/test_space.sh
+++ b/tools/testing/selftests/tpm2/test_space.sh
@@ -1,4 +1,9 @@
 #!/bin/bash
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+[ -f /dev/tpmrm0 ] || exit $ksft_skip
+
 python -m unittest -v tpm2_tests.SpaceTest
-- 
2.16.2

