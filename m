Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Original-To: lists+linux-kselftest@lfdr.de
Delivered-To: lists+linux-kselftest@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2307146FA5B
	for <lists+linux-kselftest@lfdr.de>; Fri, 10 Dec 2021 06:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234354AbhLJFcI (ORCPT <rfc822;lists+linux-kselftest@lfdr.de>);
        Fri, 10 Dec 2021 00:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233819AbhLJFcH (ORCPT
        <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 10 Dec 2021 00:32:07 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60158C0617A1
        for <linux-kselftest@vger.kernel.org>; Thu,  9 Dec 2021 21:28:33 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id b15-20020a25ae8f000000b005c20f367790so14862211ybj.2
        for <linux-kselftest@vger.kernel.org>; Thu, 09 Dec 2021 21:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Zr32vRf61UZFH6hZpGjG1QCJKVeFmDuobe731qgvIyQ=;
        b=DsOpztyE+wfzsV6Wk9KcDh+VPcYHm7GTdtVWlMZ+DDV5vJSGLNNGHhjCd81zKu1Z7o
         Pni24XeZhX3kALSGPpdVAft74NytQ5T7VqEeC+3BSIb8pvRwm7qn+UIbiPK6C+PTKdOe
         Mmw6bevnFWH+Gjak5HczpMV1cd11hirnlbPTyMEc+CmVofblMEawnx7LfOiuIC69cNNP
         8LaaHewACAEBvoE9jvgr/nrcQ1WRVfo77YaD7dICKuGrRBP0VlKc6S3lUtNWHQqZEgaZ
         H5Er8SX+Ij9LvwaimdjnciULtEXXvYpYn2/XmsEV1/IFyFPdjl/dVS4kAY6t0kUVgF1T
         ALjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Zr32vRf61UZFH6hZpGjG1QCJKVeFmDuobe731qgvIyQ=;
        b=e/yJYqL9B8sNVm6MRq9cdBy6U7ITWWGtEWOUp0ya8XOcz9av0+tiYEvEm54zuMo9Np
         1R0UOwUML8IUghZJXv8QyFf60tyFfTvfzX0+HR3dp2A3SZxCGplY0PVzGYhBEGfFYUrS
         pKn9ioj+mRmSE0/VencNpPi5RR/3yxEPHtQ1jWVatweQnSNZurIma3lfydDrkL+OcQz1
         CkgPDlFJ/X8Ml6JuLM1KFZCbEIR9d/zDv4LFiDodPYhduqN75nrZq+XnNJw26DwJHM9R
         tBzlhZbh0ep9jYQ+HLcFlitppgHfoM6lenR5hDOgGamg8xEhmV2YFgFOW3vPZ7TNlEXh
         s6ZQ==
X-Gm-Message-State: AOAM5321VAbkDBScV7cMmJeKDv3h1tPCLodUHUoQobwtsgwNF4FlOV1T
        H4aceZ62WQcT8EU41x7ZO/7nT0hCQHDtspk=
X-Google-Smtp-Source: ABdhPJy4qf9WwXvbXyZAH+ctBARSOTVdofWc1IHuAdqmRBZKsCitruCv7Bqc3pyCv6KXTVQZsBBYB6Ycwdgx8AA=
X-Received: from sharinder.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:c73])
 (user=sharinder job=sendgmr) by 2002:a05:6902:1503:: with SMTP id
 q3mr11869182ybu.572.1639114112638; Thu, 09 Dec 2021 21:28:32 -0800 (PST)
Date:   Fri, 10 Dec 2021 05:28:07 +0000
In-Reply-To: <20211210052812.1998578-1-sharinder@google.com>
Message-Id: <20211210052812.1998578-3-sharinder@google.com>
Mime-Version: 1.0
References: <20211210052812.1998578-1-sharinder@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v3 2/7] Documentation: KUnit: Rewrite getting started
From:   Harinder Singh <sharinder@google.com>
To:     davidgow@google.com, brendanhiggins@google.com, shuah@kernel.org,
        corbet@lwn.net
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        tim.bird@sony.com, Harinder Singh <sharinder@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kselftest.vger.kernel.org>
X-Mailing-List: linux-kselftest@vger.kernel.org

