Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6037C57F69B
	for <lists+linux-kselftest@lfdr.de>; Sun, 24 Jul 2022 20:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232676AbiGXStf (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 24 Jul 2022 14:49:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbiGXStd (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 24 Jul 2022 14:49:33 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68151DFFE
        for <linux-kselftest@vger.kernel.org>; Sun, 24 Jul 2022 11:49:32 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-317f6128c86so73815577b3.22
        for <linux-kselftest@vger.kernel.org>; Sun, 24 Jul 2022 11:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=CyQL7MKXYchL5tTvsD0JYNk64GMjDP+y6COH4opWt5c=;
        b=K2NrJLardIVtCkzGxfGyx9w1e2G0DqV8NySM2KRf0YX2f0MSi17pGB+ccX3gLyghAm
         kGxEDos9vuwGOOWLNROiY/5KyRpLYNQBi31BLJ9lmThyzhO30UKYrv56fdvYU0BGET3N
         96Q4GKwALa/7Mso6+sGGhzrLXU/7RwviZJHvlxC6R4aBm1sln/RZh/rRJKV27iJ+nQJ4
         9EcaUBIC0Ty+fcKleQ3zriOi61B5YaomxY6DBO3H7gmwI5t2R0Mjay61zY8GgoXflfIF
         NyGL6aNG/itTJj1kP53lyeuyPLJADvyqIAx4ExskkNpRZvuQzgEOc3Q3SybEOFVX53N5
         APtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=CyQL7MKXYchL5tTvsD0JYNk64GMjDP+y6COH4opWt5c=;
        b=yFphT3W0hiRyr1+rds421vJqAJHNe/aaqP+vmb7AwffPZfwrcLEH/S8SvbM2IhyyZx
         qBor5PcWn3N+JGwElMhA/rkDrxVVczdRcMjwRsszz13ivyw/07KONq/f4ON/+ait2qAT
         Imerh5dEs4+9oeSv2SHRfxCpSv0pChe1/84HcjPxmAODiXiLXoih55k4MdBC6sOlzCqE
         /rAm7Cl5v1Mr8aOwHrmDzj1osYiRREo4qNTVeFUOV1jene0PsZF/5me0NWCpCyFLKDbn
         I+AVPHpS+VGoH3ScmRrZgWsrvXz3DcoQw5yH4a22FiEeu0Q9D6RZT4cYwnuvkKH2zN3n
         pv3g==
X-Gm-Message-State: AJIora+KYpL06SBhOuOE8GgYkjxZQy2IHHFqDzF/SrT9FnaF1yUkG+R6
        X2nxXHC5DYh8VfXBtk6uBUu7yizZ9SlCgYlc
X-Google-Smtp-Source: AGRyM1tDodNaX42YIwcy2DTouI3cFX/Tf78qtdwkGH4a003LwEodYVqIB2UmB0DXTxg8beRYHlhQ/9ZGfAYMhnI1
X-Received: from skazigti.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:411e])
 (user=sadiyakazi job=sendgmr) by 2002:a81:5404:0:b0:31c:c24d:94b0 with SMTP
 id i4-20020a815404000000b0031cc24d94b0mr7175739ywb.502.1658688571667; Sun, 24
 Jul 2022 11:49:31 -0700 (PDT)
Date:   Sun, 24 Jul 2022 18:47:59 +0000
Message-Id: <20220724184758.1723925-1-sadiyakazi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v3] Documentation: kunit: Add CLI args for kunit_tool
From:   Sadiya Kazi <sadiyakazi@google.com>
To:     brendanhiggins@google.com, davidgow@google.com,
        skhan@linuxfoundation.org, corbet@lwn.net, mairacanal@riseup.net
Cc:     Sadiya Kazi <sadiyakazi@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
additional args in the file.

Signed-off-by: Sadiya Kazi <sadiyakazi@google.com>
---
Changes since v2:
https://lore.kernel.org/linux-kselftest/20220721081026.1247067-1-sadiyakazi=
@google.com/
-Added a code block for =E2=80=94kconfig_add argument to make the styling c=
onsistent
-Slightly changed the words for =E2=80=94arch argument
-Changed QEMU to qemu wherever applicable for the cli args
-Changed the style for ``-smp 8``
-Changed "Might be repeated" to "may be repeated=E2=80=9D for kernel_args



---
 Documentation/dev-tools/kunit/run_wrapper.rst | 61 ++++++++++++++++++-
 1 file changed, 60 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/=
dev-tools/kunit/run_wrapper.rst
index 5e560f2c5fca..ed3715fef32d 100644
--- a/Documentation/dev-tools/kunit/run_wrapper.rst
+++ b/Documentation/dev-tools/kunit/run_wrapper.rst
@@ -233,7 +233,7 @@ Command-Line Arguments
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
 kunit_tool has a number of other command-line arguments which can
-be useful for our test environment. Below the most commonly used
+be useful for our test environment. Below are the most commonly used
 command line arguments:
=20
 - ``--help``: Lists all available options. To list common options,
@@ -257,3 +257,62 @@ command line arguments:
             added or modified. Instead, enable all tests
             which have satisfied dependencies by adding
             ``CONFIG_KUNIT_ALL_TESTS=3Dy`` to your ``.kunitconfig``.
+
+- ``--kunitconfig``: Specifies the path or the directory of the ``.kunitco=
nfig``
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
+  appended to the ``.kunitconfig`` file. For example:
+  .. code-block::
+	./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_KASAN=3Dy
+
+- ``--arch``: Runs tests on the specified architecture. The architecture
+  argument is same as the Kbuild ARCH environment variable.
+  For example, i386, x86_64, arm, um, etc. Non-UML architectures run on qe=
mu.
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
+  - ``$HOME/toolchains/microblaze/gcc-9.2.0-nolibc/microblaze-linux/bin/mi=
croblaze-linux``
+    if we have downloaded the microblaze toolchain from the 0-day
+    website to a specified path in our home directory called toolchains.
+
+- ``--qemu_config``: Specifies the path to a file containing a
+  custom qemu architecture definition. This should be a python file
+  containing a `QemuArchParams` object.
+
+- ``--qemu_args``: Specifies additional qemu arguments, for example, ``-sm=
p 8``.
+
+- ``--jobs``: Specifies the number of jobs (commands) to run simultaneousl=
y.
+  By default, this is set to the number of cores on your system.
+
+- ``--timeout``: Specifies the maximum number of seconds allowed for all t=
ests to run.
+  This does not include the time taken to build the tests.
+
+- ``--kernel_args``: Specifies additional kernel command-line arguments. M=
ay be repeated.
+
+- ``--run_isolated``: If set, boots the kernel for each individual suite/t=
est.
+  This is useful for debugging a non-hermetic test, one that
+  might pass/fail based on what ran before it.
+
+- ``--raw_output``: If set, generates unformatted output from kernel. Poss=
ible options are:
+
+   - ``all``: To view the full kernel output, use ``--raw_output=3Dall``.
+
+   - ``kunit``: This is the default option and filters to KUnit output. Us=
e ``--raw_output`` or ``--raw_output=3Dkunit``.
+
+- ``--json``: If set, stores the test results in a JSON format and prints =
to `stdout` or
+  saves to a file if a filename is specified.
--=20
2.37.1.359.gd136c6c3e2-goog

