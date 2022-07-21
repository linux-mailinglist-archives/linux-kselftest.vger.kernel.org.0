Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5DAA57C636
	for <lists+linux-kselftest@lfdr.de>; Thu, 21 Jul 2022 10:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiGUI0I (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 21 Jul 2022 04:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbiGUI0I (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 21 Jul 2022 04:26:08 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629802D1FF
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jul 2022 01:26:06 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id g67-20020a636b46000000b0040e64eee874so610593pgc.4
        for <linux-kselftest@vger.kernel.org>; Thu, 21 Jul 2022 01:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=D/jsDBi2QFOs4Zs9HMSmYJI8zRXb+dPzos0HZwfSzzc=;
        b=hDrAMBg+Z58759aVRZuEyzgtEevkSBomPALCPlB5FpjqCmKg8B0/ALxrCvYQikj+H5
         fxst5CjnEkashz8KaxmEkft/H1HJM0q/5JSCTEziGJVfyxDb8Tjqo1FJSXZJmHaSCFFJ
         Z6k161Kw/1FwBVTD39n/pntZJBIGo4dLkrk8RxqVFcKP5FVn37uScX64N3sZHH383QnV
         7yjJX6A9ZpFCvoc1YqHM0qqNOuh5VMEDTbpU80qq8Gmw0u7fPJf9odGO03uIMXvljOn1
         QmjxH/o8StFq9utrr0exokzUQlGoDdEjVLijTC72IRrs36dKf1irONKGhxhL94DIpx1X
         ZluA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=D/jsDBi2QFOs4Zs9HMSmYJI8zRXb+dPzos0HZwfSzzc=;
        b=g42sSCW8kSYj8y6ddPZ43Hw3aruN4IQlPjMXToD6Qgb8vIhnVoIv1uvR6sl1A78+vR
         ZPl5zVoeQkJbY6lEEyz2IQ9B6Jyw5/OBQphsohs2/PATknOHfWiUbnEzd04e583RqXUu
         2Tsw0TDukGHgbsiYs3qqobE/rph223/y1Et18Z/uWivYDsa4of13i5KEF6uh+kfNnjWH
         J8bpu+gJjC4R8jdHJPD2dzSWpDeXz/EycTm4+6ZL8PcAamDk89GtwomR4RzgD054wg8c
         222ToUQ99u2fU7OtAE9of7bqrI0toQTHI2QJzKDsdy/pmFT0qd9GtMrhNZcGNub1o9U5
         QSDQ==
X-Gm-Message-State: AJIora/zCL4aT2N79fg4aZ6FUmLtdsiiFc3D0QTboyNrrGX/+zXN2NUz
        JUxzKigGxLwGPH5Tl3CYZ2WZhmGNb1yjoDny
X-Google-Smtp-Source: AGRyM1te19it3AE4l9t6OQd4moI7u3bYsVRejG70XLibIb70+UbPjpftAuMZHyGoLFjGdHCu7fLF3uBTDNrUINke
X-Received: from skazigti.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:411e])
 (user=sadiyakazi job=sendgmr) by 2002:a05:6a00:1a:b0:52a:dec1:308c with SMTP
 id h26-20020a056a00001a00b0052adec1308cmr43268981pfk.52.1658391965893; Thu,
 21 Jul 2022 01:26:05 -0700 (PDT)
Date:   Thu, 21 Jul 2022 08:10:27 +0000
Message-Id: <20220721081026.1247067-1-sadiyakazi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v2] Documentation: kunit: Add CLI args for kunit_tool
From:   Sadiya Kazi <sadiyakazi@google.com>
To:     brendanhiggins@google.com, davidgow@google.com,
        skhan@linuxfoundation.org, corbet@lwn.net, mairacanal@riseup.net
Cc:     Sadiya Kazi <sadiyakazi@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Run_wrapper.rst was missing some command line arguments. Added
additional args in the file.

