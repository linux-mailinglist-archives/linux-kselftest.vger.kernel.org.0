Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDF2D580A39
	for <lists+linux-kselftest@lfdr.de>; Tue, 26 Jul 2022 06:13:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiGZENR (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Tue, 26 Jul 2022 00:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiGZENQ (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Tue, 26 Jul 2022 00:13:16 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C44205E4
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Jul 2022 21:13:13 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id j10-20020a62b60a000000b0052b30f6626bso4394385pff.17
        for <linux-kselftest@vger.kernel.org>; Mon, 25 Jul 2022 21:13:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=VOgQF+G8SNdxv9KXxlnj8cWs1UtKcyFM/CeLPL1cf7A=;
        b=qLZlSfzMGHj5dcZe2ZQFJyIeQ06FEbm0g27vehG1XYchRmx7b7dFsEJRhLVb8BUQZF
         0JgQCGyPdVEFFFuhga7lHZebVqdL5fe8YG1dAlgsvgJkgDsmkHNXBtOr4pewYVd331GR
         BAtr3f9upswaSut4UsqvHYu/To8Slq2GxHDR/Bp8thuQRHXqCniZqli8OqU1PPIXMKu3
         DweGNS7NoFDDvFSrJTO1egKraeAQ/kM5SE2OuKExQyE2wmO3pVABWgYBIkN5spPdVud9
         fVyrLBerlex3++Ff0OvH3+Vc7rZU/wzxkTmV3lk2i0IJqhpjNRpUFvkBw8mOa6xt1mNs
         3e+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc
         :content-transfer-encoding;
        bh=VOgQF+G8SNdxv9KXxlnj8cWs1UtKcyFM/CeLPL1cf7A=;
        b=Rg8Z74pHX8PGm0gumkZOtRZcy+wpO/pnSl5SyIcKglokgS9wTAdXEn12igzMfoLnSG
         3grxHsTeNs4+4fXAOGPjeKIBpTb5SC4lDAnRrhQxzQt2s7Am5hjAc9k3W6qs6p6I9HCc
         2Wieo7dvVSwpDGJtH+jU+fD81B4xCrjQdgLCKZfoPId6OoTQ+eFI5hUcISKJzBhjZ2bB
         jIMsAk0lWEEgSmY0wTKTnpQ15pbglEPR1a9fpoLfLwFG4D9vs5CADz/ubbulyjLDqAFp
         CGCB/EUZPEWsksLqDJRqXbl+jJGX0jx3LRZGx4BT42HvGJY/iLoWy9f2HIu2GmJ78NMB
         Ohzw==
X-Gm-Message-State: AJIora9JeApj2w2JcSt4Z901gxqKoKKHjzvw0nV/KH6jaYhiQRdLPh0F
        HnyDDdGnQDM2wuZtBxICtye+NyN5BfmEdJA0
X-Google-Smtp-Source: AGRyM1vg1d/+z8ikDa8GdVjfcnaomA/orA9VGjZIdsqU/f5WKSvEZAKhcNt2ka+zCtEWu5HA4j956NpCVzrAQJai
X-Received: from skazigti.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:411e])
 (user=sadiyakazi job=sendgmr) by 2002:a17:90b:3509:b0:1f2:dc98:5976 with SMTP
 id ls9-20020a17090b350900b001f2dc985976mr4344862pjb.154.1658808792908; Mon,
 25 Jul 2022 21:13:12 -0700 (PDT)
Date:   Tue, 26 Jul 2022 04:12:50 +0000
Message-Id: <20220726041250.1905521-1-sadiyakazi@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.359.gd136c6c3e2-goog
Subject: [PATCH v4] Documentation: kunit: Add CLI args for kunit_tool
From:   Sadiya Kazi <sadiyakazi@google.com>
To:     brendanhiggins@google.com, davidgow@google.com,
        skhan@linuxfoundation.org, corbet@lwn.net, mairacanal@riseup.net
Cc:     Sadiya Kazi <sadiyakazi@google.com>,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Daniel Latypov <dlatypov@google.com>
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

Some kunit_tool command line arguments are missing in run_wrapper.rst.
Document them.

Reported-by: Bagas Sanjaya <bagasdotme@gmail.com>
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: David Gow <davidgow@google.com>
Reviewed-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Daniel Latypov <dlatypov@google.com>
Reviewed-by: Ma=C3=ADra Canal <mairacanal@riseup.net>
Signed-off-by: Sadiya Kazi <sadiyakazi@google.com>
---

Changes since v3:
https://lore.kernel.org/linux-kselftest/20220724184758.1723925-1-sadiyakazi=
@google.com/
-Fixed the indention bug in the run_wrapper.rst file. Thanks for
catching that(Kernel test robot, Bagas).
-Updated the commit message.

Changes since v2:
https://lore.kernel.org/linux-kselftest/20220721081026.1247067-1-sadiyakazi=
@google.com/
-Added a code block for =E2=80=94kconfig_add argument to make the styling c=
onsistent
-Slightly changed the words for =E2=80=94arch argument
-Changed QEMU to qemu wherever applicable for the cli args
-Changed the style for ``-smp 8``
-Changed "Might be repeated" to "may be repeated=E2=80=9D for kernel_args

Changes since V1:
https://lore.kernel.org/linux-kselftest/20220719092214.995965-1-sadiyakazi@=
google.com/
- Addressed most of the review comments from Maira and David, except
  removing the duplicate arguments as I felt its worth keeping them in
  the reference documentation as well as in context. We can improve them
  and differentiate their use cases in the future patches.

---
 Documentation/dev-tools/kunit/run_wrapper.rst | 63 ++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/=
dev-tools/kunit/run_wrapper.rst
index 5e560f2c5fca..cce203138fb7 100644
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
@@ -257,3 +257,64 @@ command line arguments:
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
+
+  .. code-block::
+
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

