Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E30B59B797
	for <lists+linux-kselftest@lfdr.de>; Mon, 22 Aug 2022 04:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbiHVCae (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 21 Aug 2022 22:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbiHVCa0 (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 21 Aug 2022 22:30:26 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C7B20BD4;
        Sun, 21 Aug 2022 19:30:24 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id m66so9759413vsm.12;
        Sun, 21 Aug 2022 19:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=GSefg8YQpT3u9+pfohwKASBnhhYqGoMiDllFOEHH9aU=;
        b=SBOe5pELxeIq/knY/Op1ceMEXVmx64inaD3aGG+1Y4AbrA9/L9KZLELlkMoEfd3yO/
         SQ1VCAcsVZHlKfIcSYkwt3EEg5Ort4lu4x0D1sPEko/H21DtJQuqkGLfArO18OUYsHBY
         Vx3rqns4fpGiFPJevcWVqXBz7JPHysnoYPTJOIH4KMtCviq0krNvAR4IXv5UvmQN1vH0
         xPv2UPeQohk1VfzOQuzXwKf5StHUTf1m7VPuPZKrlbq4BUqclpsngVk7QEIBUqooOEM5
         YcF1tC0/Oz/6kapRR62QSwSBr0PCmSyAXV62Zst4miHuor4nCMZYjlKrQa1rxiE7fXMC
         RNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=GSefg8YQpT3u9+pfohwKASBnhhYqGoMiDllFOEHH9aU=;
        b=nEK1Fu3G63cKSIblEMYSHCZUg3WmYp10IJYEis3r9lIlml8ZBjdC7NxC2tD5dTbWFW
         wcGfErvYSHSAop6lbTrnDvRuF3xgzjiowvUUXEnyj9hmB3OsRTwCVU52bZq4+I1UqOzD
         4OaiFiZ5/jsOj1+PWwz/oi3qZer8dT/HXf4Qo65x3XrJwozKmyBMTVIv/VZViWnnjUQn
         nno0nSDCmn4HboCjt/lac10yZq46B+8EiR8Chcw4KGtU5YzIjyxRQPthn3uhan60ATav
         NkkOvEEbIkpalfhvAhMunPkVqRhfHx7f/bgz4xjAa29Qh4EHAgU1zcmbmeZ+s9iXigLG
         fLiA==
X-Gm-Message-State: ACgBeo1hzWFeu2mhWculyl5zGY00QInDhniGn3QF4DH+nO8Q8G89LgaX
        5Ca2PtMJLay6ZN13/WVXc5c=
X-Google-Smtp-Source: AA6agR683sDaDUjlcVNCqb8ALf1tjoGLjcOXWOTwlJ7Zz3wm0jS5GHJoILsbh1CrBrtfP8VWXzYO6Q==
X-Received: by 2002:a05:6102:390d:b0:387:78b9:bf9c with SMTP id e13-20020a056102390d00b0038778b9bf9cmr6679441vsu.43.1661135423525;
        Sun, 21 Aug 2022 19:30:23 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:4c2:8202::1001])
        by smtp.gmail.com with ESMTPSA id y125-20020a1f3283000000b00378fe8518dcsm8330853vky.51.2022.08.21.19.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 19:30:23 -0700 (PDT)
From:   Tales Aparecida <tales.aparecida@gmail.com>
To:     Sadiya Kazi <sadiyakazi@google.com>
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
        davidgow@google.com, corbet@lwn.net, brendan.higgins@linux.dev,
        Trevor Woerner <twoerner@gmail.com>, siqueirajordao@riseup.net,
        mwen@igalia.com, andrealmeid@riseup.net, mairacanal@riseup.net,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com
Subject: [PATCH v2 1/8] Documentation: KUnit: remove duplicated docs for kunit_tool
Date:   Sun, 21 Aug 2022 23:26:39 -0300
Message-Id: <20220822022646.98581-2-tales.aparecida@gmail.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220822022646.98581-1-tales.aparecida@gmail.com>
References: <20220822022646.98581-1-tales.aparecida@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Delete "kunit-tool.rst" to remove repeated info from KUnit docs.
"What is kunit_tool?" was integrated into index.rst, the remaining
sections were moved into run_wrapper.rst and renamed as follows:

"What is a .kunitconfig?" -> "Creating a ``.kunitconfig`` file"
"Getting Started with kunit_tool" -> "Running tests with kunit_tool"
"Configuring, Building, and Running Tests" ->
	"Configuring, building, and running tests"
"Running Tests on QEMU" -> "Running tests on QEMU"
"Parsing Test Results" -> "Parsing test results"
"Filtering Tests" -> "Filtering tests"
"Other Useful Options" -> "Running command-line arguments"

