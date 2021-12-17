Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5643D478443
	for <lists+linux-kselftest@lfdr.de>; Fri, 17 Dec 2021 05:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232939AbhLQEtp (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Thu, 16 Dec 2021 23:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232878AbhLQEto (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Thu, 16 Dec 2021 23:49:44 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B47AC061574
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Dec 2021 20:49:44 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id h5-20020a255f45000000b005ffd939127bso2512207ybm.10
        for <linux-kselftest@vger.kernel.org>; Thu, 16 Dec 2021 20:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=14H6xhOpDNBLVv1Dapd5bhsBv/80ue6Xu3pTRU70RaY=;
        b=hQgmi6bX94+r+35PUX51w0LNl4vBxBUth8pmg7kUBo/TE45iuWKbLH6KiF32TFqdLQ
         wYoH1x6Et4pTlBHtANW24wYQ7jnYPKgwYUGxJLF166w9h0PUI1q4cuOuJUpQS+ojETi/
         ZcJkZDubTKckfuqT1ic0foH4P8zJEpizIqKOXPlqN6GWKLQMK49v8LbjHesyUIQmd/0e
         1Q+YZHcYdlwQZVFHESXXZQ6mSPCS9M2eYEq2JgBb+rNm+N3M6/bbQW+x8QO0B1j/1gPE
         BqJkz2Ln7U4rKVVSk7VQjr7t9rZtEGN5xwUCGZVm+EDr3Y9Vpng5MqCHp81th7yURSbz
         yvsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=14H6xhOpDNBLVv1Dapd5bhsBv/80ue6Xu3pTRU70RaY=;
        b=APpteq2ACq7b/uE+CwJEarnDpKo7Ekb7rlyIZxpqOTuxoUHZC3rQRlS4ATsxpOduJ8
         GSzVMCzwzG8meCcfbdK0uFOUmo0Ci5GfEVaOaYVmCkclrmPuKAMlzkh73Asa+nv2nIRd
         v4r1cjmlRv51rONYlyvnlWPwsU8mh6F5vmdNADIuzytpXOaXY9/Z826Enk8RqX0O56qv
         9YSCCBtViEFgRfVpIotZ/LAGBVza4eHks5Ii67HrLRI8AIWNnDCdkuEvWIAecL/JCXKm
         zP+ocMjjlk8MdGEMZCgaBw9cklFOFpJjlJB07cgjrU2RBBjTSHTAJnv9WMbYeY2psAdz
         j0fg==
X-Gm-Message-State: AOAM531zHc8WRTnyzDCbruYGbtq82ttfY6tCZiMWIx3N2oZyzvg4HVXh
        5ji3GDCP6cE+/v+ZNfHpJIbRgpZ33sbR63I=
X-Google-Smtp-Source: ABdhPJzyUo8jdIxcVz70ahdPvq4MajHXxAskNtoXTNZGOCabdhwNTUmrKBWSYNRhECqyjb3CKKH+66KLPNVcdPA=
X-Received: from sharinder.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:c73])
 (user=sharinder job=sendgmr) by 2002:a25:8690:: with SMTP id
 z16mr2047398ybk.435.1639716583549; Thu, 16 Dec 2021 20:49:43 -0800 (PST)
Date:   Fri, 17 Dec 2021 04:49:08 +0000
In-Reply-To: <20211217044911.798817-1-sharinder@google.com>
Message-Id: <20211217044911.798817-5-sharinder@google.com>
Mime-Version: 1.0
References: <20211217044911.798817-1-sharinder@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v6 4/7] Documentation: kunit: Reorganize documentation related
 to running tests
From:   Harinder Singh <sharinder@google.com>
To:     davidgow@google.com, brendanhiggins@google.com, shuah@kernel.org,
        corbet@lwn.net
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tim.bird@sony.com, elver@google.com,
        Harinder Singh <sharinder@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Consolidate documentation running tests into two pages: "run tests with
kunit_tool" and "run tests without kunit_tool".

Signed-off-by: Harinder Singh <sharinder@google.com>
Reviewed-by: Tim Bird <tim.bird@sony.com>
---
 Documentation/dev-tools/kunit/index.rst       |   4 +
 Documentation/dev-tools/kunit/run_manual.rst  |  57 ++++
 Documentation/dev-tools/kunit/run_wrapper.rst | 247 ++++++++++++++++++
 Documentation/dev-tools/kunit/start.rst       |   4 +-
 4 files changed, 311 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/dev-tools/kunit/run_manual.rst
 create mode 100644 Documentation/dev-tools/kunit/run_wrapper.rst

