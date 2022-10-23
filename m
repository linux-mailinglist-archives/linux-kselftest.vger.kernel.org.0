Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32210609313
	for <lists+linux-kselftest@lfdr.de>; Sun, 23 Oct 2022 14:56:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiJWMz5 (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Sun, 23 Oct 2022 08:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiJWMzp (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Sun, 23 Oct 2022 08:55:45 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE2EB53009;
        Sun, 23 Oct 2022 05:55:36 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id w189so5413827pfw.4;
        Sun, 23 Oct 2022 05:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vpG+SRQgjbwGLK3JR4AvWZbDBzEcpzsUq8C95pBLv3g=;
        b=VXG6ib9kVkqnXksm+4BptaUjV1+QQsQeViQ+alkXZpQQZ1EMIsMS15+2qaKTEG46Lr
         wi2Lslm7KPLXxHZDidOwJ9OCp8Mkg3AnmQeQKJLCPKC4pU2MSY5NQ5pCoHjeBRAkgdAd
         a9GTCcO4bjoTT17Q/sO7EDjk1k31QyfjCR5Q5eLT5Wp8lrlt7/FpnKI6TJVnOe5LkLo8
         mcCPO5RLSzNxb/ltjYLFSXHQVX/U6CuGeuhvq6AghuWTR1syoRL6bIplaC4rXDpwasmx
         8zgJHxEfO7wN+gITeX/AvJmPE6qh2EQknQDHmrFREPNodrXfk5PG3X9PGp3A+fF78ELU
         x2rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vpG+SRQgjbwGLK3JR4AvWZbDBzEcpzsUq8C95pBLv3g=;
        b=ikCdfiplrBrQ/910JJWDjtQOsy8ekwMxEG1u0Mc1yTsQgfXeplt3e9z1ksx6lwdc8v
         BF+hEUwo+Kun780r6CJTk8iFVQ7v1IkgIkYOd2lrTLCwa9eWFbrsLAGIsoEsbrqiDtzX
         Qln1Lwr23jMoOUX2U8kpN1SF8c1UoC/ZvrDWKTvN6Vje9VmzM+SZRFOfpsrSWUmTlokZ
         1tVODSAsPslpZ8yJGneqnYW+DVxNQ9Dr1NlgNq4d2NQ4OO4MTqMOONmj1zO5cuKOCYsF
         3C5eKbd++6L4V1UJCbH1+Vh6xXVGTnYO+EjYgmOP5U8DYMxRCLEOdK7jCNrxfsWo1gwu
         BEbg==
X-Gm-Message-State: ACrzQf1+EFgEBs6F5xfAtxA7SAcflu94gkBJzaTxUcnMhj9uaCVOu4hd
        vsROBa25FXw+BUJl/o+lv5h//y/27RsPiA==
X-Google-Smtp-Source: AMsMyM5KcL3RazCpFInBPWLF0AMXiSN8Zf9aVwuUd9VnHhFkmD+9hEQskagYOEkkvSgIhOkurRka7Q==
X-Received: by 2002:a63:ea48:0:b0:43c:69c4:68d4 with SMTP id l8-20020a63ea48000000b0043c69c468d4mr24389797pgk.416.1666529735247;
        Sun, 23 Oct 2022 05:55:35 -0700 (PDT)
Received: from debian.. (subs02-180-214-232-1.three.co.id. [180.214.232.1])
        by smtp.gmail.com with ESMTPSA id om10-20020a17090b3a8a00b00212daa68b7csm2670639pjb.44.2022.10.23.05.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Oct 2022 05:55:34 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        David Gow <davidgow@google.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Khalid Masum <khalid.masum.92@gmail.com>,
        Sadiya Kazi <sadiyakazi@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 5/7] Documentation: kunit: rewrite "Running tests with kunit_tool"
Date:   Sun, 23 Oct 2022 19:54:12 +0700
Message-Id: <20221023125414.60961-6-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221023125414.60961-1-bagasdotme@gmail.com>
References: <20221023125414.60961-1-bagasdotme@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=18063; i=bagasdotme@gmail.com; h=from:subject; bh=rxjOwzmgDzh9fnwudOgKLwsz0s/nduKdCjKl6wBh20A=; b=owGbwMvMwCH2bWenZ2ig32LG02pJDMmhlnltWY9MFB+sOqGWmeqjENsXPjvje9f02h9rd+15tqb9 x/OwjlIWBjEOBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEzk0lmG/47ut//XVsjN2nTg30JneY NX9ip27zLqw4V/J3+tcutolWVkWCjkZL/zXXl/8r61nyqt605NCeq50da0TDPl7POG0vUMrAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Rewrite the documentation for clarity. Major points:

  * Switch from first-person to second-person point of view
  * The configuration step is now within "Kernel configuration" section
  * Replace description of common options with pointer to running
    --help for commands of the wrapper script

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/dev-tools/kunit/run_wrapper.rst | 302 ++++++------------
 1 file changed, 97 insertions(+), 205 deletions(-)

diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/dev-tools/kunit/run_wrapper.rst
index dafe8eb28d3015..d683580b21d2db 100644
--- a/Documentation/dev-tools/kunit/run_wrapper.rst
+++ b/Documentation/dev-tools/kunit/run_wrapper.rst
@@ -4,21 +4,20 @@
 Running tests with kunit_tool
 =============================
 
-We can either run KUnit tests using kunit_tool or can run tests
-manually, and then use kunit_tool to parse the results. To run tests
-manually, see: Documentation/dev-tools/kunit/run_manual.rst.
-As long as we can build the kernel, we can run KUnit.
+This documentation describes running tests with kunit_tool script.
+If you'd like to manually run tests, see
+Documentation/dev-tools/kunit/run_manual.rst.
 
 kunit_tool is a Python script which configures and builds a kernel, runs
 tests, and formats the test results.
 
-Run command:
+To run the tests:
 
 .. code-block::
 
 	./tools/testing/kunit/kunit.py run
 
-We should see the following:
+You should see the following output:
 
 .. code-block::
 
@@ -26,124 +25,112 @@ We should see the following:
 	Building KUnit kernel...
 	Starting KUnit kernel...
 
-We may want to use the following options:
+You can also specify options to the script when running the tests. For
+example, to run tests utilizing all available CPUs within 30 seconds
+time limit:
 
 .. code-block::
 
 	./tools/testing/kunit/kunit.py run --timeout=30 --jobs=`nproc --all`
 
-- ``--timeout`` sets a maximum amount of time for tests to run.
-- ``--jobs`` sets the number of threads to build the kernel.
+For list of all options, see::
 
-kunit_tool will generate a ``.kunitconfig`` with a default
-configuration, if no other ``.kunitconfig`` file exists
-(in the build directory). In addition, it verifies that the
-generated ``.config`` file contains the ``CONFIG`` options in the
-``.kunitconfig``.
-It is also possible to pass a separate ``.kunitconfig`` fragment to
-kunit_tool. This is useful if we have several different groups of
-tests we want to run independently, or if we want to use pre-defined
-test configs for certain subsystems.
+        ./tools/testing/kunit/kunit.py run --help
+
+Kernel configuration
+====================
+
+kunit_tool will generate kernel configuration named ``.kunitconfig``
+if it doesn't exist in the build directory. For list of selected options by
+default, see ``tools/testing/kunit/configs/default.config`` file.
+
+In addition, it verifies that the synchronized ``.config`` file
+contains options enabled in ``.kunitconfig``. It will errored out if
+you have not enabled option dependencies required by all selected options.
+
+It is also possible to specify different ``.kunitconfig`` to
+kunit_tool. This is useful if you have several different groups of
+tests that you want to run independently, or if you want to use pre-defined
+configurations for certain subsystems.
 
 To use a different ``.kunitconfig`` file (such as one
-provided to test a particular subsystem), pass it as an option:
+provided to test a particular subsystem), specify ``--kunitconfig`` option.
+For example, to run ext4 tests:
 
 .. code-block::
 
 	./tools/testing/kunit/kunit.py run --kunitconfig=fs/ext4/.kunitconfig
 
