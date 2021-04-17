Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25832362D5F
	for <lists+linux-kselftest@lfdr.de>; Sat, 17 Apr 2021 05:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235589AbhDQDqX (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 16 Apr 2021 23:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234999AbhDQDqX (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Apr 2021 23:46:23 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8BEC061574
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Apr 2021 20:45:57 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id u73-20020a25ab4f0000b0290410f38a2f81so855321ybi.22
        for <linux-kselftest@vger.kernel.org>; Fri, 16 Apr 2021 20:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=DwfZ6Wi0V5teVjChDKKISP6jFpDU0ASTBwZn9CpapWY=;
        b=YY9cghOZEU4tRYcLmU/Ul1HlY8NfrG8ZUTScwggfUTK7dFpM0nMTPLaKcavTo769pt
         yyLJpEYJ7Pb7PYNfCqZFaqUemCzDpvY+Js40EHuGJ5DB4cSRCsJIL65xeuzEb8JiAzd4
         qij0gag9alXE9MIHBZzBSo2oEb0ulyJ4t6pBHAbhx1beedGLuZ9VsuBRFoFUHwFx4kww
         anm+XdoduyejZSWnrUWT+/OV6yMiFKf37EilqHuLzFfoR2tYM8iaizA4fA0vpDEJHRX7
         RAN+LbUdoa78Oht962NNMr5KaEoNZ7kNBPJvw6tvqGOMaoA99iaINzUVolykxnYqDLSw
         usPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=DwfZ6Wi0V5teVjChDKKISP6jFpDU0ASTBwZn9CpapWY=;
        b=kOKKUhuRyfHVyjEL6oRsl35+v0mmKB4jgimuxpD9gAhzRw+pO0KwwXz072rkZ86TuG
         SYdM/KNQGPgrCKzfZWLF0wQsoWLPqQTm6r913f0eXhjFhqSsOkTim0Ayw2HO0212SS+p
         qyZrme1brJuvs5dJk+lARqbea4VzcWfnfj9N3TbO6lBb3Lzz4fsOubDLRtllKqbyCfTD
         0I04Be0svHtowMEcD6KeISMC3238c4w/SCdwUPnqvshBeGQ7XUfoHoKu2L/OsA0rtdPL
         TYnxs7p4dHh5Ba/2yBUbfF7tGrWzwfnnwvcfaaYLXVfIVHpVf1z5IA1IPzyemvGdxzNW
         lIxg==
X-Gm-Message-State: AOAM533TQiJp4X5CNQuWALSfR+KKZxXIDfSl1jbu8Yrrrx4knkHBw0bv
        8PYf5pP05tRWKtUKyFDyznZqapLBCptytw==
X-Google-Smtp-Source: ABdhPJwZQrchzW9ElVi2IAqNHV0OFnElQ2XAIX74JNaYPR7mT2w4ryIWjLPeYWLKwxOLYvZGCpgUGg0VdFQ5/w==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:fff4:37a8:7152:cd1f])
 (user=davidgow job=sendgmr) by 2002:a25:e04b:: with SMTP id
 x72mr3279598ybg.337.1618631156641; Fri, 16 Apr 2021 20:45:56 -0700 (PDT)
Date:   Fri, 16 Apr 2021 20:45:53 -0700
Message-Id: <20210417034553.1048895-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH v2] Documentation: kunit: Update kunit_tool page
From:   David Gow <davidgow@google.com>
To:     Daniel Latypov <dlatypov@google.com>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>
Cc:     David Gow <davidgow@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>,
        linux-kselftest@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

The kunit_tool documentation page was pretty minimal, and a bit
outdated. Update it and flesh it out a bit.

In particular,
- Mention that .kunitconfig is now in the build directory
- Describe the use of --kunitconfig to specify a different config
  framgent
- Mention the split functionality (i.e., commands other than 'run')
- Describe --raw_output and kunit.py parse
- Mention the globbing support
- Provide a quick overview of other options, including --build_dir and
  --alltests

Note that this does overlap a little with the new running_tips page. I
don't think it's a problem having both: this page is supposed to be a
bit more of a reference, rather than a list of useful tips, so the fact
that they both describe the same features isn't a problem.

Signed-off-by: David Gow <davidgow@google.com>
Reviewed-by: Daniel Latypov <dlatypov@google.com>
---

Adopted the changes from Daniel.

Changes since v1:
https://lore.kernel.org/linux-kselftest/20210416034036.797727-1-davidgow@google.com/
- Mention that the default build directory is '.kunit' when discussing
  '.kunitconfig' files.
- Reword the discussion of 'CONFIG_KUNIT_ALL_TESTS' under '--alltests'



 Documentation/dev-tools/kunit/kunit-tool.rst | 140 +++++++++++++++++--
 1 file changed, 132 insertions(+), 8 deletions(-)

diff --git a/Documentation/dev-tools/kunit/kunit-tool.rst b/Documentation/dev-tools/kunit/kunit-tool.rst
index 29ae2fee8123..4247b7420e3b 100644
--- a/Documentation/dev-tools/kunit/kunit-tool.rst
+++ b/Documentation/dev-tools/kunit/kunit-tool.rst
@@ -22,14 +22,19 @@ not require any virtualization support: it is just a regular program.
 What is a .kunitconfig?
 =======================
 