Clarify the purpose of kunit_tool and fixed consistency issues

Signed-off-by: Harinder Singh <sharinder@google.com>
---
 Documentation/dev-tools/kunit/start.rst | 195 +++++++++++++-----------
 1 file changed, 102 insertions(+), 93 deletions(-)

diff --git a/Documentation/dev-tools/kunit/start.rst b/Documentation/dev-tools/kunit/start.rst
index 1e00f9226f74..55f8df1abd40 100644
--- a/Documentation/dev-tools/kunit/start.rst
+++ b/Documentation/dev-tools/kunit/start.rst
@@ -4,132 +4,136 @@
 Getting Started
 ===============
 
-Installing dependencies
+Installing Dependencies
 =======================
-KUnit has the same dependencies as the Linux kernel. As long as you can build
-the kernel, you can run KUnit.
+KUnit has the same dependencies as the Linux kernel. As long as you can
+build the kernel, you can run KUnit.
 
-Running tests with the KUnit Wrapper
-====================================
-Included with KUnit is a simple Python wrapper which runs tests under User Mode
-Linux, and formats the test results.
-
-The wrapper can be run with:
+Running tests with kunit_tool
+=============================
+kunit_tool is a Python script, which configures and builds a kernel, runs
+tests, and formats the test results. From the kernel repository, you
+can run kunit_tool:
 
 .. code-block:: bash
 
 	./tools/testing/kunit/kunit.py run
 
-For more information on this wrapper (also called kunit_tool) check out the
-Documentation/dev-tools/kunit/kunit-tool.rst page.
+For more information on this wrapper, see:
+Documentation/dev-tools/kunit/kunit-tool.rst.
+
+Creating a ``.kunitconfig``
+---------------------------
+
+By default, kunit_tool runs a selection of tests. However, you can specify which
+unit tests to run by creating a ``.kunitconfig`` file with kernel config options
+that enable only a specific set of tests and their dependencies.
+The ``.kunitconfig`` file contains a list of kconfig options which are required
+to run the desired targets. The ``.kunitconfig`` also contains any other test
+specific config options, such as test dependencies. For example: the
+``FAT_FS`` tests - ``FAT_KUNIT_TEST``, depends on
+``FAT_FS``. ``FAT_FS`` can be enabled by selecting either ``MSDOS_FS``
+or ``VFAT_FS``. To run ``FAT_KUNIT_TEST``, the ``.kunitconfig`` has:
 
-Creating a .kunitconfig
------------------------
-If you want to run a specific set of tests (rather than those listed in the
-KUnit defconfig), you can provide Kconfig options in the ``.kunitconfig`` file.
-This file essentially contains the regular Kernel config, with the specific
-test targets as well. The ``.kunitconfig`` should also contain any other config
-options required by the tests.
+.. code-block:: none
+
+	CONFIG_KUNIT=y
+	CONFIG_MSDOS_FS=y
+	CONFIG_FAT_KUNIT_TEST=y
 
-A good starting point for a ``.kunitconfig`` is the KUnit defconfig:
+1. A good starting point for the ``.kunitconfig``, is the KUnit default
+   config. Run the command:
 
 .. code-block:: bash
 
 	cd $PATH_TO_LINUX_REPO
 	cp tools/testing/kunit/configs/default.config .kunitconfig
 
-You can then add any other Kconfig options you wish, e.g.:
+.. note ::
+   You may want to remove CONFIG_KUNIT_ALL_TESTS from the ``.kunitconfig`` as
+   it will enable a number of additional tests that you may not want.
+
+2. You can then add any other Kconfig options, for example:
 
 .. code-block:: none
 
 	CONFIG_LIST_KUNIT_TEST=y
 
-:doc:`kunit_tool <kunit-tool>` will ensure that all config options set in
-``.kunitconfig`` are set in the kernel ``.config`` before running the tests.
-It'll warn you if you haven't included the dependencies of the options you're
-using.
+Before running the tests, kunit_tool ensures that all config options
+set in ``.kunitconfig`` are set in the kernel ``.config``. It will warn
+you if you have not included dependencies for the options used.
 
