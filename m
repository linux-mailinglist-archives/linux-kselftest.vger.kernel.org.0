Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6255C4DCC70
	for <lists+linux-kselftest@lfdr.de>; Thu, 17 Mar 2022 18:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236876AbiCQRaK (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 17 Mar 2022 13:30:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236875AbiCQRaK (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 17 Mar 2022 13:30:10 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19A99214F9B;
        Thu, 17 Mar 2022 10:28:52 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id B66601F459AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647538131;
        bh=cxxx6hstk7rIVcr0b5g2yR0BAZctX/d+E8ToCgt6AjM=;
        h=From:To:Cc:Subject:Date:From;
        b=cwENso64YsIjVii0hQAcvg2enNRPzdS/iG2T/cGIBJhBWs8YY68moY/5Jzf/7ZHmR
         sYRnBikAemwr81rSkHvi3J4smDqhCPJTWBiPdw+vpuM1XxoqIndRD/JH9xRxk7jylg
         SoMdaXCwDYwGZvFhhNPhEHITeeK/+qjCGTqFZ/s80NJ3TU4t2Maab+baKW9VCFs9jx
         s4TkkQxs+aOiTdsxRog+DnQBa8phTfNY/4AwW31vuwgiZhJj3/DSDCO/Zt2RJUpua1
         guR1v0Bs8ZJ4Opp4blOFYyWstNjZzt+Mk4nijUdxoemvzga3Mww9wWCMFg11c26BUf
         AYfQAnR9jOcHg==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] docs/kselftest: add more guidelines for adding new tests
Date:   Thu, 17 Mar 2022 22:27:57 +0500
Message-Id: <20220317172758.582690-1-usama.anjum@collabora.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Add the following new guidelines:
- Add instruction to use lib.mk
- Add instruction about how to use headers from kernel source
- Add instruction to add .gitignore file
- Add instruction about how to add new test in selftests/Makefile
- Add instruction about different build commands to test

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Following patch is fixing build of kselftest when separate output
direcotry is specified using kernel's top most Makefile. It should be
accepted first:
https://lore.kernel.org/lkml/20220223191016.1658728-1-usama.anjum@collabora.com/
---
 Documentation/dev-tools/kselftest.rst | 46 ++++++++++++++++++++++++++-
 1 file changed, 45 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index a833ecf12fbc1..637f83d1450dc 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -208,6 +208,13 @@ In general, the rules for selftests are
 Contributing new tests (details)
 ================================
 
+ * Use lib.mk instead of writing Makefile from sratch. Specify flags and
+   binaries generation flags on need basis before including lib.mk. ::
+
+    CFLAGS = $(KHDR_INCLUDES)
+    TEST_GEN_PROGS := close_range_test
+    include ../lib.mk
+
  * Use TEST_GEN_XXX if such binaries or files are generated during
    compiling.
 
@@ -230,13 +237,50 @@ Contributing new tests (details)
  * First use the headers inside the kernel source and/or git repo, and then the
    system headers.  Headers for the kernel release as opposed to headers
    installed by the distro on the system should be the primary focus to be able
-   to find regressions.
+   to find regressions. Use KHDR_INCLUDES in Makefile to include headers from
+   the kernel source.
 
  * If a test needs specific kernel config options enabled, add a config file in
    the test directory to enable them.
 
    e.g: tools/testing/selftests/android/config
 
+ * Create a .gitignore file inside test directory and add all generated objects
+   in it.
+
+ * Add new test name in TARGETS in selftests/Makefile::
+
+    TARGETS += android
+
+ * All of the following build commands should be successful
+
+   - Same directory build of kselftests::
+
+      make kselftest-all
+      make kselftest-install
+      make kselftest-clean
+      make kselftest-gen_tar
+
+   - Build with absolute output directory path::
+
+      make kselftest-all O=/abs_build_path
+      make kselftest-install O=/abs_build_path
+      make kselftest-clean O=/abs_build_path
+      make kselftest-gen_tar O=/abs_build_path
+
+   - Build with relative output directory path::
+
+      make kselftest-all O=relative_path
+      make kselftest-install O=relative_path
+      make kselftest-clean O=relative_path
+      make kselftest-gen_tar O=relative_path
+
+   - Build from Makefile of selftests directly::
+
+      make -C tools/testing/selftests
+      make -C tools/testing/selftests O=/abs_build_path
+      make -C tools/testing/selftests O=relative_path
+
 Test Module
 ===========
 
-- 
2.30.2