diff --git a/Documentation/dev-tools/kunit/index.rst b/Documentation/dev-tools/kunit/index.rst
index 50d3ef9359dd..f9f37997b58c 100644
--- a/Documentation/dev-tools/kunit/index.rst
+++ b/Documentation/dev-tools/kunit/index.rst
@@ -10,6 +10,8 @@ KUnit - Linux Kernel Unit Testing
 
 	start
 	architecture
+	run_wrapper
+	run_manual
 	usage
 	kunit-tool
 	api/index
@@ -98,6 +100,8 @@ How do I use it?
 
 *   Documentation/dev-tools/kunit/start.rst - for KUnit new users.
 *   Documentation/dev-tools/kunit/architecture.rst - KUnit architecture.
+*   Documentation/dev-tools/kunit/run_wrapper.rst - run kunit_tool.
+*   Documentation/dev-tools/kunit/run_manual.rst - run tests without kunit_tool.
 *   Documentation/dev-tools/kunit/usage.rst - KUnit features.
 *   Documentation/dev-tools/kunit/tips.rst - best practices with
     examples.
diff --git a/Documentation/dev-tools/kunit/run_manual.rst b/Documentation/dev-tools/kunit/run_manual.rst
new file mode 100644
index 000000000000..e7b46421f247
--- /dev/null
+++ b/Documentation/dev-tools/kunit/run_manual.rst
@@ -0,0 +1,57 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+============================
+Run Tests without kunit_tool
+============================
+
+If we do not want to use kunit_tool (For example: we want to integrate
+with other systems, or run tests on real hardware), we can
+include KUnit in any kernel, read out results, and parse manually.
+
+.. note:: KUnit is not designed for use in a production system. It is
+          possible that tests may reduce the stability or security of
+          the system.
+
+Configure the Kernel
+====================
+
+KUnit tests can run without kunit_tool. This can be useful, if:
+
+- We have an existing kernel configuration to test.
+- Need to run on real hardware (or using an emulator/VM kunit_tool
+  does not support).
+- Wish to integrate with some existing testing systems.
+
+KUnit is configured with the ``CONFIG_KUNIT`` option, and individual
+tests can also be built by enabling their config options in our
+``.config``. KUnit tests usually (but don't always) have config options
+ending in ``_KUNIT_TEST``. Most tests can either be built as a module,
+or be built into the kernel.
+
+.. note ::
+
+	We can enable the ``KUNIT_ALL_TESTS`` config option to
+	automatically enable all tests with satisfied dependencies. This is
+	a good way of quickly testing everything applicable to the current
+	config.
+
+Once we have built our kernel (and/or modules), it is simple to run
+the tests. If the tests are built-in, they will run automatically on the
+kernel boot. The results will be written to the kernel log (``dmesg``)
+in TAP format.
+
+If the tests are built as modules, they will run when the module is
+loaded.
+
+.. code-block :: bash
+
+	# modprobe example-test
+
+The results will appear in TAP format in ``dmesg``.
+
+.. note ::
+
+	If ``CONFIG_KUNIT_DEBUGFS`` is enabled, KUnit test results will
+	be accessible from the ``debugfs`` filesystem (if mounted).
+	They will be in ``/sys/kernel/debug/kunit/<test_suite>/results``, in
+	TAP format.
diff --git a/Documentation/dev-tools/kunit/run_wrapper.rst b/Documentation/dev-tools/kunit/run_wrapper.rst
new file mode 100644
index 000000000000..653985ce9cae
--- /dev/null
+++ b/Documentation/dev-tools/kunit/run_wrapper.rst
@@ -0,0 +1,247 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=========================
+Run Tests with kunit_tool
+=========================
+
+We can either run KUnit tests using kunit_tool or can run tests
+manually, and then use kunit_tool to parse the results. To run tests
+manually, see: Documentation/dev-tools/kunit/run_manual.rst.
+As long as we can build the kernel, we can run KUnit.
+
+kunit_tool is a Python script which configures and builds a kernel, runs
+tests, and formats the test results.
+
+Run command:
+
+.. code-block::
+
+	./tools/testing/kunit/kunit.py run
+
+We should see the following:
+
+.. code-block::
+
+	Generating .config...
+	Building KUnit kernel...
+	Starting KUnit kernel...
+
+We may want to use the following options:
+
+.. code-block::
+
+	./tools/testing/kunit/kunit.py run --timeout=30 --jobs=`nproc --all
+
+- ``--timeout`` sets a maximum amount of time for tests to run.
+- ``--jobs`` sets the number of threads to build the kernel.
+
+kunit_tool will generate a ``.kunitconfig`` with a default
+configuration, if no other ``.kunitconfig`` file exists
+(in the build directory). In addition, it verifies that the
+generated ``.config`` file contains the ``CONFIG`` options in the
+``.kunitconfig``.
+It is also possible to pass a separate ``.kunitconfig`` fragment to
+kunit_tool. This is useful if we have several different groups of
+tests we want to run independently, or if we want to use pre-defined
+test configs for certain subsystems.
+
+To use a different ``.kunitconfig`` file (such as one
+provided to test a particular subsystem), pass it as an option:
+
+.. code-block::
+
+	./tools/testing/kunit/kunit.py run --kunitconfig=fs/ext4/.kunitconfig
+
+To view kunit_tool flags (optional command-line arguments), run:
+
+.. code-block::
+
+	./tools/testing/kunit/kunit.py run --help
+
+Create a  ``.kunitconfig`` File
+===============================
+
+If we want to run a specific set of tests (rather than those listed
+in the KUnit ``defconfig``), we can provide Kconfig options in the
+``.kunitconfig`` file. For default .kunitconfig, see:
+https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/tools/testing/kunit/configs/default.config.
+A ``.kunitconfig`` is a ``minconfig`` (a .config
+generated by running ``make savedefconfig``), used for running a
+specific set of tests. This file contains the regular Kernel configs
+with specific test targets. The ``.kunitconfig`` also
+contains any other config options required by the tests (For example:
+dependencies for features under tests, configs that enable/disable
+certain code blocks, arch configs and so on).
+
+To create a ``.kunitconfig``, using the KUnit ``defconfig``:
+
+.. code-block::
+
+	cd $PATH_TO_LINUX_REPO
+	cp tools/testing/kunit/configs/default.config .kunit/.kunitconfig
+
+We can then add any other Kconfig options. For example:
+
+.. code-block::
+
+	CONFIG_LIST_KUNIT_TEST=y
+
+kunit_tool ensures that all config options in ``.kunitconfig`` are
+set in the kernel ``.config`` before running the tests. It warns if we
+have not included the options dependencies.
+
+.. note:: Removing something from the ``.kunitconfig`` will
+   not rebuild the ``.config file``. The configuration is only
+   updated if the ``.kunitconfig`` is not a subset of ``.config``.
+   This means that we can use other tools
+   (For example: ``make menuconfig``) to adjust other config options.
+   The build dir needs to be set for ``make menuconfig`` to
+   work, therefore  by default use ``make O=.kunit menuconfig``.
+
+Configure, Build, and Run Tests
+===============================
+
+If we want to make manual changes to the KUnit build process, we
+can run part of the KUnit build process independently.
+When running kunit_tool, from a ``.kunitconfig``, we can generate a
+``.config`` by using the ``config`` argument:
+
+.. code-block::
+
+	./tools/testing/kunit/kunit.py config
+
+To build a KUnit kernel from the current ``.config``, we can use the
+``build`` argument:
+
+.. code-block::
+
+	./tools/testing/kunit/kunit.py build
+
+If we already have built UML kernel with built-in KUnit tests, we
+can run the kernel, and display the test results with the ``exec``
+argument:
+
+.. code-block::
+
+	./tools/testing/kunit/kunit.py exec
+
+The ``run`` command discussed in section: **Run Tests with kunit_tool**,
+is equivalent to running the above three commands in sequence.
+
+Parse Test Results
+==================
+
+KUnit tests output displays results in TAP (Test Anything Protocol)
+format. When running tests, kunit_tool parses this output and prints
+a summary. To see the raw test results in TAP format, we can pass the
+``--raw_output`` argument:
+
+.. code-block::
+
+	./tools/testing/kunit/kunit.py run --raw_output
+
+If we have KUnit results in the raw TAP format, we can parse them and
+print the human-readable summary with the ``parse`` command for
+kunit_tool. This accepts a filename for an argument, or will read from
+standard input.
+
+.. code-block:: bash
+
+	# Reading from a file
+	./tools/testing/kunit/kunit.py parse /var/log/dmesg
+	# Reading from stdin
+	dmesg | ./tools/testing/kunit/kunit.py parse
+
+Run Selected Test Suites
+========================
+
+By passing a bash style glob filter to the ``exec`` or ``run``
+commands, we can run a subset of the tests built into a kernel . For
+example: if we only want to run KUnit resource tests, use:
+
+.. code-block::
+
+	./tools/testing/kunit/kunit.py run 'kunit-resource*'
+
+This uses the standard glob format with wildcard characters.
+
+Run Tests on qemu
+=================
+
+kunit_tool supports running tests on  qemu as well as
+via UML. To run tests on qemu, by default it requires two flags:
+
+- ``--arch``: Selects a configs collection (Kconfig, qemu config options
+  and so on), that allow KUnit tests to be run on the specified
+  architecture in a minimal way. The architecture argument is same as
+  the option name passed to the ``ARCH`` variable used by Kbuild.
+  Not all architectures currently support this flag, but we can use
+  ``--qemu_config`` to handle it. If ``um`` is passed (or this flag
+  is ignored), the tests will run via UML. Non-UML architectures,
+  for example: i386, x86_64, arm and so on; run on qemu.
+
+- ``--cross_compile``: Specifies the Kbuild toolchain. It passes the
+  same argument as passed to the ``CROSS_COMPILE`` variable used by
+  Kbuild. As a reminder, this will be the prefix for the toolchain
+  binaries such as GCC. For example:
+
+  - ``sparc64-linux-gnu`` if we have the sparc toolchain installed on
+    our system.
+
+  - ``$HOME/toolchains/microblaze/gcc-9.2.0-nolibc/microblaze-linux/bin/microblaze-linux``
+    if we have downloaded the microblaze toolchain from the 0-day
+    website to a directory in our home directory called toolchains.
+
+If we want to run KUnit tests on an architecture not supported by
+the ``--arch`` flag, or want to run KUnit tests on qemu using a
+non-default configuration; then we can write our own``QemuConfig``.
+These ``QemuConfigs`` are written in Python. They have an import line
+``from..qemu_config import QemuArchParams`` at the top of the file.
+The file must contain a variable called ``QEMU_ARCH`` that has an
+instance of ``QemuArchParams`` assigned to it. See example in:
+``tools/testing/kunit/qemu_configs/x86_64.py``.
+
+Once we have a ``QemuConfig``, we can pass it into kunit_tool,
+using the ``--qemu_config`` flag. When used, this flag replaces the
+``--arch`` flag. For example: using
+``tools/testing/kunit/qemu_configs/x86_64.py``, the invocation appear
+as
+
+.. code-block:: bash
+
+	./tools/testing/kunit/kunit.py run \
+		--timeout=60 \
+		--jobs=12 \
+		--qemu_config=./tools/testing/kunit/qemu_configs/x86_64.py
+
+To run existing KUnit tests on non-UML architectures, see:
+Documentation/dev-tools/kunit/non_uml.rst.
+
+Command-Line Arguments
+======================
+
+kunit_tool has a number of other command-line arguments which can
+be useful for our test environment. Below the most commonly used
+command line arguments:
+
+- ``--help``: Lists all available options. To list common options,
+  place ``--help`` before the command. To list options specific to that
+  command, place ``--help`` after the command.
+
+  .. note:: Different commands (``config``, ``build``, ``run``, etc)
+            have different supported options.
+- ``--build_dir``: Specifies kunit_tool build directory. It includes
+  the ``.kunitconfig``, ``.config`` files and compiled kernel.
+
+- ``--make_options``: Specifies additional options to pass to make, when
+  compiling a kernel (using ``build`` or ``run`` commands). For example:
+  to enable compiler warnings, we can pass ``--make_options W=1``.
+
+- ``--alltests``: Builds a UML kernel with all config options enabled
+  using ``make allyesconfig``. This allows us to run as many tests as
+  possible.
+
+  .. note:: It is slow and prone to breakage as new options are
+            added or modified. Instead, enable all tests
+            which have satisfied dependencies by adding
+            ``CONFIG_KUNIT_ALL_TESTS=y`` to your ``.kunitconfig``.
diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index 5dd2c88fa2bd..af13f443c976 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -20,7 +20,7 @@ can run kunit_tool:
 	./tools/testing/kunit/kunit.py run
 
 For more information on this wrapper, see:
-Documentation/dev-tools/kunit/kunit-tool.rst.
+Documentation/dev-tools/kunit/run_wrapper.rst.
 
 Creating a ``.kunitconfig``
 ---------------------------
@@ -241,6 +241,8 @@ Next Steps
 ==========
 
 *   Documentation/dev-tools/kunit/architecture.rst - KUnit architecture.
+*   Documentation/dev-tools/kunit/run_wrapper.rst - run kunit_tool.
+*   Documentation/dev-tools/kunit/run_manual.rst - run tests without kunit_tool.
 *   Documentation/dev-tools/kunit/usage.rst - KUnit features.
 *   Documentation/dev-tools/kunit/tips.rst - best practices with
     examples.
-- 
2.34.1.173.g76aa8bc2d0-goog

