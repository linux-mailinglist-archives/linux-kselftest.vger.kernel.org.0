Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 339CC52F9BF
	for <lists+linux-kselftest@lfdr.de>; Sat, 21 May 2022 09:38:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237387AbiEUHiJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sat, 21 May 2022 03:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbiEUHiJ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sat, 21 May 2022 03:38:09 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C7017D39F;
        Sat, 21 May 2022 00:38:07 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: usama.anjum)
        with ESMTPSA id 686CC1F41DC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1653118686;
        bh=1mZ8cwoInROONWuhTnsZHEew9Oj6lZBNbHe4imfY4go=;
        h=From:To:Cc:Subject:Date:From;
        b=mqGEZhYRlV39fiHFvJ8f5n/bf6mcyfVdAB6AMVNSb5evx/uhtIBcmR8Qe90UbMFog
         Ksazz3MjUkp8wZUmD7pAskomaah1mB/28ymbS8EV8JlKi9eNrsj2olW+fNtDn0E7Tp
         M4co91yyQikyv/fGowQUZ2wwmMNI3QYsTqIXtLB8OIWXyAJYk8iSvww417K8ytP39s
         ABG8psZ5W7kMB9KqepswkbDulrfpHW6YtDe+dxhfJ8swa4qCmEIEKxpDDJ2EIaX6sX
         IZ4Bou3u88GlE3Ws2GxmzhnnYOXMCv2BpothIkIViCoXcwHplC1DvoC6eV0wTSHzoD
         J8S/AWEdpNW9A==
From:   Muhammad Usama Anjum <usama.anjum@collabora.com>
To:     Shuah Khan <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Cc:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        kernel@collabora.com, bagasdotme@gmail.com,
        linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] docs/kselftest: add more guidelines for adding new tests
Date:   Sat, 21 May 2022 12:36:51 +0500
Message-Id: <20220521073651.4191910-1-usama.anjum@collabora.com>
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

Improve and add instructions to add new tests. Add build commands to
test before sending the new test patch.

Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
---
Changes in v2:
- Updated commit message
- Removed dependence of this patch from other patch
- Updated instructions
---
 Documentation/dev-tools/kselftest.rst | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kselftest.rst b/Documentation/dev-tools/kselftest.rst
index a833ecf12fbc1..ee6467ca8293f 100644
--- a/Documentation/dev-tools/kselftest.rst
+++ b/Documentation/dev-tools/kselftest.rst
@@ -208,6 +208,14 @@ In general, the rules for selftests are
 Contributing new tests (details)
 ================================
 
+ * In your Makefile, use facilities from lib.mk by including it instead of
+   reinventing the wheel. Specify flags and binaries generation flags on
+   need basis before including lib.mk. ::
+
+    CFLAGS = $(KHDR_INCLUDES)
+    TEST_GEN_PROGS := close_range_test
+    include ../lib.mk
+
  * Use TEST_GEN_XXX if such binaries or files are generated during
    compiling.
 
@@ -230,13 +238,30 @@ Contributing new tests (details)
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
+ * All changes should pass::
+
+    kselftest-{all,install,clean,gen_tar}
+    kselftest-{all,install,clean,gen_tar} O=abo_path
+    kselftest-{all,install,clean,gen_tar} O=rel_path
+    make -C tools/testing/selftests {all,install,clean,gen_tar}
+    make -C tools/testing/selftests {all,install,clean,gen_tar} O=abs_path
+    make -C tools/testing/selftests {all,install,clean,gen_tar} O=rel_path
+
 Test Module
 ===========
 
-- 
2.30.2