-It's just a defconfig that kunit_tool looks for in the base directory.
-kunit_tool uses it to generate a .config as you might expect. In addition, it
-verifies that the generated .config contains the CONFIG options in the
-.kunitconfig; the reason it does this is so that it is easy to be sure that a
-CONFIG that enables a test actually ends up in the .config.
+It's just a defconfig that kunit_tool looks for in the build directory
+(``.kunit`` by default).  kunit_tool uses it to generate a .config as you might
+expect. In addition, it verifies that the generated .config contains the CONFIG
+options in the .kunitconfig; the reason it does this is so that it is easy to
+be sure that a CONFIG that enables a test actually ends up in the .config.
 
-How do I use kunit_tool?
-========================
+It's also possible to pass a separate .kunitconfig fragment to kunit_tool,
+which is useful if you have several different groups of tests you wish
+to run independently, or if you want to use pre-defined test configs for
+certain subsystems.
+
+Getting Started with kunit_tool
+===============================
 
 If a kunitconfig is present at the root directory, all you have to do is:
 
@@ -48,10 +53,129 @@ However, you most likely want to use it with the following options:
 
 .. note::
 	This command will work even without a .kunitconfig file: if no
-        .kunitconfig is present, a default one will be used instead.
+	.kunitconfig is present, a default one will be used instead.
+
+If you wish to use a different .kunitconfig file (such as one provided for
+testing a particular subsystem), you can pass it as an option.
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py run --kunitconfig=fs/ext4/.kunitconfig
 
 For a list of all the flags supported by kunit_tool, you can run:
 
 .. code-block:: bash
 
 	./tools/testing/kunit/kunit.py run --help
+
+Configuring, Building, and Running Tests
+========================================
+
+It's also possible to run just parts of the KUnit build process independently,
+which is useful if you want to make manual changes to part of the process.
+
+A .config can be generated from a .kunitconfig by using the ``config`` argument
+when running kunit_tool:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py config
+
+Similarly, if you just want to build a KUnit kernel from the current .config,
+you can use the ``build`` argument:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py build
+
+And, if you already have a built UML kernel with built-in KUnit tests, you can
+run the kernel and display the test results with the ``exec`` argument:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py exec
+
+The ``run`` command which is discussed above is equivalent to running all three
+of these in sequence.
+
+All of these commands accept a number of optional command-line arguments. The
+``--help`` flag will give a complete list of these, or keep reading this page
+for a guide to some of the more useful ones.
+
+Parsing Test Results
+====================
+
+KUnit tests output their results in TAP (Test Anything Protocol) format.
+kunit_tool will, when running tests, parse this output and print a summary
+which is much more pleasant to read. If you wish to look at the raw test
+results in TAP format, you can pass the ``--raw_output`` argument.
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py run --raw_output
+
+.. note::
+	The raw output from test runs may contain other, non-KUnit kernel log
+	lines.
+
+If you have KUnit results in their raw TAP format, you can parse them and print
+the human-readable summary with the ``parse`` command for kunit_tool. This
+accepts a filename for an argument, or will read from standard input.
+
+.. code-block:: bash
+
+	# Reading from a file
+	./tools/testing/kunit/kunit.py parse /var/log/dmesg
+	# Reading from stdin
+	dmesg | ./tools/testing/kunit/kunit.py parse
+
+This is very useful if you wish to run tests in a configuration not supported
+by kunit_tool (such as on real hardware, or an unsupported architecture).
+
+Filtering Tests
+===============
+
+It's possible to run only a subset of the tests built into a kernel by passing
+a filter to the ``exec`` or ``run`` commands. For example, if you only wanted
+to run KUnit resource tests, you could use:
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py run 'kunit-resource*'
+
+This uses the standard glob format for wildcards.
+
+Other Useful Options
+====================
+
+kunit_tool has a number of other command-line arguments which can be useful
+when adapting it to fit your environment or needs.
+
+Some of the more useful ones are:
+
+``--help``
+	Lists all of the available options. Note that different commands
+	(``config``, ``build``, ``run``, etc) will have different supported
+	options. Place ``--help`` before the command to list common options,
+	and after the command for options specific to that command.
+
+``--build_dir``
+	Specifies the build directory that kunit_tool will use. This is where
+	the .kunitconfig file is located, as well as where the .config and
+	compiled kernel will be placed. Defaults to ``.kunit``.
+
+``--make_options``
+	Specifies additional options to pass to ``make`` when compiling a
+	kernel (with the ``build`` or ``run`` commands). For example, to enable
+	compiler warnings, you can pass ``--make_options W=1``.
+
+``--alltests``
+        Builds a UML kernel with all config options enabled using ``make
+        allyesconfig``. This allows you to run as many tests as is possible,
+        but is very slow and prone to breakage as new options are added or
+        modified. In most cases, enabling all tests which have satisfied
+        dependencies by adding ``CONFIG_KUNIT_ALL_TESTS=1`` to your
+        .kunitconfig is preferable.
+
+There are several other options (and new ones are often added), so do check
+``--help`` if you're looking for something not mentioned here.
-- 
2.31.1.368.gbe11c130af-goog