-To view kunit_tool flags (optional command-line arguments), run:
+Customizing configuration
+-------------------------
 
-.. code-block::
+A ``.kunitconfig`` is a configuration file generated by
+``make savedefconfig``, used for running enabled set of tests. This file
+contains configuration options with specific enabled tests. The file also
+contains any other coptions required by the tests, for example
+dependencies for features under tests, arch-specific configs and so on.
 
-	./tools/testing/kunit/kunit.py run --help
-
-Creating a ``.kunitconfig`` file
-================================
-
-If we want to run a specific set of tests (rather than those listed
-in the KUnit ``defconfig``), we can provide Kconfig options in the
-``.kunitconfig`` file. For default .kunitconfig, see:
-https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/kunit/configs/default.config.
-A ``.kunitconfig`` is a ``minconfig`` (a .config
-generated by running ``make savedefconfig``), used for running a
-specific set of tests. This file contains the regular Kernel configs
-with specific test targets. The ``.kunitconfig`` also
-contains any other config options required by the tests (For example:
-dependencies for features under tests, configs that enable/disable
-certain code blocks, arch configs and so on).
-
-To create a ``.kunitconfig``, using the KUnit ``defconfig``:
+To generate default ``.kunitconfig``:
 
 .. code-block::
 
 	cd $PATH_TO_LINUX_REPO
 	cp tools/testing/kunit/configs/default.config .kunit/.kunitconfig
 