Signed-off-by: Tales Aparecida <tales.aparecida@gmail.com>
Reviewed-by: Sadiya Kazi <sadiyakazi@google.com>

---
Notes:
    Update titles on run_wrapper.rst (Sadiya Kazi)
---
 Documentation/dev-tools/kunit/index.rst       |   3 -
 Documentation/dev-tools/kunit/kunit-tool.rst  | 232 ------------------
 Documentation/dev-tools/kunit/run_wrapper.rst |  32 +--
 Documentation/dev-tools/kunit/start.rst       |   2 -
 4 files changed, 16 insertions(+), 253 deletions(-)
 delete mode 100644 Documentation/dev-tools/kunit/kunit-tool.rst

diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
index bc91ad7b8961..d7187282ba28 100644
--- a/Documentation/dev-tools/kunit/index.rst
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -13,7 +13,6 @@ KUnit - Linux Kernel Unit Testing
 	run_wrapper
 	run_manual
 	usage
-	kunit-tool
 	api/index
 	style
 	faq
@@ -109,7 +108,5 @@ How do I use it?
     examples.
 *   Documentation/dev-tools/kunit/api/index.rst - KUnit APIs
     used for testing.
-*   Documentation/dev-tools/kunit/kunit-tool.rst - kunit_tool helper
-    script.
 *   Documentation/dev-tools/kunit/faq.rst - KUnit common questions and
     answers.
