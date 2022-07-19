Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD313579639
	for <lists+linux-kselftest@lfdr.de>; Tue, 19 Jul 2022 11:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235999AbiGSJWe (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 19 Jul 2022 05:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237284AbiGSJWX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 19 Jul 2022 05:22:23 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7CFAE91
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jul 2022 02:22:21 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id u6-20020a25b7c6000000b00670862c5b16so407542ybj.12
        for <linux-kselftest@vger.kernel.org>; Tue, 19 Jul 2022 02:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=KovM5m9Iu+8wBRMriioge8BEE5ifITpdRRU2nQEdeDk=;
        b=kDYGB4RydVygHc+YAmyBVD8txGmKH2WudLiJiTqu7qOhG/e7lQZsTPTZ5/FDBj2ieQ
         li6ymq8ImnMB8etvsp4FbDjajNykpVJsOPiB2vmDlC6jLoPgZ+u8VDuGgbruJXTtuVvl
         MydfGqW+adgx+dBr4xdUAjzIH9lL+QVmMtPsWJz5eSppfx/zzA+DOa1uaCdqsqT3maC6
         LMyJsJTot5FPa8CBI1Yxl0QM2JWsp9BK5JgBSglSK1WudskNYgM1PF/JW5gOtwbplNra
         RjBSRqoAiW2Ye7Ye5IxXjZgBeLRNjuggB+RvOoeKEvvegXGun5/AJlDy+dyaK15Favp+
         OVZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=KovM5m9Iu+8wBRMriioge8BEE5ifITpdRRU2nQEdeDk=;
        b=uw4r7wG6ObD76tudJgaVXjWkFkDjrPwvPojH7f/VqRydA6cJM4AXCSNl8NETOlm1eA
         K5TJBxfKxiKINDRFJUxYKi1mPXrVmugURA28eFh5Ax0QfR7+quoX5CE4TQnQUOJDTmiL
         xnlhuyO+Njv39YGcqU8DWZhMxkDnAwNh3hKFDmPdITKVePMR3guoYiUx5PIcnmMmtYrA
         BMcR2TM4FmG/cYLL/xSnZikPzcWLv9K6lRxI4jVs3ObPNeS+nIRlTXVrcA5Kvcoshmcp
         wAyUqLA0+LB2B39rAPya7lylGvIp//qWaefsKlb53v20jxTvAFfOmqKJGgnuHP9bgiVh
         ljfQ==
X-Gm-Message-State: AJIora/Pjd5GjsWBeimq5vLJVwdz1IBcR2tvCaaUYbAK8Cbfc/Rna3m3
        FLfnfA9po6ntpCRY/exC6nLk6s5aQrVAe2bh
X-Google-Smtp-Source: AGRyM1tX4ntzL6CFfgsSFEX41qDpN6AJFpHeZHzP+J3yvd15fGv8FVkzS1S/ofZm2aLIFJZaud3B0DYoK3Irb4dL
X-Received: from skazigti.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:411e])
 (user=sadiyakazi job=sendgmr) by 2002:a25:8749:0:b0:66f:28a9:7595 with SMTP
 id e9-20020a258749000000b0066f28a97595mr29048736ybn.568.1658222540969; Tue,
 19 Jul 2022 02:22:20 -0700 (PDT)
Date:   Tue, 19 Jul 2022 09:22:14 +0000
Message-Id: <20220719092214.995965-1-sadiyakazi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH] Documentation: kunit: Add CLI args for kunit_tool
From:   Sadiya Kazi <sadiyakazi@google.com>
To:     brendanhiggins@google.com, davidgow@google.com,
        skhan@linuxfoundation.org, corbet@lwn.net,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sadiya Kazi <sadiyakazi@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Run_wrapper.rst was missing some command line arguments. Added
additional args in the file. Included all initial review comments.

Signed-off-by: Sadiya Kazi <sadiyakazi@google.com>
---
 Documentation/dev-tools/kunit/run_wrapper.rst | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/dev-tools/kunit/run_wrapper.rst
index 5e560f2c5fca..91f5dda36e83 100644
--- a/Documentation/dev-tools/kunit/run_wrapper.rst
+++ b/Documentation/dev-tools/kunit/run_wrapper.rst
@@ -257,3 +257,51 @@ command line arguments:
             added or modified. Instead, enable all tests
             which have satisfied dependencies by adding
             ``CONFIG_KUNIT_ALL_TESTS=y`` to your ``.kunitconfig``.
+- ``--kunitconfig``: Specifies the path to the ``.kunitconfig`` file.
+  This Kconfig fragment enables KUnit tests. The "/.kunitconfig" gets
+  appended to the path specified. For example, If a directory path "lib/kunit"
+  is given, the complete path will be "lib/kunit/.kunitconfig".
+
+- ``--kconfig_add``: Specifies additional configuration options to be
+  appended to the ``.kunitconfig`` file. For example, ``CONFIG_KASAN=y``.
+
+- ``--arch``: Runs tests with the specified architecture. The architecture
+  specified must match the string passed to the ARCH make parameter.
+  For example, i386, x86_64, arm, um, etc. Non-UML architectures run on QEMU.
+  Default to 'um'.
+
+- ``--cross_compile``: Specifies the Kbuild toolchain. It passes the
+  same argument as passed to the ``CROSS_COMPILE`` variable used by
+  Kbuild. This will be the prefix for the toolchain
+  binaries such as GCC. For example:
+
+  - ``sparc64-linux-gnu`` if we have the sparc toolchain installed on
+    our system.
+
+  - ``$HOME/toolchains/microblaze/gcc-9.2.0-nolibc/microblaze-linux/bin/microblaze-linux``
+    if we have downloaded the microblaze toolchain from the 0-day
+    website to a specified path in our home directory called toolchains.
+
+- ``--qemu_config``: Specifies the path to the file containing a
+  custom qemu architecture definition. This should be a python file
+  containing a QemuArchParams object.
+
+- ``--qemu_args``: Specifies additional QEMU arguments, for example, "-smp 8".
+
+- ``--jobs``: Specifies the number of jobs (commands) to run simultaneously.
+  By default, this is set to the number of cores on your system.
+
+- ``--timeout``: Specifies the maximum number of seconds allowed for all tests to run.
+  This does not include the time taken to build the tests.
+
+- ``--kernel_args``: Specifies the kernel command-line arguments. Might be repeated.
+
+- ``--run_isolated``: If set, boots the kernel for each individual suite/test.
+  This is useful for debugging a non-hermetic test, one that
+  might pass/fail based on what ran before it.
+
+- ``--raw_output``: If set, generates unformatted output from kernel.
+  If set to ``--raw_output=kunit``, filters to just KUnit output.
+
+- ``--json``: If set, it stores the test results in a JSON format and prints to stdout or
+  saves to a file if a filename is specified.
-- 
2.37.0.170.g444d1eabd0-goog