-We can then add any other Kconfig options. For example:
+You can then customize the configuration. As with configuring regular kernels
+for production deployment, it is recommended to use
+:doc:`one of configuration interfaces </kbuild/kconfig>`. For example,
+to configure through menuconfig::
 
-.. code-block::
+	make O=.kunit KCONFIG_CONFIG=.kunit/.kunitconfig menuconfig
 
-	CONFIG_LIST_KUNIT_TEST=y
+.. note::
+   ``.config`` will only be resynchronized if it is the superset of
+   ``.kunitconfig``. Removing any options from the latter will not
+   resynchronize the former. In that case, you need to manually
+   update the former by::
 
-kunit_tool ensures that all config options in ``.kunitconfig`` are
-set in the kernel ``.config`` before running the tests. It warns if we
-have not included the options dependencies.
+        cp .kunitconfig .config
 
-.. note:: Removing something from the ``.kunitconfig`` will
-   not rebuild the ``.config file``. The configuration is only
-   updated if the ``.kunitconfig`` is not a subset of ``.config``.
-   This means that we can use other tools
-   (For example: ``make menuconfig``) to adjust other config options.
-   The build dir needs to be set for ``make menuconfig`` to
-   work, therefore  by default use ``make O=.kunit menuconfig``.
+Step-by-step run
+================
 
-Configuring, building, and running tests
-========================================
+It is possible to sequentially run testing steps for finer-grained control.
 
-If we want to make manual changes to the KUnit build process, we
-can run part of the KUnit build process independently.
-When running kunit_tool, from a ``.kunitconfig``, we can generate a
-``.config`` by using the ``config`` argument:
+First, synchronize ``.config`` from ``.kunitconfig`` that have been
+configured before:
 
 .. code-block::
 
 	./tools/testing/kunit/kunit.py config
 
-To build a KUnit kernel from the current ``.config``, we can use the
-``build`` argument:
+Before the tests can be run, the kernel needs to be built first:
 
 .. code-block::
 
 	./tools/testing/kunit/kunit.py build
 
-If we already have built UML kernel with built-in KUnit tests, we
-can run the kernel, and display the test results with the ``exec``
-argument:
+The whole tests can now be executed:
 
 .. code-block::
 
 	./tools/testing/kunit/kunit.py exec
 
-The ``run`` command discussed in section: **Running tests with kunit_tool**,
-is equivalent to running the above three commands in sequence.
-
 Parsing test results
 ====================
 
-KUnit tests output displays results in TAP (Test Anything Protocol)
-format. When running tests, kunit_tool parses this output and prints
-a summary. To see the raw test results in TAP format, we can pass the
-``--raw_output`` argument:
+KUnit generates test results in TAP (Test Anything Protocol) format. When
+the tests are running, kunit_tool parses the result and prints
+the summary. To see the results in raw TAP format, you can pass
+``--raw_output`` option:
 
 .. code-block::
 
 	./tools/testing/kunit/kunit.py run --raw_output
 
-If we have KUnit results in the raw TAP format, we can parse them and
-print the human-readable summary with the ``parse`` command for
-kunit_tool. This accepts a filename for an argument, or will read from
-standard input.
+Now you can parse the output and print the human-readable summary with the
+``parse`` command. It accepts the filename argument. If none is given, it
+will read from standard input.
 
 .. code-block:: bash
 
@@ -155,74 +142,63 @@ standard input.
 Filtering tests
 ===============
 