diff --git a/Documentation/dev-tools/kunit/kunit-tool.rst b/Documentation/dev-tools/kunit/kunit-tool.rst
deleted file mode 100644
index ae52e0f489f9..000000000000
--- a/Documentation/dev-tools/kunit/kunit-tool.rst
+++ /dev/null
@@ -1,232 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-=================
-kunit_tool How-To
-=================
-
-What is kunit_tool?
-===================
-
-kunit_tool is a script (``tools/testing/kunit/kunit.py``) that aids in building
-the Linux kernel as UML (`User Mode Linux
-<http://user-mode-linux.sourceforge.net/>`_), running KUnit tests, parsing
-the test results and displaying them in a user friendly manner.
-
-kunit_tool addresses the problem of being able to run tests without needing a
-virtual machine or actual hardware with User Mode Linux. User Mode Linux is a
-Linux architecture, like ARM or x86; however, unlike other architectures it
-compiles the kernel as a standalone Linux executable that can be run like any
-other program directly inside of a host operating system. To be clear, it does
-not require any virtualization support: it is just a regular program.
-
-What is a .kunitconfig?
-=======================
-
-It's just a defconfig that kunit_tool looks for in the build directory
-(``.kunit`` by default).  kunit_tool uses it to generate a .config as you might
-expect. In addition, it verifies that the generated .config contains the CONFIG
-options in the .kunitconfig; the reason it does this is so that it is easy to
-be sure that a CONFIG that enables a test actually ends up in the .config.
-
-It's also possible to pass a separate .kunitconfig fragment to kunit_tool,
-which is useful if you have several different groups of tests you wish
-to run independently, or if you want to use pre-defined test configs for
-certain subsystems.
-
-Getting Started with kunit_tool
-===============================
-
-If a kunitconfig is present at the root directory, all you have to do is:
-
-.. code-block:: bash
-
-	./tools/testing/kunit/kunit.py run
-
-However, you most likely want to use it with the following options:
-
-.. code-block:: bash
-
-	./tools/testing/kunit/kunit.py run --timeout=30 --jobs=`nproc --all`
-
-- ``--timeout`` sets a maximum amount of time to allow tests to run.
-- ``--jobs`` sets the number of threads to use to build the kernel.
-
-.. note::
-	This command will work even without a .kunitconfig file: if no
-	.kunitconfig is present, a default one will be used instead.
-
-If you wish to use a different .kunitconfig file (such as one provided for
-testing a particular subsystem), you can pass it as an option.
-
-.. code-block:: bash
-
-	./tools/testing/kunit/kunit.py run --kunitconfig=fs/ext4/.kunitconfig
-
-For a list of all the flags supported by kunit_tool, you can run:
-
-.. code-block:: bash
-
-	./tools/testing/kunit/kunit.py run --help
-
-Configuring, Building, and Running Tests
-========================================
-
-It's also possible to run just parts of the KUnit build process independently,
-which is useful if you want to make manual changes to part of the process.
-
-A .config can be generated from a .kunitconfig by using the ``config`` argument
-when running kunit_tool:
-
-.. code-block:: bash
-
-	./tools/testing/kunit/kunit.py config
-
-Similarly, if you just want to build a KUnit kernel from the current .config,
-you can use the ``build`` argument:
-
-.. code-block:: bash
-
-	./tools/testing/kunit/kunit.py build
-
-And, if you already have a built UML kernel with built-in KUnit tests, you can
-run the kernel and display the test results with the ``exec`` argument:
-
-.. code-block:: bash
-
-	./tools/testing/kunit/kunit.py exec
-
-The ``run`` command which is discussed above is equivalent to running all three
-of these in sequence.
-
-All of these commands accept a number of optional command-line arguments. The
-``--help`` flag will give a complete list of these, or keep reading this page
-for a guide to some of the more useful ones.
-
-Parsing Test Results
-====================
-
-KUnit tests output their results in TAP (Test Anything Protocol) format.
-kunit_tool will, when running tests, parse this output and print a summary
-which is much more pleasant to read. If you wish to look at the raw test
-results in TAP format, you can pass the ``--raw_output`` argument.
-
-.. code-block:: bash
-
-	./tools/testing/kunit/kunit.py run --raw_output
-
-The raw output from test runs may contain other, non-KUnit kernel log
-lines. You can see just KUnit output with ``--raw_output=kunit``:
-
-.. code-block:: bash
-
-	./tools/testing/kunit/kunit.py run --raw_output=kunit
-
-If you have KUnit results in their raw TAP format, you can parse them and print
-the human-readable summary with the ``parse`` command for kunit_tool. This
-accepts a filename for an argument, or will read from standard input.
-
-.. code-block:: bash
-
-	# Reading from a file
-	./tools/testing/kunit/kunit.py parse /var/log/dmesg
-	# Reading from stdin
-	dmesg | ./tools/testing/kunit/kunit.py parse
-
-This is very useful if you wish to run tests in a configuration not supported
-by kunit_tool (such as on real hardware, or an unsupported architecture).
-
-Filtering Tests
-===============
-
-It's possible to run only a subset of the tests built into a kernel by passing
-a filter to the ``exec`` or ``run`` commands. For example, if you only wanted
-to run KUnit resource tests, you could use:
-
-.. code-block:: bash
-
-	./tools/testing/kunit/kunit.py run 'kunit-resource*'
-
-This uses the standard glob format for wildcards.
-
-Running Tests on QEMU
-=====================
-
-kunit_tool supports running tests on QEMU as well as via UML (as mentioned
-elsewhere). The default way of running tests on QEMU requires two flags:
-
-``--arch``
-	Selects a collection of configs (Kconfig as well as QEMU configs
-	options, etc) that allow KUnit tests to be run on the specified
-	architecture in a minimal way; this is usually not much slower than
-	using UML. The architecture argument is the same as the name of the
-	option passed to the ``ARCH`` variable used by Kbuild. Not all
-	architectures are currently supported by this flag, but can be handled
-	by the ``--qemu_config`` discussed later. If ``um`` is passed (or this
-	this flag is ignored) the tests will run via UML. Non-UML architectures,
-	e.g. i386, x86_64, arm, um, etc. Non-UML run on QEMU.
-
-``--cross_compile``
-	Specifies the use of a toolchain by Kbuild. The argument passed here is
-	the same passed to the ``CROSS_COMPILE`` variable used by Kbuild. As a
-	reminder this will be the prefix for the toolchain binaries such as gcc
-	for example ``sparc64-linux-gnu-`` if you have the sparc toolchain
-	installed on your system, or
-	``$HOME/toolchains/microblaze/gcc-9.2.0-nolibc/microblaze-linux/bin/microblaze-linux-``
-	if you have downloaded the microblaze toolchain from the 0-day website
-	to a directory in your home directory called ``toolchains``.
-
-In many cases it is likely that you may want to run an architecture which is
-not supported by the ``--arch`` flag, or you may want to just run KUnit tests
-on QEMU using a non-default configuration. For this use case, you can write
-your own QemuConfig. These QemuConfigs are written in Python. They must have an
-import line ``from ..qemu_config import QemuArchParams`` at the top of the file
-and the file must contain a variable called ``QEMU_ARCH`` that has an instance
-of ``QemuArchParams`` assigned to it. An example can be seen in
-``tools/testing/kunit/qemu_configs/x86_64.py``.
-
-Once you have a QemuConfig you can pass it into kunit_tool using the
-``--qemu_config`` flag; when used this flag replaces the ``--arch`` flag. If we
-were to do this with the ``x86_64.py`` example from above, the invocation would
-look something like this:
-
-.. code-block:: bash
-
-	./tools/testing/kunit/kunit.py run \
-		--timeout=60 \
-		--jobs=12 \
-		--qemu_config=./tools/testing/kunit/qemu_configs/x86_64.py
-
-Other Useful Options
-====================
-
-kunit_tool has a number of other command-line arguments which can be useful
-when adapting it to fit your environment or needs.
-
-Some of the more useful ones are:
-
-``--help``
-	Lists all of the available options. Note that different commands
-	(``config``, ``build``, ``run``, etc) will have different supported
-	options. Place ``--help`` before the command to list common options,
-	and after the command for options specific to that command.
-
-``--build_dir``
-	Specifies the build directory that kunit_tool will use. This is where
-	the .kunitconfig file is located, as well as where the .config and
-	compiled kernel will be placed. Defaults to ``.kunit``.
-
-``--make_options``
-	Specifies additional options to pass to ``make`` when compiling a
-	kernel (with the ``build`` or ``run`` commands). For example, to enable
-	compiler warnings, you can pass ``--make_options W=1``.
-
-``--alltests``
-        Builds a UML kernel with all config options enabled using ``make
-        allyesconfig``. This allows you to run as many tests as is possible,
-        but is very slow and prone to breakage as new options are added or
-        modified. In most cases, enabling all tests which have satisfied
-        dependencies by adding ``CONFIG_KUNIT_ALL_TESTS=1`` to your
-        .kunitconfig is preferable.
-
-There are several other options (and new ones are often added), so do check
-``--help`` if you're looking for something not mentioned here.
diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/dev-tools/kunit/run_wrapper.rst
index a1070def284f..518cf87ea732 100644
--- a/Documentation/dev-tools/kunit/run_wrapper.rst
+++ b/Documentation/dev-tools/kunit/run_wrapper.rst
@@ -1,8 +1,8 @@
 .. SPDX-License-Identifier: GPL-2.0
 
