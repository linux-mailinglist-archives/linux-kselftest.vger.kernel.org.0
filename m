Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D3959C5C7
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 20:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbiHVSKs (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Mon, 22 Aug 2022 14:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236799AbiHVSKh (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Mon, 22 Aug 2022 14:10:37 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAE82A258
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 11:10:35 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id e16-20020a17090301d000b00172fbf52e7dso489665plh.11
        for <linux-kselftest@vger.kernel.org>; Mon, 22 Aug 2022 11:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=qlD6NeLsjzcixDwtOHCxTrg3u7mh8GFZd+CsXJLZniE=;
        b=Zo9A95i3UccLuWai9d8/rafLsVcTppbLB6LThLylbNiZN8uVtjIWgFt6dmcy7arPza
         jGvhEJ6Xr8JqHxQl2TNVtqN9D+9jAxTPMdrJC86OwU3dfdtOeNEiM3aUQ6zIFPa/4GKn
         VcG/k3B6HMrfvvsS1ejioW9mvQYjw9oYM0L+l2pm2xtSQtqkgVmhHUEGSN7a42ZaBMxq
         tIGmy4fUWQfvoi1UBLd5vLM94l5EoG0t5r8sAxGwBZuGpmuzWScJ04cKJ82TmETH3+hQ
         qY2p7lmqImUGENosyXeJYGjFN863cksQXaTMb42qh7IzSd8SXo5B/JRxMNLo5WQme4kS
         dJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=qlD6NeLsjzcixDwtOHCxTrg3u7mh8GFZd+CsXJLZniE=;
        b=nfIevPlSu/K5LTR0k0bzhfpSn8bhYtiiPu6fzaFvWmgyofr3XbJP31ZdizhFFPpejO
         RUqLbJFc7zUSzArllp7gOeNpet4OHR8MJah/PfIssmae3f5RS6+BC3qWo6z/XiWXk0Vh
         P20XqUJ/eC08hNM5rS3u6GZSNs5G6gpF7ThmpIOKxtCXL7fe89NA85tkcHeYfqZ1ra+M
         twJNurkVup22M6wg56zb5PrvsbDhBcWhJYYGmsCe4SHUJsKCoaQGdIfIdzTolade9XSN
         /SJ3ESIM1BVrK/EsP8EacOVeb9MTFmUASJXTfxF8yzNm3XiFjtbukOPwxLR1FEwpzX+g
         I5oQ==
X-Gm-Message-State: ACgBeo3abGvxRWKAFp+95BgFlAytlu3KG1Ibz4y2PJ9amRfgMk4k7+6t
        EpcyWIs4ZxxEJhiejtWkpATgftpXXeT4azhN
X-Google-Smtp-Source: AA6agR5CXQQiS+1zFYsmDhF9Fy+ePsTwFuotO+BWRhclkJ7/SuOGlEcaMFAZ1R/hJk280pakCYkFLYb+hDsf1rwO
X-Received: from skazigti.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:411e])
 (user=sadiyakazi job=sendgmr) by 2002:a05:6a00:855:b0:52e:f01d:723a with SMTP
 id q21-20020a056a00085500b0052ef01d723amr21871779pfk.31.1661191834758; Mon,
 22 Aug 2022 11:10:34 -0700 (PDT)
Date:   Mon, 22 Aug 2022 18:09:56 +0000
Message-Id: <20220822180956.4013497-1-sadiyakazi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH] Documentation: KUnit: Reword kunit_tool guide
From:   Sadiya Kazi <sadiyakazi@google.com>
To:     brendanhiggins@google.com, davidgow@google.com,
        skhan@linuxfoundation.org, corbet@lwn.net
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sadiya Kazi <sadiyakazi@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Updated the kunit_tool.rst guide to streamline it. The following changes
were made:
1. Updated headings
2. Reworded content across sections
3. Added a cross reference to full list of command-line args

Signed-off-by: Sadiya Kazi <sadiyakazi@google.com>
---
 Documentation/dev-tools/kunit/kunit-tool.rst | 82 ++++++++++----------
 1 file changed, 42 insertions(+), 40 deletions(-)

