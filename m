Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9BD361848
	for <lists+linux-kselftest@lfdr.de>; Fri, 16 Apr 2021 05:40:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238156AbhDPDlJ (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 15 Apr 2021 23:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234816AbhDPDlI (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 15 Apr 2021 23:41:08 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A410CC061574
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Apr 2021 20:40:44 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id w3-20020a05621412e3b029019a7b97dd69so3201875qvv.14
        for <linux-kselftest@vger.kernel.org>; Thu, 15 Apr 2021 20:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=bRyPvMWK8Npj/WYtdOVLc9Ru8MoKLbscf5g6mUndbAg=;
        b=ZnE47k/XeM5jw10N2+TjSDQ+5rqO60/RnWyfxxRNp4pfrPol2syJpwtb4AS3nxjzn0
         tkTsL0aZkhWjWdB1cnjAHRza041HRsJNZJO7k+qJcoC3EtMLX9Bvwhh5It/QUe6+JHFq
         JWkFAyxq3unYO1xE6YFvLsLHGH0HldREA1VuzCMjOIv0zuYi57ejl3AEFc37ZW+dZpEN
         02L2ocL1lVs9RmhTBEoPN2Fh+BRH/GVKpxKRl2/+Y1/KhBaq1ScYxYMSOJRMga2VIZ3J
         n4YWeT9adyz6UXgFMrjqt4OU9XQr7hKbgxcbFZHr6a6O2tVQPiFiM7ozYe3mBujjFlF0
         hofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=bRyPvMWK8Npj/WYtdOVLc9Ru8MoKLbscf5g6mUndbAg=;
        b=rE5UGzfOOghdYE2XamRnxbF+O/u/AN9p7X/CIh5XsYK5HvwuPzIwno4x5R7P+VyKYW
         uhRBZCPsT2RZNN05Ja+Z1peDcpEfumSythqD4gK1SKMvNomMMjf9reGFU+BuhYcCZa3/
         YjvKGULonYZaP1w4RSJ6FkjtnX0gDOJf8BTrO+uKahDpDrYzk/NZ+JtC4PmJMcqtTQPN
         QQKofUoNQbohOZBhI39M9X/yMiKU9cytvL1mZ794CUuYIofp7UN69tKy7O0q6Fe0fmn2
         f+7xpz9HGktw2eXy9v/f5bGpE02cjgxQU9n+OZ6RXfbLtviT4zn+ZaAYN90+hFPRQ8r7
         qKUg==
X-Gm-Message-State: AOAM530dtFmsCWGr8NRc8UMo2dwwNqmPHs4NzWkVOERLzAPJHwbOKJHu
        JDw+TdnXEaGB+RT4jvo/2Gk88kbmyouExA==
X-Google-Smtp-Source: ABdhPJxJWCxoSgcosSmI6fhw0zEyXaKUhP3fuvEBiDcw/YbDSJXKrOiF6qwW04sAamc/mK53Yo9uHhvQFPNGSA==
X-Received: from spirogrip.svl.corp.google.com ([2620:15c:2cb:201:fe36:58a6:c432:3234])
 (user=davidgow job=sendgmr) by 2002:a0c:c3cd:: with SMTP id
 p13mr6790575qvi.4.1618544443832; Thu, 15 Apr 2021 20:40:43 -0700 (PDT)
Date:   Thu, 15 Apr 2021 20:40:36 -0700
Message-Id: <20210416034036.797727-1-davidgow@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.1.368.gbe11c130af-goog
Subject: [PATCH] Documentation: kunit: Update kunit_tool page
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
---
 Documentation/dev-tools/kunit/kunit-tool.rst | 132 ++++++++++++++++++-
 1 file changed, 128 insertions(+), 4 deletions(-)

diff --git a/Documentation/dev-tools/kunit/kunit-tool.rst b/Documentation/dev-tools/kunit/kunit-tool.rst
index 29ae2fee8123..0b45affcd65c 100644
--- a/Documentation/dev-tools/kunit/kunit-tool.rst
+++ b/Documentation/dev-tools/kunit/kunit-tool.rst
@@ -22,14 +22,19 @@ not require any virtualization support: it is just a regular program.
 What is a .kunitconfig?
 =======================
 
-It's just a defconfig that kunit_tool looks for in the base directory.
+It's just a defconfig that kunit_tool looks for in the build directory.
 kunit_tool uses it to generate a .config as you might expect. In addition, it
 verifies that the generated .config contains the CONFIG options in the
 .kunitconfig; the reason it does this is so that it is easy to be sure that a
 CONFIG that enables a test actually ends up in the .config.
 
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
+	Builds a UML kernel with all config options enabled using
+	``make allyesconfig``. This allows you to run as many tests as is
+	possible, but is very slow and prone to breakage as new options are
+	added or modified. Most people should add ``CONFIG_KUNIT_ALL_TESTS=1``
+	to their .kunitconfig instead if they wish to run "all tests".
+
+
+There are several other options (and new ones are often added), so do check
+``--help`` if you're looking for something not mentioned here.
-- 
2.31.1.368.gbe11c130af-goog

