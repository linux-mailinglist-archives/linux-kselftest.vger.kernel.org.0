Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9C4781A85
	for <lists+linux-kselftest@lfdr.de>; Sat, 19 Aug 2023 18:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbjHSQZs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 19 Aug 2023 12:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbjHSQZs (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 19 Aug 2023 12:25:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEAA12748;
        Sat, 19 Aug 2023 09:25:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A4ED61D26;
        Sat, 19 Aug 2023 16:25:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD61C433C8;
        Sat, 19 Aug 2023 16:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692462344;
        bh=Gm54xopY5U1g+dtLdCK5BXvhK5nJLYt1xvvTvw4Ipn0=;
        h=From:To:Cc:Subject:Date:From;
        b=T6GsYfmlM2iBvguNjtaNVEn5Yfpe+DOYTsuVXVxaORC11cv1yKBJRbUmjgoFq0hH2
         IP3h6MQ3AWE0RREdvLTdNk3vIN2xwCjSAW4mFrbB1N913sJoWsMPA8sHMoIivoPgFW
         N95ys0niXO9pPKSvWzCM1EJ28Yjd4gK6ein72TNAIe0EiIHGlq8ONX/BSZ6JbmBWbc
         aJW1ZeOJi8nGsrGgAWFUPzum08ulHkNO/X09PvmX5f/I+24m/qx+/SVl3aBdJYQBmZ
         H6l5XkWy2OPV1ZDByOKieYjp14fehrhWO+NuOGHE2HopHVbeuoNV7nLDDaM4GlvXly
         erBEyGNLS670Q==
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>,
        linux-kernel@vger.kernel.org (open list),
        linux-kselftest@vger.kernel.org (open list:KERNEL SELFTEST FRAMEWORK)
Subject: [PATCH v2] selftests/tpm2: tpm2-parse-error.py
Date:   Sat, 19 Aug 2023 16:25:37 +0000
Message-Id: <20230819162540.5717-1-jarkko@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add a script to quickly parse any TPM error code. This can be useful, e.g.
when parsing klog output when TPM fails in an internal kernel operation.

Example transcript:

$ python3 tpm2-parse-error.py 0x1C4
TPM_RC_VALUE: rc=0x000001c4

Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
v2:
Makefile: s/tpm2-parse-error/tpm2-parse-error.py/
---
 tools/testing/selftests/tpm2/Makefile           |  2 +-
 .../testing/selftests/tpm2/tpm2-parse-error.py  | 17 +++++++++++++++++
 2 files changed, 18 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/tpm2/tpm2-parse-error.py

diff --git a/tools/testing/selftests/tpm2/Makefile b/tools/testing/selftests/tpm2/Makefile
index a9bf9459fb25..dbff77612785 100644
--- a/tools/testing/selftests/tpm2/Makefile
+++ b/tools/testing/selftests/tpm2/Makefile
@@ -2,4 +2,4 @@
 include ../lib.mk
 
 TEST_PROGS := test_smoke.sh test_space.sh test_async.sh
-TEST_PROGS_EXTENDED := tpm2.py tpm2_tests.py
+TEST_PROGS_EXTENDED := tpm2.py tpm2_tests.py tpm2-parse-error.py
diff --git a/tools/testing/selftests/tpm2/tpm2-parse-error.py b/tools/testing/selftests/tpm2/tpm2-parse-error.py
new file mode 100644
index 000000000000..8eed72681af1
--- /dev/null
+++ b/tools/testing/selftests/tpm2/tpm2-parse-error.py
@@ -0,0 +1,17 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
+
+from argparse import ArgumentParser
+from argparse import FileType
+import os
+import sys
+import tpm2
+
+def main():
+    parser = ArgumentParser(description='Parse a TPM error code')
+    parser.add_argument('rc', type=(lambda x: int(x, 0)))
+    args = parser.parse_args()
+    print(str(tpm2.ProtocolError(None, args.rc)))
+
+if __name__ == '__main__':
+    main()
-- 
2.39.2