diff --git a/Documentation/dev-tools/kunit/kunit-tool.rst b/Documentation/dev-tools/kunit/kunit-tool.rst
index ae52e0f489f9..33186679f5de 100644
--- a/Documentation/dev-tools/kunit/kunit-tool.rst
+++ b/Documentation/dev-tools/kunit/kunit-tool.rst
@@ -1,8 +1,10 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-=================
-kunit_tool How-To
-=================
+========================
+Understanding kunit_tool
+========================
+
+This page introduces the kunit_tool and covers the concepts and working of this tool.
 
 What is kunit_tool?
 ===================
@@ -10,39 +12,37 @@ What is kunit_tool?
 kunit_tool is a script (``tools/testing/kunit/kunit.py``) that aids in building
 the Linux kernel as UML (`User Mode Linux
 <http://user-mode-linux.sourceforge.net/>`_), running KUnit tests, parsing
-the test results and displaying them in a user friendly manner.
+the test results and displaying them in a user-friendly manner.
 
 kunit_tool addresses the problem of being able to run tests without needing a
 virtual machine or actual hardware with User Mode Linux. User Mode Linux is a
 Linux architecture, like ARM or x86; however, unlike other architectures it
-compiles the kernel as a standalone Linux executable that can be run like any
+compiles the kernel as a standalone Linux executable. This executable can be run like any
 other program directly inside of a host operating system. To be clear, it does
 not require any virtualization support: it is just a regular program.
 
-What is a .kunitconfig?
-=======================
+What is .kunitconfig?
+=====================
 
-It's just a defconfig that kunit_tool looks for in the build directory
-(``.kunit`` by default).  kunit_tool uses it to generate a .config as you might
-expect. In addition, it verifies that the generated .config contains the CONFIG
-options in the .kunitconfig; the reason it does this is so that it is easy to
-be sure that a CONFIG that enables a test actually ends up in the .config.
+.kunitconfig is a default configuration file (defconfig) that kunit_tool looks
+for in the build directory (``.kunit``). The kunit_tool uses this file to
+generate a .config. Additionally, it also verifies that the generated .config contains the CONFIG options in the .kunitconfig file. This is done to make sure that a CONFIG that enables a test is  actually part of the .config file.
 
-It's also possible to pass a separate .kunitconfig fragment to kunit_tool,
+It is also possible to pass a separate .kunitconfig fragment to kunit_tool,
 which is useful if you have several different groups of tests you wish
-to run independently, or if you want to use pre-defined test configs for
+to run independently, or if you want to use pre-defined test configurations for
 certain subsystems.
 
-Getting Started with kunit_tool
+Getting started with kunit_tool
 ===============================
 
-If a kunitconfig is present at the root directory, all you have to do is:
+If a kunitconfig is present at the root directory, run the following command:
 
 .. code-block:: bash
 
 	./tools/testing/kunit/kunit.py run
 
-However, you most likely want to use it with the following options:
+However, most likely you may want to use it with the following options:
 
 .. code-block:: bash
 
@@ -68,20 +68,20 @@ For a list of all the flags supported by kunit_tool, you can run:
 
 	./tools/testing/kunit/kunit.py run --help
 
-Configuring, Building, and Running Tests
+Configuring, building, and running tests
 ========================================
 
-It's also possible to run just parts of the KUnit build process independently,
-which is useful if you want to make manual changes to part of the process.
+It is also possible to run specific parts of the KUnit build process independently.
+This is useful if you want to make manual changes to part of the process.
 
-A .config can be generated from a .kunitconfig by using the ``config`` argument
+If you want to generate a .config from a .kunitconfig, you can use the ``config`` argument
 when running kunit_tool:
 
 .. code-block:: bash
 
 	./tools/testing/kunit/kunit.py config
 
-Similarly, if you just want to build a KUnit kernel from the current .config,
+Similarly, if you want to build a KUnit kernel from the current .config,
 you can use the ``build`` argument:
 
 .. code-block:: bash
@@ -95,33 +95,31 @@ run the kernel and display the test results with the ``exec`` argument:
 
 	./tools/testing/kunit/kunit.py exec
 