-.. note::
-   Note that removing something from the ``.kunitconfig`` will not trigger a
-   rebuild of the ``.config`` file: the configuration is only updated if the
-   ``.kunitconfig`` is not a subset of ``.config``. This means that you can use
-   other tools (such as make menuconfig) to adjust other config options.
+.. note ::
+   The configuration is only updated if the ``.kunitconfig`` is not a
+   subset of ``.config``. You can use tools (for example:
+   make menuconfig) to adjust other config options.
 
-
-Running the tests (KUnit Wrapper)
----------------------------------
-
-To make sure that everything is set up correctly, simply invoke the Python
-wrapper from your kernel repo:
+Running Tests (KUnit Wrapper)
+-----------------------------
+1. To make sure that everything is set up correctly, invoke the Python
+   wrapper from your kernel repository:
 
 .. code-block:: bash
 
 	./tools/testing/kunit/kunit.py run
 
-.. note::
-   You may want to run ``make mrproper`` first.
-
 If everything worked correctly, you should see the following:
 
-.. code-block:: bash
+.. code-block::
 
 	Generating .config ...
 	Building KUnit Kernel ...
 	Starting KUnit Kernel ...
 
-followed by a list of tests that are run. All of them should be passing.
+The tests will pass or fail.
 
-.. note::
-	Because it is building a lot of sources for the first time, the
-	``Building KUnit kernel`` step may take a while.
+.. note ::
+   Because it is building a lot of sources for the first time, the
+   ``Building KUnit kernel`` may take a while.
 
-Running tests without the KUnit Wrapper
+Running Tests without the KUnit Wrapper
 =======================================
-
-If you'd rather not use the KUnit Wrapper (if, for example, you need to
-integrate with other systems, or use an architecture other than UML), KUnit can
-be included in any kernel, and the results read out and parsed manually.
-
-.. note::
-   KUnit is not designed for use in a production system, and it's possible that
-   tests may reduce the stability or security of the system.
-
-
-
-Configuring the kernel
+If you do not want to use the KUnit Wrapper (for example: you want code
+under test to integrate with other systems, or use a different/
+unsupported architecture or configuration), KUnit can be included in
+any kernel, and the results are read out and parsed manually.
+
+.. note ::
+   ``CONFIG_KUNIT`` should not be enabled in a production environment.
+   Enabling KUnit disables Kernel Address-Space Layout Randomization
+   (KASLR), and tests may affect the state of the kernel in ways not
+   suitable for production.
+
+Configuring the Kernel
 ----------------------
+To enable KUnit itself, you need to enable the ``CONFIG_KUNIT`` Kconfig
+option (under Kernel Hacking/Kernel Testing and Coverage in
+``menuconfig``). From there, you can enable any KUnit tests. They
+usually have config options ending in ``_KUNIT_TEST``.
 
-In order to enable KUnit itself, you simply need to enable the ``CONFIG_KUNIT``
-Kconfig option (it's under Kernel Hacking/Kernel Testing and Coverage in
-menuconfig). From there, you can enable any KUnit tests you want: they usually
-have config options ending in ``_KUNIT_TEST``.
-
-KUnit and KUnit tests can be compiled as modules: in this case the tests in a
-module will be run when the module is loaded.
+KUnit and KUnit tests can be compiled as modules. The tests in a module
+will run when the module is loaded.
 
-
-Running the tests (w/o KUnit Wrapper)
+Running Tests (without KUnit Wrapper)
 -------------------------------------
+Build and run your kernel. In the kernel log, the test output is printed
+out in the TAP format. This will only happen by default if KUnit/tests
+are built-in. Otherwise the module will need to be loaded.
 
-Build and run your kernel as usual. Test output will be written to the kernel
-log in `TAP <https://testanything.org/>`_ format.
-
-.. note::
-   It's possible that there will be other lines and/or data interspersed in the
-   TAP output.
-
+.. note ::
+   Some lines and/or data may get interspersed in the TAP output.
 