-By passing a bash style glob filter to the ``exec`` or ``run``
-commands, we can run a subset of the tests built into a kernel . For
-example: if we only want to run KUnit resource tests, use:
+You can also specify tests using :manpage:`glob(7)` pattern. For example,
+to run resource tests (which are prefixed by ``kunit-resource``):
 
 .. code-block::
 
 	./tools/testing/kunit/kunit.py run 'kunit-resource*'
 
-This uses the standard glob format with wildcard characters.
-
 .. _kunit-on-qemu:
 
 Running tests on QEMU
 =====================
 
-kunit_tool supports running tests on  qemu as well as
-via UML. To run tests on qemu, by default it requires two flags:
+Besides running tests with UML kernel, kunit_wrapper also supports
+running tests on QEMU. Two options are required for this to work:
 
-- ``--arch``: Selects a configs collection (Kconfig, qemu config options
-  and so on), that allow KUnit tests to be run on the specified
-  architecture in a minimal way. The architecture argument is same as
-  the option name passed to the ``ARCH`` variable used by Kbuild.
-  Not all architectures currently support this flag, but we can use
-  ``--qemu_config`` to handle it. If ``um`` is passed (or this flag
-  is ignored), the tests will run via UML. Non-UML architectures,
-  for example: i386, x86_64, arm and so on; run on qemu.
+- ``--arch``: Run tests for the specified architecture. The value will be
+  passed to make as ``ARCH`` environment variable. 
+  Not all architectures currently support this flag. For such architectures,
+  use ``--qemu_config`` instead (discussed later). If ``um`` is specifed (or
+  if this option is not given), the tests will run in UML kernel. Otherwise,
+  the tests run on QEMU.
 
-- ``--cross_compile``: Specifies the Kbuild toolchain. It passes the
-  same argument as passed to the ``CROSS_COMPILE`` variable used by
-  Kbuild. As a reminder, this will be the prefix for the toolchain
-  binaries such as GCC. For example:
+- ``--cross_compile``: Specifies the cross-compiler toolchain prefix.
+  The value will be used for ``CROSS_COMPILE`` environment variable when
+  building the kernel. 
 
-  - ``sparc64-linux-gnu`` if we have the sparc toolchain installed on
-    our system.
+Examples:
 
-  - ``$HOME/toolchains/microblaze/gcc-9.2.0-nolibc/microblaze-linux/bin/microblaze-linux``
-    if we have downloaded the microblaze toolchain from the 0-day
-    website to a directory in our home directory called toolchains.
+  - To run tests for native x86_64 architecture:
 
-This means that for most architectures, running under qemu is as simple as:
-
-.. code-block:: bash
+    .. code-block:: bash
 
 	./tools/testing/kunit/kunit.py run --arch=x86_64
 
-When cross-compiling, we'll likely need to specify a different toolchain, for
-example:
+  - To cross-compile and test for s390:
 
-.. code-block:: bash
+    .. code-block:: bash
 
 	./tools/testing/kunit/kunit.py run \
 		--arch=s390 \
 		--cross_compile=s390x-linux-gnu-
 
-If we want to run KUnit tests on an architecture not supported by
-the ``--arch`` flag, or want to run KUnit tests on qemu using a
-non-default configuration; then we can write our own``QemuConfig``.
-These ``QemuConfigs`` are written in Python. They have an import line
-``from..qemu_config import QemuArchParams`` at the top of the file.
-The file must contain a variable called ``QEMU_ARCH`` that has an
-instance of ``QemuArchParams`` assigned to it. See example in:
-``tools/testing/kunit/qemu_configs/x86_64.py``.
+Custom QEMU configuration
+-------------------------
+If you want to test on an architecture unsupported by the ``--arch`` option,
+or to customize QEMU invocation, you can write ``QemuConfig`` configuration,
+which is written in Python. The file begins with
+:code:`from..qemu_config import QemuArchParams` as import directive.
+The file must contain an object called ``QEMU_ARCH`` which is
+built from ``QemuArchParams`` class.
 
-Once we have a ``QemuConfig``, we can pass it into kunit_tool,
-using the ``--qemu_config`` flag. When used, this flag replaces the
-``--arch`` flag. For example: using
-``tools/testing/kunit/qemu_configs/x86_64.py``, the invocation appear
-as
+Once ``QemuConfig`` have been configured, you can specify the file to
+kunit_tool using the ``--qemu_config`` option. This overrides ``--arch``
+option. 
+
+For example, to specify QEMU configuration for native x86_64 architecture
+with 12 build jobs and 60 seconds timeout:
 
 .. code-block:: bash
 