Signed-off-by: Sadiya Kazi <sadiyakazi@google.com>
---
Changes since V1:
https://lore.kernel.org/linux-kselftest/20220719092214.995965-1-sadiyakazi@google.com/
- Addressed most of the review comments from Maira and David, except
  removing the duplicate arguments as I felt its worth keeping them in
  the reference documentation as well as in context. We can improve them
  and differentiate their use cases in the future patches.


---
 Documentation/dev-tools/kunit/run_wrapper.rst | 60 ++++++++++++++++++-
 1 file changed, 59 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/dev-tools/kunit/run_wrapper.rst
index 5e560f2c5fca..600af7ac5f88 100644
--- a/Documentation/dev-tools/kunit/run_wrapper.rst
+++ b/Documentation/dev-tools/kunit/run_wrapper.rst
@@ -233,7 +233,7 @@ Command-Line Arguments
 ======================
 
 kunit_tool has a number of other command-line arguments which can
-be useful for our test environment. Below the most commonly used
+be useful for our test environment. Below are the most commonly used
 command line arguments:
 
 - ``--help``: Lists all available options. To list common options,
@@ -257,3 +257,61 @@ command line arguments:
             added or modified. Instead, enable all tests
             which have satisfied dependencies by adding
             ``CONFIG_KUNIT_ALL_TESTS=y`` to your ``.kunitconfig``.
+
+- ``--kunitconfig``: Specifies the path or the directory of the ``.kunitconfig``
+  file. For example:
+
+  - ``lib/kunit/.kunitconfig`` can be the path of the file.
+
+  - ``lib/kunit`` can be the directory in which the file is located.
+
+  This file is used to build and run with a predefined set of tests
+  and their dependencies. For example, to run tests for a given subsystem.
+
+- ``--kconfig_add``: Specifies additional configuration options to be
+  appended to the ``.kunitconfig`` file.
+  For example, ``./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_KASAN=y``.
+
+- ``--arch``: Runs tests on the specified architecture. The architecture
+  specified must match the Kbuild ARCH environment variable.
+  For example, i386, x86_64, arm, um, etc. Non-UML architectures run on QEMU.
+  Default is `um`.
+
+- ``--cross_compile``: Specifies the Kbuild toolchain. It passes the
+  same argument as passed to the ``CROSS_COMPILE`` variable used by
+  Kbuild. This will be the prefix for the toolchain
+  binaries such as GCC. For example:
+
+  - ``sparc64-linux-gnu-`` if we have the sparc toolchain installed on
+    our system.
+
+  - ``$HOME/toolchains/microblaze/gcc-9.2.0-nolibc/microblaze-linux/bin/microblaze-linux``
+    if we have downloaded the microblaze toolchain from the 0-day
+    website to a specified path in our home directory called toolchains.
+
+- ``--qemu_config``: Specifies the path to a file containing a
+  custom qemu architecture definition. This should be a python file
+  containing a `QemuArchParams` object.
+
+- ``--qemu_args``: Specifies additional QEMU arguments, for example, "-smp 8".
+
+- ``--jobs``: Specifies the number of jobs (commands) to run simultaneously.
+  By default, this is set to the number of cores on your system.
+
+- ``--timeout``: Specifies the maximum number of seconds allowed for all tests to run.
+  This does not include the time taken to build the tests.
+
+- ``--kernel_args``: Specifies additional kernel command-line arguments. Might be repeated.
+
+- ``--run_isolated``: If set, boots the kernel for each individual suite/test.
+  This is useful for debugging a non-hermetic test, one that
+  might pass/fail based on what ran before it.
+
+- ``--raw_output``: If set, generates unformatted output from kernel. Possible options are:
+
+   - ``all``: To view the full kernel output, use ``--raw_output=all``.
+
+   - ``kunit``: This is the default option and filters to KUnit output. Use ``--raw_output`` or ``--raw_output=kunit``.
+
+- ``--json``: If set, stores the test results in a JSON format and prints to `stdout` or
+  saves to a file if a filename is specified.
-- 
2.37.0.170.g444d1eabd0-goog

