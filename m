Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D8F4EE63B
	for <lists+linux-kselftest@lfdr.de>; Fri,  1 Apr 2022 04:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242133AbiDACs6 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 31 Mar 2022 22:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230504AbiDACs6 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 31 Mar 2022 22:48:58 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B397198EE6;
        Thu, 31 Mar 2022 19:47:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=WZYJFNG1vMt9ILegHLIhkuZmBUpDUyiWrIv97AnX75A=; b=XC397vKJudcGNaI6Ezh9RPyGqz
        ZSxfwBn+W3MaqoHCHqqH8BCAO3TglGIlVPGFv4j3188AZiAYjeLPUXgIqhIsSKQr3x31wYmoYtEE7
        Al2gXbODEFCnukmrqr/koYfwa7vJfHKix48eXy+OLwxZAQpkycmm8ApYYmvXYW5xfgiBUHi3Q+Ihf
        QyAaRgODzriIaDSlD73F/MWfkLOWPWZHBQaOdsC7HOsIWgylSWbdo2PPDzX4MHgsgKwg1e6LuwXPU
        A90tiGRr1Q/0cp0462luzYOb5IvgfEbB5rkrhkiVAZoB3N1+Fdl/3TEFHNP7j6qEJYiB4ZHZFx0za
        a8OTHL4w==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1na7Jc-004KC3-AA; Fri, 01 Apr 2022 02:47:08 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Harinder Singh <sharinder@google.com>,
        Tim Bird <tim.bird@sony.com>
Subject: [PATCH] Documentation: kunit: eliminate code-block warnings
Date:   Thu, 31 Mar 2022 19:47:07 -0700
Message-Id: <20220401024707.10550-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Fix Sphinx complaints about code-block directive missing an argument.
For start.rst, add "none" since that is already heavily used in that
file. For run_wrapper.rst, use the simpler "::" literal block instead.

dev-tools/kunit/start.rst:83: WARNING: Error in "code-block" directive:
1 argument(s) required, 0 supplied.

dev-tools/kunit/run_wrapper.rst:17: WARNING: Error in "code-block" directive:
1 argument(s) required, 0 supplied.
dev-tools/kunit/run_wrapper.rst:23: WARNING: Error in "code-block" directive:
1 argument(s) required, 0 supplied.
dev-tools/kunit/run_wrapper.rst:31: WARNING: Error in "code-block" directive:
1 argument(s) required, 0 supplied.
dev-tools/kunit/run_wrapper.rst:51: WARNING: Error in "code-block" directive:
1 argument(s) required, 0 supplied.
dev-tools/kunit/run_wrapper.rst:57: WARNING: Error in "code-block" directive:
1 argument(s) required, 0 supplied.
dev-tools/kunit/run_wrapper.rst:78: WARNING: Error in "code-block" directive:
1 argument(s) required, 0 supplied.
dev-tools/kunit/run_wrapper.rst:85: WARNING: Error in "code-block" directive:
1 argument(s) required, 0 supplied.
dev-tools/kunit/run_wrapper.rst:109: WARNING: Error in "code-block" directive:
1 argument(s) required, 0 supplied.
dev-tools/kunit/run_wrapper.rst:116: WARNING: Error in "code-block" directive:
1 argument(s) required, 0 supplied.
dev-tools/kunit/run_wrapper.rst:124: WARNING: Error in "code-block" directive:
1 argument(s) required, 0 supplied.
dev-tools/kunit/run_wrapper.rst:139: WARNING: Error in "code-block" directive:
1 argument(s) required, 0 supplied.
dev-tools/kunit/run_wrapper.rst:162: WARNING: Error in "code-block" directive:
1 argument(s) required, 0 supplied.