-=========================
-Run Tests with kunit_tool
-=========================
+=============================
+Running tests with kunit_tool
+=============================
 
 We can either run KUnit tests using kunit_tool or can run tests
 manually, and then use kunit_tool to parse the results. To run tests
@@ -58,8 +58,8 @@ To view kunit_tool flags (optional command-line arguments), run:
 
 	./tools/testing/kunit/kunit.py run --help
 
-Create a  ``.kunitconfig`` File
-===============================
+Creating a ``.kunitconfig`` file
+================================
 
 If we want to run a specific set of tests (rather than those listed
 in the KUnit ``defconfig``), we can provide Kconfig options in the
@@ -98,8 +98,8 @@ have not included the options dependencies.
    The build dir needs to be set for ``make menuconfig`` to
    work, therefore  by default use ``make O=.kunit menuconfig``.
 
-Configure, Build, and Run Tests
-===============================
+Configuring, building, and running tests
+========================================
 
 If we want to make manual changes to the KUnit build process, we
 can run part of the KUnit build process independently.
@@ -125,11 +125,11 @@ argument:
 
 	./tools/testing/kunit/kunit.py exec
 
-The ``run`` command discussed in section: **Run Tests with kunit_tool**,
+The ``run`` command discussed in section: **Running tests with kunit_tool**,
 is equivalent to running the above three commands in sequence.
 
-Parse Test Results
-==================
+Parsing test results
+====================
 
 KUnit tests output displays results in TAP (Test Anything Protocol)
 format. When running tests, kunit_tool parses this output and prints
@@ -152,8 +152,8 @@ standard input.
 	# Reading from stdin
 	dmesg | ./tools/testing/kunit/kunit.py parse
 
-Run Selected Test Suites
-========================
+Filtering tests
+===============
 
 By passing a bash style glob filter to the ``exec`` or ``run``
 commands, we can run a subset of the tests built into a kernel . For
@@ -167,8 +167,8 @@ This uses the standard glob format with wildcard characters.
 
 .. _kunit-on-qemu:
 
-Run Tests on qemu
-=================
+Running tests on QEMU
+=====================
 
 kunit_tool supports running tests on  qemu as well as
 via UML. To run tests on qemu, by default it requires two flags:
@@ -231,8 +231,8 @@ as
 		--jobs=12 \
 		--qemu_config=./tools/testing/kunit/qemu_configs/x86_64.py
 
-Command-Line Arguments
-======================
+Running command-line arguments
+==============================
 
 kunit_tool has a number of other command-line arguments which can
 be useful for our test environment. Below are the most commonly used
diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index 867a4bba6bf6..e730df1f468e 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -254,7 +254,5 @@ Next Steps
     examples.
 *   Documentation/dev-tools/kunit/api/index.rst - KUnit APIs
     used for testing.
-*   Documentation/dev-tools/kunit/kunit-tool.rst - kunit_tool helper
-    script.
 *   Documentation/dev-tools/kunit/faq.rst - KUnit common questions and
     answers.
-- 
2.37.2

