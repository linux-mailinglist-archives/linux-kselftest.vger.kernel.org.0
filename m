Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC5B814EF83
	for <lists+linux-kselftest@lfdr.de>; Fri, 31 Jan 2020 16:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729030AbgAaPZw (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 31 Jan 2020 10:25:52 -0500
Received: from us03-smtprelay2.synopsys.com ([149.117.87.133]:41954 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728893AbgAaPZw (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 31 Jan 2020 10:25:52 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id BA005C057A;
        Fri, 31 Jan 2020 15:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1580484350; bh=lcoAa7VqB7NirC/myBLSakmDMyizo7a5wkGDAM+kf6o=;
        h=From:To:Cc:Subject:Date:From;
        b=VG8389gwPt2jxUvak4Q/mO0PJL4zFYZ8vps2aU3Fxc0gNehr4yzHohQCQnqpjDzW/
         Qv1s4O5yezqNsKZhqXMOSCXHxhODPjwNYM/1TZ+zohajwGZJulK5ASGHMPFO1Tfoiy
         6M3gd3nf7uATlmFCmqoMI/SvVGyTg5RC37x2IbzPn4qmfXh3/CZ6FBfoMrIFUANGw3
         mMvSE4dbTNXDnxzxwNKB8RZZkHnzYc3nu5YsakhNr4G1KvHK8hWNQuIaR6SKugHrix
         /aMlACJzvYtk9vqGtyVozc9Mf3WKsVuIqnHpFSiLNyMJM6VXiEZZ9HFn67VEjeHNif
         RWj/uI+QkfF2Q==
Received: from ru20arcgnu1.internal.synopsys.com (ru20arcgnu1.internal.synopsys.com [10.121.9.48])
        by mailhost.synopsys.com (Postfix) with ESMTP id 1D905A0064;
        Fri, 31 Jan 2020 15:25:40 +0000 (UTC)
From:   Nikita Sobolev <Nikita.Sobolev@synopsys.com>
To:     Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Tadeusz Struk <tadeusz.struk@intel.com>,
        Joey Pabalinas <joeypabalinas@gmail.com>,
        Petr Vorel <petr.vorel@gmail.com>,
        linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        linux-snps-arc@lists.infradead.org,
        Nikita Sobolev <Nikita.Sobolev@synopsys.com>
Subject: [PATCH] Kernel selftests: tpm2: check for tpm support
Date:   Fri, 31 Jan 2020 18:25:23 +0300
Message-Id: <20200131152523.4442-1-Nikita.Sobolev@synopsys.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kselftest-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

tpm2 tests set fails if there is no /dev/tpm0 and /dev/tpmrm0
supported. Check if these files exist before run and mark test as
skipped in case of absence.

Signed-off-by: Nikita Sobolev <Nikita.Sobolev@synopsys.com>
---
 tools/testing/selftests/tpm2/test_smoke.sh | 13 +++++++++++--
 tools/testing/selftests/tpm2/test_space.sh |  9 ++++++++-
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/tpm2/test_smoke.sh b/tools/testing/selftests/tpm2/test_smoke.sh
index 8155c2ea7ccb..b630c7b5950a 100755
--- a/tools/testing/selftests/tpm2/test_smoke.sh
+++ b/tools/testing/selftests/tpm2/test_smoke.sh
@@ -1,8 +1,17 @@
 #!/bin/bash
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+self.flags = flags
 
-python -m unittest -v tpm2_tests.SmokeTest
-python -m unittest -v tpm2_tests.AsyncTest
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
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