Fixes: c48b9ef1f794 ("Documentation: KUnit: Rewrite getting started")
Fixes: 46201d47d6c4 ("Documentation: kunit: Reorganize documentation related to running tests")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Brendan Higgins <brendanhiggins@google.com>
Cc: linux-kselftest@vger.kernel.org
Cc: kunit-dev@googlegroups.com
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Harinder Singh <sharinder@google.com>
Cc: Tim Bird <tim.bird@sony.com>
---
 Documentation/dev-tools/kunit/run_wrapper.rst |   24 ++++++++--------
 Documentation/dev-tools/kunit/start.rst       |    2 -
 2 files changed, 13 insertions(+), 13 deletions(-)

--- linux-next-20220331.orig/Documentation/dev-tools/kunit/run_wrapper.rst
+++ linux-next-20220331/Documentation/dev-tools/kunit/run_wrapper.rst
@@ -14,13 +14,13 @@ tests, and formats the test results.
 
 Run command:
 
-.. code-block::
+::
 
 	./tools/testing/kunit/kunit.py run
 
 We should see the following:
 
-.. code-block::
+::
 
 	Generating .config...
 	Building KUnit kernel...
@@ -28,7 +28,7 @@ We should see the following:
 
 We may want to use the following options:
 
-.. code-block::
+::
 
 	./tools/testing/kunit/kunit.py run --timeout=30 --jobs=`nproc --all
 
@@ -48,13 +48,13 @@ test configs for certain subsystems.
 To use a different ``.kunitconfig`` file (such as one
 provided to test a particular subsystem), pass it as an option:
 
-.. code-block::
+::
 
 	./tools/testing/kunit/kunit.py run --kunitconfig=fs/ext4/.kunitconfig
 
 To view kunit_tool flags (optional command-line arguments), run:
 
-.. code-block::
+::
 
 	./tools/testing/kunit/kunit.py run --help
 
@@ -75,14 +75,14 @@ certain code blocks, arch configs and so
 
 To create a ``.kunitconfig``, using the KUnit ``defconfig``:
 
-.. code-block::
+::
 
 	cd $PATH_TO_LINUX_REPO
 	cp tools/testing/kunit/configs/default.config .kunit/.kunitconfig
 
 We can then add any other Kconfig options. For example:
 
-.. code-block::
+::
 
 	CONFIG_LIST_KUNIT_TEST=y
 
@@ -106,14 +106,14 @@ can run part of the KUnit build process
 When running kunit_tool, from a ``.kunitconfig``, we can generate a
 ``.config`` by using the ``config`` argument:
 
-.. code-block::
+::
 
 	./tools/testing/kunit/kunit.py config
 
 To build a KUnit kernel from the current ``.config``, we can use the
 ``build`` argument:
 
-.. code-block::
+::
 
 	./tools/testing/kunit/kunit.py build
 
@@ -121,7 +121,7 @@ If we already have built UML kernel with
 can run the kernel, and display the test results with the ``exec``
 argument:
 
-.. code-block::
+::
 
 	./tools/testing/kunit/kunit.py exec
 
@@ -136,7 +136,7 @@ format. When running tests, kunit_tool p
 a summary. To see the raw test results in TAP format, we can pass the
 ``--raw_output`` argument:
 
-.. code-block::
+::
 
 	./tools/testing/kunit/kunit.py run --raw_output
 
@@ -159,7 +159,7 @@ By passing a bash style glob filter to t
 commands, we can run a subset of the tests built into a kernel . For
 example: if we only want to run KUnit resource tests, use:
 
-.. code-block::
+::
 
 	./tools/testing/kunit/kunit.py run 'kunit-resource*'
 
--- linux-next-20220331.orig/Documentation/dev-tools/kunit/start.rst
+++ linux-next-20220331/Documentation/dev-tools/kunit/start.rst
@@ -80,7 +80,7 @@ Running Tests (KUnit Wrapper)
 
 If everything worked correctly, you should see the following:
 
-.. code-block::
+.. code-block:: none
 
 	Generating .config ...
 	Building KUnit Kernel ...
