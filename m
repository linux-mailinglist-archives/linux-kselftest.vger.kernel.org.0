Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911E01D8A1B
	for <lists+linux-kselftest@lfdr.de>; Mon, 18 May 2020 23:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgERVjr (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 18 May 2020 17:39:47 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:56542 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726502AbgERVjr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 18 May 2020 17:39:47 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id ACEBE400B9;
        Mon, 18 May 2020 21:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1589837987; bh=4fUtfqcSwPxDzsZvtjaryhdzMyuy3jPIOnsb1fo4TLE=;
        h=From:To:Cc:Subject:Date:From;
        b=LmW2zV3vqgfLtNGu6lM/+d6Fcr3odAXOx1mpOrnSof+11mW/l74QsXtnwaTKqce9I
         uDfdtMdKwe41oYXsqdZgX2SD0Pt+TD0U10To7eG4t7BDtNNc78sghfN7RvlILSFyJA
         ipdKw2/UhZezG/b79Qf8ZZgqxINOkOsFKCRm7ErvyHtxdlelaiBCOJr6pun9ta1oB8
         oKuFMJbWK5n+KYL5DCdxFI7aI204vdNIL5AJ9AFpSgfGtbwZ8l0LXZIMkFwAtWPClX
         QJ/5xREN94OsXPYjk1KNCgXFNUJxtcYe9bB4UPuZ5U2UHy/tkR6wUDz4FSS8rmy0Jb
         qO/QgEz8NjF2Q==
Received: from ru20arcgnu1.internal.synopsys.com (ru20arcgnu1.internal.synopsys.com [10.121.9.48])
        by mailhost.synopsys.com (Postfix) with ESMTP id 2B482A005C;
        Mon, 18 May 2020 21:39:37 +0000 (UTC)
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
Subject: [PATCH] Kernel selftests: Add check if tpm devices are supported
Date:   Tue, 19 May 2020 00:39:34 +0300
Message-Id: <20200518213934.23156-1-Nikita.Sobolev@synopsys.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

tpm2 tests set uses /dev/tpm0 and /dev/tpmrm0 without check if they
are available. In case, when these devices are not available test
fails, but expected behaviour is test to be skipped.

Signed-off-by: Nikita Sobolev <Nikita.Sobolev@synopsys.com>
---
 tools/testing/selftests/tpm2/test_smoke.sh | 11 +++++++++--
 tools/testing/selftests/tpm2/test_space.sh |  9 ++++++++-
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/tpm2/test_smoke.sh b/tools/testing/selftests/tpm2/test_smoke.sh
index 8155c2ea7ccb..e55d3e400666 100755
--- a/tools/testing/selftests/tpm2/test_smoke.sh
+++ b/tools/testing/selftests/tpm2/test_smoke.sh
@@ -1,8 +1,15 @@
 #!/bin/bash
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 
-python -m unittest -v tpm2_tests.SmokeTest
-python -m unittest -v tpm2_tests.AsyncTest
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+if [ -f /dev/tpm0 ] ; then
+	python -m unittest -v tpm2_tests.SmokeTest
+	python -m unittest -v tpm2_tests.AsyncTest
+else
+	exit $ksft_skip
+fi
 
 CLEAR_CMD=$(which tpm2_clear)
 if [ -n $CLEAR_CMD ]; then
diff --git a/tools/testing/selftests/tpm2/test_space.sh b/tools/testing/selftests/tpm2/test_space.sh
index a6f5e346635e..180b469c53b4 100755
--- a/tools/testing/selftests/tpm2/test_space.sh
+++ b/tools/testing/selftests/tpm2/test_space.sh
@@ -1,4 +1,11 @@
 #!/bin/bash
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 
-python -m unittest -v tpm2_tests.SpaceTest
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+if [ -f /dev/tpmrm0 ] ; then
+	python -m unittest -v tpm2_tests.SpaceTest
+else
+	exit $ksft_skip
+fi
-- 
2.16.2