-The ``run`` command which is discussed above is equivalent to running all three
+The ``run`` command, discussed above is equivalent to running all three
 of these in sequence.
 
 All of these commands accept a number of optional command-line arguments. The
 ``--help`` flag will give a complete list of these, or keep reading this page
 for a guide to some of the more useful ones.
 
-Parsing Test Results
+Parsing test results
 ====================
 
-KUnit tests output their results in TAP (Test Anything Protocol) format.
-kunit_tool will, when running tests, parse this output and print a summary
-which is much more pleasant to read. If you wish to look at the raw test
-results in TAP format, you can pass the ``--raw_output`` argument.
+The output of the KUnit test results are displayed in TAP (Test Anything Protocol) format.
+When running tests, the kunit_tool parses this output and prints a plaintext, human-readable summary. To view the raw test results in TAP format, you can use the ``--raw_output`` argument.
 
 .. code-block:: bash
 
 	./tools/testing/kunit/kunit.py run --raw_output
 
 The raw output from test runs may contain other, non-KUnit kernel log
-lines. You can see just KUnit output with ``--raw_output=kunit``:
+lines. To view only the KUnit output, you can use ``--raw_output=kunit``:
 
 .. code-block:: bash
 
 	./tools/testing/kunit/kunit.py run --raw_output=kunit
 
-If you have KUnit results in their raw TAP format, you can parse them and print
+If you have KUnit results in the raw TAP format, you can parse them and print
 the human-readable summary with the ``parse`` command for kunit_tool. This
 accepts a filename for an argument, or will read from standard input.
 
@@ -135,11 +133,11 @@ accepts a filename for an argument, or will read from standard input.
 This is very useful if you wish to run tests in a configuration not supported
 by kunit_tool (such as on real hardware, or an unsupported architecture).
 
-Filtering Tests
+Filtering tests
 ===============
 
-It's possible to run only a subset of the tests built into a kernel by passing
-a filter to the ``exec`` or ``run`` commands. For example, if you only wanted
+It is possible to run only a subset of the tests built into a kernel by passing
+a filter to the ``exec`` or ``run`` commands. For example, if you want
 to run KUnit resource tests, you could use:
 
 .. code-block:: bash
@@ -148,15 +146,14 @@ to run KUnit resource tests, you could use:
 
 This uses the standard glob format for wildcards.
 
-Running Tests on QEMU
+Running tests on QEMU
 =====================
 
-kunit_tool supports running tests on QEMU as well as via UML (as mentioned
-elsewhere). The default way of running tests on QEMU requires two flags:
+kunit_tool supports running tests on QEMU as well as via UML. The default way of running tests on QEMU requires two flags:
 
 ``--arch``
 	Selects a collection of configs (Kconfig as well as QEMU configs
-	options, etc) that allow KUnit tests to be run on the specified
+	options and so on) that allow KUnit tests to be run on the specified
 	architecture in a minimal way; this is usually not much slower than
 	using UML. The architecture argument is the same as the name of the
 	option passed to the ``ARCH`` variable used by Kbuild. Not all
@@ -196,8 +193,8 @@ look something like this:
 		--jobs=12 \
 		--qemu_config=./tools/testing/kunit/qemu_configs/x86_64.py
 
-Other Useful Options
-====================
+Other useful options
+======================
 
 kunit_tool has a number of other command-line arguments which can be useful
 when adapting it to fit your environment or needs.
@@ -228,5 +225,10 @@ Some of the more useful ones are:
         dependencies by adding ``CONFIG_KUNIT_ALL_TESTS=1`` to your
         .kunitconfig is preferable.
 
-There are several other options (and new ones are often added), so do check
+There are several other options (and new ones are often added), so do run
 ``--help`` if you're looking for something not mentioned here.
+For more information on these options, see `Command-line-arguments
+<https://www.kernel.org/doc/html/latest/dev-tools/kunit/run_wrapper.html#command-line-arguments>`__
+
+
+.
-- 
2.37.1.595.g718a3a8f04-goog