-Writing your first test
+Writing Your First Test
 =======================
+In your kernel repository, let's add some code that we can test.
 
-In your kernel repo let's add some code that we can test. Create a file
-``drivers/misc/example.h`` with the contents:
+1. Create a file ``drivers/misc/example.h``, which includes:
 
 .. code-block:: c
 
 	int misc_example_add(int left, int right);
 
-create a file ``drivers/misc/example.c``:
+2. Create a file ``drivers/misc/example.c``, which includes:
 
 .. code-block:: c
 
@@ -142,21 +146,22 @@ create a file ``drivers/misc/example.c``:
 		return left + right;
 	}
 
-Now add the following lines to ``drivers/misc/Kconfig``:
+3. Add the following lines to ``drivers/misc/Kconfig``:
 
 .. code-block:: kconfig
 
 	config MISC_EXAMPLE
 		bool "My example"
 
-and the following lines to ``drivers/misc/Makefile``:
+4. Add the following lines to ``drivers/misc/Makefile``:
 
 .. code-block:: make
 
 	obj-$(CONFIG_MISC_EXAMPLE) += example.o
 
-Now we are ready to write the test. The test will be in
-``drivers/misc/example-test.c``:
+Now we are ready to write the test cases.
+
+1. Add the below test case in ``drivers/misc/example_test.c``:
 
 .. code-block:: c
 
@@ -191,7 +196,7 @@ Now we are ready to write the test. The test will be in
 	};
 	kunit_test_suite(misc_example_test_suite);
 
-Now add the following to ``drivers/misc/Kconfig``:
+2. Add the following lines to ``drivers/misc/Kconfig``:
 
 .. code-block:: kconfig
 
@@ -200,20 +205,20 @@ Now add the following to ``drivers/misc/Kconfig``:
 		depends on MISC_EXAMPLE && KUNIT=y
 		default KUNIT_ALL_TESTS
 
-and the following to ``drivers/misc/Makefile``:
+3. Add the following lines to ``drivers/misc/Makefile``:
 
 .. code-block:: make
 
-	obj-$(CONFIG_MISC_EXAMPLE_TEST) += example-test.o
+	obj-$(CONFIG_MISC_EXAMPLE_TEST) += example_test.o
 
-Now add it to your ``.kunitconfig``:
+4. Add the following lines to ``.kunitconfig``:
 
 .. code-block:: none
 
 	CONFIG_MISC_EXAMPLE=y
 	CONFIG_MISC_EXAMPLE_TEST=y
 
-Now you can run the test:
+5. Run the test:
 
 .. code-block:: bash
 
@@ -227,16 +232,20 @@ You should see the following failure:
 	[16:08:57] [PASSED] misc-example:misc_example_add_test_basic
 	[16:08:57] [FAILED] misc-example:misc_example_test_failure
 	[16:08:57] EXPECTATION FAILED at drivers/misc/example-test.c:17
-	[16:08:57] 	This test never passes.
+	[16:08:57]      This test never passes.
 	...
 
-Congrats! You just wrote your first KUnit test!
+Congrats! You just wrote your first KUnit test.
 
 Next Steps
 ==========
-*   Check out the Documentation/dev-tools/kunit/tips.rst page for tips on
-    writing idiomatic KUnit tests.
-*   Check out the :doc:`running_tips` page for tips on
-    how to make running KUnit tests easier.
-*   Optional: see the :doc:`usage` page for a more
-    in-depth explanation of KUnit.
+
+*   Documentation/dev-tools/kunit/usage.rst - KUnit features.
+*   Documentation/dev-tools/kunit/tips.rst - best practices with
+    examples.
+*   Documentation/dev-tools/kunit/api/index.rst - KUnit APIs
+    used for testing.
+*   Documentation/dev-tools/kunit/kunit-tool.rst - kunit_tool helper
+    script.
+*   Documentation/dev-tools/kunit/faq.rst - KUnit common questions and
+    answers.
-- 
2.34.1.173.g76aa8bc2d0-goog

