Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E25E563B493
	for <lists+linux-kselftest@lfdr.de>; Mon, 28 Nov 2022 23:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233897AbiK1WDs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 28 Nov 2022 17:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbiK1WDr (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 28 Nov 2022 17:03:47 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB6724BCD;
        Mon, 28 Nov 2022 14:03:45 -0800 (PST)
Received: from notapiano.myfiosgateway.com (unknown [IPv6:2600:4041:5b1a:cd00:524d:e95d:1a9c:492a])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: nfraprado)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id BB3B16602AB1;
        Mon, 28 Nov 2022 22:03:43 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669673024;
        bh=eocx9jyPGyUFPK58l8dbQu46lL3zk0WxNc1r0CBITUk=;
        h=From:To:Cc:Subject:Date:From;
        b=BDxHaQtOjRDrRawPm0wE1M8kKZo9u9eBWJZ9EQdNLUPP6+zw7YnM40cM53A/9bwHR
         UBaiYK/ozQkI6VFke4k5jzMLtCNhD8BAKFiRKOOncFrTcfGFgXNEb6CkBSj0ACgrBn
         /s/OChZKyYI4vTbnZzhn1fmFdhVYCRK5nVeqlbcz6kUjv2aTihrpxcMKaypKu/upEI
         PGikCp32nFoxUHSaA9mS/RFGEK6ESJiZ/VzRJd8AY0+FWr2jm7bMHzm3vtCb0yoIYE
         NlJtkN4iBRLa5MbMURytwET5blK/U2HudkevkO8VEaR7xSJTskbxJtkNE8xWXoyuew
         4wQMAA/o/KwCw==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Shuah Khan <shuah@kernel.org>, Jarkko Sakkinen <jarkko@kernel.org>
Cc:     kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: [PATCH] selftests/tpm2: Split async tests call to separate shell script runner
Date:   Mon, 28 Nov 2022 17:03:40 -0500
Message-Id: <20221128220340.536558-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

When the async test case was introduced, despite being a completely
independent test case, the command to run it was added to the same shell
script as the smoke test case. Since a shell script implicitly returns
the error code from the last run command, this effectively caused the
script to only return as error code the result from the async test case,
hiding the smoke test result (which could then only be seen from the
python unittest logs).

Move the async test case call to its own shell script runner to avoid
the aforementioned issue. This also makes the output clearer to read,
since each kselftest KTAP result now matches with one python unittest
report.

While at it, also make it so the async test case is skipped if
/dev/tpmrm0 doesn't exist, since commit 8335adb8f9d3 ("selftests: tpm:
add async space test with noneexisting handle") added a test that relies
on it.

Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 tools/testing/selftests/tpm2/Makefile      |  2 +-
 tools/testing/selftests/tpm2/test_async.sh | 10 ++++++++++
 tools/testing/selftests/tpm2/test_smoke.sh |  1 -
 3 files changed, 11 insertions(+), 2 deletions(-)
 create mode 100755 tools/testing/selftests/tpm2/test_async.sh

diff --git a/tools/testing/selftests/tpm2/Makefile b/tools/testing/selftests/tpm2/Makefile
index 1a5db1eb8ed5..a9bf9459fb25 100644
--- a/tools/testing/selftests/tpm2/Makefile
+++ b/tools/testing/selftests/tpm2/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
 include ../lib.mk
 
-TEST_PROGS := test_smoke.sh test_space.sh
+TEST_PROGS := test_smoke.sh test_space.sh test_async.sh
 TEST_PROGS_EXTENDED := tpm2.py tpm2_tests.py
diff --git a/tools/testing/selftests/tpm2/test_async.sh b/tools/testing/selftests/tpm2/test_async.sh
new file mode 100755
index 000000000000..43bf5bd772fd
--- /dev/null
+++ b/tools/testing/selftests/tpm2/test_async.sh
@@ -0,0 +1,10 @@
+#!/bin/sh
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+
+# Kselftest framework requirement - SKIP code is 4.
+ksft_skip=4
+
+[ -e /dev/tpm0 ] || exit $ksft_skip
+[ -e /dev/tpmrm0 ] || exit $ksft_skip
+
+python3 -m unittest -v tpm2_tests.AsyncTest
diff --git a/tools/testing/selftests/tpm2/test_smoke.sh b/tools/testing/selftests/tpm2/test_smoke.sh
index 3e5ff29ee1dd..58af963e5b55 100755
--- a/tools/testing/selftests/tpm2/test_smoke.sh
+++ b/tools/testing/selftests/tpm2/test_smoke.sh
@@ -7,4 +7,3 @@ ksft_skip=4
 [ -e /dev/tpm0 ] || exit $ksft_skip
 
 python3 -m unittest -v tpm2_tests.SmokeTest
-python3 -m unittest -v tpm2_tests.AsyncTest
-- 
2.38.1