@@ -231,93 +207,9 @@ as
 		--jobs=12 \
 		--qemu_config=./tools/testing/kunit/qemu_configs/x86_64.py
 
-Running command-line arguments
-==============================
+Command options
+===============
 
-kunit_tool has a number of other command-line arguments which can
-be useful for our test environment. Below are the most commonly used
-command line arguments:
+To see a list of options for a particular command (along with usage), see::
 
-- ``--help``: Lists all available options. To list common options,
-  place ``--help`` before the command. To list options specific to that
-  command, place ``--help`` after the command.
-
-  .. note:: Different commands (``config``, ``build``, ``run``, etc)
-            have different supported options.
-- ``--build_dir``: Specifies kunit_tool build directory. It includes
-  the ``.kunitconfig``, ``.config`` files and compiled kernel.
-
-- ``--make_options``: Specifies additional options to pass to make, when
-  compiling a kernel (using ``build`` or ``run`` commands). For example:
-  to enable compiler warnings, we can pass ``--make_options W=1``.
-
-- ``--alltests``: Enable a predefined set of options in order to build
-  as many tests as possible.
-
-  .. note:: The list of enabled options can be found in
-            ``tools/testing/kunit/configs/all_tests.config``.
-
-            If you only want to enable all tests with otherwise satisfied
-            dependencies, instead add ``CONFIG_KUNIT_ALL_TESTS=y`` to your
-            ``.kunitconfig``.
-
-- ``--kunitconfig``: Specifies the path or the directory of the ``.kunitconfig``
-  file. For example:
-
-  - ``lib/kunit/.kunitconfig`` can be the path of the file.
-
-  - ``lib/kunit`` can be the directory in which the file is located.
-
-  This file is used to build and run with a predefined set of tests
-  and their dependencies. For example, to run tests for a given subsystem.
-
-- ``--kconfig_add``: Specifies additional configuration options to be
-  appended to the ``.kunitconfig`` file. For example:
-
-  .. code-block::
-
-	./tools/testing/kunit/kunit.py run --kconfig_add CONFIG_KASAN=y
-
-- ``--arch``: Runs tests on the specified architecture. The architecture
-  argument is same as the Kbuild ARCH environment variable.
-  For example, i386, x86_64, arm, um, etc. Non-UML architectures run on qemu.
-  Default is `um`.
-
-- ``--cross_compile``: Specifies the Kbuild toolchain. It passes the
-  same argument as passed to the ``CROSS_COMPILE`` variable used by
-  Kbuild. This will be the prefix for the toolchain
-  binaries such as GCC. For example:
-
-  - ``sparc64-linux-gnu-`` if we have the sparc toolchain installed on
-    our system.
-
-  - ``$HOME/toolchains/microblaze/gcc-9.2.0-nolibc/microblaze-linux/bin/microblaze-linux``
-    if we have downloaded the microblaze toolchain from the 0-day
-    website to a specified path in our home directory called toolchains.
-
-- ``--qemu_config``: Specifies the path to a file containing a
-  custom qemu architecture definition. This should be a python file
-  containing a `QemuArchParams` object.
-
-- ``--qemu_args``: Specifies additional qemu arguments, for example, ``-smp 8``.
-
-- ``--jobs``: Specifies the number of jobs (commands) to run simultaneously.
-  By default, this is set to the number of cores on your system.
-
-- ``--timeout``: Specifies the maximum number of seconds allowed for all tests to run.
-  This does not include the time taken to build the tests.
-
-- ``--kernel_args``: Specifies additional kernel command-line arguments. May be repeated.
-
-- ``--run_isolated``: If set, boots the kernel for each individual suite/test.
-  This is useful for debugging a non-hermetic test, one that
-  might pass/fail based on what ran before it.
-
-- ``--raw_output``: If set, generates unformatted output from kernel. Possible options are:
-
-   - ``all``: To view the full kernel output, use ``--raw_output=all``.
-
-   - ``kunit``: This is the default option and filters to KUnit output. Use ``--raw_output`` or ``--raw_output=kunit``.
-
-- ``--json``: If set, stores the test results in a JSON format and prints to `stdout` or
-  saves to a file if a filename is specified.
+	./tools/testing/kunit/kunit.py <command> --help
-- 
An old man doll... just what I always wanted! - Clara

